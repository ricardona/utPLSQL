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

  member procedure execute_tests(self int out nocopy ut_test_suite, a_reporters in ut_suite_reporters) is
  begin
    ut_reporter_execution.begin_suite(a_reporters, self);
  
    for i in a_suite.tests.first .. a_suite.tests.last loop
      a_suite.tests(i).execute(a_reporters, true);
    end loop;
  
    ut_reporter_execution.end_suite(a_reporters, self);
  end;
	
  member procedure execute_tests(self int out nocopy ut_test_suite, a_reporter in ut_suite_reporter) is
  begin
    self.execute_tests(ut_suite_reporters(a_reporter));
  end;
	
  member procedure execute_tests(self int out nocopy ut_test_suite) is
  begin
    self.execute_tests(ut_reporter_execution.get_default_reporters);
  end;

end;
/
