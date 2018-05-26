CREATE OR REPLACE FUNCTION func_core_delete_role(v_rolecode character varying)
  RETURNS void AS
$BODY$
begin
delete from core_role_portal where roleid in (select sysid from core_role where rolecode = v_rolecode);
delete from core_role_menu where roleid in (select sysid from core_role where rolecode = v_rolecode);
delete from core_account_role where roleid in (select sysid from core_role where rolecode = v_rolecode);
delete from core_organization_role where roleid in (select sysid from core_role where rolecode = v_rolecode);
delete from core_role where rolecode = v_rolecode;
end;
$BODY$
language plpgsql;