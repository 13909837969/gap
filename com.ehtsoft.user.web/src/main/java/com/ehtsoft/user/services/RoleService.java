package com.ehtsoft.user.services;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import com.ehtsoft.fw.core.context.AppException;
import com.ehtsoft.fw.core.context.GlobalsName;
import com.ehtsoft.fw.core.db.RowDataListener;
import com.ehtsoft.fw.core.db.SQLAdapter;
import com.ehtsoft.fw.core.db.SqlDbFilter;
import com.ehtsoft.fw.core.dto.BasicMap;
import com.ehtsoft.fw.core.dto.Paginate;
import com.ehtsoft.fw.core.dto.ResultList;
import com.ehtsoft.fw.core.sso.User;
import com.ehtsoft.fw.core.services.SqlBasicService;
import com.ehtsoft.fw.core.sso.SingleSignOnClient;
import com.ehtsoft.fw.core.utils.AppUtil;
import com.ehtsoft.fw.utils.NumberUtil;
import com.ehtsoft.fw.utils.StringUtil;
import com.ehtsoft.fw.utils.Util;
import com.ehtsoft.user.api.UserConst;


public class RoleService extends SqlBasicService {
	@Resource
	private SingleSignOnClient ssoClient;
	/**
	 * 保存角色信息
	 *
	 */
	public  void save(BasicMap<String,Object> roleData,List<BasicMap<String,Object>> menuData) throws AppException{
		User user = ssoClient.getUser();
		//非平台管理员
		if(!user.isPsa()){
			if(!"PSA".equals(roleData.get("FRULE")) && 
			   !"OSA".equals(roleData.get("FRULE")) &&
			   !"OBM".equals(roleData.get("FRULE"))){
				roleData.put("ORGID", user.getOrgid());
			}
		}else{
			roleData.remove("ORGID");
		}
		//普通角色类型
		if("-1".equals(roleData.get("frule"))){
			roleData.remove("frule");
		}
		super.save(UserConst.Collections.CORE_ROLE, roleData);
		String roleid = StringUtil.toString(roleData.get(GlobalsName.SQLDB_PK_FIELD));
		
		//删除角色中的菜单数据
		SqlDbFilter filter = new SqlDbFilter();
		filter.eq("ROLEID",roleid);
		sqlDbClient.remove(UserConst.Collections.CORE_ROLE_MENU, filter);
		
		for(BasicMap<String,Object> map:menuData){
			map.put("ROLEID", roleid);
		}
		//保存角色数据
		super.save(UserConst.Collections.CORE_ROLE_MENU, menuData);
	}
	
	/**
	 *  查找 角色表数据
	 * @return
	 * @throws AppException
	 */
	public ResultList<BasicMap<String,Object>> findRole(BasicMap<String,Object> query,Paginate paginate) throws AppException{
		/** PSA 平台管理员角色过滤掉，不显示
		 * PSA 权限角色仅用于系统安装初始化的角色数据（初始化，写死的角色)
		 **/
		SqlDbFilter filter = toSqlFilter(query);
		User user = ssoClient.getUser();
		if(!user.isPsa()){
			filter.in("SYSID", "SELECT ROLEID FROM CORE_ORGANIZATION_ROLE WHERE ORGID = '" + user.getOrgid() + "'").or().eq("ORGID", user.getOrgid());
		}else{
			filter.isNull("ORGID");
		}
		return this.sqlDbClient.find(UserConst.Collections.CORE_ROLE,filter.asc("SYSID"),paginate);
	}
	
	 
	
