create or replace type ut_suite_reporter as object
(
  owner_name            varchar2(32 char),
  package_name          varchar2(32 char),
  begin_suite_procedure varchar2(32 char),
  end_suite_procedure   varchar2(32 char),
  begin_test_procedure  varchar2(32 char),
  end_test_procedure    varchar2(32 char),

  constructor function ut_suite_reporter(a_owner_name varchar2, a_package_name varchar2, a_begin_suite_procedure varchar2 default null, a_end_suite_procedure varchar2 default null, a_begin_test_procedure varchar2 default null, a_end_test_procedure varchar2 default null)
    return self as result,

  member function is_valid(self in out nocopy ut_suite_reporter) return boolean,
  member function begin_suite_stmt(self in ut_suite_reporter) return varchar2,
  member function end_suite_stmt(self in ut_suite_reporter) return varchar2,
  member function begin_test_stmt(self in ut_suite_reporter) return varchar2,
  member function end_test_stmt(self in ut_suite_reporter) return varchar2

)
not final
/
