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
@Service("RmtjWyhService")
public class RmtjWyhService extends AbstractService{
	
	@Resource(name="sqlDbClient")
	SqlDbClient dbClient;
	
	@Resource(name="SSOService")
	private SSOService service;
	/**
	 * 查询调解委员会基本信息
	 * @param query
	 * @param paginate
	 * @return
	 */
	public ResultList<BasicMap<String,Object>> findAllWyh(BasicMap<String,Object> query,Paginate paginate){
		User user = service.getUser();
		ResultList<BasicMap<String,Object>>  list = new ResultList<>();
		if(user != null){
			SqlDbFilter filter = toSqlFilter(query);
			String sql = "select * from RMTJ_JWHJBXX";
			filter.in("orgid", user.getOrgidSet());
			SQLAdapter adapter = new SQLAdapter(sql);
			adapter.setFilter(filter);
			list = dbClient.find(adapter, paginate);
		}
		return list;
	}
	/**
	 * 查询调解员基本信息
	 * @param query
	 * @param paginate
	 * @return
	 */
	public ResultList<BasicMap<String,Object>> findAllTjy(BasicMap<String,Object> query,Paginate paginate){
		User user = service.getUser();
		ResultList<BasicMap<String,Object>>  list = new ResultList<>();
		if(user != null){
			SqlDbFilter filter = toSqlFilter(query);
			String sql = "select * from RMTJ_TJYJBXX";
			SQLAdapter adapter = new SQLAdapter(sql);
			adapter.setFilter(filter);
			list = dbClient.find(adapter, paginate);
		}
		return list;
	}
}
