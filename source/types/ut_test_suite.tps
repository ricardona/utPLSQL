create or replace type ut_test_suite as object
(
  suite_name varchar2(50 char),
  tests      ut_test_list,
	
	constructor function ut_test_suite(a_suite_name varchar2, a_tests ut_test_list default ut_test_list()) return self as result,
	member procedure add_test(self in out nocopy ut_test_suite, a_test ut_single_test)
)
not final
/
