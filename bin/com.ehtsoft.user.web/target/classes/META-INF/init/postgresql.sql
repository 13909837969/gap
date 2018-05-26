create or replace function ltrhao_core_del_organization(orgid varchar)
  returns void as
$body$
begin
delete from core_organization_role where orgid = v_orgid;
delete from core_organization where sysid = v_orgid;
delete from core_account_role where accountid in (select accountid from core_account_organization where orgid = v_orgid);
delete from core_account_bill where accountid in (select accountid from core_account_organization where orgid = v_orgid);
delete from core_account_firstpage where accountid in (select accountid from core_account_organization where orgid = v_orgid);
delete from core_account_workgroup where accountid in (select accountid from core_account_organization where orgid = v_orgid);
delete from core_account_menu where accountid in (select accountid from core_account_organization where orgid = v_orgid);
delete from core_shortcut where accountid in (select accountid from core_account_organization where orgid = v_orgid);
delete from core_account where sysid in (select accountid from core_account_organization where orgid = v_orgid);
delete from core_account_organization where orgid = v_orgid;
delete from core_personnel where orgid = v_orgid;
delete from core_role where orgid = v_orgid;
end;
$body$
language plpgsql;