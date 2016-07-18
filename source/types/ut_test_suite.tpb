create or replace type body ut_test_suite is

  constructor function ut_test_suite(a_suite_name varchar2, a_tests ut_test_list default ut_test_list())
    return self as result is
  begin
    self.suite_name := a_suite_name;
    self.tests      := a_tests;
    return;
  end ut_test_suite;

  member procedure add_test(self in out nocopy ut_test_suite, a_test ut_single_test) is
  begin
    self.tests.extend;
    self.tests(self.tests.last) := a_test;
  end add_test;

end;
/
