package com.ehtsoft.supervise.services;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ehtsoft.common.services.SSOService;
import com.ehtsoft.fw.core.db.RowDataListener;
import com.ehtsoft.fw.core.db.SQLAdapter;
import com.ehtsoft.fw.core.db.SqlDbClient;
import com.ehtsoft.fw.core.db.SqlDbFilter;
import com.ehtsoft.fw.core.dto.BasicMap;
import com.ehtsoft.fw.core.dto.Paginate;
import com.ehtsoft.fw.core.services.AbstractService;
import com.ehtsoft.fw.core.sso.User;
import com.ehtsoft.fw.utils.DateUtil;
import com.ehtsoft.fw.utils.StringUtil;
import com.ehtsoft.fw.utils.Util;
import com.ehtsoft.fw.utils.api.IDictionary;
import com.ehtsoft.supervise.api.SupConst;

/**
 * 
 * @author sunhailong,GeiLaBa
 *
 */
@Service("FlyzZxbService")
public class FlyzZxbService extends AbstractService {

	@Resource(name = "sqlDbClient")
	private SqlDbClient dbClient;

	@Resource(name = "SSOService")
	private SSOService service;

	@Resource
	private IDictionary dictionaryService;

	/**
	 * 涉案人员相关信息 姓名 a.XM 性别 a.XB 证件类型 a.ZJLX 证件号码 a.ZJHM 出生日期 a.CSRQ 国籍 a.GJ 民族 a.MZ
	 * 职业 a.ZY 婚姻状态 a.HYZK 文化程度 a.WHCD 同案人数 a.TARS 人员类别 a.RYXXLB 联系电话 a.LXDH 健康状况
	 * a.JKZK 电子邮件 a.DZYX 户籍地址 a.HJSZDDZMX 现住地址 a.ZSDZMX 工作单位或雇主 a.GZDWHGZ 身份类别
	 * a.SFLB
	 * 
	 * 咨询事项信息 事项类型 b.ZXSXAYMC 处理方式 b.CLFS 咨询时间 b.ZXSJ 接待人 b.JDRXM 接待日期 b.JDRQ 同来人数
	 * b.TLRS 咨询内容 b.zxnr 答复意见 b.dfyj 是否送法援申请 b.SFSFLSQ
	 * 
	 * @param query
	 * @return
	 */
	public BasicMap<String, Object> findOne(String id) {
		String sql = "select a.id,a.xm,a.xb,a.zjlx,a.zjhm,a.csrq,a.gj,a.mz,a.zy,a.hyzk,a.whcd,a.tars,a.ryxxlb,a.lxdh,"
				+ "a.jkzk,a.dzyx,a.hjszddzmx,a.zsdzmx,a.gzdwhgz,b.id,b.zxsxaymc,b.clfs,b.zxsj,b.jdrxm,"
				+ "b.zxsxlxbm,b.zxsxrjay,b.jdrq,b.tlrs,b.sfsflsq,b.zxnr,b.dfyj from FLYZ_SARY a right join FLYZ_ZXB b on a.ajid=b.id";
		SQLAdapter adapter = new SQLAdapter(sql);
		adapter.getFilter().eq("b.id", id);
		BasicMap<String, Object> rtn = dbClient.findOne(adapter);
		rtn.put("csrq", DateUtil.format(rtn.get("csrq"), "yyyy-MM-dd"));
		rtn.put("jdrq", DateUtil.format(rtn.get("jdrq"), "yyyy-MM-dd"));
		rtn.put("zxsj", DateUtil.format(rtn.get("zxsj"), "yyyy-MM-dd"));

		sql = "select sqrsflb from FLYZ_SQRSFLBB where syrid='" + id + "'";
		final StringBuffer sb_code = new StringBuffer();
		final StringBuffer sb_name = new StringBuffer();
		adapter = new SQLAdapter(sql);
		dbClient.find(adapter, new RowDataListener() {
			public void processData(BasicMap<String, Object> rowData) {
				sb_code.append(StringUtil.toEmptyString(rowData.get("SQRSFLB")) + ",");
				sb_name.append(StringUtil.toEmptyString(
						dictionaryService.getDictionaryName("SYS132", StringUtil.toEmptyString(rowData.get("SQRSFLB"))))
						+ ",");
			}
		});
		if (sb_code.length() > 0) {
			sb_code.deleteCharAt(sb_code.length() - 1);
		}
		if (sb_name.length() > 0) {
			sb_name.deleteCharAt(sb_name.length() - 1);
		}
		String codeStr = sb_code.toString().equals(",") ? "" : sb_code.toString();
		String nameStr = sb_name.toString().equals(",") ? "" : sb_name.toString();
		rtn.put("sflb_code", codeStr);
		rtn.put("sflb_name", nameStr);
		return rtn;
	}

