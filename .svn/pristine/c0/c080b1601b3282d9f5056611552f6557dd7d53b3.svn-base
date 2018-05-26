package com.ehtsoft.supervise.services;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import com.ehtsoft.common.services.SSOService;
import com.ehtsoft.fw.core.context.AppException;
import com.ehtsoft.fw.core.db.SQLAdapter;
import com.ehtsoft.fw.core.db.SqlDbClient;
import com.ehtsoft.fw.core.db.SqlDbFilter;
import com.ehtsoft.fw.core.dto.BasicMap;
import com.ehtsoft.fw.core.dto.Paginate;
import com.ehtsoft.fw.core.dto.ResultList;
import com.ehtsoft.fw.core.services.AbstractService;
import com.ehtsoft.fw.core.sso.User;
import com.ehtsoft.supervise.api.SupConst;
@Service("JcflfwsService")
public class JcflfwsService extends AbstractService{
	
	@Resource(name="sqlDbClient")
	SqlDbClient dbClient;
	
	@Resource(name="SSOService")
	private SSOService service;
	/**
	 * 查询所有基层法律服务所
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
			String sql = "select * from FLFW_JCFLFWS";
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
		dbClient.save(SupConst.Collections.FLFW_JCFLFWS, data);
	}
	/**
	 * 删除服务所信息
	 * @param id
	 */
	public void remove(String id){
		dbClient.remove(SupConst.Collections.FLFW_JCFLFWS, new SqlDbFilter().eq("id", id));
	}
	/**
	 * 查询机构对应的坐标和编码
	 * @return{"":""}
	 */
	public BasicMap<String, Object> findOne(){
		User user = service.getUser();
		BasicMap<String,Object> map = new BasicMap<>();
		if(user != null){
			String sql = "select regionid,lat,lng from SYS_REGION where region_code='"+user.getRegioncode()+"'";
			SqlDbFilter filter = new SqlDbFilter();
			filter.in("orgid", user.getOrgidSet());
			SQLAdapter adapter = new SQLAdapter(sql);
			map = dbClient.findOne(adapter);
		}else{
			new AppException("登陆用户没有权限！");
		}
		return map;
	}
}
