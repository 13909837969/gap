---全区解除安置帮教情况
CREATE OR REPLACE VIEW view_zl_azbj_bjqk
AS
SELECT sum(azbj_bjqk.cnt) cnt ,SUM(azbj_bjqk.cnt2) cnt2,SUM(azbj_bjqk.cnt3) cnt3,SUM(azbj_bjqk.cnt4) cnt4,SUM(azbj_bjqk.cnt5) cnt5,SUM(azbj_bjqk.cnt6) cnt6 FROM 
(
--落实责任田
SELECT 'lszrt' XSBX,A.AID,A.XSBX,B.ID,C.f_name lbname,COUNT(2)cnt,0 cnt2,0 cnt3,0 cnt4,0 cnt5,0 cnt6 
FROM	ANZBJ_GZJLCJB A
LEFT JOIN JZ_JZRYJBXX B ON B. ID = A .AID
LEFT JOIN sys_dictionary C ON A .XSBX = C .f_code
WHERE	C .f_typecode = 'SYS154'
AND A .XSBX = '01'
GROUP BY
A.AID,A.XSBX,b.id,lbname
union ALL
--公益性岗位安置
SELECT 'gyxgwaz' azfs,a.f_aid,a.azfs,b.id,c.f_name lbname,0 cnt,COUNT(2) cnt2,0 cnt3,0 cnt4,0 cnt5,0 cnt6 
FROM ANZBJ_AZXXCJB A
LEFT JOIN JZ_JZRYJBXX B ON B.ID = A.F_AID
LEFT JOIN sys_dictionary C ON A.AZFS = c.f_code
WHERE c.f_typecode  ='SYS154'
AND a.azfs ='02'
GROUP BY 
a.f_aid,a.azfs,b.id,lbname

union ALL
--自主创业
SELECT 'zzcy' azfs,a.f_aid,a.azfs,b.id,c.f_name lbname,0 cnt,0 cnt2,count(2) cnt3,0 cnt4,0 cnt5,0 cnt6
FROM ANZBJ_AZXXCJB A
LEFT JOIN JZ_JZRYJBXX B ON B.ID = A.F_AID
LEFT JOIN sys_dictionary C ON A.AZFS = c.f_code
WHERE c.f_typecode  ='SYS154'
AND a.azfs ='03'
GROUP BY 
a.f_aid,a.azfs,b.id,lbname
--从事个体经营
union ALL
SELECT 'zzcy' azfs,a.f_aid,a.azfs,b.id,c.f_name lbname,0 cnt,0 cnt2,0 cnt3,count(2) cnt4,0 cnt5,0 cnt6
FROM ANZBJ_AZXXCJB A
LEFT JOIN JZ_JZRYJBXX B ON B.ID = A.F_AID
LEFT JOIN sys_dictionary C ON A.AZFS = c.f_code
WHERE c.f_typecode  ='SYS154'
AND a.azfs ='04'
GROUP BY 
a.f_aid,a.azfs,b.id,lbname
--企业户和经济实体吸钠就业
union ALL
SELECT 'zzcy' azfs,a.f_aid,a.azfs,b.id,c.f_name lbname,0 cnt,0 cnt2,0 cnt3,0 cnt4,count(2) cnt5,0 cnt6
FROM ANZBJ_AZXXCJB A
LEFT JOIN JZ_JZRYJBXX B ON B.ID = A.F_AID
LEFT JOIN sys_dictionary C ON A.AZFS = c.f_code
WHERE c.f_typecode  ='SYS154'
AND a.azfs ='05'
GROUP BY 
a.f_aid,a.azfs,b.id,lbname
union ALL
--其他安置方式
SELECT 'zzcy' azfs,a.f_aid,a.azfs,b.id,c.f_name lbname,0 cnt,0 cnt2,0 cnt3,0 cnt4,0 cnt5,count(2) cnt6
FROM ANZBJ_AZXXCJB A
LEFT JOIN JZ_JZRYJBXX B ON B.ID = A.F_AID
LEFT JOIN sys_dictionary C ON A.AZFS = c.f_code
WHERE c.f_typecode  ='SYS154'
AND a.azfs ='06'
GROUP BY 
a.f_aid,a.azfs,b.id,lbname

)azbj_bjqk