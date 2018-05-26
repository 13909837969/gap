CREATE OR REPLACE FUNCTION fun_core_menu_sort()
  RETURNS void AS
$BODY$
declare
 i integer :=1;
 menu1 cursor is select * from core_menu order by sysid; 
 --menu2 cursor is select * from core_menu where  menucode like 'G%' order by menucode;
begin
for cur in menu1 loop
 update core_menu set sort = i where sysid = cur.sysid;
 i:= i+1;
end loop;
/*
for cur in menu2 loop
 update core_menu set sort = i where sysid = cur.sysid;
 i:= i+1;
end loop;
*/
end;
$BODY$
  LANGUAGE plpgsql VOLATILE