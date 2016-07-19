create or replace type ut_test_object as object
(
  name varchar2(250 char),

  not instantiable member procedure run(self in out ut_test_object),
  not instantiable member procedure execute(self in out nocopy ut_test_object, a_reporters in ut_suite_reporters),
  not instantiable member procedure execute(self in out nocopy ut_test_object, a_reporter in ut_suite_reporter),
  not instantiable member procedure execute(self in out nocopy ut_test_object)
)
not instantiable not final
/
