----安置帮教总览界面--全区安置帮教类型曲线图(界面总览没有用上，缺少计算月份的，重新写了一个计算月份的在Servic 里面写的)
create or replace view view_zl_azbj_azbjlxqxt
as (
SELECT  count(AZBJRYFXXXCJB01) AS anbjid,'重点帮教对象'  lx from ANZBJ_AZBJRYFXXXCJB WHERE WXXPG ='01'

UNION ALL

SELECT  count(AZBJRYFXXXCJB01) AS anbjid,'一般帮教对象'  lx from ANZBJ_AZBJRYFXXXCJB WHERE WXXPG ='02'



)