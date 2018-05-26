package com.ehtsoft.supervise.services;

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

@Service("JCshzyzxxService")
public class JCshzyzxxService extends AbstractService{
	
	@Resource(name = "sqlDbClient")
	private SqlDbClient dbClient;
	
	@Resource(name = "SSOService")
	private SSOService service;
	
	@Resource(name="mongoClient")
	private MongoClient mongoClient;
	
	
	/**
	 * 志愿者工作人员查找
	 */
	public ResultList<BasicMap<String,Object>> find(BasicMap<String,Object> data,Paginate page){
		User user=service.getUser();
		//SqlDbFilter filter=toSqlFilter(data);
		SqlDbFilter filter=new SqlDbFilter();
		String sql="SELECT * FROM JC_SFXZJGGZRYJBXX";
		SQLAdapter sqlAdapter = new SQLAdapter(sql);
		filter.eq("orgid", user.getOrgid());
		filter.asc("xm");
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
	 * 提交
	 * @return 
	 */
	public void saveSfsry(BasicMap<String, Object> data){
		dbClient.save(SupConst.Collections.JC_SFXZJGGZRYJBXX, data);
	}
	
	/**
	 * 删除
	 */
	public void deleteOne(BasicMap<String, Object> data){
		dbClient.remove(SupConst.Collections.JC_SFXZJGGZRYJBXX,new SqlDbFilter().eq("id", StringUtil.toEmptyString(data.get("id"))));
		
	}
}
