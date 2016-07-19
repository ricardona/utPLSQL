create or replace type ut_dbms_output_suite_reporter under ut_suite_reporter
(


  constructor function ut_dbms_output_suite_reporter
    return self as result,

	static function c_dashed_line return varchar2,
  overriding member procedure begin_suite(self in ut_dbms_output_suite_reporter, a_suite in ut_test_suite),
  overriding member procedure end_suite(self in ut_dbms_output_suite_reporter, a_suite in ut_test_suite),
  overriding member procedure begin_test(self in ut_dbms_output_suite_reporter, a_test in ut_single_test),
  overriding member procedure end_test(self in ut_dbms_output_suite_reporter, a_test in ut_single_test)
)
/
