create or replace type body ut_test_suite is

  constructor function ut_test_suite(a_suite_name varchar2, a_items ut_test_objects_list default ut_test_objects_list())
    return self as result is
  begin
    self.name := a_suite_name;
    self.items      := a_items;
    return;
  end ut_test_suite;

  member procedure add_test(self in out nocopy ut_test_suite, a_item ut_test_object) is
  begin
    self.items.extend;
    self.items(self.items.last) := a_item;
  end add_test;

  overriding member procedure execute(self in out nocopy ut_test_suite, a_reporter in ut_suite_reporter) is
  begin
    a_reporter.begin_suite(self.name);
		
		for i in self.items.first..self.items.last loop
			self.items(i).execute(a_reporter => a_reporter);
			end loop;
			
		a_reporter.end_suite(self.name, self.execution_result);
  end;

  overriding member procedure execute(self in out nocopy ut_test_suite) is
  begin
	  null;
    --self.execute_tests(ut_reporter_execution.get_default_reporter);
  end;

end;
/
