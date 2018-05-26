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
import com.ehtsoft.fw.core.dto.Paginate;
import com.ehtsoft.fw.core.dto.ResultList;
import com.ehtsoft.fw.core.services.AbstractService;
import com.ehtsoft.fw.core.sso.User;
import com.ehtsoft.fw.utils.DateUtil;
import com.ehtsoft.supervise.api.SupConst;
@Service("BfxxService")
public class BfxxService extends AbstractService{
	@Resource(name="sqlDbClient")
	SqlDbClient dbClient;
	
	@Resource(name="SSOService")
	private SSOService service;
	/*
	 * 帮扶服务情况查询
	 */
	public ResultList<BasicMap<String, Object>> findAllHelp(BasicMap<String, Object> query,Paginate paginate){
		User user = service.getUser();
		ResultList<BasicMap<String, Object>> list = new ResultList<>();
		SqlDbFilter filter = toSqlFilter(query);
		if(user != null){
			String sql = "select a.id,a.f_aid,a.bfsj,a.bfdd,a.bfnr,a.jlr,b.xm,b.xb,b.sqjzrybh from JZ_BFXXCJB a inner join JZ_JZRYJBXX b on a.f_aid=b.id";
			SQLAdapter sqlAdapter = new SQLAdapter(sql);
			filter.in("b.orgid", user.getOrgidSet());
			sqlAdapter.setFilter(filter);
			list = dbClient.find(sqlAdapter, paginate,new RowDataListener() {
				@Override
				public void processData(BasicMap<String, Object> rowData) {
					rowData.put("bfsj", DateUtil.format(rowData.get("bfsj"), "yyyy-MM-dd HH:mm"));
				}
			});
		}
		return list;
	}
	/**
	 * 新增或插入一条帮扶信息
	 */
	public void saveHelp(BasicMap<String,Object> data){
		dbClient.save(SupConst.Collections.JZ_BFXXCJB, data);
	}
	/**
	 * 删除一条帮扶信息
	 */
	public void deleteHelp(String f_aid){
		dbClient.remove(SupConst.Collections.JZ_BFXXCJB, new SqlDbFilter().eq("id", f_aid));
	}
	/**
	 * 查询所属机构范围的矫正人员
	 * @return{{"":"","":""},{"":"","":""}}
	 */
	public List<BasicMap<String, Object>> findJzry(){
		User user = service.getUser();
		List<BasicMap<String, Object>> list = new ArrayList<>();
		if(user != null){
			String sql = "select id,xm,grlxdh from JZ_JZRYJBXX";
			SqlDbFilter filter = new SqlDbFilter();
			filter.in("orgid", user.getOrgidSet());
			SQLAdapter adapter = new SQLAdapter(sql);
			adapter.setFilter(filter);
			list = dbClient.find(adapter);
		}
		return list;
	}
}
