create or replace type ut_test_call_params as object
(
  -- Author  : PAVEL.KAPLYA
  -- Created : 19.07.2016 15:18:40
  -- Purpose : 
  
  -- Attributes
    object_name        varchar2(32 char),
		test_procedure     varchar2(32 char),
		owner_name         varchar2(32 char),
		setup_procedure    varchar2(32 char),
		teardown_procedure varchar2(32 char)
) final
/
