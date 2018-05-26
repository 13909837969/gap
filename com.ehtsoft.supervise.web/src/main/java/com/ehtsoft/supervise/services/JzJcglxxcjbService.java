package com.ehtsoft.supervise.services;

import java.util.ArrayList;
import java.util.List;

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
import com.ehtsoft.fw.utils.Util;
import com.ehtsoft.supervise.api.SupConst;


/**
 * 社区矫正人员奖惩信息采集表-人员奖惩
 * @author liheng
 *
 */
@Service("JzJcglxxcjbService")
public class JzJcglxxcjbService extends AbstractService{
	@Resource(name="sqlDbClient")
	private SqlDbClient dbClient;
	
	@Resource(name = "SSOService")
	private SSOService ssoService;

	/**
	 * 查询所有矫正人员信息
	 * @param query
	 * @param paginate
	 * @return{
	 *  [
	 *		主键	id
	 *		社区矫正人员编号	sqjzrybh
	 *		奖惩类别  jclb
	 *		奖惩时间	 jcsj
	 *		奖惩原因	 jcyy
	 *		姓名		 xm
	 *		性别		 xb
	 *		联系电话  lxdh
	 *		身份证号	 sfzh
	 *		居住地址	 jzdz
	 *		奖惩次数   jccs
	 *		管教类型   gjlx
	 * 	]
	 * }
	 */
	public ResultList<BasicMap<String, Object>> findAllRy1(BasicMap<String,Object> data,Paginate paginate){
		User user = ssoService.getUser();
		ResultList<BasicMap<String,Object>> list = new ResultList<>();
		SqlDbFilter filter = toSqlFilter(data);
		if(user!=null) {
			StringBuffer sqlstr = new StringBuffer("SELECT  A.ID, A.xm,A.grlxdh, A.xb,A.orgid,A.sfzh,A.JGLX, count(*) as jccs,  c.GDJZDMX " + 
					"FROM JZ_JZRYJBXX A  " + 
					"LEFT JOIN JZ_SQJZRYJCXXCJB b ON " + 
					" a.ID = b.jcid " + 
					"LEFT JOIN JZ_JZRYJBXX_DZ c ON " + 
					"a.ID = c.ID where a.orgid='"+ user.getOrgid() +"' ");
			if(Util.isNotEmpty(data.get("xm"))) {
				sqlstr.append(" and a.xm like '"+SqlDbFilter.convertSqlParameter(StringUtil.toString(data.get("xm")))+"%'");
			}
			if(Util.isNotEmpty(data.get("grlxdh"))) {
				sqlstr.append(" and a.grlxdh like '"+SqlDbFilter.convertSqlParameter(StringUtil.toString(data.get("grlxdh")))+"%'");
			}
			sqlstr.append(" GROUP BY A.ID,A.xm, A .grlxdh, A .xb, A .sfzh, A.orgid,c.GDJZDMX,A.JGLX");
			SQLAdapter sqlAdapter = new SQLAdapter(sqlstr.toString());
			sqlAdapter.setFilter(filter);
			list = dbClient.find(sqlAdapter, paginate);
		}
		return list;
	}
	public BasicMap<String, Object> findOne(String id){
		String sql = "SELECT f_aid,sqjzrybh,jclb,jcsj,jcyy FROM JZ_SQJZRYJCXXCJB WHERE jcid=?";
		BasicMap<String,Object> data = dbClient.findOne(sql,id);
		return data;
	}
	/**
	 * 根据服刑人员ID查询该人员的奖惩信息
	 * @param JCID
	 * @return
	 */
	public List<BasicMap<String,Object>> findWgqks(String id){
		List<BasicMap<String,Object>> list = new ArrayList<BasicMap<String,Object>>();
		list = dbClient.find(SupConst.Collections.JZ_SQJZRYJCXXCJB, new SqlDbFilter().eq("F_AID", id));
		return list;
	}
	
	/**
	 * @param data 新增奖惩人员信息
	 */
	public void saveJzry(BasicMap<String,Object> data) {
		dbClient.save(SupConst.Collections.JZ_SQJZRYJCXXCJB, data);
	}
	
	/**
	 * 获取一条奖惩信息
	 * @param id
	 * @return
	 * 平板用
	 */
	public BasicMap<String,Object> findOneJc(String id){
		if (id == null) {
				BasicMap<String,Object> map = new BasicMap<>();
			return map;
		}
		BasicMap<String,Object> data=new BasicMap<>();
		String sql="select a.jcid,a.f_aid,a.jcsj,a.jclb,a.jcyy,b.xm from JZ_SQJZRYJCXXCJB a left join JZ_JZRYJBXX b on a.f_aid=b.id";
		SQLAdapter adapter=new SQLAdapter(sql);
		adapter.getFilter().eq("a.jcid", id);
		data=dbClient.findOne(adapter);
		return data;
	}
	
	/**
	 * 根据jcid删除奖惩信息
	 * @param id
	 * 平板用
	 */
	public void deleteJc(String id) {
		dbClient.remove(SupConst.Collections.JZ_SQJZRYJCXXCJB, new SqlDbFilter().eq("jcid", id));
	}
	
	/**
	 * 查询所有的奖惩信息
	 * 平板用
	 */
	public List<BasicMap<String,Object>> findAll(BasicMap<String,Object> query,Paginate paginate){
		User user=ssoService.getUser();
		List<BasicMap<String,Object>> list=new ArrayList<>();
		SqlDbFilter filter = new SqlDbFilter();
		String sql="select a.jcid,a.f_aid as aid,a.jcsj,a.jclb,a.jcyy,b.xm "
				+ "from JZ_SQJZRYJCXXCJB a left join JZ_JZRYJBXX b on a.f_aid=b.id ";
		SQLAdapter adapter=new SQLAdapter(sql);
		filter.eq("b.xm", StringUtil.toEmptyString(query.get("xm")))
		      .desc("a.jcsj")
		     .eq("b.orgid", user.getOrgid());
		adapter.setFilter(filter);
		list=dbClient.find(adapter, paginate).getRows();
		return list;
	}
	
}
	