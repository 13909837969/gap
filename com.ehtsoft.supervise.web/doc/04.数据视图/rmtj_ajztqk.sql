create or replace view rmtj_ajztqk as
select
a.bh  as  ID  ,--  ����
jgdm  as  TWHBM  ,--  ��ί�����
NULL  as  ND  ,--  ��� extract(year from b.SLRQ)
NULL  as  YF  ,--  �·� to_number(to_char(sysdate,'yyyy'))
null  as  TJJFJS  ,--  ������׼���
null  as  PCJFCS  ,--  �Ų���״���
null  as  YFJFJS  ,--  Ԥ�����׼���
null	as	orgid	,--	��ǰ����
null	as	remark	--	��ע
from sfszh.t_rmtj_tjwyh a ,sfszh.t_rmtj_aj b where a.bh=b.sldw;
