create or replace view jz_jzxzcy as
select
b.RYBS AS XZID  ��--  ����
b.RYBS AS F_AID  ��--  ����������ԱID
a.SQJZRYBH AS SQJZRYBH   ��--  ����������Ա���
a.XZCYLX AS XZCYLX   ��--  С���Ա����
a.XZCYLB AS XZCYLB   ��--  С���Ա���
a.XM AS XM   ��--  ����
a.XB AS XB   ��--  �Ա�
a.CSRQ AS CSRQ   ��--  ��������
NULL AS SFZH   ��--  ���֤��
a.XL AS XL   ��--  ѧ��
a.ZGXL AS ZGXW   ��--  ���ѧλ
a.ZZMM AS ZZMM   ��--  ������ò
a.ZHY AS ZY   ��--  רҵ
a.zy AS ZHY   ��--  ְҵ
a.GZDW AS GZDW   ��--  ������λ
NULL AS LXDH   ��--  ��ϵ�绰
a.SJ AS SJ   ��--  �ֻ�
a.JTZZ AS JTZZ   ��--  ��ͥסַ
a.SHGZZYLZC AS SHGZZYLZC   ��--  ��Ṥ��רҵ��ְ��
NULL AS orgid	��--	��ǰ����
NULL AS remark	--	��ע
FROM sfszh.T_SQJZ_JZXZ a,sfszh.T_SQJZ_JZXZJZRY b
where a.SQJZRYBH=b.JZXZRYBH;
