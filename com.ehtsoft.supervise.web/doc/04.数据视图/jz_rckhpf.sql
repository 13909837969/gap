create or replace view jz_rckhpf as
select
RYBS as ID  ，--  主键
null as KHXM  ，--  考核项目
null as KFFS  ，--  扣分分数
ZRRYJ as KHMSQK  ，--  考核描述情况
RYBS as F_AID  ，--  矫正人员ID
null as orgid	，--	当前机构
null as remark	--	备注
from sfszh.T_SQJZ_JDNDKH;
