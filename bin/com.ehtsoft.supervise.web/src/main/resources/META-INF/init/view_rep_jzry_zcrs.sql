/**
 * 统计矫正人员在册统计
 */
create view view_rep_jzry_zcrs
as
SELECT region.parentid AS city_code,
    creg.region_name AS city_name,
    region.regionid AS district_code,
    region.region_name AS district_name,
    jg.id AS orgid,
    jg.jgmc AS orgname,
    count(jzry.id) AS jzrys
   FROM sys_region region
     JOIN jc_sfxzjgjbxx jg ON region.regionid::text = jg.regionid::text
     JOIN jz_jzryjbxx jzry ON jg.id = jzry.orgid
     JOIN sys_region creg ON creg.regionid::text = region.parentid::text
	WHERE
		jzry.JCJZ = '0' and jzry.sfjs = '1' and  jzry.orgid IS NOT NULL
  GROUP BY creg.region_name, region.regionid, region.parentid, region.region_name, jg.id, jg.jgmc
  ORDER BY jg.regionid;