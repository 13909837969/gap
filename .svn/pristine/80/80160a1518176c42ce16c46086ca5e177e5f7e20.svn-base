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
@Service("JcflgzzService")
public class JcflgzzService extends AbstractService{
	
	@Resource(name="sqlDbClient")
	SqlDbClient dbClient;
	
	@Resource(name="SSOService")
	private SSOService service;
	
	/**
	 * 查询所有基层法律服务工作者
	 * @param query
	 * @param paginate
	 * @return{{"":""},{"":""},{"":""},{"":""}}
	 */
	public ResultList<BasicMap<String, Object>> findAll(BasicMap<String, Object> query,Paginate paginate){
		User user = service.getUser();
		ResultList<BasicMap<String, Object>> list = new ResultList<>();
		if(user != null){
			SqlDbFilter filter = toSqlFilter(query);
			SqlDbFilter sqlDbFilter = new SqlDbFilter();
			String sql = "select * from FLFW_JCFLFWGZZ";
			SQLAdapter adapter = new SQLAdapter(sql);
			adapter.setFilter(filter);
			list = dbClient.find(adapter, paginate);
			sqlDbFilter.in("orgid", user.getOrgidSet());
		}
		return list;
	}
	/**
	 * 新增或者修改一条信息
	 * @param data
	 */
	public void saveOne(BasicMap<String, Object> data){
		dbClient.save(SupConst.Collections.FLFW_JCFLFWGZZ, data);
	}
	/**
	 * 删除服务工作者信息
	 * @param id
	 */
	public void remove(String id){
		dbClient.remove(SupConst.Collections.FLFW_JCFLFWGZZ, new SqlDbFilter().eq("id", id));
	}
}
