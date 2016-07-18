create or replace type ut_suite_reporter as object
(
  name varchar2(32 char),

  --not instantiable constructor function ut_suite_reporter return self as result,

  --not instantiable member procedure is_valid(self in out nocopy ut_suite_reporter) return boolean,
  not instantiable member procedure begin_suite(self in ut_suite_reporter, a_suite in ut_test_suite),
  not instantiable member procedure end_suite(self in ut_suite_reporter, a_suite in ut_test_suite),
  not instantiable member procedure begin_test(self in ut_suite_reporter, a_test in ut_single_test, a_in_suite in boolean),
  not instantiable member procedure end_test(self in ut_suite_reporter, a_test in ut_single_test, a_in_suite in boolean)

)
not instantiable not final
/
