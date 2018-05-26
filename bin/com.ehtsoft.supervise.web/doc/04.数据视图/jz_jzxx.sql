create or replace view jz_jzxx as
select
a.RYBS  as ID  ，--  主键
b.SQJZDXBH  as JZJGBM  ，--  矫正机构编码
b.SQJZDW  as JZJG  ，--  矫正机构
null  as JZSSSQ  ，--  矫正所属社区
null  as JFZXRQ  ，--  交付执行日期
b.SQJZRYJSRQ  as SQJZRYJSRQ  ，--  社区矫正人员接收日期
null  as SQJZRYJSFS  ，--  社区矫正人员接收方式
null  as BDQK  ，--  报到情况
null  as WASBDQKSM  ，--  未按时报到情况说明
null  as SFJLJZXZ  ，--  是否建立矫正小组
null  as SFCYDZDWGL  ，--  是否采用电子定位管理
null  as DZDWFS  ，--  电子定位方式
null  as DWHM  ，--  定位号码
null  as DHHBFQH  ，--  电话汇报发起号码
null  as DHHBJSH  ，--  电话汇报接收号码
null  as orgid	，--	当前机构
null  as remark	--	备注
from sfszh.T_JJXQBDQK a ,sfszh.T_SQJZDXXX b
where a.RYBS=b.RYBS;
