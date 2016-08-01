#!/bin/sh

# Based http://stackoverflow.com/questions/3779569/check-database-connectivity-using-shell-script

DB_OK=1

echo "Wait until DB is up"
while [ $DB_OK = 1 ]
do
  echo "exit" | $ORACLE_HOME/bin/sqlplus -L system/oracle | grep Connected > /dev/null
  if [ $? -eq 0 ]
  then
     echo "OK"
     DB_OK=0
  else
     echo "DB not up yet. Sleeping for 5 seconds"
     sleep 5
     DB_OK=1
  fi

done

echo "DB is UP"
