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
import com.ehtsoft.fw.core.dto.Paginate;
import com.ehtsoft.fw.core.dto.ResultList;
import com.ehtsoft.fw.core.services.AbstractService;
import com.ehtsoft.fw.core.sso.User;
import com.ehtsoft.fw.utils.NumberUtil;
import com.ehtsoft.fw.utils.StringUtil;
import com.ehtsoft.fw.utils.Util;
import com.ehtsoft.supervise.api.SupConst;
import com.fasterxml.jackson.core.io.NumberInput;

/**
 * 
 * 司法人员管理
 * @author Administrator
 * @date 2018年4月7日
 *
 */
@Service("SfryglService")
public class SfryglService extends AbstractService {

	@Resource(name="sqlDbClient")
	private SqlDbClient dbClient;
	
	@Resource(name="SSOService")
	private SSOService service;
	
	/**
	 * 
	 * 返回机构的人员列表
	 * @param orgid  机构id
	 * @param paginate 分页信息
	 * @return<br>
	 * 返回值格式:  ResultList<BasicMap<String, Object>>
	 *
	 * @author Administrator
	 * @date   2018年4月7日
	 * 方法的作用：TODO
	 */
	public ResultList<BasicMap<String, Object>> findPoeplist(BasicMap<String, Object> query,Paginate paginate) {
		StringBuffer sql = new StringBuffer("SELECT id,xm,zw,sfzh,zzzt,orgid FROM "
				+ "jc_sfxzjggzryjbxx where orgid = '"+ query.get("orgid") +"' and zzzt = '" + query.get("zzzt") +"' ");
		if (!"".equals( query.get("xm")) || null ==  query.get("xm")) {
			sql.append(" and xm like '"+  query.get("xm") +"%'");
		}
		SQLAdapter adapter = new SQLAdapter(sql.toString());
		ResultList<BasicMap<String, Object>> list = dbClient.find(adapter, paginate);
		return list;
	}
	
	/**
	 * 机构人员管理
	 * @param query
	 * @param paginate
	 * @return
	 */
	public List<BasicMap<String,Object>> findList(BasicMap<String,Object> query,Paginate paginate){
		User user=service.getUser();
		String sql="SELECT id,xm,zw,sfzh,zzzt,orgid FROM jc_sfxzjggzryjbxx";
		SQLAdapter adapter=new SQLAdapter(sql);
		SqlDbFilter filter=toSqlFilter(query);
		filter.eq("orgid", user.getOrgid());
		adapter.setFilter(filter);
		List<BasicMap<String,Object>> list=dbClient.find(adapter, paginate).getRows();	
		return list;
	}
	
	
	
	/**
	 * 
	 * 人员的详情信息
	 * @param id 人员ID
	 * @return<br>
	 * 返回值格式: BasicMap<String, Object>
	 *
	 * @author Administrator
	 * @date   2018年4月7日
	 * 方法的作用：TODO
	 */
	public BasicMap<String, Object> findPopeDeilt(String id) {
		String sql = "SELECT a.id,a.rybm,a.xm,a.ywm,a.xb,a.csrq,a.sfzh,a.mz,a.zzmm,a.hyzk,a.byyx,a.xl,"
				+ "a.zgxw,a.zy,a.ssjg,a.zw,a.rybz,a.cjgzsj,a.sjhm,a.lxdh,a.dzyx,a.zz ,a.orgid FROM JC_SFXZJGGZRYJBXX a "
				+ "where a.del = '0' and a.id = '"+ id +"' ";
		SQLAdapter adapter = new SQLAdapter(sql);
		return dbClient.findOne(adapter);
	}
	
	
	/**
	 * 
	 * 修改工作人员
	 * @param query<br>
	 * 返回值格式:<br>
	 *
	 * @author Administrator
	 * @date   2018年4月7日
	 * 方法的作用：TODO
	 */
	public void updateGzry(BasicMap<String, Object> data) {
		dbClient.update(SupConst.Collections.JC_SFXZJGGZRYJBXX, data);
	}
	
	
}
