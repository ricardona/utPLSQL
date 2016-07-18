create or replace type body ut_single_test is

  constructor function ut_single_test(a_object_name varchar2, a_test_procedure varchar2, a_owner_name varchar2 default null, a_setup_procedure varchar2 default null, a_teardown_procedure varchar2 default null)
    return self as result is
  begin
    self.owner_name         := a_owner_name;
    self.test_procedure     := a_test_procedure;
    self.owner_name         := a_owner_name;
    self.setup_procedure    := a_setup_procedure;
    self.teardown_procedure := a_teardown_procedure;
    return;
  end ut_single_test;

  member function is_valid(self in ut_single_test) return boolean is
  begin
    if test_procedure is null then
      return false;
    end if;

    if not ut_metadata.do_resolve(owner_name, object_name, test_procedure) then
      return false;
    end if;

    if setup_procedure is not null and not ut_metadata.do_resolve(owner_name, object_name, setup_procedure) then
      return false;
    end if;

    if teardown_procedure is not null and not ut_metadata.do_resolve(owner_name, object_name, teardown_procedure) then
      return false;
    end if;

    return true;
  end is_valid;

  member function setup_stmt(self in ut_single_test) return varchar2 is
  begin
    if trim(setup_procedure) is null or trim(object_name) is null then
      return null;
    end if;

    if trim(owner_name) is not null then
      return trim(owner_name) || '.' || object_name || '.' || setup_procedure;
    else
      return object_name || '.' || setup_procedure;
    end if;
  end setup_stmt;

  member function test_stmt(self in ut_single_test) return varchar2 is
  begin
    if trim(test_procedure) is null or trim(object_name) is null then
      return null;
    end if;

    if trim(owner_name) is not null then
      return trim(owner_name) || '.' || object_name || '.' || test_procedure;
    else
      return object_name || '.' || test_procedure;
    end if;
  end test_stmt;

  member function teardown_stmt(self in ut_single_test) return varchar2 is
  begin
    if trim(teardown_procedure) is null or trim(object_name) is null then
      return null;
    end if;

    if trim(owner_name) is not null then
      return trim(owner_name) || '.' || object_name || '.' || teardown_procedure;
    else
      return object_name || '.' || teardown_procedure;
    end if;
  end teardown_stmt;

  member procedure execute(self in out nocopy ut_single_test) is

    procedure execute_procedure(a_owner_name in varchar2, a_package_name in varchar2, a_procedure_name in varchar2) as
      obj_data     user_objects%rowtype;
      stmt         varchar2(150); --128 plus some extra
      execute_stmt boolean := true;
    begin
      $if $$ut_trace $then
      dbms_output.put_line('ut_execute.execute_procedure');
      $end

      if execute_stmt then
        stmt := trim(a_package_name) || '.' || trim(a_procedure_name);
        if trim(a_owner_name) is not null then
          stmt := trim(a_owner_name) || '.' || stmt;
        end if;
        stmt := 'begin ' || stmt || '; end;';

        $if $$ut_trace $then
        dbms_output.put_line('execute_procedure stmt:' || stmt);
        $end

        execute immediate stmt;
      end if;
    end;

    procedure execute_package_test is
    begin
      $if $$ut_trace $then
      dbms_output.put_line('execute_package_test ' || a_test_to_execute.owner_name || '.' ||
                           a_test_to_execute.object_name || '.' || a_test_to_execute.test_procedure);
      $end

      if not self.is_valid then
        ut_assert.report_error('Single_Test is not invalid: ');
        return;
      end if;

      if not ut_metadata.package_valid(self.owner_name, self.object_name) then
        ut_assert.report_error('package does not exist or is invalid: ' ||
                               nvl(self.object_name, '<missing package name>'));
        return;
      end if;

      if not ut_metadata.procedure_exists(self.owner_name, self.object_name, self.setup_procedure) then
        ut_assert.report_error('package missing setup method ' || self.object_name || '.' ||
                               nvl(self.setup_procedure, '<missing procedure name>'));
        return;
      end if;

      if not ut_metadata.procedure_exists(self.owner_name, self.object_name, self.test_procedure) then
        ut_assert.report_error('package missing test method ' || self.object_name || '.' ||
                               nvl(self.test_procedure, '<missing procedure name>'));
        return;
      end if;

      if not ut_metadata.procedure_exists(self.owner_name, self.object_name, self.teardown_procedure) then
        ut_assert.report_error('package missing teardown method ' || self.object_name || '.' ||
                               nvl(self.teardown_procedure, '<missing procedure name>'));
        return;
      end if;

      execute_procedure(self.owner_name, self.object_name, self.setup_procedure);
      begin
        execute_procedure(self.owner_name, self.object_name, self.test_procedure);
      exception
        when others then
          -- dbms_utility.format_error_backtrace is 10g or later
          -- utl_call_stack package may be better but it's 12c but still need to investigate
          -- article with details: http://www.oracle.com/technetwork/issue-archive/2014/14-jan/o14plsql-2045346.html
          $if $$ut_trace $then
          dbms_output.put_line('testmethod failed-' || sqlerrm(sqlcode) || ' ' || dbms_utility.format_error_backtrace);
          $end
          ut_assert.report_error(sqlerrm(sqlcode) || ' ' || dbms_utility.format_error_backtrace);
      end;
      execute_procedure(self.owner_name, self.object_name, self.teardown_procedure);

    end execute_package_test;
  begin
    $if $$ut_trace $then
    dbms_output.put_line('ut_single_test.execute_test');
    $end

    self.test_result := ut_execution_result();

		execute_package_test;

    self.test_result.end_time       := current_timestamp;
    self.test_result.assert_results := ut_assert_list();

    ut_assert.process_asserts(self.test_result.assert_results,self.test_result.result);

  exception
    when others then
      begin
        $if $$ut_trace $then
        dbms_output.put_line('execute_test failed-' || sqlerrm(sqlcode) || ' ' || dbms_utility.format_error_backtrace);
        $end
        -- most likely occured in setup or teardown if here.
        ut_assert.report_error(sqlerrm(sqlcode) || ' ' || dbms_utility.format_error_stack);
        ut_assert.report_error(sqlerrm(sqlcode) || ' ' || dbms_utility.format_error_backtrace);
        ut_assert.process_asserts(self.test_result.assert_results,self.test_result.result);
      end;

  end execute;

end;
/
