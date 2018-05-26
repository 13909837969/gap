package com.ehtsoft.supervise.services;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ehtsoft.common.services.SSOService;
import com.ehtsoft.fw.core.db.MongoClient;
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
import com.ehtsoft.im.api.ImConst;
import com.ehtsoft.supervise.api.SupConst;
import com.ehtsoft.supervise.utils.ParameterUtil;

/**
 * 矫正人员接收管理
 * @Description TODO(用一句话描述该文件是做什么功能的，哪个地方使用的)
 * @author Administrator
 * @date 2018年4月22日
 *
 */
@Service("JZAcceptService")
public class JZAcceptService extends AbstractService{
	
	@Resource(name = "sqlDbClient")
	private SqlDbClient dbClient;
	
	
	@Resource(name="mongoClient")
	private MongoClient mongoClient;
	
	@Resource(name="SSOService")
	private SSOService service;
	
	
	/**
	 * 接收人员基本信息
	 * @param paginate
	 * @param query:{name:矫正人员姓名}
	 * @return
	 * [
	 * 	{
	 * 		id:主键
	 * 		sqjzrybh:矫正人员编号
	 * 		xm:矫正人员姓名
	 *      sfzh:身份证号
	 * 		sfjs:是否接收
	 * 	}
	 * ]
	 */
	public List<BasicMap<String, Object>> findArchives(BasicMap<String, Object> query,Paginate paginate){
//		User user = service.getUser();
//		String sqlstr = "select id,sqjzrybh,xm,sfzh,gdjzdmx,fzlx,grlxdh,JGLX,SQJZRYBH from JZ_JZRYJBXX";
//		SQLAdapter sqlAdapter = new SQLAdapter(sqlstr);
//		SqlDbFilter filter = sqlAdapter.getFilter()
//			.like("XM", StringUtil.toEmptyString(query.get("name")))
//			.eq("SFJS", 0);
//		filter.eq("ORGID", user.getOrgid());
//		return dbClient.find(sqlAdapter,paginate);
		
		User user = service.getUser();
	
		List<BasicMap<String, Object>> list = new ArrayList<>();
		if(user!=null){
			String sqlstr = "select a.id,sqjzrybh,xm,sfzh,b.gdjzdmx,c.fzlx,grlxdh,sfjs from JZ_JZRYJBXX a "
							+ " left join JZ_JZRYJBXX_DZ b on a.id = b.id "
							+ " left join JZ_JZRYJBXX_JZ c on a.id = c.id ";
			SqlDbFilter sqlFilter = new SqlDbFilter();
			sqlFilter.like("a.xm", StringUtil.toEmptyString(query.get("name")))
			         .eq("a.sfjs", "0")
			         .eq("a.jcjz", "0");
			Set<String> set =  user.getOrgidSet();
			if(set.size()>0){
				sqlFilter.in("a.orgid", set);
			}
			SQLAdapter sqlAdapter = new SQLAdapter(sqlstr);
			sqlAdapter.setFilter(sqlFilter);
			list = dbClient.find(sqlAdapter,paginate).getRows();
		}
		return list;
		
	}
	/**
	 * 接收服刑人员
	 * @param data
	 * {
	 *   id:"服刑人员ID"
	 * }
	 */
	public void save(BasicMap<String, Object> data) {
		User user = service.getUser();
		data.put("SFJS","1");
		data.put("SFCJ", "1");
		dbClient.save(SupConst.Collections.JZ_JZRYJBXX, data);
		
		String aid = StringUtil.toString(data.get("ID"));
		BasicMap<String,Object> bm = dbClient.findOne("SELECT ID,SQJZRYBH,XM,XB,GRLXDH FROM " + SupConst.Collections.JZ_JZRYJBXX + " WHERE ID = ?",aid);
		if(bm!=null){
			BasicMap<String,Object> owner = new BasicMap<>();
			String gid = user.getOrgid();
			//群组信息ID
			owner.put("F_GID", gid);
			//群成员ID
			owner.put("F_AID", user.getAid()); //当前登录用户（管理人员）
			//成员类型：0 普通成员 1 管理员  2 群主
			owner.put("F_TYPE", 2);
			//成员备注名
			owner.put("F_NAME", user.getNickname());
			dbClient.save(ImConst.Collections.IM_GROUP_USER, owner);
	
			BasicMap<String,Object> jzusr = new BasicMap<>();
			jzusr.put("F_GID", gid);
			jzusr.put("F_AID", aid);
			jzusr.put("F_TYPE", 0);
			jzusr.put("F_NAME", bm.get("XM"));
			dbClient.save(ImConst.Collections.IM_GROUP_USER, jzusr);
			
			//初始化公告信息
			BasicMap<String,Object> affiche = new BasicMap<String,Object>();
			affiche.put("F_ID", gid);
			affiche.put("F_GID", gid);
			String content = ParameterUtil.getParameter(dbClient).get(SupConst.ParameterKey.KEY_SYSTEM_008).getValue();
			if(Util.isEmpty(content)){
				affiche.put("F_CONTENT","注册成功");
			}else{
				affiche.put("F_CONTENT", content);
			}
			affiche.put("F_TYPE", 4); //3 群公告  4 注册通知  5 集中教育通知  6 集中服务通知
			dbClient.save(ImConst.Collections.IM_GROUP_AFFICHE, affiche);
			
			//初始化到好友表中
			BasicMap<String,Object> friend = new BasicMap<>();
			friend.put("f_aid0", aid);
			friend.put("f_aid1", user.getAid());
			dbClient.save(ImConst.Collections.IM_USERINFO_FRIEND, friend);
			friend.put("f_aid0", user.getAid());
			friend.put("f_aid1", aid);
			dbClient.save(ImConst.Collections.IM_USERINFO_FRIEND, friend);
			
			BasicMap<String,Object> collect = new BasicMap<>();
			collect.put("F_ID", aid);//矫正人员AID
			collect.put("F_AID", user.getAid());//矫正管理人员 aid
			dbClient.save(SupConst.Collections.JZ_COLLECT_USER, collect);
		}
	}
	/**
	 * 退回服刑人员
	 * @param data
	 * {
	 *   id:"服刑人员ID"
	 * }
	 */
	public void update(BasicMap<String, Object> data) {
		User user=service.getUser();
		//获取当前用户的orgid
		String orgid=user.getOrgid();
		//通过id查询出上级的id
		String sql="select parentid from jc_sfxzjgjbxx where id = ?";
		//上传(id=orgid)
		BasicMap<String,Object> one = dbClient.findOne(sql, orgid);
	
		if(one!=null) {
			//上级id
			String pid = StringUtil.toString(one.get("parentid"));
			if(Util.isNotEmpty(pid)) {
				//修改条件
				data.put("orgid", pid);
				data.put("SFJS","0"); //是否接收 0 不接受 1接收
				data.put("SFZP", "0"); //更新转派标识为不转派
				dbClient.update(SupConst.Collections.JZ_JZRYJBXX, data);
			}
			
			BasicMap<String,Object> th=new BasicMap<String,Object>();
			th.put("AID", data.get("id"));
			th.put("orgid", pid); //orgid - ID
			dbClient.save(SupConst.Collections.JZ_JZRYZPXXTH, th);
		}
	}
	
