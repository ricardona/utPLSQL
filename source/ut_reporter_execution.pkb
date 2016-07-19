create or replace package body ut_reporter_execution as

  function get_default_reporters return ut_suite_reporters is
  begin
    return ut_suite_reporters(ut_dbms_output_suite_reporter);
  end get_default_reporters;

  procedure begin_suite(a_reporter in ut_suite_reporter, a_suite in ut_test_suite) as
  begin
    a_reporter.begin_suite(a_suite);
  end;

  procedure end_suite(a_reporter in ut_suite_reporter, a_suite in ut_test_suite, a_results in ut_suite_results) as
    stmt varchar2(100);
  begin
    a_reporter.end_suite(a_suite);
  end;
  procedure begin_test(a_reporter in ut_suite_reporter, a_test in ut_single_test, a_in_suite in boolean) as
    stmt varchar2(100);
  begin
    a_reporter.begin_test(a_test, a_in_suite);
  end;
  procedure end_test(a_reporter in ut_suite_reporter, a_test in ut_single_test,  a_in_suite in boolean) as
    stmt varchar2(100);
  begin
    a_reporter.end_test(a_test, a_in_suite);
  end;

  procedure begin_suite(a_reporters in ut_suite_reporters, a_suite in ut_test_suite) as
  begin
    if a_reporters is not null then
      for i in a_reporters.first .. a_reporters.last loop
        begin_suite(a_reporters(i), a_suite);
      end loop;
    end if;
  end;

  procedure end_suite(a_reporters in ut_suite_reporters, a_suite in ut_test_suite) as
  begin
    if a_reporters is not null then
      for i in a_reporters.first .. a_reporters.last loop
        end_suite(a_reporters(i), a_suite);
      end loop;
    end if;
  end;
  procedure begin_test(a_reporters in ut_suite_reporters, a_test in ut_single_test, a_in_suite in boolean) as
  begin
    if a_reporters is not null then
      for i in a_reporters.first .. a_reporters.last loop
        begin_test(a_reporters(i), a_test, a_in_suite);
      end loop;
    end if;
  
  end;
  procedure end_test(a_reporters in ut_suite_reporters, a_test in ut_single_test, a_in_suite in boolean) as
  begin
    if a_reporters is not null then
      for i in a_reporters.first .. a_reporters.last loop
        end_test(a_reporters(i), a_test, a_in_suite);
      end loop;
    end if;
  end;

end;
/
