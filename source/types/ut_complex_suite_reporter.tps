create or replace type ut_complex_suite_reporter under ut_suite_reporter
(
  -- Author  : PAVEL.KAPLYA
  -- Created : 19.07.2016 11:36:53
  -- Purpose : 
  
  -- Attributes
  reporters ut_suite_reporters,
  
  -- Member functions and procedures
	constructor function ut_complex_suite_reporter return self as result,
  member procedure add_reporter(self in out nocopy ut_complex_suite_reporter, a_reporter ut_suite_reporter),

  overriding member procedure begin_suite(self in ut_complex_suite_reporter, a_suite in ut_test_suite),
  overriding member procedure end_suite(self in ut_complex_suite_reporter, a_suite in ut_test_suite),
  overriding member procedure begin_test(self in ut_complex_suite_reporter, a_test in ut_single_test),
  overriding member procedure end_test(self in ut_complex_suite_reporter, a_test in ut_single_test)
	
) not final
/
