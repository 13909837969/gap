create or replace view rmtj_wystwj as
select
ID  as  ID  ，--  主键
RYBS  as  WJBM  ，--  文件编码
null  as  WJFL  ，--  文件分类
null  as  YWJLBM  ，--  业务记录编码
null as  WJMS  ，--  文件描述
null  as  XSSX  ，--  显示顺序
null  as  WJLJ  ，--  文件路径
null	as	orgid	，--	当前机构
null	as	remark	--	备注
 from sfszh.T_RMTJ_WS;
