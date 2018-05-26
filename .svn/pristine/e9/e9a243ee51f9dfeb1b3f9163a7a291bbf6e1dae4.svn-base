CREATE OR REPLACE FUNCTION fun_core_init_osa_role()
  RETURNS void AS
$BODY$
declare
account cursor is SELECT sysid FROM CORE_ACCOUNT WHERE rule = 'OSA';
begin
  for cur in account loop
  DELETE FROM CORE_ACCOUNT_ROLE WHERE ACCOUNTID = cur.sysid;
  INSERT INTO CORE_ACCOUNT_ROLE(accountid,roleid) select cur.sysid,sysid from CORE_ROLE WHERE RULE = 'OSA';
  INSERT INTO CORE_SHORTCUT SELECT cur.sysid,MENUID FROM CORE_ROLE_MENU WHERE ROLEID IN (select sysid from CORE_ROLE WHERE RULE = 'OSA');
  end loop;
end;
$BODY$
LANGUAGE plpgsql