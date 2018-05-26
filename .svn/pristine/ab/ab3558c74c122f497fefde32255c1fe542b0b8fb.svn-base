package com.ehtsoft.supervise.services;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ehtsoft.fw.core.db.RowDataListener;
import com.ehtsoft.fw.core.db.SQLAdapter;
import com.ehtsoft.fw.core.db.SqlDbClient;
import com.ehtsoft.fw.core.db.SqlDbFilter;
import com.ehtsoft.fw.core.dto.BasicMap;
import com.ehtsoft.fw.core.dto.Paginate;
import com.ehtsoft.fw.core.services.AbstractService;
import com.ehtsoft.fw.utils.DateUtil;
import com.ehtsoft.fw.utils.StringUtil;
import com.ehtsoft.supervise.api.SupConst;

/**
 * 
 * @author 何向昕
 * 社区矫正人员--同案犯
 */
@Service("JZTAFService")
public class JZTAFService extends AbstractService{
	
	@Resource(name="sqlDbClient")
	SqlDbClient dbClient;
	
	/**
	 * 查询同案犯关联矫正人员信息
	 * @param query
	 * @return
	 */
	public List<BasicMap<String, Object>> findTafBasic(BasicMap<String, Object> query){
		List<BasicMap<String, Object>> rtn = new ArrayList<>();
		String sqlstr = "select id,xm,xb,csrq,jtzm as zm,ypxq as xq,gdjzdmx as jtzz,grlxdh from jz_jzryjbxx";
		SqlDbFilter sqlDbFilter = toSqlFilter(query);
		SQLAdapter sqlAdapter = new SQLAdapter(sqlstr);
		sqlAdapter.setFilter(sqlDbFilter);
		rtn = dbClient.find(sqlAdapter,new RowDataListener() {
			@Override
			public void processData(BasicMap<String, Object> arg0) {
				arg0.put("csrq", DateUtil.format(arg0.get("csrq"), "yyyy-MM-dd"));
			}
		});
		return rtn;
	}
	
	
	/**
	 * 查询当前矫正人员同案犯信息
	 * @param query
	 * @return
	 */
	public List<BasicMap<String, Object>> findTaf(BasicMap<String, Object> query){
		List<BasicMap<String,Object>> list = new ArrayList<>();
		String sqlstr = "select a.id,a.xm,a.xb,a.csrq,a.zm ,a.xq,a.jtzz,a.BPCXZJSZJS  "
				+ "from JZ_TAFXXCJ a ";
		SqlDbFilter sqlDbFilter = new SqlDbFilter();
		sqlDbFilter.like("a.xm", StringUtil.toEmptyString(query.get("xm")))
		.eq("a.f_aid", StringUtil.toEmptyString(query.get("f_aid")));
		SQLAdapter sqlAdapter = new SQLAdapter(sqlstr);
		sqlAdapter.setFilter(sqlDbFilter);
		list = dbClient.find(sqlAdapter);
		if (list.size() <= 0) {
			BasicMap<String, Object> map = new BasicMap<>();
			map.put("nomessage", "0");
			list.add(map);
		}
		return list;
	}
	
	
	
	
	/**
	 * 查询当前矫正人员同案犯信息
	 * @param query
	 * @return
	 */
	public List<BasicMap<String, Object>> findTaf(String id,Paginate paginate){
		List<BasicMap<String,Object>> list = new ArrayList<>();
		String sqlstr = "select a.id,a.xm,a.xb,a.csrq,a.zm ,a.xq,a.jtzz,a.BPCXZJSZJS  "
				+ "from JZ_TAFXXCJ a ";
		SqlDbFilter sqlDbFilter = new SqlDbFilter();
		sqlDbFilter.eq("f_aid", id);
		SQLAdapter sqlAdapter = new SQLAdapter(sqlstr);
		sqlAdapter.setFilter(sqlDbFilter);
		list = dbClient.find(sqlAdapter);
		return list;
	}
	
	/**
	 * 删除当前矫正人员同案犯信息
	 * @param query
	 */
	public void  deleteOne(BasicMap<String, Object> query){
		dbClient.remove(SupConst.Collections.JZ_TAFXXCJ,new SqlDbFilter().eq("id", StringUtil.toEmptyString(query.get("id"))));
	}
	/**
	 * 查询一条同案犯信息
	 * @param query
	 * @return
	 */
	public BasicMap<String, Object> findOne(BasicMap<String, Object> query){
		BasicMap<String, Object> rtn = new BasicMap<>();
		rtn = dbClient.findOne(SupConst.Collections.JZ_TAFXXCJ, new SqlDbFilter().eq("id", StringUtil.toEmptyString(query.get("id"))));
		return rtn;
	}
	
	/**
	 * 保存或修改同案犯信息
	 * @param data
	 */
	public void saveTaf(BasicMap<String,Object> data){
		if(!"".equals(data.get("id"))){
			data.put("sfczda", "1");
		}
		dbClient.save(SupConst.Collections.JZ_TAFXXCJ, data);
	}
}
