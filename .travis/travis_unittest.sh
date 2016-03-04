#!/bin/bash

set -ev


"$ORACLE_HOME/bin/sqlplus" -L -S utc/utc <<SQL
@examples/run_test.sql
exit
SQL

