create or replace view jz_tafxxcj as
select
RYBS as ID  ，--  主键
RYBS as F_AID  ，--  矫正人员ID
XM as XM  ，--  姓名
XB as XB  ，--  性别
CSRQ as CSRQ  ，--  出生日期
ZM as ZM  ，--  罪名
XQ as XQ  ，--  刑期
JTZZ as JTZZ  ，--  家庭住址
BPCXZJSZJS as BPCXZJSZJS  ，--  被判处刑法及所在监狱
null as sfczda  ，--  是否存在档案
null as orgid	，--	当前机构
null as remark --	备注
FROM SFSZH.T_TAFQK;
