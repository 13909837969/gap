package com.ehtsoft.supervise.services;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ehtsoft.common.services.SSOService;
import com.ehtsoft.fw.core.db.RowDataListener;
import com.ehtsoft.fw.core.db.SQLAdapter;
import com.ehtsoft.fw.core.db.SqlDbClient;
import com.ehtsoft.fw.core.db.SqlDbFilter;
import com.ehtsoft.fw.core.dto.BasicMap;
import com.ehtsoft.fw.core.services.AbstractService;
import com.ehtsoft.fw.core.sso.User;
import com.ehtsoft.fw.utils.DateUtil;
import com.ehtsoft.fw.utils.NumberUtil;
import com.ehtsoft.fw.utils.StringUtil;
import com.ehtsoft.supervise.utils.DateUtils;

/**
 * 
 * 首页矫正总览界面
 * @author Administrator
 * @date 2018年4月10日
 *
 */
@Service("SyJzzlSerivce")
public class SyJzzlSerivce extends AbstractService {
	
	@Resource(name="sqlDbClient")
	SqlDbClient dbClient;
	
	@Resource(name="SSOService")
	private SSOService service;
	
	
	//第一部分
	//在册人数
	public List<BasicMap<String, Object>> findZcrs() {
		User user = service.getUser();
		String orgid = user.getOrgid();
		
		String sqlstr = "SELECT A.f_name as NAME ,COUNT (B .*) AS " + 
				"VALUE FROM sys_dictionary a LEFT JOIN JZ_JZRYJBXX_JZ B ON A.f_code = B.jzlb " + 
				"WHERE a.f_typecode = 'SYS017' " +
				"AND  b.orgid = '"+ orgid +"' " + 
				"GROUP BY  NAME";
		SQLAdapter adapter = new SQLAdapter(sqlstr);
		List<BasicMap<String, Object>> list = dbClient.find(adapter);
		
		if (list.isEmpty()) {
			String sql = "SELECT A .f_name AS NAME,0 as value FROM sys_dictionary A WHERE A .f_typecode = 'SYS017'";
			SQLAdapter aSqlAdapter = new SQLAdapter(sql);
			list = dbClient.find(aSqlAdapter);
		}
		return list;
	}
	
	//等级管理 - 矫正类型
	public List<BasicMap<String, Object>> findJzlx() {
		User user = service.getUser();
		String orgid = user.getOrgid();
		StringBuffer sqlstr = new StringBuffer("SELECT COUNT (A .*) as VALUE, b.f_name as name " + 
				"FROM jz_jzryjbxx A " + 
				"LEFT JOIN sys_dictionary b ON A .jglx = b.f_code " + 
				"WHERE b.f_typecode = 'SYS114' " + 
				"AND A .orgid = '"+ orgid +"' " + 
				"AND A .jglx <> '' " + 
				"GROUP BY  name");
		SQLAdapter adapter = new SQLAdapter(sqlstr.toString());
		List<BasicMap<String, Object>> list = dbClient.find(adapter);
		if (list.isEmpty()) {
			String sql = "SELECT A .f_name AS NAME,0 as value FROM sys_dictionary A WHERE A .f_typecode = 'SYS114'";
			SQLAdapter aSqlAdapter = new SQLAdapter(sql);
			list = dbClient.find(aSqlAdapter);
		}
		
		return list;
	}

