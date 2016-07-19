create or replace type body ut_complex_suite_reporter is

  -- Member procedures and functions
  constructor function ut_complex_suite_reporter return self as result is
  begin
    self.name      := $$plsql_unit;
    self.reporters := ut_suit_reporters();
    return;
  end;

  member procedure add_reporter(self in out nocopy ut_complex_suite_reporter, a_reporter ut_suite_reporter) is
  begin
    self.reporters.extend;
    self.reporters(self.reporters.last) := a_reporter;
  end add_reporter;

  overriding member procedure begin_suite(self in ut_complex_suite_reporter, a_suite in ut_test_suite) as
  begin
    for i in self.reporters.first .. self.reporters.last loop
      self.reporters(i).begin_suite(a_suite);
    end loop;
  end;

  overriding member procedure end_suite(self in ut_complex_suite_reporter, a_suite in ut_test_suite) as
  begin
    for i in self.reporters.first .. self.reporters.last loop
      self.reporters(i).end_suite(a_suite);
    end loop;
  end;

  overriding member procedure begin_test(self in ut_complex_suite_reporter, a_test in ut_single_test) as
  begin
    for i in self.reporters.first .. self.reporters.last loop
      self.reporters(i).begin_test(a_suite);
    end loop;
  end;

  overriding member procedure end_test(self in ut_complex_suite_reporter, a_test in ut_single_test) as
  begin
    for i in self.reporters.first .. self.reporters.last loop
      self.reporters(i).end_test(a_suite);
    end loop;
  end;

end;
/
