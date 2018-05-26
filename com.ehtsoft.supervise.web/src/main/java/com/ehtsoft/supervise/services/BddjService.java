package com.ehtsoft.supervise.services;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ehtsoft.common.services.SFCodeService;
import com.ehtsoft.common.services.SSOService;
import com.ehtsoft.fw.core.db.InsertOperation;
import com.ehtsoft.fw.core.db.RowDataListener;
import com.ehtsoft.fw.core.db.SQLAdapter;
import com.ehtsoft.fw.core.db.SaveOperation;
import com.ehtsoft.fw.core.db.SqlDbClient;
import com.ehtsoft.fw.core.db.SqlDbFilter;
import com.ehtsoft.fw.core.dto.BasicMap;
import com.ehtsoft.fw.core.dto.Paginate;
import com.ehtsoft.fw.core.dto.ResultList;
import com.ehtsoft.fw.core.services.AbstractService;
import com.ehtsoft.fw.core.sso.User;
import com.ehtsoft.fw.utils.DateUtil;
import com.ehtsoft.fw.utils.NumberUtil;
import com.ehtsoft.fw.utils.StringUtil;
import com.ehtsoft.fw.utils.Util;
import com.ehtsoft.im.api.ImConst;
import com.ehtsoft.supervise.api.SupConst;
import com.ehtsoft.supervise.utils.ParameterUtil;
@Service("BddjService")
public class BddjService extends AbstractService{
	
	@Resource(name = "sqlDbClient")
	private SqlDbClient dbClient;
	
	@Resource(name="SSOService")
	private SSOService service;
	
	@Resource(name="SFCodeService")
	private SFCodeService sfCodeService;
	/**
	 * 报到登记查询
	 * @param query
	 * @param paginate
	 * @return
	 * @author yanyubo
	 */
	public ResultList<BasicMap<String, Object>> findBdjj(BasicMap<String, Object> query, Paginate paginate){
		User user = service.getUser();
		ResultList<BasicMap<String, Object>> list = new ResultList<>();
		if(user!=null){
			SqlDbFilter filter = toSqlFilter(query);
			String sql = "select a.id,a.xm,a.xb,a.mz,a.bdqk,a.sfjid,a.sfjs,c.sqjzryjsrq,c.sqjzksrq,c.sqjzjsrq "  
					+ "from JZ_JZRYJBXX a "
					+ "left join JZ_JZRYJBXX_JZ	c on c.id=a.id";
			SQLAdapter sqlAdapter = new SQLAdapter(sql);
			filter.eq("a.orgid", user.getOrgid());
			filter.eq("sfzp", "1");
			
			if(Util.isNotEmpty(query.get("sqjzksrq"))) {
				filter.gtEq("c.sqjzksrq",query.get("sqjzksrq") );
			}
			if(Util.isNotEmpty(query.get("sqjzjsrq"))) {
				filter.ltEq("c.sqjzjsrq", query.get("sqjzjsrq"));
			}
			sqlAdapter.setFilter(filter);
			list =  dbClient.find(sqlAdapter, paginate);
		}
		return list;
	}
	
	/**
	 * 登记
	 * @param query
	 * @param paginate
	 * @return
	 * @author yanyubo
	 */
	public void saveOne(final BasicMap<String, Object> data){
		data.put("sfjs", "1");
		dbClient.save(SupConst.Collections.JZ_JZRYJBXX, data);
			
	}		
	
	/**
	 * 报到登记
	 * @param query
	 * @param paginate
	 * @return
	 * @author yanyubo
	 */
	public void saveBd(final BasicMap<String, Object> data){
		
		dbClient.save(SupConst.Collections.JZ_JZRYJBXX, data);
			
	}		
	
	/**
	 * 退回
	 * @param query
	 * @param paginate
	 * @return
	 * @author yanyubo
	 */
	public void removeBd(String id){
		BasicMap<String,Object> map=new BasicMap<>();
		SqlDbFilter filter = new SqlDbFilter();
		String sql = "SELECT" + 
					"	a.parentid " + 
					"   FROM" + 
					"   jc_sfxzjgjbxx a"+
					"   LEFT JOIN jz_jzryjbxx b ON a.id=b.orgid";
			SQLAdapter adapter = new SQLAdapter(sql);
			filter.eq("b.id", id);
			adapter.setFilter(filter);
			map = dbClient.findOne(adapter);
			map.put("sfzp", "0");
			map.put("orgid", map.get("parentid"));
			map.put("id", id);
			dbClient.update("jz_jzryjbxx", map);
			
			
	}		
	
	
	
}
