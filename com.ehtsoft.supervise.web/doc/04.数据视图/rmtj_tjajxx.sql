create or replace view rmtj_tjajxx as
select
a.ID  as  ID  ��--  ����
NULL  as  TJLX  ��--  ��������
a.AJBH  as  AJBM  ��--  ��������
null  as  AH  ��--  ����
a.SSQY  as  TWHBM  ��--  ��ί�����
a.SLDW  as  TJGZSBM  ��--  ���⹤���ұ���
a.TJXYBH  as  TJYBM  ��--  ����Ա����
a.SLRQ  as  SLRQ  ��--  ��������
c.jzlb  as  JFLB  ��--  �������
case when b.sqrlb=1 then b.id else 90   end  as  SQRBM  ��--  �����˱���
case when b.sqrlb=2 then b.id else 91   end   as  BSQRBM  ��--  �������˱���
NULL  as  AJLY  ��--  ������Դ
NULL  as  AJNDJB  ��--  �����Ѷȼ���
SSLY  as  JFJYQK  ��--  ���׼�Ҫ���
NULL  as  AJYC  ��--  ����Ԥ��
null  as  TJJG  ��--  ������
null  as  XYNR  ��--  Э������
null  as  LXFS  ��--  ���з�ʽ
null  as  SAJE  ��--  �永���
null  as  XYRQ  ��--  Э������
null  as  XYLXQK  ��--  Э���������TJRQ  as  TJRQ  ��--  ��������
null  as  TJDD  ��--  ����ص�
null  as  SFMY  ��--  �Ƿ�����
SJRS  as  SJRS  ��--  �漰����
null as  orgid  ��--  ��ǰ����
null as  remark --  ��ע
from sfszh.T_RMTJ_AJ a,sfszh.T_RMTJ_SQRXX b,sfszh.T_RMTJ_JZ c
where a.id = b.ajbh
  and a.id=c.ajid;
