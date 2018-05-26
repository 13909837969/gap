/**
 * 社区预览 - 矫正人员类型 - 宽/普/严
 */
create view view_rep_jzrys_lx
as
SELECT region.parentid AS city_code,
    creg.region_name AS city_name,
    region.regionid AS district_code,
    region.region_name AS district_name,
    jg.id AS orgid,
    jg.jgmc AS orgname,
    count(jzry.id) AS jzrys,
		jzry.jglx
   FROM sys_region region
     JOIN jc_sfxzjgjbxx jg ON region.regionid::text = jg.regionid::text
     JOIN jz_jzryjbxx jzry ON jg.id = jzry.orgid
     JOIN sys_region creg ON creg.regionid::text = region.parentid::text
   WHERE
		jzry.sfjs ='1' AND jzry.jcjz = '0'
  GROUP BY creg.region_name, region.regionid, region.parentid, region.region_name, jg.id, jg.jgmc,jzry.jglx
  ORDER BY jg.regionid;