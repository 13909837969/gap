create or replace view jz_ysxx as
select
RYBS as ID	��--	����
RYBS as F_AID	��--	������ԱID
null as SQJZRYBH	��--	����������Ա���
ZXYSJCXM as ZXYSJCXM	��--	ִ��Ѻ�;�������
DWJZW as DWJZW	��--	��λ��ְ��
YSRQ as YSRQ	��--	Ѻ������
null as orgid	��--	��ǰ����
null as remark	--	��ע
from sfszh.T_JWZXYS;
