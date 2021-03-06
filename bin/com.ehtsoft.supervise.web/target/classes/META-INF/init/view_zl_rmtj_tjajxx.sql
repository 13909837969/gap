----人民调解总览界面_调解案件信息分类(与字典表关联为左关联，有字典值为空情况，只能查到lb有数据的列)
create or replace view view_zl_rmtj_tjajxx
as
select c.provinceid,c.province,c.cityid,c.city,c.districtid,c.district,b.jgbm,b.jgmc,a.lx,a.lb,a.lbname,a.rq,sum(a.cnt) cnt from 
(
	--履行情况__协议日期
	SELECT a.orgid,'lxqk' lx,a.xylxqk lb,b.f_name lbname,substr(a.xyrq,1,10) rq,count(1) cnt from rmtj_tjajxx a left join sys_dictionary b on a.xylxqk = b.f_code where b.f_typecode = 'SYS106' group by orgid,lb,lbname,rq 
		union all 
	--案件来源__受理日期
	select a.orgid,'ajly' lx,a.ajly lb,b.f_name lbname,substr(a.slrq,1,10) rq,count(1) cnt from rmtj_tjajxx a left join sys_dictionary b on a.ajly = b.f_code where b.f_typecode = 'SYS111' group by orgid,lb,lbname,rq  
	 union all 
	--案件纠纷__受理日期
	select a.orgid,'ajjf' lx,a.jflb lb,b.f_name lbname,substr(a.slrq,1,10) rq,count(1) cnt from rmtj_tjajxx a left join sys_dictionary b on a.jflb = b.f_code where b.f_typecode = 'SYS104' group by orgid,lb,lbname,rq
	 union all 
	--调解结果__调解日期
	select a.orgid,'tjjg' lx,a.tjjg lb,b.f_name lbname,substr(a.tjrq,1,10) rq,count(1) cnt from rmtj_tjajxx a left join sys_dictionary b on a.tjjg = b.f_code where b.f_typecode = 'SYS110' group by orgid,lb,lbname,rq
	 union all 
	--案件难易__创建时间戳
	select a.orgid,'ajny' lx,a.ajndjb lb,b.f_name lbname,to_char(a.cts,'yyyy-MM-dd') rq,count(1) cnt from rmtj_tjajxx a left join sys_dictionary b on a.ajndjb = b.f_code where b.f_typecode = 'SYS112' group by orgid,lb,lbname,rq
) a inner join jc_sfxzjgjbxx b on a.orgid = b.id
inner join view_sys_region c on b.regionid = c.districtid 
group by c.provinceid,c.province,c.cityid,c.city,c.districtid,c.district,b.jgbm,b.jgmc,a.lx,a.lb,a.lbname,a.rq 
order by c.provinceid,c.cityid,c.districtid,a.lx,a.lb,a.rq asc