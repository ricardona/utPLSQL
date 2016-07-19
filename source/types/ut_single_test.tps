create or replace type ut_single_test under ut_test_object
(

  object_name        varchar2(32 char),
  test_procedure     varchar2(32 char),
  owner_name         varchar2(32 char),
  setup_procedure    varchar2(32 char),
  teardown_procedure varchar2(32 char),
  test_result        ut_execution_result,

  constructor function ut_single_test(a_object_name varchar2, a_test_procedure varchar2, a_name in varchar2 default null, a_owner_name varchar2 default null, a_setup_procedure varchar2 default null, a_teardown_procedure varchar2 default null)
    return self as result,

  member function is_valid(self in ut_single_test) return boolean,
  member function setup_stmt(self in ut_single_test) return varchar2,
  member function test_stmt(self in ut_single_test) return varchar2,
  member function teardown_stmt(self in ut_single_test) return varchar2,

  overriding member procedure run(self in out ut_single_test),
  overriding member procedure execute(self in out nocopy ut_single_test, a_reporter in ut_suite_reporter),
  overriding member procedure execute(self in out nocopy ut_single_test)

)
not final
/