	/**
	 * 
	 * 就学....等等接口
	 * @return<br>
	 * 返回值格式: List<BasicMap<String, Object>>
	 *
	 * @author Administrator
	 * @date   2018年4月10日
	 * 方法的作用：TODO
	 */
	public List<BasicMap<String, Object>> findDblb() {
		List<BasicMap<String, Object>> list = new ArrayList<>();
		User user = service.getUser();
		String orgid = user.getOrgid();
		
		//就学
		String sqlstr = "SELECT COUNT (A .*) as jx " + 
				"FROM jz_jzryjbxx A " + 
				"LEFT JOIN sys_dictionary b ON A .jyjxqk = b.f_code " + 
				"WHERE b.f_typecode = 'SYS031' AND b.f_code = '01' and a.orgid = '"+orgid +"' ";
		SQLAdapter adapter = new SQLAdapter(sqlstr);
		BasicMap< String, Object> map_jy= dbClient.findOne(adapter);
		 if (map_jy.isEmpty()) {
			 map_jy.put("jx", "0");
		}
	
		 //未成年
		 String sql_wcn = "SELECT count(*) as wcn from jz_jzryjbxx  WHERE orgid = '"+ orgid +"'";
		 SQLAdapter wcn = new SQLAdapter(sql_wcn);
		 BasicMap< String, Object> map_wcn= dbClient.findOne(wcn);
		 if (map_wcn.isEmpty()) {
			 map_wcn.put("wcn", "0");
		}
		 
		 //准假外出
		 String sql_qj = "SELECT count(a.*) as qj from JZ_WCSQXXCJB a WHERE a.audit = 1 and a.orgid = '"+ orgid +"'";
		 SQLAdapter qj = new SQLAdapter(sql_qj);
		 BasicMap<String, Object> map_qj = dbClient.findOne(qj);
		 if (map_qj.isEmpty()) {
			 map_qj.put("qj", "0");
		}
		 
		 
		 //托管
		 String sql_tg = "SELECT count(*) as tg from jz_jzryjbxx WHERE sftk = '1' and orgid = '"+orgid+"'";
		 SQLAdapter tg = new SQLAdapter(sql_tg);
		 BasicMap<String, Object> map_tg = dbClient.findOne(tg);
		 if (map_tg.isEmpty()) {
			 map_tg.put("tg", "0");
		}
		 
		 //附加禁止令
		 String sql_jzl = "SELECT count(*) as jzl from JZ_JZLXXCJB WHERE orgid = '"+orgid+"'";
		 SQLAdapter jzl = new SQLAdapter(sql_jzl);
		 BasicMap< String, Object> map_jzl = dbClient.findOne(jzl);
		 if (map_jzl.isEmpty()) {
			 map_jzl.put("jzl", "0");
		}
		 
		 //未报到
		 String sql_wbd = "SELECT count(a.*) as wbd from jz_jzryjbxx a LEFT JOIN sys_dictionary b on "
		 		+ "a.bdqk = b.f_code WHERE b.f_typecode = 'SYS016' AND a.bdqk = '02' and a.orgid = '"+ orgid +"'";
		 SQLAdapter wbd = new SQLAdapter(sql_wbd);
		 BasicMap<String, Object> map_wbd = dbClient.findOne(wbd);
		 if (map_wbd.isEmpty()) {
			map_wbd.put("wbd", "0");
		}
		 
		list.add(map_jy);
		list.add(map_wcn);
		list.add(map_qj);
		list.add(map_tg);
		list.add(map_jzl);
		list.add(map_wbd);
		
		return list;
	}
	
