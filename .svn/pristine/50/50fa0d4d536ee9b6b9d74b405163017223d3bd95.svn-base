create or replace view view_sys_region
as
select c.regionid as provinceid,c.region_name as province,
b.regionid as cityid,b.region_name as city,
a.regionid as districtid,a.region_name as district
from sys_region a
inner join sys_region b on a.parentid = b.regionid
inner join sys_region c on b.parentid = c.regionid
