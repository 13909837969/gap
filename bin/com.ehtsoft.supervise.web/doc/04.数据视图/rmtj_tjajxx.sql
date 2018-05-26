create or replace view rmtj_tjajxx as
select
a.ID  as  ID  ，--  主键
NULL  as  TJLX  ，--  调解类型
a.AJBH  as  AJBM  ，--  案件编码
null  as  AH  ，--  案号
a.SSQY  as  TWHBM  ，--  调委会编码
a.SLDW  as  TJGZSBM  ，--  调解工作室编码
a.TJXYBH  as  TJYBM  ，--  调解员编码
a.SLRQ  as  SLRQ  ，--  受理日期
c.jzlb  as  JFLB  ，--  纠纷类别
case when b.sqrlb=1 then b.id else 90   end  as  SQRBM  ，--  申请人编码
case when b.sqrlb=2 then b.id else 91   end   as  BSQRBM  ，--  被申请人编码
NULL  as  AJLY  ，--  案件来源
NULL  as  AJNDJB  ，--  案件难度级别
SSLY  as  JFJYQK  ，--  纠纷简要情况
NULL  as  AJYC  ，--  案件预测
null  as  TJJG  ，--  调解结果
null  as  XYNR  ，--  协议内容
null  as  LXFS  ，--  履行方式
null  as  SAJE  ，--  涉案金额
null  as  XYRQ  ，--  协议日期
null  as  XYLXQK  ，--  协议履行情况TJRQ  as  TJRQ  ，--  调解日期
null  as  TJDD  ，--  调解地点
null  as  SFMY  ，--  是否满意
SJRS  as  SJRS  ，--  涉及人数
null as  orgid  ，--  当前机构
null as  remark --  备注
from sfszh.T_RMTJ_AJ a,sfszh.T_RMTJ_SQRXX b,sfszh.T_RMTJ_JZ c
where a.id = b.ajbh
  and a.id=c.ajid;
