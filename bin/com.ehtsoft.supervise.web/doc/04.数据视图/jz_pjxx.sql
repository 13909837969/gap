create or replace view jz_pjxx as
select
RYBS as ID  ，--  主键
SQJZDW as SQJZJDJG  ，--  社区矫正决定机关
SQJZJDJG as SQJZJDJGMC  ，--  社区矫正决定机关名称
ZXTZSWHJRQ as ZXTZSWH  ，--  执行通知书文号
TQSSRQ as ZXTZSRQ  ，--  执行通知书日期
CZDW as YJZFJG  ，--  移交罪犯机关
ZCJGMC as YJZFJGMC  ，--  移交罪犯机关名称
ZYFZSS as ZYFZSS  ，--  主要犯罪事实
SQJZQX as SQJZQX  ，--  社区矫正期限
PJJIEGUO as YPXF  ，--  原判刑罚
YPXQ as YPXQ  ，--  原判刑期
XQQSRQ as YPXQKSRQ  ，--  原判刑期开始日期
XQJSRQ as YPXQJSRQ  ，--  原判刑期结束日期
null as YQTXQX  ，--  有期徒刑期限
FJX as FJX  ，--  附加刑
null as SFBXGJZL  ，--  是否被宣告禁止令
PJSH as PJSBH  ，--  判决书编号
WSLX as WSLX  ，--  文书类型
PJRQ as PJRQ  ，--  判决日期
WSBH as WSBH  ，--  文书编号
WSSXRQ as WSSXRQ  ，--  文书生效日期
null as orgid	，--	当前机构
null as remark	--	备注
from sfszh.T_SQJZDXXX;
