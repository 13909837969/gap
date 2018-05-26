package com.ehtsoft.supervise.services;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ehtsoft.common.services.SFCodeService;
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
/**
 * 
 * @author 何向昕
 *社区矫正人员--矫正小组
 */
@Service("JzjzxzService")
public class JzjzxzService extends AbstractService{
	
	@Resource(name="sqlDbClient")
	SqlDbClient dbClient;
	
	@Resource(name="SSOService")
	private SSOService service;
	
	@Resource(name="SFCodeService")
	private SFCodeService sfCodeService;
	/**
	 * 新增或修改矫正小组人员
	 * @param data
	 */
	public void saveJzjzxz(BasicMap<String, Object> data){
		
		dbClient.save(SupConst.Collections.JZ_JZXZCY, data);
	}
	
	
	/**
	 * 查询当前矫正人员矫正小组成员信息
	 * @param query
	 * @return
	 */
	public List<BasicMap<String,Object>> findJzjzxz(BasicMap<String, Object>  query){
		List<BasicMap<String, Object>> list = new ArrayList<>();
		String sqlstr = "select * from JZ_JZXZCY";
		SqlDbFilter sqlDbFilter = new SqlDbFilter();
		SQLAdapter sqlAdapter = new SQLAdapter(sqlstr);
		sqlDbFilter.like("xm", StringUtil.toEmptyString(query.get("xm")))
		.eq("f_aid", StringUtil.toEmptyString(query.get("f_aid")));
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
	 * 查询当前矫正人员矫正小组成员信息
	 * @param query
	 * @return
	 */
	public ResultList<BasicMap<String,Object>> findXzcy(String id,Paginate paginate){
		ResultList<BasicMap<String,Object>> list = new ResultList<>();
			String sqlstr = "select * from JZ_JZXZCY";
			SqlDbFilter sqlDbFilter = new SqlDbFilter();
			SQLAdapter sqlAdapter = new SQLAdapter(sqlstr);
			sqlDbFilter.eq("f_aid", id);
			sqlAdapter.setFilter(sqlDbFilter);
			list = dbClient.find(sqlAdapter,paginate);
		
		return list;
	}
	
	/**
	 *  查询矫正人员
	 * @param query
	 * @return
	 */
	public ResultList<BasicMap<String,Object>> findJzjzxz(BasicMap<String, Object> query,Paginate paginate){
		User user = service.getUser();
		ResultList<BasicMap<String,Object>> list=new ResultList<>();
		if(user!=null) {
			String sqlstr = "select a.id,a.xm,a.jglx,a.grlxdh,b.jzlb "
					+ "from jz_jzryjbxx a "
					+ "left join jz_jzryjbxx_jz b "
					+ "on a.id=b.id";
			SqlDbFilter sqlDbFilter =toSqlFilter(query);
			SQLAdapter sqlAdapter = new SQLAdapter(sqlstr);
			sqlDbFilter.in("a.orgid", user.getOrgidSet());
			sqlAdapter.setFilter(sqlDbFilter);
			list =  dbClient.find(sqlAdapter,paginate);
		}
		return list;
	}
	
	
	/**
	 * 删除当前矫正人员小组成员
	 * @param query
	 */
	public void deleteOne(BasicMap<String,Object> query){
		dbClient.remove(SupConst.Collections.JZ_JZXZCY, new SqlDbFilter().eq("xzid", StringUtil.toEmptyString(query.get("xzid"))));
	}
	
	
	
	/**
	 * 删除当前矫正人员小组成员
	 * @param query
	 */
	public void deleteOne(String id){
		dbClient.remove(SupConst.Collections.JZ_JZXZCY, new SqlDbFilter().eq("xzid", id));
	}
}
