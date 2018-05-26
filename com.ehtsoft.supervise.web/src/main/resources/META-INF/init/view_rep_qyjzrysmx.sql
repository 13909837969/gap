/*
 * 区域矫正人员数量明细
 */
drop view view_rep_qyjzrysmx;
CREATE OR REPLACE VIEW public.view_rep_qyjzrysmx AS 
 SELECT 
    region.provinceid as province_code,
    region.province as province_name,
    region.cityid AS city_code,
    region.city AS city_name,
    region.districtid AS district_code,
    region.district AS district_name,
    jg.id AS orgid,
    jg.jgmc AS orgname,
    jzry.xm,
    jzry.xb,
    jzry.sfzh,
    jzry.grlxdh,
    jzry.jglx,
    jzry.jcjz,
    jzry.id
   FROM view_sys_region region
   JOIN jc_sfxzjgjbxx jg ON region.districtid::text = jg.regionid::text
   JOIN jz_jzryjbxx jzry ON jg.id = jzry.orgid
     
   WHERE
	jzry.JCJZ = '0' and jzry.sfjs = '1'
		
  ORDER BY jg.regionid;
