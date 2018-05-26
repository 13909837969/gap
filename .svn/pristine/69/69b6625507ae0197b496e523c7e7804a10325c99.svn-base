CREATE OR REPLACE FUNCTION fun_delete_core_organizations(flag character varying)
  RETURNS void AS
$BODY$
declare
  cur cursor is select sysid,orgcode,orgname,preflag from core_organization where lvl>=4 and preflag is null;
begin
if(flag = 'nopreflag') then
  for c in cur loop
   execute  fun_delete_core_organization(c.orgcode);
  end loop;
 end if;
end;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION fun_delete_core_organizations(character varying)
  OWNER TO postgres;
