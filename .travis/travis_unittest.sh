#!/bin/bash

set -ev

cd test

"$ORACLE_HOME/bin/sqlplus" -L -S utc/utc <<SQL
@utPLSQL_selftest.sql
exit
SQL

