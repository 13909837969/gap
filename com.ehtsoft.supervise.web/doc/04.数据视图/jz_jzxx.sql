create or replace view jz_jzxx as
select
a.RYBS  as ID  ��--  ����
b.SQJZDXBH  as JZJGBM  ��--  ������������
b.SQJZDW  as JZJG  ��--  ��������
null  as JZSSSQ  ��--  ������������
null  as JFZXRQ  ��--  ����ִ������
b.SQJZRYJSRQ  as SQJZRYJSRQ  ��--  ����������Ա��������
null  as SQJZRYJSFS  ��--  ����������Ա���շ�ʽ
null  as BDQK  ��--  �������
null  as WASBDQKSM  ��--  δ��ʱ�������˵��
null  as SFJLJZXZ  ��--  �Ƿ�������С��
null  as SFCYDZDWGL  ��--  �Ƿ���õ��Ӷ�λ����
null  as DZDWFS  ��--  ���Ӷ�λ��ʽ
null  as DWHM  ��--  ��λ����
null  as DHHBFQH  ��--  �绰�㱨�������
null  as DHHBJSH  ��--  �绰�㱨���պ���
null  as orgid	��--	��ǰ����
null  as remark	--	��ע
from sfszh.T_JJXQBDQK a ,sfszh.T_SQJZDXXX b
where a.RYBS=b.RYBS;
