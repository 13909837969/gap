create or replace view jz_wcsqxxcjb as
select
RYBS as ID  ��--  ����
RYBS as F_AID  ��--  ����������Աid
SQJZRYBH as SQJZRYBH  ��--  ����������Ա���
null as SQBT  ��--  �������
null as SQSJ  ��--  ����ʱ��
null as WCMDDSZS  ��--  ���Ŀ�ĵ�����ʡ�������У�
null as WCMDDSZD  ��--  ���Ŀ�ĵ����ڵأ��С��ݣ�
null as WCMDDSZX  ��--  ���Ŀ�ĵ������أ��С�����
null as WCMDDXZ  ��--  ���Ŀ�ĵأ����򡢽ֵ���
WCMDDMX as WCMDDMX  ��--  ���Ŀ�ĵ���ϸ
WCLY as WCLY  ��--  �������
WCTS as WCTS  ��--  �������
KSQR as KSQR  ��--  �����ʼʱ��
JSRQ as JSRQ  ��--  �������ʱ��
SFSSHR as SFSSHR  ��--  ˾���������
SFSSHSJ as SFSSHSJ  ��--  ˾�������ʱ��
SFSSHYJ as SFSSHYJ  ��--  ˾����������
XSFJSPR as XSFJSPR  ��--  �أ��С�����˾����������
XSFJSPSJ as XSFJSPSJ  ��--  �أ��С�����˾��������ʱ��
XSFJSPYJ as XSFJSPYJ  ��--  �أ��С�����˾�����������
null as JTGJ  ��--  ��ͨ����
null as YJCFSJ  ��--  Ԥ�Ƴ���ʱ��
null as orgid	��--	��ǰ����
null as remark	--	��ע
from sfszh.T_SQJZ_WC;
