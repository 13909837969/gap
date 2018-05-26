create or replace view rmtj_ajztqk as
select
a.bh  as  ID  ,--  主键
jgdm  as  TWHBM  ,--  调委会编码
NULL  as  ND  ,--  年度 extract(year from b.SLRQ)
NULL  as  YF  ,--  月份 to_number(to_char(sysdate,'yyyy'))
null  as  TJJFJS  ,--  调解纠纷件数
null  as  PCJFCS  ,--  排查纠纷次数
null  as  YFJFJS  ,--  预防纠纷件数
null	as	orgid	,--	当前机构
null	as	remark	--	备注
from sfszh.t_rmtj_tjwyh a ,sfszh.t_rmtj_aj b where a.bh=b.sldw;
