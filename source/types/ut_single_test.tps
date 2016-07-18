create or replace type ut_single_test as object
(

  object_name        varchar2(32 char),
  test_procedure     varchar2(32 char),
  owner_name         varchar2(32 char),
  setup_procedure    varchar2(32 char),
  teardown_procedure varchar2(32 char),

  constructor function ut_single_test(a_object_name varchar2, a_test_procedure varchar2, a_owner_name varchar2 default null, a_setup_procedure varchar2 default null, a_teardown_procedure varchar2 default null)
    return self as result,

  member function is_valid(self in ut_single_test) return boolean,
  member function setup_stmt(self in ut_single_test) return varchar2,
  member function test_stmt(self in ut_single_test) return varchar2,
  member function teardown_stmt(self in ut_single_test) return varchar2,
	
	member procedure execute(self in ut_single_test, a_test_result out ut_execution_result)
)
not final
/
