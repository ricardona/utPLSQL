create or replace type body ut_dbms_output_suite_reporter is

  static function c_dashed_line return varchar2 is
  begin
    return '--------------------------------------------------------------------------------';
  end;

  constructor function ut_dbms_output_suite_reporter return self as result is
  begin
    self.name := $$plsql_unit;
  end;

  overriding member procedure begin_suite(self in ut_dbms_output_suite_reporter, a_suite in ut_test_suite) as
  begin
    dbms_output.put_line(ut_dbms_output_suite_reporter.c_dashed_line);
    dbms_output.put_line('suite "' || nvl(a_suite.suite_name, '') || '" started.');
  end;

  overriding member procedure end_suite(self in ut_dbms_output_suite_reporter, a_suite in ut_test_suite) as
  begin
    --todo: report total suite result here with pretty message
    dbms_output.put_line(ut_dbms_output_suite_reporter.c_dashed_line);
    dbms_output.put_line('suite "' || nvl(a_suite.suite_name, '') || '" ended.');
    dbms_output.put_line(ut_dbms_output_suite_reporter.c_dashed_line);
  end;

  overriding member procedure begin_test(self in ut_dbms_output_suite_reporter, a_test in ut_single_test, a_in_suite in boolean) as
  begin
    null;
  end;

  overriding member procedure end_test(self in ut_dbms_output_suite_reporter, a_test in ut_single_test, a_in_suite in boolean) as
  begin
    dbms_output.put_line(ut_dbms_output_suite_reporter.c_dashed_line);
    dbms_output.put_line('test  ' || nvl(a_test.owner_name, '') || nvl(a_test.object_name, '') || '.' ||
                         nvl(a_test.test_procedure, ''));
    dbms_output.put_line('result: ' || a_test.test_result.result_to_char);
    dbms_output.put_line('asserts');
    for i in a_test.test_result.assert_results.first .. a_test.test_result.assert_results.last loop
      dbms_output.put('assert ' || i || ' ' || a_test.test_result.assert_results(i).result_to_char);
      dbms_output.put_line(' message: ' || a_test.test_result.assert_results(i).message);
    end loop;
  end;

end;
/
