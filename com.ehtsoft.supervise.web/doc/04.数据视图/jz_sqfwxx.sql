create or replace view jz_sqfwxx as
select
SQJZRYBH as ID	��--	����
null as FWBT	��--	�������
SQFWSJ as SQFWKSSJ	��--	��������ʼʱ��
null as SQFWJSSJ	��--	�����������ʱ��
null as YDRS	��--	Ӧ������
null as SDRS	��--	ʵ������
null as SQFWSC	��--	��������ʱ��
SQFWDD as SQFWDD	��--	��������ص�
SQFWNR as SQFWNR	��--	������������
null as SQFWHDZJ  ��--  ���������ܽ�
JLR as JLR  ��--  ��¼��
null as FUTZID  ��--  ����֪ͨ
null as orgid  ��--  ��ǰ����
null as remark  --  ��ע
from sfszh.T_SQJZ_SQFW;
