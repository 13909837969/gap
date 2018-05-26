create or replace view jz_ysxx as
select
RYBS as ID	，--	主键
RYBS as F_AID	，--	矫正人员ID
null as SQJZRYBH	，--	社区矫正人员编号
ZXYSJCXM as ZXYSJCXM	，--	执行押送警察姓名
DWJZW as DWJZW	，--	单位及职务
YSRQ as YSRQ	，--	押送日期
null as orgid	，--	当前机构
null as remark	--	备注
from sfszh.T_JWZXYS;
