package com.ehtsoft.supervise.services;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.bouncycastle.i18n.filter.SQLFilter;
import org.springframework.stereotype.Service;

import com.ehtsoft.common.services.SSOService;
import com.ehtsoft.fw.core.db.SQLAdapter;
import com.ehtsoft.fw.core.db.SqlDbClient;
import com.ehtsoft.fw.core.db.SqlDbFilter;
import com.ehtsoft.fw.core.dto.BasicMap;
import com.ehtsoft.fw.core.dto.Paginate;
import com.ehtsoft.fw.core.services.AbstractService;
import com.ehtsoft.fw.core.sso.User;
import com.ehtsoft.fw.utils.StringUtil;
import com.ehtsoft.supervise.api.SupConst;

/**
 * 基层法律服务-基层法律服务所
 * @author maruimin
 *
 */

@Service("FlfwJcflfwsService")
public class FlfwJcflfwsService extends AbstractService{
	
	@Resource(name="sqlDbClient")
	private SqlDbClient dbClient;
	@Resource(name="SSOService")
	private SSOService service;
	
	/**
	 * 查询所有法律服务所
	 * @param query
	 * @param paginate
	 * @return
	 */
	public List<BasicMap<String,Object>> findAll(BasicMap<String,Object> query,Paginate paginate){
		User user =service.getUser();
		List<BasicMap<String,Object>> list=new ArrayList<>();
		//SqlDbFilter filter=toSqlFilter(query);
		String sql="select * from FLFW_JCFLFWS";
		SQLAdapter adapter=new SQLAdapter(sql);
		SqlDbFilter filter=new SqlDbFilter();
		filter.like("jgmc",StringUtil.toEmptyString(query.get("jgmc")))
		      .eq("id", user.getOrgid());
		adapter.setFilter(filter);
		list=dbClient.find(adapter, paginate).getRows();
		return list;
	}
	
	/**
	 * 查询法律服务所的详细信息
	 * @param id
	 * @return
	 */
	public BasicMap<String,Object> findOne(String id){
		BasicMap<String,Object> data=new BasicMap<>();
		String sql="select * from FLFW_JCFLFWS";
		SQLAdapter adapter=new SQLAdapter(sql);
		adapter.getFilter().eq("id", id);
		data=dbClient.findOne(adapter);
		return data;
	}
	
	/**
	 * 保存法律服务所经纬度
	 * @param data
	 */
	public void save(BasicMap<String,Object> data){
		dbClient.save(SupConst.Collections.FLFW_JCFLFWS, data);
		
	}

	

}
