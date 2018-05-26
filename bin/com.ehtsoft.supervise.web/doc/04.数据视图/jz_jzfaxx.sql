create or replace view jz_jzfaxx as
select
RYBH as FAID  ，--  主键
RYBH as SQJZRYBH  ，--  社区矫正人员编号
null as DXQKFX  ，--  矫正对象情况分析
FANR as JZFANR  ，--  矫正方案内容
ZDR as JLR  ，--  记录人
ZDRQ as JLSJ  ，--  记录时间
null as orgid	，--	当前机构
null as remark	--	备注
from sfszh.T_SQJZ_JZFA;
