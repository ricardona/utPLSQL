#!/bin/bash

set -ev


"$ORACLE_HOME/bin/sqlplus" -L -S utc/utc <<SQL
@examples/betwnstr.fnc
@examples/ut_betwnstr.pks
@examples/ut_betwnstr.pkb
@examples/run_test.sql
exit
SQL

