create or replace view rmtj_ajdsrxx as
select
b.AJBH  AS  ID  ��--  ����
b.AJBH  AS  DSRBM  ��--  �����˱���
b.SQRLB  AS  DSRLX  ��--  ����������
b.SQRXM  AS  DSRXM  ��--  ����������
NULL  AS  DSRZJLX  ��--  ������֤������
NULL  AS  DSRZJHM  ��--  ������֤������
b.SQRDH  AS  DSRLXDH  ��--  ��������ϵ�绰
a.TJJG  AS  DSDWMC  ��--  ���µ�λ����
b.SQRDZ  AS  DSDWDZ  ��--  ���µ�λ��ַ
a.TJY  AS  DSDWFZR  ��--  ���µ�λ������
NULL  AS  BFDSRSL  ��--  ��������������
NULL  AS  orgid  ��--  ��ǰ����
NULL  AS  remark--  ��ע

from sfszh.t_rmtj_aj a,sfszh.t_rmtj_sqrxx b where a.id=b.ajbh;
