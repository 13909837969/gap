create or replace view jz_pxqkdjb as
select
RYBS as ID	，--	主键
PXZT as PXZTMC	，--	培训主题名称
null as YCJRS	，--	应参加人数
null as SJCJRS	，--	实际参加人数
null as PXLSMC	，--	培训老师名称
PXRQ as PXKSJ	，--	培训开始时间
null as PXJSSJ	，--	培训结束时间
PXDD as PXDZ	，--	培训地址
PXNR as PXNRMS	，--	培训内容描述
null as KSQKFX  ，--  考试情况分析
null as PXJGPJ  ，--  培训结果平价
null as orgid	，--	当前机构
null as remark	--	备注
from sfszh.T_SQJZ_JYPX;
