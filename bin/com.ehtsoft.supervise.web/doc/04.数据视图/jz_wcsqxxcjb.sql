create or replace view jz_wcsqxxcjb as
select
RYBS as ID  ，--  主键
RYBS as F_AID  ，--  社区矫正人员id
SQJZRYBH as SQJZRYBH  ，--  社区矫正人员编号
null as SQBT  ，--  申请标题
null as SQSJ  ，--  申请时间
null as WCMDDSZS  ，--  外出目的地所在省（区、市）
null as WCMDDSZD  ，--  外出目的地所在地（市、州）
null as WCMDDSZX  ，--  外出目的地所在县（市、区）
null as WCMDDXZ  ，--  外出目的地（乡镇、街道）
WCMDDMX as WCMDDMX  ，--  外出目的地明细
WCLY as WCLY  ，--  外出理由
WCTS as WCTS  ，--  外出天数
KSQR as KSQR  ，--  外出开始时间
JSRQ as JSRQ  ，--  外出结束时间
SFSSHR as SFSSHR  ，--  司法所审核人
SFSSHSJ as SFSSHSJ  ，--  司法所审核时间
SFSSHYJ as SFSSHYJ  ，--  司法所审核意见
XSFJSPR as XSFJSPR  ，--  县（市、区）司法局审批人
XSFJSPSJ as XSFJSPSJ  ，--  县（市、区）司法局审批时间
XSFJSPYJ as XSFJSPYJ  ，--  县（市、区）司法局审批意见
null as JTGJ  ，--  交通工具
null as YJCFSJ  ，--  预计出发时间
null as orgid	，--	当前机构
null as remark	--	备注
from sfszh.T_SQJZ_WC;
