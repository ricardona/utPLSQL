#!/bin/bash

set -ev

cd source

"$ORACLE_HOME/bin/sqlplus" -L -S / AS SYSDBA <<SQL
@code/create_owner.sql
exit
SQL

"$ORACLE_HOME/bin/sqlplus" -L -S utc/utc <<SQL
@code/create_schema.sql
exit
SQL

