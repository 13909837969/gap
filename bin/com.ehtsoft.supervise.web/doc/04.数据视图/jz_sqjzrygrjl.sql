create or replace view jz_sqjzrygrjl as
select
a.RYBS as ID  ，--  主键
a.RYBS as F_AID  ，--  矫正人员ID
b.SQJZRYBH as SQJZRYBH  ，--  社区矫正人员编号
a.QSRQ as QS  ，--  起时
a.ZZRQ as ZR  ，--  止日
a.SZDW as SZDW  ，--  所在单位（所在地）
a.ZW as ZW  ，--  职务（职业）
null as orgid  ，--  当前机构
null as remark  --  备注
FROM SFSZH.T_GRJL a,SFSZH.T_SQJZ_JG b where a.rybs = b.rybs;
