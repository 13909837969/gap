create or replace view rmtj_jwhjbxx as
select
a.BH	as	ID	��--	����
a.BH	as	TWHBM	��--	��ί�����
a.JGMC	as	TWHMC	��--	��ί������
NULL	as	TWHZP	��--	��ί����Ƭ
NULL	as	TWHLX	��--	��ί������
NULL	as	HZTWHLX	��--	��ר��ί������
NULL	as	ZZTJYRS	��--	רְ����Ա����
NULL	as	JZTJYRS	��--	��ְ����Ա����
a.LXDH	as	LXDH	��--	��ϵ�绰
NULL	as	CZHM	��--	�������
a.JGDM	as	LXDZ	��--	��ϵ��ַ
a.YZBM	as	YZBM	��--	��������
NULL	as	DZYX	��--  ��������
a.FZRXM  as  FZR  ��--  ������
NULL  as  CLRQ  ��--  ��������
b.SLRQ  as  XXCJRQ  ��--  ��Ϣ�ɼ�����
a.SSQY  as  SUQY  ��--  ��������
NULL  as  orgid  ��--  ��ǰ����
NULL  as  remark  --  ��ע
from sfszh.T_RMTJ_TJWYH a,sfszh.t_rmtj_aj b
where a.bh = b.sldw;
