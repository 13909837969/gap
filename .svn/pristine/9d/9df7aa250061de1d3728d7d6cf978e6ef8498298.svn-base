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
import com.mongodb.operation.InsertOperation;

/**
 * 
 * @Description 审批流程
 * @author Administrator
 * @date 2018年3月20日
 *
 */
@Service("SqlcService")
public class SqlcService extends AbstractService {
	
	@Resource(name = "sqlDbClient")
	private SqlDbClient dbClient;
   
	@Resource(name = "SSOService")
	private SSOService ssoService;

	/**
	 * 
	 * 工作组的新增
	 * @param team<br>
	 * 返回值格式: void
	 *
	 * @author Administrator
	 * @date   2018年3月24日
	 * 方法的作用：新增
	 */
	public List<BasicMap<String, Object>> save(BasicMap<String,Object> team,BasicMap<String,Object> teamry){
		dbClient.save(SupConst.Collections.SYS_AUDIT_TEAM,team);
		teamry.put("f_teamid", team.get("f_teamid")); 
		dbClient.insert(SupConst.Collections.SYS_AUDIT_TEAM_APPROVER,teamry);
		List<BasicMap<String, Object>> list = new ArrayList<>();
				team.put("f_approver",teamry.get("f_approver"));
				list.add(team);
		return list;
	}
	
	
	/**
	 * 
	 * 审批人员的保存
	 * @param team
	 * @param teamry<br>
	 * 返回值格式:<br>
	 *
	 * @author Administrator
	 * @date   2018年3月24日
	 * 方法的作用：TODO
	 */
	public void saveAll(BasicMap<String,Object> team) {
		dbClient.save(SupConst.Collections.SYS_AUDIT_CONFIG,team);
		

	}
	/**
	 * 
	 * 返回单据类型 【界面的单选】
	 * 返回值格式:<br>
	 *
	 * @author Administrator
	 * @date   2018年3月20日
	 * 方法的作用：TODO
	 */
	public List<BasicMap<String, Object>> findDocument() {
		String sql = "SELECT f_id,f_name from sys_audit_bill GROUP BY f_name,f_id";
		SQLAdapter adapter = new SQLAdapter(sql);
		List<BasicMap<String, Object>> list = dbClient.find(adapter);
		return list;
	} 
	
	
	
	/**
	 * 
	 * 审批列表【分页】
	 * @param query
	 * @param paginate
	 * @return<br>
	 * 返回值格式:ResultList<BasicMap<String, Object>>
	 * @author Administrator
	 * @date   2018年3月20日
	 * 方法的作用：TODO
	 */
	public ResultList<BasicMap<String, Object>> findAll(BasicMap<String , Object> query,Paginate paginate) {
		String sqlstr = "";
		if (query.get("djlx") != null || "".equals(query.get("djlx"))) {
			 sqlstr = "SELECT A .f_id, A .f_name, b.f_lvl, C .xm, e.f_teamname FROM sys_audit_bill AS A " + 
					"LEFT JOIN sys_audit_config AS b ON A .f_id = b.f_billid " + 
					"LEFT JOIN jc_sfxzjggzryjbxx AS C ON b.f_approver = C . ID " + 
					"LEFT JOIN sys_audit_team AS e ON e.f_billid = b.f_billid " + 
					"WHERE C .xm <> '' AND A .id = '"+ query.get("djlx")+ "' "+
					"GROUP BY A .f_id, A .f_name, b.f_lvl, C .xm, e.f_teamname ";
		}else{
			 sqlstr = "SELECT A .f_id, A .f_name, b.f_lvl, C .xm, e.f_teamname FROM sys_audit_bill AS A " + 
						"LEFT JOIN sys_audit_config AS b ON A .f_id = b.f_billid " + 
						"LEFT JOIN jc_sfxzjggzryjbxx AS C ON b.f_approver = C . ID " + 
						"LEFT JOIN sys_audit_team AS e ON e.f_billid = b.f_billid " + 
						"WHERE C .xm <> '' GROUP BY A .f_id, A .f_name, b.f_lvl, C .xm, e.f_teamname ";
		}
		
		SQLAdapter sql = new SQLAdapter(sqlstr);
		ResultList<BasicMap<String, Object>> list = dbClient.find(sql,paginate);
		return list;
	}
	
	/**
	 * 
	 * 新增流程的Tree
	 * @return<br>
	 * 返回值格式:<br>
	 *
	 * @author Administrator
	 * @date   2018年3月22日
	 * 方法的作用：TODO
	 */
	public List<BasicMap<String, Object>> findTree() {
		List<BasicMap<String, Object>> rtn = new ArrayList<>();
		User user = ssoService.getUser();
		//获取父级及子集
		String sql = "SELECT id,parentid,jgbm,jgmc,regionid FROM jc_sfxzjgjbxx WHERE del = '0' and (parentid ='"+ user.getOrgid()+"'or  id = '"+user.getOrgid() +"')";
		SQLAdapter adapter = new SQLAdapter(sql);
		//父级
		final BasicMap<String,Object> p = dbClient.findOne("SELECT id,parentid,jgbm,jgmc,regionid FROM jc_sfxzjgjbxx where del = '0' AND regionid  = ?", user.getRegioncode());
		if(p!=null) {
			//检索市
			final List<BasicMap<String, Object>> list = new ArrayList<>();
			//list.add(p);
			dbClient.find(adapter,new RowDataListener() {
				@Override
				public void processData(BasicMap<String, Object> rowData) {
					list.add(rowData);
				}
			});
			rtn = Util.list2Tree(list, "parentid", "regionid","nodes",new Util.List2Tree() {
				@Override
				public boolean isFirstNode(BasicMap<String, Object> obj) {
					boolean r = false;
					if(NumberUtil.toInt(obj.get("parentid")) == NumberUtil.toInt( p.get("parentid"))){
						r = true;
					}
					return r;
				}
			});
		}
		return rtn;
	}
	
	/**
	 * 
	 * 根据父级id  parentid 检索子集司法所
	 * @return<br>
	 * 返回值格式: List<BasicMap<String, Object>>
	 *
	 * @author Administrator
	 * @date   2018年3月22日
	 * 方法的作用： 获取子集的司法所
	 */
	public List<BasicMap<String, Object>> findJudiciary(String parentid) {
		String sql = "SELECT id,parentid,jgbm,jgmc,regionid FROM jc_sfxzjgjbxx WHERE del = '0' and (parentid = '"+ parentid +"' or id = '"+ parentid+"')";
		SQLAdapter adapter = new SQLAdapter(sql);
		return dbClient.find(adapter);

	}
	
	/**
	 * 
	 * 检索机构下的工作人员
	 * @param parentid
	 * @return<br>
	 * 返回值格式:List<BasicMap<String, Object>>
	 *
	 * @author Administrator
	 * @date   2018年3月22日
	 * 方法的作用：TODO
	 */
	public List<BasicMap<String, Object>> findJudiciaryUser(String orgid) {
		String sql = "SELECT id,xm FROM jc_sfxzjggzryjbxx WHERE orgid = '"+ orgid +"'";
		SQLAdapter adapter = new SQLAdapter(sql);
		return dbClient.find(adapter);

	}
	
}
