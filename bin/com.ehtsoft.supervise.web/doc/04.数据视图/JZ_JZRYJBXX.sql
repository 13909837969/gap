CREATE OR REPLACE VIEW JZ_JZRYJBXX AS
SELECT
a.RYBS AS ID, --主键
a.RYBS AS SQJZRYBH, --社区矫正人员编号
b.SQJZDW as JZJGBM, --矫正机构编码
CASE WHEN C.RYBS = NULL THEN  0 ELSE 1 END AS SFDCPG, --是否调查评
-- D.PGYJ as DCPGYJ, --调查评估意见  长度 是 2 ？
NULL as DCYJCXQK, --调查意见采信情况
null as JZLB, --矫正类别
A.SFCN as SFCN, --是否成年
null as WCN, --未成年
A.XM as XM, --姓名
A.CYM as CYM, --曾用名
A.XB as XB, --性别
A.MZ as MZ, --民族
A.SFZH as SFZH, --身份证号
null as CSRQ, --出生日期
A.YWGATSFZ as YWGATSFZ, --有无港澳台身份证
null as GATSFZLX, --港澳台身份证类型
null as GATSFZHM, --港澳台身份证号码
A.YWHZ as YWHZ, --有无护照
A.HZHM as HZHM, --护照号码
null as HZBCZT, --护照保存状态
A.YWGATTXZ as YWGATTXZ, --有无港澳台通行证
null as GATTXZLX, --港澳台通行证类型
A.GATTXZHM as GATTXZHM, --港澳台通行证号码
null as GATTXZBCZT, --港澳台通行证保存状态
null as YWGAJMWLNDTXZ, --有无港澳居民往来内地通 行证
null as GAJMWLNDTXZ, --港澳居民往来内地通行证 号码
null as GAJMWLNDTXZBCZT, --港澳居民往来内地通行证 保存状态
null as YWTBZ, --有无台胞证
null as TBZHM, --台胞证号码
null as TBZBCZT, --台胞证保存状态
null as ZYJWZXRYSTZK, --暂予监外执行人员身体状 况
null as ZHJZYY, --最后就诊医院
null as SFYJSB, --是否有精神病
A.JDJG as JDJG, --鉴定机构
null as SFYCRB, --是否有传染病
null as JTCRB, --具体传染病
null as WHCD, --文化程度
A.HYZK as HYZK, --婚姻状况
null as PQZY, --捕前职业
A.JYJXQK as JYJXQK, --就业就学情况
null as XZZMM, --现政治面貌
A.YZZMM as YZZMM, --原政治面貌
null as YGZDW, --原工作单位
A.XGZDW as XGZDW, --现工作单位
A.DWLXDH as DWLXDH, --单位联系电话
A.GRLXDH as GRLXDH, --个人联系电话(手机号)
null as QTLXFS, --其他联系方式
null as GJ, --国籍
A.YXJTCYJZYSHGX as YXJTCYJZYSHGX, --有无家庭成员及主要社会 关系
null as HJDSFYJZDXT, --户籍地是否与居住地相同
A.GDJZDSZS as GDJZDSZS, --固定居住地所在省（区、 市）
A.GDJZDSZDS as GDJZDSZDS, --固定居住地所在地（市、 州）
A.GDJZDSZXQ as GDJZDSZXQ, --固定居住地所在县（市、 区）
A.GDJZD as GDJZD, --固定居住地（乡镇、街道）
A.GDJZDMX as GDJZDMX, --固定居住地明细
A.HJSZS as HJSZS, --户籍所在省（区、市）
A.HJSZDS as HJSZDS, --户籍所在地（市、州）
A.HJSZXQ as HJSZXQ, --户籍所在县（市、区）
A.HJSZD as HJSZD, --户籍所在地（乡镇、街道）
A.HJSZDMX as HJSZDMX, --户籍所在地明细
null as SFSWRY, --是否三无人员
null as JZJG, --矫正机构
null as JZSSSQ, --矫正所属社区
null as SQJZJDJG, --社区矫正决定机关
null as SQJZJDJGMC, --社区矫正决定机关名称
null as ZXTZSWH, --执行通知书文号
null as ZXTZSRQ, --执行通知书日期
null as JFZXRQ, --交付执行日期
null as YJZFJG, --移交罪犯机关
null as YJZFJGMC, --移交罪犯机关名称
null as SFYQK, --是否有前科
null as SFLF, --是否累犯
null as QKLX, --前科类型
null as ZYFZSS, --主要犯罪事实
null as SQJZQX, --社区矫正期限
null as SQJZKSRQ, --社区矫正开始日期
null as SQJZJSRQ, --社区矫正结束日期
null as FZLX, --犯罪类型
null as JTZM, --具体罪名
null as GZQX, --管制期限
null as HXKYQX, --缓刑考验期限
null as SFSZBF, --是否数罪并罚
null as YPXF, --原判刑罚
null as YPXQ, --原判刑期
null as YPXQKSRQ, --原判刑期开始日期
null as YPXQJSRQ, --原判刑期结束日期
null as YQTXQX, --有期徒刑期限
null as FJX, --附加刑
null as SFWD, --是否“五独”
null as SFWS, --是否“五涉”
null as SFYSS, --是否有“四史”
null as SFBXGJZL, --是否被宣告禁止令
null as SQJZRYJSRQ, --社区矫正人员接收日期
null as SQJZRYJSFS, --社区矫正人员接收方式
null as FLWSSDSJ, --法律文书收到时间
null as FLWSZL, --法律文书种类
null as BDQK, --报到情况
null as SFCJ, --是否采集完成
null as WASBDQKSM, --未按时报到情况说明
null as SFJLJZXZ, --是否建立矫正小组
null as JZXZRYZCQK, --矫正小组人员组成情况
null as SFCYDZDWGL, --是否采用电子定位管理
null as DZDWFS, --电子定位方式
null as DWHM, --定位号码
null as DHHBFQH, --电话汇报发起号码
null as DHHBJSH, --电话汇报接收号码
null as SFTK, --是否脱管
null as JCQK, --奖惩情况
null as ONLINE1, --是否在线
null as PJSBH, --判决书编号
null as WSLX, --文书类型
null as PJRQ, --判决日期
null as WSBH, --文书编号
null as WSSXRQ, --文书生效日期
null as DEL, --删除标记
null as AUDIT1, --审核标记
null as CTS, --创建时间戳
null as UTS, --更新时间戳
null as CDATE, --创建日期
null as UDATE, --更新日期
null as CUID, --当前创建人员
null as UUID, --当前更新人员
null as CAID, --当前创建账号
null as UAID, --当前更新账号
null as ORGID, --当前机构
null as REMARK --备注
FROM sfszh.T_RYJBXX A
inner join sfszh.T_SQJZDXXX B on A.RYBS = B.RYBS
left join sfszh.T_ZLXGPGJL C on A.RYBS = C.RYBS
left join SFSZH.T_DJPGJL D ON A.RYBS = D.RYBS;
