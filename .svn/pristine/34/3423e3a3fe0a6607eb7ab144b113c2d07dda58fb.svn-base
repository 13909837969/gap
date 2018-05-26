CREATE OR REPLACE FUNCTION fun_core_update_proxy_sysid()
  RETURNS void AS
$BODY$
declare
 tables varchar := 'CORE_ACCOUNT,CORE_APPLICATION,CORE_MENU,CORE_ORGANIZATION,CORE_PERSONNEL,CORE_PORTAL,CORE_ROLE,CORE_SCENE';
 sqlstr varchar;
 maxv int;
 cnt int;
 part varchar := '';
begin
 --CORE_ACCOUNT,CORE_APPLICATION,CORE_MENU,CORE_ORGANIZATION,CORE_PERSONNEL,CORE_PORTAL,CORE_ROLE,CORE_SCENE
FOR i IN 1..10 LOOP
 part := split_part(tables,',',i);
 if(part<>'') then
	 sqlstr:='select max(sysid) from ' ||part||';';
	 execute sqlstr into maxv;
	 if(maxv is null) then
	    maxv:=0;
	 end if;
	 sqlstr:='select count(1) from core_proxy_primary where tablename='''||part||''';';
	 execute sqlstr into cnt;
	 if(cnt=0) then
		execute 'insert into core_proxy_primary values('''||part||''','||(maxv+1)||');';
	 else
		execute 'update core_proxy_primary set sysid='||(maxv+1)||' where tablename='''||part||'''';
	 end if;
  end if;
END LOOP;

end;
$BODY$
LANGUAGE plpgsql