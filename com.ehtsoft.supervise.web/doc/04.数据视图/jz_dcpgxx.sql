create or replace view jz_dcpgxx as
select
a.RYBS as ID  ，--  主键
null as WTBH  ，--  委托编号
null as NSYSQJZRYLX  ，--  拟适用社区矫正人员类型
a.XM as BGRXM  ，--  被告人（罪犯）姓名
a.SFZH as BGRSFZH  ，--  被告人（罪犯）身份证号
a.XB as BGRXB  ，--  被告人（罪犯）性别
a.CSNY as BGRCSRQ  ，--  被告人（罪犯）出生日期
a.GDJZDMX as BGRJZDDZ  ，--  被告人（罪犯）居住地地址
a.XGZDW as BGRGZDW  ，--  被告人（罪犯）工作单位
null as ZM  ，--  罪名
null as YPXQ  ，--  原判刑期
null as YPXQKSRQ  ，--  原判刑期开始日期
null as YPXQJSRQ  ，--  原判刑期结束日期
null as YPXF  ，--  原判刑罚
null as FJX  ，--  附加刑
null as PJJG  ，--  判决机关
null as PJRQ  ，--  判决日期
null as WTDW  ，--  委托单位
null as WTDCS  ，--  委托调查书
null as BDCRXM  ，--  被调查人姓名
null as YBGRGX  ，--  与被告人（罪犯）关系
null as DCSX  ，--  调查事项
null as DCSJ  ，--  调查时间
null as DCDD  ，--  调查地点
null as NSYJZLB  ，--  拟适用矫正类别
null as DCDWSFS  ，--  调查单位（司法所）
null as DCDWXQJ  ，--  调查单位（县区局）
null as DCR  ，--  调查人
null as DCYJSHR  ，--  调查意见审核人
null as DCPGYJS  ，--  调查评估意见书
null as orgid	，--	当前机构
null as remark	--	备注
from sfszh.T_RYJBXX a;
