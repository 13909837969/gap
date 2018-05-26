package com.ehtsoft.supervise.services;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ehtsoft.common.services.SSOService;
import com.ehtsoft.fw.core.db.InsertOperation;
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
 * 法律援助案件登记表
 * 
 * @author sunhailong,GeiLaBa
 *
 */
@Service("FlyzAjdjbService")
public class FlyzAjdjbService extends AbstractService {

	@Resource(name = "sqlDbClient")
	private SqlDbClient dbClient;

	@Resource(name = "SSOService")
	private SSOService service;
	
	@Resource
	private IDictionary dictionaryService;

	/**
	 * 保存或者修改涉案人员信息
	 * 
	 * @param ajData
	 *            { 姓名 性别 证件类型 证件号码 出生日期 国籍 民族 职业 婚姻状态 文化程度 同案人数 人员类别 联系电话 健康状态 电子邮件
	 *            住所地址 受援人类别 工作单位或雇主 户籍地址 现住地址 受理审查 事项类型 审查时间 重大支出 * 事项类型 案由法律状态
	 *            法律地位 案件来源 案件年号 案件期号 是否群体案件 受理时间 案情概述 咨询内容 }
	 * @param listDataSary
	 *            { 姓名 性别 证件类型 证件号码 出生日期 国籍 民族 人员类别 婚姻状态 健康状态 户籍地址 现住地址 受援人类别 人员关系 }
	 * @param grjjData
	 *            { 有无房产 有无汽车 房产套数 房产面积 现金，存款，有价证券等资产 重大支出
	 * 
	 *            }
	 * @param listDataJtxx
	 *            { 姓名 关系 出生日期 证件号码 职业 工作或学习单位 工资性收入 生产经营性收入 其他收入
	 * 
	 *            }
	 */
	public void saveOne(BasicMap<String, Object> ajData, List<BasicMap<String, Object>> listDataSary,
			BasicMap<String, Object> grjjData, List<BasicMap<String, Object>> listDataJtxx) {
		User user = service.getUser();
		// 01+6位行政区划+yyyyMM+d{4}
		String preZxlsh = "01" + user.getRegioncode() + DateUtil.format(new Date(), "yyyyMM");
		long c = 1;

		// 案件信息
		
		if (Util.isEmpty(ajData.get("ID"))) {
			// 01+6位行政区划+yyyyMM+d{4}涉案人员流水号
			ajData.put("AJLSH", String.format(preZxlsh + "%04d", c));
		}
		// 主表案件表
		dbClient.save(SupConst.Collections.FLYZ_AJB, ajData);
		ajData.put("ajid", ajData.get("id"));
		// 案件案由表
		dbClient.save(SupConst.Collections.FLYZ_AJAYB, ajData);
		// 1-申请人/2-咨询人/3-法律援助受援人（其他申请人）4-代理申请人/5-对方当事人
		ajData.put("RYXXLB", "1");
		// 申请人相关信息
		dbClient.save(SupConst.Collections.FLYZ_SARY, ajData);
		ajData.put("syrid", ajData.get("id")); 
		// 案件申请人经济状况表
		grjjData.put("syrid", ajData.get("syrid")); 
		grjjData.put("id", ajData.get("id")); 
		dbClient.save(SupConst.Collections.FLYZ_AJSQRJJZKB, grjjData);
		
		dbClient.remove(SupConst.Collections.FLYZ_SARY, new SqlDbFilter().unEq("ryxxlb", "1").eq("ajid", ajData.get("id")));
		
		
		dbClient.save(SupConst.Collections.FLYZ_SARY_XGRY, listDataSary, new InsertOperation() {

			@Override
			public void insertBefore(BasicMap<String, Object> data) {
				data.put("AJID", ajData.get("id"));
			}

			@Override
			public void insertAfter(BasicMap<String, Object> data) {

			}
		});
		dbClient.remove(SupConst.Collections.FLYZ_SQRJTCYJSRB, new SqlDbFilter().eq("SQRID", ajData.get("syrid")));
		dbClient.insert(SupConst.Collections.FLYZ_SQRJTCYJSRB, listDataJtxx, new InsertOperation() {

			@Override
			public void insertBefore(BasicMap<String, Object> data) {
				data.put("SQRID", ajData.get("syrid"));
			}

			@Override
			public void insertAfter(BasicMap<String, Object> data) {

			}
		});
		/*
		 * 申请人身份类别流水号 SQRSFLBLSH 申请人身份类别 SQRSFLB 涉案人员ID SYRID
		 */
		String sflb_items = StringUtil.toEmptyString(ajData.get("sflb_code"));
		String[] sflbs = sflb_items.split(",");
		dbClient.remove(SupConst.Collections.FLYZ_SQRSFLBB, new SqlDbFilter().eq("SYRID", ajData.get("ID")));
		for (String sflb : sflbs) {
			BasicMap<String, Object> lb = new BasicMap<>();
			// 01+6位行政区划+yyyyMM+d{4}
			String preLb = "14" + user.getRegioncode() + DateUtil.format(new Date(), "yyyyMM");
			c = dbClient.getProxyPrimary(preLb, 1);
			lb.put("SQRSFLBLSH", String.format(preLb + "%04d", c));
			lb.put("SQRSFLB", sflb);
			lb.put("SYRID", ajData.get("ID"));
			dbClient.insert(SupConst.Collections.FLYZ_SQRSFLBB, lb);
		}
		
	}
	
