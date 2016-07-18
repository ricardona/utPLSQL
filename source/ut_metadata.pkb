create or replace package body ut_metadata as

  function package_valid(a_owner_name varchar2, a_package_name in varchar2) return boolean as
    v_cnt integer;
  begin
    --maybe use DBMS_UTILITY.NAME_RESOLVE first
  
    select count(*)
      into v_cnt
      from all_objects
     where owner = a_owner_name
       and object_name = a_package_name
       and object_type in ('PACKAGE', 'PACKAGE BODY')
       and status = 'VALID';
  
    -- expect both package and body to be valid
    return v_cnt = 2;
  end;

  function procedure_exists(a_owner_name varchar2, a_package_name in varchar2, a_procedure_name in varchar2)
    return boolean as
    v_cnt integer;
  begin
    if a_owner_name is null or a_package_name is null or a_procedure_name is null then
      return false;
    end if;
    select count(*)
      into v_cnt
      from all_procedures
     where owner = a_owner_name
       and object_name = a_package_name
       and procedure_name = a_procedure_name;
    --expect one method only for the package with that name.
    return v_cnt = 1;
  end;

  function do_resolve(the_owner in out varchar2, the_object in out varchar2, a_procedurename in out varchar2)
    return boolean is
    name          varchar2(200);
    context       number;
    schema        varchar2(200);
    part1         varchar2(200);
    part2         varchar2(200);
    dblink        varchar2(200);
    part1_type    number;
    object_number number;
  begin
  
    name := the_object;
    if trim(the_owner) is not null then
      name := trim(the_owner) || '.' || name;
    end if;
    if trim(a_procedurename) is not null then
      name := name || '.' || a_procedurename;
    end if;
  
    context := 1; --plsql
  
    dbms_utility.name_resolve(name          => name
                             ,context       => context
                             ,schema        => schema
                             ,part1         => part1
                             ,part2         => part2
                             ,dblink        => dblink
                             ,part1_type    => part1_type
                             ,object_number => object_number);
    the_owner       := schema;
    the_object      := part1;
    a_procedurename := part2;
    return true;
  
  exception
    when others then
      --replace with correct exception
      return false;
  end;

end;
/
