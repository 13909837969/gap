create or replace view jz_jzfaxx as
select
RYBH as FAID  ��--  ����
RYBH as SQJZRYBH  ��--  ����������Ա���
null as DXQKFX  ��--  ���������������
FANR as JZFANR  ��--  ������������
ZDR as JLR  ��--  ��¼��
ZDRQ as JLSJ  ��--  ��¼ʱ��
null as orgid	��--	��ǰ����
null as remark	--	��ע
from sfszh.T_SQJZ_JZFA;
