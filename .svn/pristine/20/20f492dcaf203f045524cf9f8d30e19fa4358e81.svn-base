package com.ehtsoft.supervise.services;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ehtsoft.common.services.SSOService;
import com.ehtsoft.fw.core.db.SQLAdapter;
import com.ehtsoft.fw.core.db.SqlDbClient;
import com.ehtsoft.fw.core.db.SqlDbFilter;
import com.ehtsoft.fw.core.dto.BasicMap;
import com.ehtsoft.fw.core.dto.Paginate;
import com.ehtsoft.fw.core.dto.ResultList;
import com.ehtsoft.fw.core.services.AbstractService;
import com.ehtsoft.fw.core.sso.User;
import com.ehtsoft.fw.utils.StringUtil;
import com.ehtsoft.supervise.api.SupConst;

@Service("XqbdService")
public class XqbdService extends AbstractService{

	/**
	 * 刑期变动
	 */
	
	@Resource(name="sqlDbClient")
	private SqlDbClient dbClient;
	
	@Resource(name="SSOService")
	private SSOService service;
	/**
	 * 获取社区矫正人员基本信息
	 * 
	 * 姓名:xm
	 * 身份证号：sfzh
	 * 个人联系电话:grlxdh
	 * 教管类型:jglx
	 * 结果意见:jgyj
	 */	
	public ResultList<BasicMap<String, Object>> findAllRy(BasicMap<String,Object> data,Paginate paginate){
		User user= service.getUser();
		SqlDbFilter filter = toSqlFilter(data);		
		String sql = "SELECT id,xm,sfzh,grlxdh,jglx FROM JZ_JZRYJBXX " ;		
		SQLAdapter sqlAdapter = new SQLAdapter(sql);
		sqlAdapter.setFilter(filter);
		filter.asc("xm");
		filter.eq("orgid", user.getOrgid());
		filter.eq("JCJZ","0");
		ResultList<BasicMap<String, Object>> list = dbClient.find(sqlAdapter, paginate);
		return list;
	}
	
	/**
	 * 保存 刑期变动情况信息采集表
	 * @param data
	 */
	public void saveXq(BasicMap<String, Object> data){		
		dbClient.save(SupConst.Collections.JZ_XQBDQKXXCJB, data);
	}
	
	
	public List<BasicMap<String, Object>> findXqbd(String aid){
		List<BasicMap<String,Object>> list = new ArrayList<>();
		String sqlstr = "select * from JZ_XQBDQKXXCJB";
		SqlDbFilter sqlDbFilter = new SqlDbFilter();
		sqlDbFilter.eq("AID", aid);
		SQLAdapter sqlAdapter = new SQLAdapter(sqlstr);
		sqlAdapter.setFilter(sqlDbFilter);
		list = dbClient.find(sqlAdapter);
		return list;
	}
		
	
	/**
	 * 删除
	 */
	public void deleteOne(BasicMap<String, Object> data){
		dbClient.remove(SupConst.Collections.JZ_XQBDQKXXCJB,new SqlDbFilter().eq("id", StringUtil.toEmptyString(data.get("id"))));
	}
	
}