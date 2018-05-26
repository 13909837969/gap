create or replace view jz_sqfwxx as
select
SQJZRYBH as ID	，--	主键
null as FWBT	，--	服务标题
SQFWSJ as SQFWKSSJ	，--	社区服务开始时间
null as SQFWJSSJ	，--	社区服务结束时间
null as YDRS	，--	应到人数
null as SDRS	，--	实到人数
null as SQFWSC	，--	社区服务时长
SQFWDD as SQFWDD	，--	社区服务地点
SQFWNR as SQFWNR	，--	社区服务内容
null as SQFWHDZJ  ，--  社区服务活动总结
JLR as JLR  ，--  记录人
null as FUTZID  ，--  服务通知
null as orgid  ，--  当前机构
null as remark  --  备注
from sfszh.T_SQJZ_SQFW;
