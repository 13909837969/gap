----安置帮教总览界面--全年安置帮教人员表现情况(界面总览没有用上，缺少计算月份的，重新写了一个计算月份的在Servic 里面写的)

create or replace view view_zl_azbj_qnazbjrybxqk
as 
SELECT SUM(azbj_rybxqk.cnt) cnt, SUM(azbj_rybxqk.cnt2) cnt2 ,SUM(azbj_rybxqk.cnt3) cnt3 FROM (

SELECT 'good' XSBX,A.AID,A.XSBX,B.ID,C.f_name lbname,COUNT(2)cnt,0 cnt2,0 cnt3
FROM	ANZBJ_GZJLCJB A
LEFT JOIN JZ_JZRYJBXX B ON B. ID = A .AID
LEFT JOIN sys_dictionary C ON A .XSBX = C .f_code
WHERE	C .f_typecode = 'SYS149'
AND A .XSBX = '01'
GROUP BY
A.AID,A.XSBX,b.id,lbname

UNION ALL

SELECT 'commonly' XSBX,A.AID,A.XSBX,B.ID,C.f_name lbname,	0 cnt,COUNT(2) cnt2,	0 cnt3
FROM	ANZBJ_GZJLCJB A
LEFT JOIN JZ_JZRYJBXX B ON B. ID = A .AID
LEFT JOIN sys_dictionary C ON A .XSBX = C .f_code
WHERE	C .f_typecode = 'SYS149'
AND A .XSBX = '02'
GROUP BY
A .AID,	a.XSBX, b.id,lbname

UNION ALL

SELECT 'bad' XSBX,A.AID,A.XSBX,B.ID,C.f_name lbname,0 cnt, 0 cnt2,COUNT (2) cnt3 
FROM	ANZBJ_GZJLCJB A
LEFT JOIN JZ_JZRYJBXX B ON B. ID = A .AID
LEFT JOIN sys_dictionary C ON A .XSBX = C .f_code
WHERE	C .f_typecode = 'SYS149'
AND A .XSBX = '03'
GROUP BY
A .AID,	a.XSBX, b.id,lbname

)azbj_rybxqk