	/**
	 * 右侧 功能菜单 
	 * @param query
	 * @return
	 * @throws AppException
	 */
	public List<BasicMap<String,Object>> findMenuTree(BasicMap<String,Object> query) throws AppException{
		User user = ssoClient.getUser();
		String sqlstr = "SELECT DISTINCT A.*,B.ROLEID FROM CORE_MENU A " +
 	 			"LEFT JOIN CORE_ROLE_MENU B ON A.SYSID = B.MENUID AND B.ROLEID " + 
 	 			(Util.isEmpty(query.get("ROLEID"))?" is null":"= '" + query.get("ROLEID") + "'")+
 	 			" INNER JOIN CORE_APPLICATION AP ON AP.SYSID=A.APPID ";
		//机构用户(非平台管理员)
		if(!user.isPsa()){
			sqlstr = "SELECT DISTINCT A.*,B.ROLEID FROM CORE_MENU A " +
					"INNER JOIN (" +
					"SELECT MENUID FROM CORE_ROLE_MENU WHERE ROLEID IN (SELECT ROLEID FROM CORE_ORGANIZATION_ROLE WHERE ORGID = '"+user.getOrgid()+"')" +
					") OM ON A.SYSID=OM.MENUID " +
	 	 			"LEFT JOIN CORE_ROLE_MENU B ON A.SYSID = B.MENUID AND B.ROLEID " + 
	 	 			(Util.isEmpty(query.get("ROLEID"))?" is null":"= '" + query.get("ROLEID") + "'")+
	 	 			" INNER JOIN CORE_APPLICATION AP ON AP.SYSID=A.APPID ";
		}
		SQLAdapter sql = new SQLAdapter(sqlstr);
		if("PSA".equals(query.get("appfrule"))){
			sql.getFilter().eq("AP.FRULE", "PSA");
		}else{
			sql.getFilter().eq("AP.FRULE", "OSA");
		}
		sql.getFilter().asc("A.SORT").eq("A.DEL", 0);
		
		List<BasicMap<String,Object>> list=this.sqlDbClient.find(sql,new RowDataListener() {
			public void processData(BasicMap<String, Object> rowData) {
				//CASE  WHEN B.ROLEID IS NULL THEN 0 ELSE 1 END SELECTED
				if(Util.isEmpty(rowData.get("ROLEID"))){
					rowData.put("SELECTED", 0);
				}else{
					rowData.put("SELECTED", 1);
				}
			}
		});
		
		List<BasicMap<String,Object>>  rtn = this.sqlDbClient.find(UserConst.Collections.CORE_APPLICATION,null);
		List<BasicMap<String,Object>> menutree = AppUtil.list2Tree(list, "parentid", "sysid",new AppUtil.List2Tree() {
			@Override
			public boolean isFirstNode(BasicMap<String, Object> obj) {
				if("".equals(StringUtil.toEmptyString(obj.get("parentid")).trim())) {
					return true;
				}
				return false;
			}
		});
		List<BasicMap<String,Object>> tmp = new ArrayList<BasicMap<String,Object>>();
		for(BasicMap<String,Object> app : rtn){
			app.put("menuname", app.get("appname"));
			for(BasicMap<String,Object> menu:menutree){
				if(StringUtil.toEmptyString(app.get("SYSID")).equals(menu.get("APPID"))){
					if(app.get("children")==null){						
						List<BasicMap<String,Object>> l = new ArrayList<BasicMap<String,Object>>();
						l.add(menu);
						app.put("children", l);
					}else{
						((List<BasicMap<String,Object>>)app.get("children")).add(menu);
					}
					//已经设置的菜单将 app 数据也选择上去
					if(NumberUtil.toInt(menu.get("SELECTED"))==1){
						app.put("SELECTED", 1);
					}
				}
			}
			if(app.get("children")==null){
				tmp.add(app);
			}
		}
		for(BasicMap<String,Object> b : tmp){
			rtn.remove(b);
		}
		return rtn;
	}
	
	
	public void remove(List<BasicMap<String,Object>> data) throws AppException{
		if(data!=null && data.size()>0){
			try{
			for(BasicMap<String,Object> d:data){
				if(Util.isNotEmpty(d.get("sysid"))){
					this.sqlDbClient.remove(UserConst.Collections.CORE_ROLE, d);
				}
			}
			}catch(AppException ex){
				throw new AppException("角色已经被使用，不能删除");
			}
		}
	}
}
