create or replace type ut_test_suite as object
(
  suite_name varchar2(50 char),
  tests      ut_test_list
)
not final
/