	/**
	 * 查询接待信息 a.xm 咨询人姓名 b.jdrq 接待日期 b.jdrxm 接待人 b.zxsxaymc 事项类型
	 */
	public List<BasicMap<String, Object>> findListZxr(BasicMap<String, Object> query, Paginate paginate) {
		SqlDbFilter filter=new SqlDbFilter();
		User user=service.getUser();
		String sql  = "select a.id,a.xm,a.xb,a.zjlx,a.zjhm,a.csrq,a.gj,a.mz,a.zy,a.hyzk,a.whcd,a.tars,a.ryxxlb,a.lxdh,"
				+ "a.jkzk,a.dzyx,a.hjszddzmx,a.zsdzmx,a.gzdwhgz,b.id,b.zxsxaymc,b.clfs,b.zxsj,b.jdrxm,"
				+ "b.zxsxlxbm,b.zxsxrjay,b.jdrq,b.tlrs,b.sfsflsq,b.zxnr,b.dfyj from FLYZ_SARY a right join FLYZ_ZXB b on a.ajid=b.id";
		SQLAdapter adapter = new SQLAdapter(sql);
		filter.like("a.xm", StringUtil.toEmptyString(query.get("xm")))
	      .eq("a.orgid", user.getOrgid())
	      .desc("b.cts");
	     adapter.setFilter(filter);
		List<BasicMap<String, Object>> list = new ArrayList<>();
		list = (List<BasicMap<String, Object>>) dbClient.find(adapter, paginate, new RowDataListener() {

			@Override
			public void processData(BasicMap<String, Object> rowData) {
				rowData.put("jdrq", DateUtil.format(rowData.get("jdrq"), "yyyy-MM-dd"));
			}
		}).getRows();
		return list;
	}

	/**
	 * 新增或修改咨询信息
	 */
	public void saveZxxx(BasicMap<String, Object> data) {
		User user = service.getUser();

		// 01+6位行政区划+yyyyMM+d{4}
		String preZxlsh = "01" + user.getRegioncode() + DateUtil.format(new Date(), "yyyyMM");
		long c = 1;
		if (Util.isEmpty(data.get("ID"))) {
			c = dbClient.getProxyPrimary(preZxlsh, 1);
			data.put("ZXLSH", String.format(preZxlsh + "%04d", c));
		}

		dbClient.save(SupConst.Collections.FLYZ_ZXB, data);
		if (Util.isEmpty(data.get("ID"))) {
			// 01+6位行政区划+yyyyMM+d{4}
			data.put("SARYLSH", String.format(preZxlsh + "%04d", c));
		}

		// 1-申请人/2-咨询人/3-法律援助受援人（其他申请人）4-代理申请人/5-对方当事人
		data.put("RYXXLB", "2");
		data.put("AJID", data.get("ID"));
		dbClient.save(SupConst.Collections.FLYZ_SARY, data);
		dbClient.remove(SupConst.Collections.FLYZ_SQRSFLBB, new SqlDbFilter().eq("SYRID", data.get("ID")));
		/*
		 * 申请人身份类别流水号 SQRSFLBLSH 申请人身份类别 SQRSFLB 涉案人员ID SYRID
		 */
		String sflb_items = StringUtil.toEmptyString(data.get("sflb_code"));
		String[] sflbs = sflb_items.split(",");
		for (String sflb : sflbs) {
			BasicMap<String, Object> lb = new BasicMap<>();
			// 01+6位行政区划+yyyyMM+d{4}
			String preLb = "14" + user.getRegioncode() + DateUtil.format(new Date(), "yyyyMM");
			c = dbClient.getProxyPrimary(preLb, 1);
			lb.put("SQRSFLBLSH", String.format(preLb + "%04d", c));
			lb.put("SQRSFLB", sflb);
			lb.put("SYRID", data.get("ID"));
			dbClient.insert(SupConst.Collections.FLYZ_SQRSFLBB, lb);
		}

	}

	/**
	 * 删除咨询信息
	 */
	public void delete(String id) {
		dbClient.remove(SupConst.Collections.FLYZ_ZXB, new SqlDbFilter().eq("id", id));
		dbClient.remove(SupConst.Collections.FLYZ_SARY, new SqlDbFilter().eq("AJID", id));
	}
}
