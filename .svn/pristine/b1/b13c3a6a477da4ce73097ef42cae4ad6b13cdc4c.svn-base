create or replace view jz_jzxzcy as
select
b.RYBS AS XZID  ，--  主键
b.RYBS AS F_AID  ，--  社区矫正人员ID
a.SQJZRYBH AS SQJZRYBH   ，--  社区矫正人员编号
a.XZCYLX AS XZCYLX   ，--  小组成员类型
a.XZCYLB AS XZCYLB   ，--  小组成员类别
a.XM AS XM   ，--  姓名
a.XB AS XB   ，--  性别
a.CSRQ AS CSRQ   ，--  出生日期
NULL AS SFZH   ，--  身份证号
a.XL AS XL   ，--  学历
a.ZGXL AS ZGXW   ，--  最高学位
a.ZZMM AS ZZMM   ，--  政治面貌
a.ZHY AS ZY   ，--  专业
a.zy AS ZHY   ，--  职业
a.GZDW AS GZDW   ，--  工作单位
NULL AS LXDH   ，--  联系电话
a.SJ AS SJ   ，--  手机
a.JTZZ AS JTZZ   ，--  家庭住址
a.SHGZZYLZC AS SHGZZYLZC   ，--  社会工作专业类职称
NULL AS orgid	，--	当前机构
NULL AS remark	--	备注
FROM sfszh.T_SQJZ_JZXZ a,sfszh.T_SQJZ_JZXZJZRY b
where a.SQJZRYBH=b.JZXZRYBH;
