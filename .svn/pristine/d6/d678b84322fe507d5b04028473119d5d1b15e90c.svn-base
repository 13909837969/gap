package com.ehtsoft.sfs.services;

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
import com.ehtsoft.fw.utils.StringUtil;
import com.ehtsoft.fw.utils.Util;
import com.ehtsoft.supervise.api.SupConst;
//sunhailong
@Service("SfsGzrysbzService")
public class SfsGzrysbzService extends AbstractService{
	
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
			String sql = "select b.id as bid,b.xm,b.xb,b.rybm,b.sfzh,a.* "
					+ "FROM  SFS_SFSGZRYSBZQKXXB a "
					+ "LEFT JOIN JC_SFXZJGGZRYJBXX b on b.id=a.ryid";
			SQLAdapter adapter = new SQLAdapter(sql);
			
			filter.eq("a.orgid", user.getOrgid());
			adapter.setFilter(filter);
			list = dbClient.find(adapter, paginate,new RowDataListener() {
				
				@Override
				public void processData(BasicMap<String, Object> rowData) {
					rowData.put("bzsj", DateUtil.format(rowData.get("bzsj"), "yyyy-MM-dd"));
					
					
				}
			});
		}
		return list;
	}
	/**
	 * 保存一条矫正基地信息
	 * @param data
	 */
	public void saveOne(BasicMap<String, Object> data){
		
		dbClient.save(SupConst.Collections.SFS_SFSGZRYSBZQKXXB, data);
	}
	/**
	 * 删除一条信息
	 * @param query
	 */
	public void deleteOne(BasicMap<String, Object> query){
		
		dbClient.remove(SupConst.Collections.SFS_SFSGZRYSBZQKXXB, new SqlDbFilter().eq("id", StringUtil.toEmptyString(query.get("id"))));
	}
	/**
	 * 查询一条信息
	 * @param query
	 * @return
	 */
	public BasicMap<String, Object> findOne(BasicMap<String, Object> query){
		User user = ssoService.getUser();
		BasicMap<String, Object> rtn = new BasicMap<>();
		SqlDbFilter filter = new SqlDbFilter();
		String sql = "select b.id as bid,b.xm,b.xb,b.sfzh,a.* "
				+ "FROM  SFS_SFSGZRYSBZQKXXB a "
				+ "LEFT JOIN JC_SFXZJGGZRYJBXX b on b.id=a.ryid";
		SQLAdapter adapter = new SQLAdapter(sql);
		filter.eq("a.id", query.get("id"));
		filter.eq("a.orgid", user.getOrgid());
		adapter.setFilter(filter);
		rtn = dbClient.findOne(adapter);
		rtn.put("bzsj", DateUtil.format(rtn.get("bzsj"), "yyyy-MM-dd"));
		return rtn;
	}
	public List<BasicMap<String,Object>> findGzry(BasicMap<String,Object> query){
		User user = ssoService.getUser();
		List<BasicMap<String,Object>> list=new ArrayList<>();
		if(user!=null) {
			SqlDbFilter filter = toSqlFilter(query);
			
			String sql = "SELECT id,xm,rybm from JC_SFXZJGGZRYJBXX";
			SQLAdapter adapter = new SQLAdapter(sql);
			filter.eq("orgid", user.getOrgid());
			
			adapter.setFilter(filter);
			list = dbClient.find(adapter);
		}
		return list;
	}
	
	public BasicMap<String, Object> findRybm(String id){
		
		BasicMap<String, Object> rtn = new BasicMap<>();
		SqlDbFilter filter = new SqlDbFilter();
		String sql = "select rybm from JC_SFXZJGGZRYJBXX";
		SQLAdapter adapter = new SQLAdapter(sql);
		filter.eq("id", id);
		adapter.setFilter(filter);
		rtn = dbClient.findOne(adapter);
		return rtn;
	}
	
}
