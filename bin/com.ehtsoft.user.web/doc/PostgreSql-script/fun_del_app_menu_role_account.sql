CREATE OR REPLACE FUNCTION fun_del_app_menu_role_account(command character varying)
  RETURNS void AS
$BODY$
begin
if (command='clearAll') then
DELETE FROM CORE_SHORTCUT;
DELETE FROM CORE_PERSONNEL WHERE SYSID IN( SELECT USERID FROM CORE_ACCOUNT WHERE RULE IN ('PSA'));
DELETE FROM CORE_ACCOUNT_FIRSTPAGE WHERE ACCOUNTID IN (SELECT SYSID FROM CORE_ACCOUNT WHERE RULE IN ('PSA'));
DELETE FROM CORE_ACCOUNT_ORGANIZATION WHERE ACCOUNTID IN(SELECT SYSID FROM CORE_ACCOUNT WHERE RULE IN ('PSA'));
DELETE FROM CORE_ACCOUNT_ROLE WHERE ACCOUNTID IN (SELECT SYSID FROM CORE_ACCOUNT WHERE RULE IN ('PSA'));
DELETE FROM CORE_ACCOUNT_WORKGROUP WHERE ACCOUNTID IN (SELECT SYSID FROM CORE_ACCOUNT WHERE RULE IN ('PSA'));
DELETE FROM CORE_ACCOUNT WHERE RULE IN ('PSA');

DELETE FROM CORE_ROLE_PORTAL WHERE ROLEID IN (SELECT SYSID FROM CORE_ROLE WHERE RULE IN ('OSA','PSA'));
DELETE FROM CORE_ROLE_MENU WHERE ROLEID IN (SELECT SYSID FROM CORE_ROLE WHERE RULE IN ('OSA','PSA'));
DELETE FROM CORE_ACCOUNT_ROLE WHERE ROLEID IN (SELECT SYSID FROM CORE_ROLE WHERE RULE IN ('OSA','PSA'));

DELETE FROM CORE_ROLE WHERE RULE IN ('OSA','PSA');



DELETE FROM CORE_MENU;
DELETE FROM CORE_APPLICATION;

end if;
end;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;