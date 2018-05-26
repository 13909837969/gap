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
import com.ehtsoft.fw.utils.StringUtil;
import com.ehtsoft.supervise.api.SupConst;
//sunhailong
@Service("ShjzjdService")
public class ShjzjdService extends AbstractService{
	
	@Resource(name="sqlDbClient")
	private SqlDbClient dbClient;
	
	@Resource(name="SSOService")
	private SSOService ssoService;
	/**
	 * 查询所有社会矫正基地
	 * @param query
	 * @param paginate
	 * @return
	 */
	public ResultList<BasicMap<String, Object>> findAll(BasicMap<String, Object> query,Paginate paginate){
		User user = ssoService.getUser();
		ResultList<BasicMap<String, Object>> list = new ResultList<>();
		if(user != null){
			SqlDbFilter filter = toSqlFilter(query);
			String sql = "select * from JZ_SHJZJD";
			SQLAdapter adapter = new SQLAdapter(sql);
			filter.in("orgid", user.getOrgidSet());
			adapter.setFilter(filter);
			list = dbClient.find(adapter, paginate);
		}
		return list;
	}
	/**
	 * 保存一条矫正基地信息
	 * @param data
	 */
	public void saveOne(BasicMap<String, Object> data){
		dbClient.save(SupConst.Collections.JZ_SHJZJD, data);
	}
	/**
	 * 删除一条信息
	 * @param query
	 */
	public void deleteOne(BasicMap<String, Object> query){
		dbClient.remove(SupConst.Collections.JZ_SHJZJD, new SqlDbFilter().eq("id", StringUtil.toEmptyString(query.get("id"))));
	}
	/**
	 * 查询一条信息
	 * @param query
	 * @return
	 */
	public BasicMap<String, Object> findOne(BasicMap<String, Object> query){
		BasicMap<String, Object> rtn = new BasicMap<>();
		rtn = dbClient.findOne(SupConst.Collections.JZ_SHJZJD, new SqlDbFilter().eq("id", StringUtil.toEmptyString(query.get("id"))));
		return rtn;
	}
}
