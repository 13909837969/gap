package com.ehtsoft.supervise.services;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ehtsoft.common.services.SSOService;
import com.ehtsoft.fw.core.db.MongoClient;
import com.ehtsoft.fw.core.db.RowDataListener;
import com.ehtsoft.fw.core.db.SQLAdapter;
import com.ehtsoft.fw.core.db.SqlDbClient;
import com.ehtsoft.fw.core.db.SqlDbFilter;
import com.ehtsoft.fw.core.dto.BasicMap;
import com.ehtsoft.fw.core.dto.Paginate;
import com.ehtsoft.fw.core.dto.ResultList;
import com.ehtsoft.fw.core.services.AbstractService;
import com.ehtsoft.fw.core.sso.User;
import com.ehtsoft.fw.utils.DateUtil;
import com.ehtsoft.fw.utils.StringUtil;
import com.ehtsoft.supervise.api.SupConst;

@Service("ZfzxxService")
public class ZfzxxService extends AbstractService{
	
	@Resource(name = "sqlDbClient")
	private SqlDbClient dbClient;
	
	@Resource(name = "SSOService")
	private SSOService service;
	
	@Resource(name="mongoClient")
	private MongoClient mongoClient;
	
	
	/**
	 * 查找人员基本信息
	 */
	public ResultList<BasicMap<String,Object>> find(BasicMap<String,Object> data,Paginate page){
		User user=service.getUser();
		SqlDbFilter filter=toSqlFilter(data);
		//SqlDbFilter filter=new SqlDbFilter();
		String sql="SELECT id,xm,sfzh,grlxdh FROM JZ_JZRYJBXX";
		SQLAdapter sqlAdapter = new SQLAdapter(sql);
		filter.eq("orgid", user.getOrgid());
		sqlAdapter.setFilter(filter);
		ResultList<BasicMap<String, Object>> list = dbClient.find(sqlAdapter, page, new RowDataListener() {
			@Override
			public void processData(BasicMap<String, Object> rowData) {
				rowData.put("CSRQ", DateUtil.format(rowData.get("CSRQ"), "yyyy-MM-dd"));
				rowData.put("CJGZSJ", DateUtil.format(rowData.get("CJGZSJ"), "yyyy-MM-dd"));
			}
		});
		return list;
	}
	
	/**
	 * 查找再罪
	 * @param aid
	 * @return
	 */
	public List<BasicMap<String,Object>> findZz(String aid){
		List<BasicMap<String,Object>> list=new ArrayList<>();
		String sql="SELECT * FROM JZ_SQJZRYZJZQJZFZXXCJB";
		SQLAdapter sqlAdapter = new SQLAdapter(sql);
		SqlDbFilter sqlDbFilter=new SqlDbFilter();
		sqlDbFilter.eq("aid",aid);
		sqlDbFilter.desc("xqksrq");
		sqlAdapter.setFilter(sqlDbFilter);
		list=dbClient.find(sqlAdapter);
		return list;
	}
	/**
	 * 提交
	 * @return 
	 */
	public void saveZfzxx(BasicMap<String, Object> data){
		dbClient.save(SupConst.Collections.JZ_SQJZRYZJZQJZFZXXCJB, data);
	}
	
	/**
	 * 删除
	 */
	public void deleteOne(BasicMap<String, Object> data){
		dbClient.remove(SupConst.Collections.JZ_SQJZRYZJZQJZFZXXCJB,new SqlDbFilter().eq("id", StringUtil.toEmptyString(data.get("id"))));
	}

	
}