	/**
	 * 查询退回上级列表
	 * @param query
	 * @param paginate
	 * @return
	 */
	public List<BasicMap<String,Object>> findBack(BasicMap<String,Object> query,Paginate paginate) {
		String sql="select a.id,a.xm,a.sfzh,b.gdjzdmx from JZ_JZRYJBXX a left join JZ_JZRYJBXX_DZ b on a.id = b.id inner join JZ_JZRYZPXXTH c on a.id=c.aid";
		SQLAdapter adapter=new SQLAdapter(sql);
		SqlDbFilter filter=new SqlDbFilter();
		filter.like("a.xm",StringUtil.toEmptyString(query.get("xm"))).eq("a.orgid", service.getUser().getOrgid());
//		      .eq("a.sfjs", "0")
//              .eq("a.jcjz", "0");
		adapter.setFilter(filter);
		List<BasicMap<String,Object>> list=dbClient.find(adapter, paginate).getRows();
		return list;
	}

	
	/**
	 * 
	 * 查询被退回的人员列表【按时间倒序排序】
	 * @return<br>
	 * 返回值格式:<br>
	 *
	 * @author Administrator
	 * @date   2018年4月22日
	 * 方法的作用：TODO
	 */
	public List<BasicMap<String, Object>> findAllBack() {
		String sql = "";
		SQLAdapter adapter = new SQLAdapter(sql);
		return dbClient.find(adapter);

	}
	
	
}
