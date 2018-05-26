package com.ehtsoft.supervise.services;

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
import com.ehtsoft.supervise.api.SupConst;
@Service("ShgzzService")
public class ShgzzService extends AbstractService{
	@Resource(name = "sqlDbClient")
	private SqlDbClient dbClient;
	
	@Resource(name="SSOService")
	private SSOService service;
	
	/**
	 * 查询社会工作者信息
	 * @param query
	 * @param paginate
	 * @return{{"":"","":"",..},{"":"","":"",...},{}...}
	 */
	public ResultList<BasicMap<String, Object>> findAll(BasicMap<String, Object> query,Paginate paginate){
		User user = service.getUser();
		ResultList<BasicMap<String, Object>> list = new ResultList<>();
		if(user != null){
			String sql = "select * from JZ_SHGZZXXCJB";
			SqlDbFilter filter = toSqlFilter(query);
			filter.in("orgid", user.getOrgidSet());
			SQLAdapter adapter = new SQLAdapter(sql);
			adapter.setFilter(filter);
			list = dbClient.find(adapter, paginate);
		}
		return list;
	}
	/**
	 * 新增或者修改一条社会工作者信息
	 * @param data
	 */
	public void saveOne(BasicMap<String, Object> data){
		dbClient.save(SupConst.Collections.JZ_SHGZZXXCJB, data);
	}
	/**
	 * 根据工作者id删除一条工作者信息
	 * @param id
	 */
	public void removeOne(String id){
		dbClient.remove(SupConst.Collections.JZ_SHGZZXXCJB, new SqlDbFilter().eq("id", id));
	}
}
