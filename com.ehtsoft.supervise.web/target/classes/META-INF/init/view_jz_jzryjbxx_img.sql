/**
 * 司法部接口-矫正人员的总体（全部）信息汇总 视图
 */
CREATE VIEW view_jz_jzryjbxx_img AS SELECT
	a111.*, b111.jgmc AS JZRYSZSFT
FROM
	(
		SELECT
			a11.*, b11.jgmc AS JZRYSZDSSFJ,
			b11.parentid AS JZRYSZSFTid
		FROM
			(
				SELECT
					a1.*, b1.jgmc AS JZRYSZQXSFJ,
					b1.parentid AS JZRYSZDSSFJid
				FROM
					(
						SELECT
							A . ID,
							REPLACE (A .sqjzrybh, 'JZ', '') AS sqjzrybh,
							A .JZJGBM,
							A .wcn,
							A .xm,
							A .cym,
							A .xb,
							A .mz,
							A .sfzh,
							A .csrq,
							A .hyzk,
							A .pqzy,
							A .jyjxqk,
							A .xzzmm,
							A .yzzmm,
							A .ygzdw,
							A .dwlxdh,
							A .GRLXDH,
							A .BDQK,
							A .SFJLJZXZ,
							e.JZXZRYZCQK,
							C .SFDCPG,
							C .DCPGYJ,
							C .DCYJCXQK,
							C .JZLB,
							A .sfcn,
							b.ywgatsfz,
							b.GATSFZLX,
							b.GATSFZHM,
							b.YWHZ,
							b.HZHM,
							b.HZBCZT,
							b.GATTXZHM,
							b.GATTXZBCZT,
							b.YWGAJMWLNDTXZ,
							b.GAJMWLNDTXZ,
							b.GAJMWLNDTXZBCZT,
							b.YWTBZ,
							b.TBZHM,
							b.TBZBCZT,
							G .ZYJWZXRYSTZK,
							G .ZHJZYY,
							G .SFYJSB,
							G .JDJG,
							G .SFYCRB,
							G .JTCRB,
							A .whcd,
							f.GJ,
							f.YXJTCYJZYSHGX,
							h.data as zp,
							f.HJDSFYJZDXT,
							f.GDJZDSZS AS GDJZDSZ,
							f.GDJZDSZDS,
							f.GDJZDSZXQ,
							f.GDJZD,
							f.GDJZDMX,
							f.HJSZS,
							f.HJSZDS,
							f.HJSZXQ,
							f.HJSZD AS HJSZDXZ,
							f.HJSZDMX,
							A .SFSWRY,
							C .SQJZJDJG,
							C .SQJZJDJGMC,
							d.ZXTZSWH,
							d.ZXTZSRQ,
							C .JFZXRQ,
							C .YJZFJG,
							C .YJZFJGMC,
							e.SFYQK,
							e.SFLF,
							e.QKLX,
							e.ZYFZSS,
							C .SQJZQX,
							C .SQJZKSRQ,
							C .SQJZJSRQ,
							C .FZLX,
							C .JTZM,
							C .GZQX,
							C .HXKYQX,
							e.SFSZBF,
							C .YPXF,
							C .YPXQ,
							C .YPXQKSRQ,
							C .YPXQJSRQ,
							C .YQTXQX,
							C .FJX,
							e.SFWD,
							e.SFWS,
							e.SFYSS,
							A .SFBXGJZL,
							C .SQJZRYJSRQ,
							C .SQJZRYJSFS,
							e.SFCYDZDWGL,
							e.DZDWFS,
							e.DWHM,
							A .SFTK,
							C .JCQK,
							A .remark as bz,
							A .orgid,
							i.jgmc AS JZRYSZSFS,
							i.parentid AS JZRYSZQXSFJID
						FROM
							jz_jzryjbxx A
						LEFT JOIN JZ_JZRYJBXX_SF b ON A . ID = b. ID
						LEFT JOIN JZ_JZRYJBXX_JZ C ON A . ID = C . ID
						LEFT JOIN JZ_JZRYJBXX_WS d ON A . ID = d. ID
						LEFT JOIN JZ_JZRYJBXX_FZ e ON A . ID = e. ID
						LEFT JOIN JZ_JZRYJBXX_DZ f ON A . ID = f. ID
						LEFT JOIN JZ_JZRYJBXX_JK G ON A . ID = G . ID
						LEFT JOIN JZ_JZRYJBXX_IMG h ON A . ID = h.IMGID
						LEFT JOIN jc_sfxzjgjbxx i ON A .orgid = i. ID
					) AS a1
				LEFT JOIN jc_sfxzjgjbxx b1 ON a1.JZRYSZQXSFJID = b1. ID
			) AS a11
		LEFT JOIN jc_sfxzjgjbxx b11 ON a11.JZRYSZDSSFJid = b11. ID
	) AS a111
LEFT JOIN jc_sfxzjgjbxx b111 ON a111.JZRYSZSFTid = b111. ID
