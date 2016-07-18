create or replace type body ut_execution_result is

  member function result_to_char(self in ut_execution_result) return varchar2 is
  begin
    return ut_types.test_result_to_char(self.result);
  end result_to_char;

end;
/
