create or replace type body ut_suite_reporter is

  -- Member procedures and functions
  constructor function ut_suite_reporter(a_owner_name varchar2, a_package_name varchar2, a_begin_suite_procedure varchar2 default null, a_end_suite_procedure varchar2 default null, a_begin_test_procedure varchar2 default null, a_end_test_procedure varchar2 default null)
    return self as result is
  begin
    self.owner_name            := a_owner_name;
    self.package_name          := a_package_name;
    self.begin_suite_procedure := nvl(a_begin_suite_procedure, 'begin_suite');
    self.end_suite_procedure   := nvl(a_end_suite_procedure, 'end_suite');
    self.begin_test_procedure  := nvl(a_begin_test_procedure, 'begin_test');
    self.end_test_procedure    := nvl(a_end_test_procedure, 'end_test');
    return;
  end ut_suite_reporter;

  member function is_valid(self in out nocopy ut_suite_reporter) return boolean is
    v_retval boolean := false;
  begin
    if package_name is null then
      return false;
    end if;
  
    if ut_metadata.do_resolve(owner_name, package_name, begin_suite_procedure) then
      v_retval := true;
    end if;
    if ut_metadata.do_resolve(owner_name, package_name, end_suite_procedure) then
      v_retval := true;
    end if;
    if ut_metadata.do_resolve(owner_name, package_name, begin_test_procedure) then
      v_retval := true;
    end if;
    if ut_metadata.do_resolve(owner_name, package_name, end_test_procedure) then
      v_retval := true;
    end if;
  
    return v_retval; --will be true if at least one of the procedures is valid
  end is_valid;

  member function begin_suite_stmt(self in ut_suite_reporter) return varchar2 is
  begin
    if trim(begin_suite_procedure) is null or trim(package_name) is null then
      return null;
    end if;
  
    if trim(owner_name) is not null then
      return trim(owner_name) || '.' || package_name || '.' || begin_suite_procedure || '(:suite)';
    else
      return package_name || '.' || begin_suite_procedure || '(:suite)';
    end if;
  end begin_suite_stmt;

  member function end_suite_stmt(self in ut_suite_reporter) return varchar2 is
  begin
    if trim(end_suite_procedure) is null or trim(package_name) is null then
      return null;
    end if;
  
    if trim(owner_name) is not null then
      return trim(owner_name) || '.' || package_name || '.' || end_suite_procedure || '(:suite,:results)';
    else
      return package_name || '.' || end_suite_procedure || '(:suite,:results)';
    end if;
  end end_suite_stmt;
	
  member function begin_test_stmt(self in ut_suite_reporter) return varchar2 is
  begin
    if trim(begin_test_procedure) is null or trim(package_name) is null then
      return null;
    end if;
  
    if trim(owner_name) is not null then
      return trim(owner_name) || '.' || package_name || '.' || begin_test_procedure || '(:test,:insuite)';
    else
      return package_name || '.' || begin_test_procedure || '(:test,:insuite)';
    end if;
  end begin_test_stmt;
	
  member function end_test_stmt(self in ut_suite_reporter) return varchar2 is
  begin
    if trim(end_test_procedure) is null or trim(package_name) is null then
      return null;
    end if;
  
    if trim(owner_name) is not null then
      return trim(owner_name) || '.' || package_name || '.' || end_test_procedure || '(:test,:result,:insuite)';
    else
      return package_name || '.' || end_test_procedure || '(:test,:result,:insuite)';
    end if;
  end end_test_stmt;

end;
/
