----(安置帮教总览界面)

create or replace view view_zl_azbj_jzryjbxxb
as (
	select count(id) as sqjzryid,'未解除' lx  from  jz_jzryjbxx where jcjz='0' 
	union all
	select count(id) as sqjzryid,'期满解除' lx  from  jz_jzryjbxx where jcjz='1' 
	union all
	select count(id) as sqjzryid,'监狱刑满释放' lx from jz_jzryjbxx where jcjz='2'
	union all
	select count(id) as sqjzryid,'看守所刑满释放' lx from jz_jzryjbxx where jcjz='3'
	union all
	select count(id) as sqjzryid,'公安机关落实管控' lx from jz_jzryjbxx where jcjz='4'
)