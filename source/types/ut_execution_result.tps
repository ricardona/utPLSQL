create or replace type ut_execution_result as object
(
-- Author  : PAVEL.KAPLYA
-- Created : 18.07.2016 18:31:47
-- Purpose :

-- Attributes
  test           ut_single_test,
  start_time     timestamp with time zone,
  end_time       timestamp with time zone,
  result         integer(1),
  assert_results ut_assert_list,

-- Member functions and procedures
--  member procedure <ProcedureName>(<Parameter> <Datatype>)
  member function result_to_char(self in ut_execution_result) return varchar2
)
not final
/
