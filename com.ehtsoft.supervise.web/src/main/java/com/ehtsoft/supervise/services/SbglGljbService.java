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
import com.ehtsoft.fw.utils.StringUtil;
import com.ehtsoft.supervise.api.SupConst;
import com.ibm.icu.text.DateFormat;
@Service("SbglGljbService")
public class SbglGljbService extends AbstractService{
	
	@Resource(name = "sqlDbClient")
	private SqlDbClient dbClient;
	
	@Resource(name="SSOService")
	private SSOService service;
	/**
	 * 查询矫正人员的管理级别信息
	 * @param query
	 * @param paginate
	 * @return
	 */
	public List<BasicMap<String, Object>> findAll(BasicMap<String, Object> query){
		User user = service.getUser();
		List<BasicMap<String, Object>> list = new ArrayList<BasicMap<String, Object>>();
		SqlDbFilter filter = new SqlDbFilter();
		if(user != null){
			String sql = "select * from JZ_GLJBXXCJB";
			filter.eq("f_aid", StringUtil.toString(query.get("f_aid")));
			SQLAdapter adapter = new SQLAdapter(sql);
			adapter.setFilter(filter);
			list = dbClient.find(adapter);
		}
		return list;
	}
	/**
	 * 新增或修改矫正人员管理级别信息
	 * @param data
	 */
	public void save(BasicMap<String, Object> data){
		dbClient.save(SupConst.Collections.JZ_GLJBXXCJB, data);
		BasicMap<String, Object> map = new BasicMap<>();
		map.put("jglb", data.get("gljb"));
		map.put("id", data.get("f_aid"));
		dbClient.update(SupConst.Collections.JZ_JZRYJBXX, map);
	}
	/**
	 * 删除矫正人员管理级别信息
	 * @param f_aid
	 */
	public void deleteOne(BasicMap<String, Object> data){
		dbClient.remove(SupConst.Collections.JZ_GLJBXXCJB, new SqlDbFilter().eq("id", StringUtil.toString(data.get("id"))));
	}
}
