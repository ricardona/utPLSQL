create or replace package ut_test_execute authid current_user as
  /*
    Package : ut_test_execute
    Purpose is to execute a single test, used *internally* by ut_test_runner.
  */

  procedure execute_test(a_test_to_execute in ut_single_test, a_test_result out ut_execution_result);
end ut_test_execute;
/
