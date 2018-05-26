create or replace view rmtj_jwhjbxx as
select
a.BH	as	ID	，--	主键
a.BH	as	TWHBM	，--	调委会编码
a.JGMC	as	TWHMC	，--	调委会名称
NULL	as	TWHZP	，--	调委会照片
NULL	as	TWHLX	，--	调委会类型
NULL	as	HZTWHLX	，--	行专调委会类型
NULL	as	ZZTJYRS	，--	专职调解员人数
NULL	as	JZTJYRS	，--	兼职调解员人数
a.LXDH	as	LXDH	，--	联系电话
NULL	as	CZHM	，--	传真号码
a.JGDM	as	LXDZ	，--	联系地址
a.YZBM	as	YZBM	，--	邮政编码
NULL	as	DZYX	，--  电子邮箱
a.FZRXM  as  FZR  ，--  负责人
NULL  as  CLRQ  ，--  成立日期
b.SLRQ  as  XXCJRQ  ，--  信息采集日期
a.SSQY  as  SUQY  ，--  所属区域
NULL  as  orgid  ，--  当前机构
NULL  as  remark  --  备注
from sfszh.T_RMTJ_TJWYH a,sfszh.t_rmtj_aj b
where a.bh = b.sldw;
