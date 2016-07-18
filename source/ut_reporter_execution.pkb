create or replace package body ut_reporter_execution as

  procedure begin_suite(a_reporter in ut_suite_reporter, a_suite in ut_test_suite) as
  begin
    if ut_metadata.package_valid(a_reporter.owner_name, a_reporter.package_name) and
       ut_metadata.procedure_exists(a_reporter.owner_name, a_reporter.package_name, a_reporter.begin_suite_procedure) then
      execute immediate 'begin ' || nvl(a_reporter.begin_suite_stmt, 'NULL') || '; end;'
        using a_suite;
    end if;
  end;

  procedure end_suite(a_reporter in ut_suite_reporter, a_suite in ut_test_suite, a_results in ut_suite_results) as
    stmt varchar2(100);
  begin
    if ut_metadata.package_valid(a_reporter.owner_name, a_reporter.package_name) and
       ut_metadata.procedure_exists(a_reporter.owner_name, a_reporter.package_name, a_reporter.end_suite_procedure) then
      stmt := 'begin ' || nvl(a_reporter.end_suite_stmt, 'NULL') || '; end;';
      execute immediate stmt
        using a_suite, a_results;
    end if;
  end;
  procedure begin_test(a_reporter in ut_suite_reporter, a_test in ut_single_test, a_in_suite in boolean) as
    stmt varchar2(100);
  begin
    if ut_metadata.package_valid(a_reporter.owner_name, a_reporter.package_name) and
       ut_metadata.procedure_exists(a_reporter.owner_name, a_reporter.package_name, a_reporter.begin_test_procedure) then
      stmt := 'begin ' || nvl(a_reporter.begin_test_stmt, 'NULL') || '; end;';
      execute immediate stmt
        using a_test, sys.diutil.bool_to_int(a_in_suite);
    end if;
  end;
  procedure end_test(a_reporter in ut_suite_reporter, a_test in ut_single_test, a_result ut_execution_result, a_in_suite in boolean) as
    stmt varchar2(100);
  begin
    if ut_metadata.package_valid(a_reporter.owner_name, a_reporter.package_name) and
       ut_metadata.procedure_exists(a_reporter.owner_name, a_reporter.package_name, a_reporter.end_test_procedure) then
      stmt := 'begin ' || nvl(a_reporter.end_test_stmt, 'NULL') || '; end;';
      execute immediate stmt
        using a_test, a_result, sys.diutil.bool_to_int(a_in_suite);
    end if;
  end;

  procedure begin_suite(a_reporters in ut_suite_reporters, a_suite in ut_test_suite) as
  begin
    if a_reporters is not null then
      for i in a_reporters.first .. a_reporters.last loop
        begin_suite(a_reporters(i), a_suite);
      end loop;
    end if;
  end;

  procedure end_suite(a_reporters in ut_suite_reporters, a_suite in ut_test_suite, a_results in ut_suite_results) as
  begin
    if a_reporters is not null then
      for i in a_reporters.first .. a_reporters.last loop
        end_suite(a_reporters(i), a_suite, a_results);
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
  procedure end_test(a_reporters in ut_suite_reporters, a_test in ut_single_test, a_result ut_execution_result, a_in_suite in boolean) as
  begin
    if a_reporters is not null then
      for i in a_reporters.first .. a_reporters.last loop
        end_test(a_reporters(i), a_test, a_result, a_in_suite);
      end loop;
    end if;
  end;

end;
/