	/**
	 * 
	 * @param id
	 * @return
	 */
	public BasicMap<String, Object> findOne(String id){
		BasicMap<String, Object> data = new BasicMap<>();
		String sqlStr = "select a.*,b.*,c.* from FLYZ_AJB a"
				+ " inner join FLYZ_SARY b on a.id=b.ajid and b.ryxxlb='1'"
		        + " inner join FLYZ_AJSQRJJZKB c on c.syrid=b.id";
		SQLAdapter adapter = new SQLAdapter(sqlStr);
		adapter.getFilter().eq("a.id", id);
		
		data = dbClient.findOne(adapter);
		
		sqlStr = "select sqrsflb from FLYZ_SQRSFLBB where syrid='" + id + "'";
		final StringBuffer sb_code = new StringBuffer();
		final StringBuffer sb_name = new StringBuffer();
		adapter = new SQLAdapter(sqlStr);
		dbClient.find(adapter,new RowDataListener() {
			public void processData(BasicMap<String, Object> rowData) {
				sb_code.append(StringUtil.toEmptyString(rowData.get("SQRSFLB"))+",");
				sb_name.append(StringUtil.toEmptyString(dictionaryService.getDictionaryName("SYS132", StringUtil.toEmptyString(rowData.get("SQRSFLB")))) + ",");
			}
		});
		if(sb_code.length()>0) {
			sb_code.deleteCharAt(sb_code.length()-1);
		}
		if (sb_name.length() > 0) {
			sb_name.deleteCharAt(sb_name.length() - 1);
		}
		String codeStr = sb_code.toString().equals(",")?"":sb_code.toString();
		String nameStr = sb_name.toString().equals(",")?"":sb_name.toString();
		data.put("sflb_code",codeStr);
		data.put("sflb_name",nameStr);
		
		return data;
	}
	
	/**
	 * 获取家庭成员信息
	 * @param id
	 * @return
	 */
	public List<BasicMap<String, Object>> getFamilyData(String id){
		List<BasicMap<String, Object>> data = new ArrayList<>();
		String sqlStr = "select * from FLYZ_SQRJTCYJSRB";
		SQLAdapter adapter = new SQLAdapter(sqlStr);
		adapter.getFilter().eq("SQRID", id);
		data = dbClient.find(adapter);
		return data;
	}
	
	/**
	 * 获取相关人员信息
	 * @param id
	 * @return
	 */
	public List<BasicMap<String, Object>> getConcerndData(String id){
		List<BasicMap<String, Object>> data = new ArrayList<>();
		String sqlStr = "select * from FLYZ_SARY_XGRY";
		SQLAdapter adapter = new SQLAdapter(sqlStr);
		adapter.getFilter().eq("AJID", id);//FLYZ_SARY_XGRY.AJID = FLYZ_SARY.ID 【关联字段】
		dbClient.find(adapter,new RowDataListener() {
			
			@Override
			public void processData(BasicMap<String, Object> rowData) {
//				String  str = StringUtil.toEmptyString(rowData.get("RYXXLB"));
//				if(!str.equals("1")) {
					data.add(rowData);
//				}
			}
		});
		return data;
	}
	

	/**
	 * 查询案件相关信息 申请人 xm (FLYZ_SARY) 事项类型 sxlx(FLYZ_AJB) 案件来源 ajly(FLYZ_AJB) 受理时间
	 * slsj(FLYZ_AJB) 登记机构 orgid 登记人 user
	 */
	public List<BasicMap<String, Object>> findList(BasicMap<String, Object> query, Paginate paginate) {
		User user = service.getUser();
		String sql = "select a.id,d.xm,a.sxlx,a.ajly,a.slsj,b.jgmc,c.xm djr from FLYZ_AJB a"
				+ " left join JC_SFXZJGJBXX b on a.orgid=b.id" 
				+ " left join JC_SFXZJGGZRYJBXX c on a.caid=c.id"
				+ " left join FLYZ_SARY d on a.id=d.ajid and d.RYXXLB='1' "
				+ "where  a.orgid = '"+ user.getOrgid() +"' and  d.xm like '" + query.get("xm")  + "%' "
				+ " order by a.cts desc ";
		SQLAdapter adapter = new SQLAdapter(sql);
		List<BasicMap<String, Object>> list = new ArrayList<>();
		list = (List<BasicMap<String, Object>>) dbClient.find(adapter, paginate, new RowDataListener() {

			@Override
			public void processData(BasicMap<String, Object> rowData) {
				rowData.put("jdrq", DateUtil.format(rowData.get("slsj"), "yyyy-MM-dd"));
			}
		}).getRows();
		return list;
	}


	/**
	 * 删除案件登记信息
	 */
	public void delete(String id) {
		// 删除案件信息
		dbClient.remove(SupConst.Collections.FLYZ_AJB, new SqlDbFilter().eq("id", id));
		// 删除案件案由信息
		dbClient.remove(SupConst.Collections.FLYZ_AJAYB, new SqlDbFilter().eq("ajid", id));
		// 删除申请人身份信息
		dbClient.remove(SupConst.Collections.FLYZ_SQRSFLBB, new SqlDbFilter().eq("syrid", id));
		// 删除申请人家庭成员及收入信息
		dbClient.remove(SupConst.Collections.FLYZ_SQRJTCYJSRB, new SqlDbFilter().eq("sqrid", id));
		// 删除申请人经济状况信息
		dbClient.remove(SupConst.Collections.FLYZ_AJSQRJJZKB, new SqlDbFilter().eq("syrid", id));
	}

	public void deletes(String id) {
		// 删除相关人员
		dbClient.remove(SupConst.Collections.FLYZ_SARY_XGRY, new SqlDbFilter().eq("id", id));
	}
	
}
