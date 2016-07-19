create or replace type ut_suite_reporter force under ut_abstract_suite_reporter
(
--  name varchar2(250 char),

  not instantiable member procedure begin_suite(self in ut_suite_reporter, a_suite in ut_test_suite),
  not instantiable member procedure end_suite(self in ut_suite_reporter, a_suite in ut_test_suite),
  not instantiable member procedure begin_test(self in ut_suite_reporter, a_test in ut_single_test),
  not instantiable member procedure end_test(self in ut_suite_reporter, a_test in ut_single_test)

)
not instantiable not final
/
