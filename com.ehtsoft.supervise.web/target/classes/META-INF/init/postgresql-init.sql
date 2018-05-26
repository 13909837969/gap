--创建地理坐标点距离插件函数
create extension cube;
create extension earthdistance;
--创建uuid生成库
create extension "uuid-ossp";
--select uuid_generate_v4();


create or replace function ltrhao_delete_register_userinfo(v_aid varchar) 
RETURNS void
as
$BODY$
begin
delete from JZ_COLLECT_USER where F_ID = v_aid;
delete from IM_USERINFO_FRIEND where f_aid0 = v_aid or f_aid1 = v_aid;
delete from IM_GROUP_USER where F_AID = v_aid;
delete from IM_USERINFO_ACCOUNT where F_AID = v_aid;
delete from IM_USERINFO where F_AID = v_aid;
UPDATE JZ_JZRYJBXX SET BDQK = '03',ONLINE='0' WHERE ID = v_aid;
end;
$BODY$
LANGUAGE plpgsql;


-- 初始化
CREATE OR REPLACE FUNCTION public.ltrhao_init_audit_config()
  RETURNS void AS
$BODY$
DECLARE

  var_cursor  refcursor;
  v_orgid VARCHAR;
  v_jgmc VARCHAR;
	v_teamid VARCHAR;

	var_billcur refcursor;
  v_billid VARCHAR;
begin
	open var_cursor  for execute 'select id,jgmc from jc_sfxzjgjbxx';
  loop
		FETCH var_cursor  into v_orgid,v_jgmc;
		if FOUND THEN
			raise notice '%',v_orgid;
			BEGIN
				open var_billcur for EXECUTE 'select f_id from sys_audit_bill';
				loop
					FETCH var_billcur INTO v_billid;
					if found then
						v_teamid = uuid_generate_v4();
						-- sys_audit_team
						insert into sys_audit_team(f_teamid,f_teamname,f_flag,f_billid,orgid) 
						VALUES(v_teamid,v_jgmc||'审批组',0,v_billid,v_orgid);
					ELSE
						exit;
          end if;
				end loop;
				close var_billcur;
			end;
		ELSE
			exit;
		end if;
	end loop; 
  close var_cursor;
	-- SYS_AUDIT_TEAM_APPROVER
	insert into SYS_AUDIT_TEAM_APPROVER(f_id,f_teamid,f_approver,orgid)
	select uuid_generate_v4(),t.f_teamid,c.id as approverid,t.orgid from SYS_AUDIT_TEAM t inner join jc_sfxzjgjbxx j on t.orgid = j.id 
	inner join jc_sfxzjggzryjbxx c on t.orgid = c.orgid;
	-- sys_audit_config
	insert into sys_audit_config(f_id,f_billid,f_approver,f_lvl,orgid,f_teamid)
	select uuid_generate_v4(),f_billid,f_teamid,1,orgid,f_teamid from SYS_AUDIT_TEAM;
   raise notice '====the end===== ';
   EXCEPTION when OTHERS THEN
			raise EXCEPTION 'error------(%)',SQLERROR;
end;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION public.ltrhao_init_audit_config()
  OWNER TO postgres;

-- 根据orgid 删除全部需要审批的数据及已经审批的垃圾数据
-- Function: public.ltrhao_delete_audit_data(character varying)

-- DROP FUNCTION public.ltrhao_delete_audit_data(character varying);

CREATE OR REPLACE FUNCTION public.ltrhao_delete_audit_data(v_orgid character varying)
  RETURNS void AS
$BODY$
DECLARE
  var_cursor  refcursor;
  var_tname VARCHAR;
  var_delsql VARCHAR;
begin
  open var_cursor  for execute 'select f_id as tname from sys_audit_bill';
  loop
	FETCH var_cursor  into var_tname;
	if FOUND THEN
		  -- raise notice '%',var_tname;
		BEGIN
		  var_delsql = 'delete from '||var_tname||' where orgid = '''||v_orgid||'''';
		  -- raise notice '%',var_delsql;
		  EXECUTE var_delsql;
		end;
	ELSE
		exit;
	end if;
  end loop; 
  close var_cursor;

  delete from sys_audit_approver where f_applyid in (select f_id from sys_audit_apply where orgid = v_orgid);
  delete from sys_audit_result where f_applyid in (select f_id from sys_audit_apply where orgid = v_orgid);
  delete from sys_audit_apply where orgid = v_orgid;

   EXCEPTION when OTHERS THEN
			raise EXCEPTION 'error------(%)',SQLERROR;
end;
$BODY$
  LANGUAGE plpgsql VOLATILE;



