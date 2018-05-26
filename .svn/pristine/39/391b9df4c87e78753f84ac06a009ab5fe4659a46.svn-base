create or replace view rmtj_ajdsrxx as
select
b.AJBH  AS  ID  ，--  主键
b.AJBH  AS  DSRBM  ，--  当事人编码
b.SQRLB  AS  DSRLX  ，--  当事人类型
b.SQRXM  AS  DSRXM  ，--  当事人姓名
NULL  AS  DSRZJLX  ，--  当事人证件类型
NULL  AS  DSRZJHM  ，--  当事人证件号码
b.SQRDH  AS  DSRLXDH  ，--  当事人联系电话
a.TJJG  AS  DSDWMC  ，--  当事单位名称
b.SQRDZ  AS  DSDWDZ  ，--  当事单位地址
a.TJY  AS  DSDWFZR  ，--  当事单位负责人
NULL  AS  BFDSRSL  ，--  本方当事人数量
NULL  AS  orgid  ，--  当前机构
NULL  AS  remark--  备注

from sfszh.t_rmtj_aj a,sfszh.t_rmtj_sqrxx b where a.id=b.ajbh;
