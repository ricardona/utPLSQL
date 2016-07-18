create or replace type ut_assert_result as object
(
-- Author  : PAVEL.KAPLYA
-- Created : 18.07.2016 18:33:50
-- Purpose : 

-- Attributes
  result  integer(1),
  message varchar2(4000 char),

-- Member functions and procedures
  member function result_to_char(self in ut_assert_result) return varchar2
)
not final
/
