create or replace type ut_test_suite as object
(
  suite_name varchar2(50 char),
  tests      ut_test_list,

	constructor function ut_test_suite(a_suite_name varchar2, a_tests ut_test_list default ut_test_list()) return self as result,
	member procedure add_test(self in out nocopy ut_test_suite, a_test ut_single_test),
	member procedure execute_tests(self int out nocopy ut_test_suite, a_reporters in ut_suite_reporters),
	member procedure execute_tests(self int out nocopy ut_test_suite, a_reporter in ut_suite_reporter),
	member procedure execute_tests(self int out nocopy ut_test_suite)
)
not final
/
