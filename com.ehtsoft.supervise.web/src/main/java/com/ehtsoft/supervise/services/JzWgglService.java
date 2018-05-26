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
 * 社区矫正人员违规信息采集表-人员违规
 * @author liheng
 *
 */



@Service("JzWgglService")
public class JzWgglService extends AbstractService{
	@Resource(name="sqlDbClient")
	private SqlDbClient dbClient;
	
	@Resource(name = "SSOService")
	private SSOService ssoService;
	/**
	 * 查询所有违规人员信息
	 * @param query
	 * @param paginate
	 * @return{
	 *  [
	 *		主键	id
	 *		社区矫正人员编号	sqjzrybh
	 *		违规类别  wglb
	 *		违规时间	 wgsj
	 *		违规原因	 wgyy
	 *		姓名		 xm
	 *		性别		 xb
	 *		联系电话  lxdh
	 *		身份证号	 sfzh
	 *		居住地址	 jzdz
	 *		违规次数   wgcs
	 *		管教类型   gjlx
	 *
	 * 	]
	 * }
	 */
	/**
	 * ABC表关联查询
	 * JZ_JZRYJBXX A
	 * JZ_SQJZRYWGXXCJB B
	 * JZ_JZRYJBXX_DZ C
	 * @param data
	 * @param paginate
	 * @return
	 */
	
	public ResultList<BasicMap<String, Object>> findAllRy2(BasicMap<String,Object> data,Paginate paginate){
		User user = ssoService.getUser();
		ResultList<BasicMap<String,Object>> list = new ResultList<>();
		if(user!=null) {
		
		StringBuffer sqlstr = new StringBuffer("SELECT  A . ID,  A .xm, A .grlxdh, A .xb, A.orgid, A .sfzh,A.JGLX, count(*) as wgcs,  c.GDJZDMX " + 
				"FROM JZ_JZRYJBXX A  " + 
				"LEFT JOIN JZ_SQJZRYWGXXCJB b ON " + 
				" a.ID = b.aid " + 
				"LEFT JOIN JZ_JZRYJBXX_DZ c ON " + 
				"a.ID = c.ID   where   a.orgid='"+ user.getOrgid() +"' ");
		
		if(Util.isNotEmpty(data.get("xm"))) {
			sqlstr.append(" and a.xm like '"+SqlDbFilter.convertSqlParameter(StringUtil.toString(data.get("xm")))+"%'");
		}
		if(Util.isNotEmpty(data.get("grlxdh"))) {
			sqlstr.append(" and a.grlxdh like '"+SqlDbFilter.convertSqlParameter(StringUtil.toString(data.get("grlxdh")))+"%'");
			
		}
		sqlstr.append("  GROUP BY A . ID, A .xm, A .grlxdh, A .xb, A .sfzh, A.JGLX, A.orgid, c.GDJZDMX");
		SQLAdapter sqlAdapter = new SQLAdapter(sqlstr.toString());
		list = dbClient.find(sqlAdapter, paginate);
		}
		return list;
	}
	
	public BasicMap<String, Object> findJcByRyId(BasicMap<String, Object> id){
		String sql = "SELECT aid,sqjzrybh,wglx,wgsj,wgxq,fkz, FROM JZ_SQJZRYWGXXCJB WHERE aid=?";
		BasicMap<String,Object> data = dbClient.findOne(sql,id);
		return data;
	}
	
	/**
	 * 根据服刑人员ID查询该人员的奖惩信息
	 * @param id
	 * @return
	 */
	public List<BasicMap<String,Object>> findWgqks(String id){
		List<BasicMap<String,Object>> list = new ArrayList<BasicMap<String,Object>>();
		list = dbClient.find(SupConst.Collections.JZ_SQJZRYWGXXCJB, new SqlDbFilter().eq("aid", id));
		return list;
	}
	/**
	 * 根据身份证查询奖惩人员信息
	 * 
	 */
	public BasicMap<String, Object> findPeById(String sfzh){
		String sql = "SELECT id,aid,sqjzrybh,wglx,wgsj,wgxq,kfz,del,audit,cts,uts,cdate,udate,cuid,uuid,caid,uaid,orgid,remrk,bdqk FROM JZ_SQJZRYWGXXCJB WHERE sfzh=?";
		BasicMap<String,Object> person = dbClient.findOne(sql, sfzh);
		return person;
	}
	/**
	 * 根据姓名查询奖惩人员信息
	 * @param sfzh
	 * @return
	 */
	public BasicMap<String, Object> findPeByName(String name){
		String sql = "SELECT id,aid,sqjzrybh,wglx,wgsj,wgxq,kfz,del,audit,cts,uts,cdate,udate,cuid,uuid,caid,uaid,orgid,remrk,bdqk FROM JZ_SQJZRYWGXXCJB WHERE xm LIKE ?";
		BasicMap<String,Object> person = dbClient.findOne(sql, name);
		return person;
	}
	
	/**
	 * @param data 新增奖惩人员信息
	 */
	public void saveJzry(BasicMap<String,Object> data) {
//		System.out.println("data:"+data);
		dbClient.save(SupConst.Collections.JZ_SQJZRYWGXXCJB, data);
	}
	
	/**
	 * 查询所有违规信息
	 * 平板用
	 * @param query
	 * @param paginate
	 * @return 
	 */
	public List<BasicMap<String,Object>> findAll(BasicMap<String,Object> query,Paginate paginate){
		User user=ssoService.getUser();
		List<BasicMap<String,Object>> list=new ArrayList<>();
		SqlDbFilter filter=new SqlDbFilter();
		String sql="select a.id,a.aid,a.wgsj,a.wglx,a.wgxq,a.kfz,b.xm "
				+ "from JZ_SQJZRYWGXXCJB a left join JZ_JZRYJBXX b on a.aid=b.id ";
		SQLAdapter adapter=new SQLAdapter(sql);
		filter.like("b.xm", StringUtil.toEmptyString(query.get("xm")))
		      .desc("a.wgsj")
		      .eq("b.orgid", user.getOrgid());
		adapter.setFilter(filter);
		list=dbClient.find(adapter,paginate).getRows();
		return list;
	}
	
	/**
	 * 获取一条违规信息
	 * 平板用
	 * @param id
	 * @return
	 */
	public BasicMap<String,Object> findOneWg(String id){
		if (id == null) {
			BasicMap<String  , Object> map = new BasicMap<>();
			return map;
		}
		BasicMap<String,Object> data=new BasicMap<>();
		String sql="select a.id,a.aid,a.wglx,a.wgsj,a.wgxq,b.xm,a.kfz from JZ_SQJZRYWGXXCJB a left join JZ_JZRYJBXX b on a.aid=b.id";
		SQLAdapter adapter=new SQLAdapter(sql);
		adapter.getFilter().eq("a.id", id);
		data=dbClient.findOne(adapter);
		return data;
	}
	
	/**
	 * 删除一条违规信息
	 * 平板用
	 * @param id
	 */
	public void removewg(String id){
		dbClient.remove(SupConst.Collections.JZ_SQJZRYWGXXCJB,new SqlDbFilter().eq("id", id));
	}

	
}
	