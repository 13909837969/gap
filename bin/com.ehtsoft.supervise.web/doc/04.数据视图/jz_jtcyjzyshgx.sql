create or replace view jz_jtcyjzyshgx as
select
RYBS as F_ID	，--	主键
RYBS as F_AID	，--	矫正人员ID
RYBS as SQJZRYBH	，--	社区矫正人员编号
GX as GX	，--	关系
XM as XM	，--	姓名
GZDW as SZDW	，--	所在单位
null as JTZZ	，--	家庭住址
LXDH as LXDH	，--	联系电话
null as orgid	，--	当前机构
null as remark	--	备注
from sfszh.T_SHGX;
