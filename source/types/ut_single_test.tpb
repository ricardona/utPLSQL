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

  member function is_valid(self in out nocopy ut_single_test) return boolean is
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

end;
/
