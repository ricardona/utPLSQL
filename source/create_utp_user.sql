create user utp identified by utp;

grant create session, create table, create procedure,
  create sequence, create view, create public synonym,
  drop public synonym to utp;

grant unlimited tablespace to utp;

exit;
