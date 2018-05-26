----人民调解总览界面_总数 (调解总数;调解成功数;调解不成功;人民调解员总数;调委会总数;协议涉及金额)
create or replace view view_zl_rmtj_zs
as
select c.provinceid,c.province,c.cityid,c.city,c.districtid,c.district,b.jgbm,b.jgmc,a.rq,sum(cnt1) cnt1,sum(cnt2) cnt2,sum(cnt3) cnt3,sum(cnt4) cnt4,sum(cnt5) cnt5,sum(cnt6) cnt6 from 
(
	select orgid,substr(tjrq,1,10) rq,count(1) cnt1,0 cnt2,0 cnt3,0 cnt4,0 cnt5,0 cnt6 from rmtj_tjajxx group by orgid,rq union all 
	select orgid,substr(tjrq,1,10) rq,0 cnt1,count(1) cnt2,0 cnt3,0 cnt4,0 cnt5,0 cnt6 from rmtj_tjajxx where tjjg = '1' group by orgid,rq union all 
	select orgid,substr(tjrq,1,10) rq,0 cnt1,0 cnt2,count(1) cnt3,0 cnt4,0 cnt5,0 cnt6 from rmtj_tjajxx where tjjg = '2' group by orgid,rq union all 
	select orgid,to_char(cts,'yyyy-MM-dd') rq,0 cnt1,0 cnt2,0 cnt3,count(1) cnt4,0 cnt5,0 cnt6 from RMTJ_TJYJBXX group by orgid,rq union all 
	select orgid,clrq rq,0 cnt1,0 cnt2,0 cnt3,0 cnt4,count(1) cnt5,0 cnt6 from RMTJ_JWHJBXX group by orgid,rq union all 
	select orgid,substr(tjrq,1,10) rq,0 cnt1,0 cnt2,0 cnt3,0 cnt4,0 cnt5,sum(SAJE) cnt6 from rmtj_tjajxx group by orgid,rq
) a inner join jc_sfxzjgjbxx b on a.orgid = b.id
inner join view_sys_region c on b.regionid = c.districtid 
group by c.provinceid,c.province,c.cityid,c.city,c.districtid,c.district,b.jgbm,b.jgmc,a.rq