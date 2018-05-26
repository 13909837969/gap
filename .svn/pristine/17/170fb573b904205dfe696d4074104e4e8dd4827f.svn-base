package com.ehtsoft.supervise.services;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ehtsoft.fw.core.db.SQLAdapter;
import com.ehtsoft.fw.core.db.SqlDbClient;
import com.ehtsoft.fw.core.db.SqlDbFilter;
import com.ehtsoft.fw.core.dto.BasicMap;
import com.ehtsoft.fw.core.dto.Paginate;
import com.ehtsoft.fw.core.services.AbstractService;
import com.ehtsoft.fw.utils.StringUtil;
import com.ehtsoft.supervise.api.SupConst;

@Service("JzxnsfxxService")
public class JzxnsfxxService extends AbstractService{

	@Resource(name="sqlDbClient")
	SqlDbClient dbClient;
	
	/**
	 * 新增或修改虚拟身份信息
	 * @param data
	 */
	public void saveJzxnsfxx(BasicMap<String, Object> data){
		dbClient.save(SupConst.Collections.JZ_XNSFXXCJ, data);
	}
	
	
	
	/**
	 * 查询当前矫正人员虚拟身份信息
	 * @param query
	 * @return
	 */
	public List<BasicMap<String, Object>> findJzxnsfxx(BasicMap<String, Object> query){
		List<BasicMap<String,Object>> list = new ArrayList<>();
		String sqlstr = "select * from JZ_XNSFXXCJ";
		SqlDbFilter sqlDbFilter = new SqlDbFilter();
		sqlDbFilter.like("hm", StringUtil.toEmptyString(query.get("hm")))
		.eq("f_aid", StringUtil.toEmptyString(query.get("f_aid")));
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
	 * 查询当前矫正人员虚拟身份信息
	 * @param query
	 * @return
	 */
	public List<BasicMap<String, Object>> findJzxnsfxx(String id,Paginate paginate){
		List<BasicMap<String,Object>> list = new ArrayList<>();
		String sqlstr = "select * from JZ_XNSFXXCJ";
		SqlDbFilter sqlDbFilter = new SqlDbFilter();
		sqlDbFilter.eq("f_aid",id);
		SQLAdapter sqlAdapter = new SQLAdapter(sqlstr);
		sqlAdapter.setFilter(sqlDbFilter);
		list = dbClient.find(sqlAdapter);
		return list;
	}
	
	/**
	 * 删除当前矫正人员虚拟信息
	 * @param query
	 */
	public void  deleteOne(BasicMap<String, Object> query){
		dbClient.remove(SupConst.Collections.JZ_XNSFXXCJ,new SqlDbFilter().eq("id", StringUtil.toEmptyString(query.get("id"))));
	}
}
