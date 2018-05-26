-- Function: fun_delete_core_organization(character varying)

-- DROP FUNCTION fun_delete_core_organization(character varying);

CREATE OR REPLACE FUNCTION fun_delete_core_organization(porgcode character varying)
  RETURNS void AS
$BODY$
declare
  vsysid integer;
begin
   select sysid into vsysid from core_organization where orgcode = porgcode;
   raise notice 'sysid %',vsysid;
   delete  from core_account_role where accountid in(select sysid from core_account where userid in (select sysid from core_personnel where orgid=vsysid));
   delete  from core_account_role where accountid in(select sysid from core_account where accountid = porgcode);
   delete  from core_shortcut where accountid in(select sysid from core_account where userid in (select sysid from core_personnel where orgid=vsysid));
   delete  from core_shortcut where accountid in(select sysid from core_account where accountid = porgcode);
   delete  from core_account_organization where orgid = vsysid;
   delete  from core_account where userid in (select sysid from core_personnel where orgid=vsysid);
   delete  from core_account where accountid = porgcode;
   delete  from core_personnel where orgid =vsysid; 
   delete  from core_organization_role where orgid = vsysid;
   delete  from core_organization where sysid = vsysid;
end;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION fun_delete_core_organization(character varying)
  OWNER TO postgres;