	//第二部分
	//待办任务列表
	
	
	
	
	//第三部分【时间检索】
	//矫正人员情况【年】【季度】【月份】
	public List<BasicMap<String, Object>> findJzry(BasicMap<String, Object> query) {
		List<BasicMap<String, Object>> list = new ArrayList<>();
		User user = service.getUser();
		String orgid = user.getOrgid();
		String months = "";
		String year = StringUtil.toString(query.get("year"));
		String jidu = StringUtil.toString(query.get("jidu"));
		int month = NumberUtil.toInt(query.get("month"));
	
		if (month == 0) {
			month  += NumberUtil.toInt(DateUtil.getMonth());
			if (month <= 9) {
				months = "0" + month;
			}
		}
		if (month <= 9) {
			 months = "0"+ month;
		}
		
		String start = year+ months +"01";
		String end = year+ months +"30";
		List<BasicMap<String, Object>> jidu_list = DateUtils.getByType(year,jidu);
			
		//余罪和在犯罪人员
		String sqlstr = "SELECT count(*) as yz from JZ_YZHZZYGQKXXCJB ";
		SQLAdapter adapter = new SQLAdapter(sqlstr);
		SqlDbFilter filter = new SqlDbFilter();
		filter.eq("orgid", orgid);
		if (null != jidu) {
			filter.between("cdate", NumberUtil.toInt(jidu_list.get(0).get("quarterstart")), 
					NumberUtil.toInt(jidu_list.get(0).get("quarterend")));
		}else {
			filter.between("cdate",NumberUtil.toInt(start), NumberUtil.toInt(end));
		}
		
		adapter.setFilter(filter);
		BasicMap<String, Object> map_yz = dbClient.findOne(adapter);
		
		//衔接 
		 String sqlstr_xj = "SELECT count(*) as xj from ANZBJ_RYXJXXCJB ";
			SQLAdapter adapter_xj = new SQLAdapter(sqlstr_xj);
			SqlDbFilter filter_xj = new SqlDbFilter();
			filter_xj.eq("orgid", orgid);
			if (null != jidu) {
				filter_xj.between("cdate", NumberUtil.toInt(jidu_list.get(0).get("quarterstart")), 
						NumberUtil.toInt(jidu_list.get(0).get("quarterend")));
			}else {
				filter_xj.between("cdate",NumberUtil.toInt(start), NumberUtil.toInt(end));
			}
			adapter_xj.setFilter(filter_xj);
			BasicMap<String, Object> map_xj = dbClient.findOne(adapter_xj);
		
		
		//未建组
		 String sqlstr_wj = "SELECT count(*) as wj from jz_jzryjbxx ";
			SQLAdapter adapter_wj = new SQLAdapter(sqlstr_wj);
			SqlDbFilter filter_wj = new SqlDbFilter();
			filter_wj.eq("SFJLJZXZ", "0");
			filter_wj.eq("orgid", orgid);
			if (null != jidu) {
				filter_wj.between("cdate", NumberUtil.toInt(jidu_list.get(0).get("quarterstart")), 
						NumberUtil.toInt(jidu_list.get(0).get("quarterend")));
			}else {
				filter_wj.between("cdate",NumberUtil.toInt(start), NumberUtil.toInt(end));
			}
			adapter_wj.setFilter(filter_wj);
			BasicMap<String, Object> map_wj = dbClient.findOne(adapter_wj);
		
		
		//解除矫正
		String sqlstr_jc = "SELECT count(*) as jc from JZ_JZJCXXCJB ";
		SQLAdapter adapter_jc = new SQLAdapter(sqlstr_jc);
		SqlDbFilter filter_jc = new SqlDbFilter();
		filter_jc.eq("orgid", orgid);
		if (null != jidu) {
			filter_jc.between("cdate", NumberUtil.toInt(jidu_list.get(0).get("quarterstart")), 
					NumberUtil.toInt(jidu_list.get(0).get("quarterend")));
		}else {
			filter_jc.between("cdate",NumberUtil.toInt(start), NumberUtil.toInt(end));
		}
		
		adapter_jc.setFilter(filter_jc);
		BasicMap<String, Object> map_jc = dbClient.findOne(adapter_jc);
		
		//思想
		String sqlstr_sx = "SELECT count(*) as sx from JZ_SXHB ";
		SQLAdapter adapter_sx = new SQLAdapter(sqlstr_sx);
		SqlDbFilter filter_sx = new SqlDbFilter();
		filter_sx.eq("orgid", orgid).eq("F_PF", "3");
		if (null != jidu) {
			filter_sx.between("cdate", NumberUtil.toInt(jidu_list.get(0).get("quarterstart")), 
					NumberUtil.toInt(jidu_list.get(0).get("quarterend")));
		}else {
			filter_sx.between("cdate",NumberUtil.toInt(start), NumberUtil.toInt(end));
		}
		
		adapter_sx.setFilter(filter_sx);
		BasicMap<String, Object> map_sx = dbClient.findOne(adapter_sx);
	
		//居住 
		String sqlstr_zz = "SELECT count(*) as zz from JZ_JZDBGXXCJB ";
		SQLAdapter adapter_zz = new SQLAdapter(sqlstr_zz);
		SqlDbFilter filter_zz = new SqlDbFilter();
		filter_zz.eq("orgid", orgid);
		if (null != jidu) {
			filter_zz.between("cdate", NumberUtil.toInt(jidu_list.get(0).get("quarterstart")), 
					NumberUtil.toInt(jidu_list.get(0).get("quarterend")));
		}else {
			filter_zz.between("cdate",NumberUtil.toInt(start), NumberUtil.toInt(end));
		}
		adapter_zz.setFilter(filter_zz);
		BasicMap<String, Object> map_zz = dbClient.findOne(adapter_zz);
		
		//方案
		String sqlstr_fa = "SELECT count(*) as fa from JZ_JZFAXX ";
		SQLAdapter adapter_fa = new SQLAdapter(sqlstr_fa);
		SqlDbFilter filter_fa = new SqlDbFilter();
		filter_fa.eq("orgid", orgid);
		if (null != jidu) {
			filter_fa.between("cdate", NumberUtil.toInt(jidu_list.get(0).get("quarterstart")), 
					NumberUtil.toInt(jidu_list.get(0).get("quarterend")));
		}else {
			filter_fa.between("cdate",NumberUtil.toInt(start), NumberUtil.toInt(end));
		}
		adapter_fa.setFilter(filter_fa);
		BasicMap<String, Object> map_fa = dbClient.findOne(adapter_fa);
		
		
		// 外出 
		String sqlstr_wc = "SELECT count(*) as wc from JZ_WCSQXXCJB ";
		SQLAdapter adapter_wc = new SQLAdapter(sqlstr_wc);
		SqlDbFilter filter_wc = new SqlDbFilter();
		filter_wc.eq("orgid", orgid);
		if (null != jidu) {
			filter_wc.between("cdate", NumberUtil.toInt(jidu_list.get(0).get("quarterstart")), 
					NumberUtil.toInt(jidu_list.get(0).get("quarterend")));
		}else {
			filter_wc.between("cdate",NumberUtil.toInt(start), NumberUtil.toInt(end));
		}
		adapter_wc.setFilter(filter_wc);
		BasicMap<String, Object> map_wc = dbClient.findOne(adapter_wc);
		
		list.add(map_yz);
		list.add(map_xj);
		list.add(map_wj);
		list.add(map_jc);
		list.add(map_sx);
		list.add(map_zz);
		list.add(map_fa);
		list.add(map_wc);
		return list;
	}
	
}
