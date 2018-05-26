CREATE OR REPLACE FUNCTION func_core_delete_application(v_appcode character varying)
  RETURNS void AS
$BODY$
begin
delete from core_shortcut where menuid in (select sysid from core_menu where appid in (select sysid from core_application where appcode=v_appcode));
delete from core_account_menu where menuid in (select sysid from core_menu where appid in (select sysid from core_application where appcode=v_appcode));
delete from core_role_menu where menuid in (select sysid from core_menu where appid in (select sysid from core_application where appcode=v_appcode));
delete from core_account_firstpage where menuid  in (select sysid from core_menu where appid in (select sysid from core_application where appcode=v_appcode));
delete from core_menu where appid in (select sysid from core_application where appcode=v_appcode);
delete from core_application where appcode=v_appcode;
end;
$BODY$
language plpgsql;