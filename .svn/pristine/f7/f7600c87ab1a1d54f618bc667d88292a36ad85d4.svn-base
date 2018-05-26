package com.ehtsoft.user.services;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import com.ehtsoft.fw.core.context.AppException;
import com.ehtsoft.fw.core.db.RowDataListener;
import com.ehtsoft.fw.core.db.SQLAdapter;
import com.ehtsoft.fw.core.db.SqlDbFilter;
import com.ehtsoft.fw.core.dto.BasicMap;
import com.ehtsoft.fw.core.dto.Paginate;
import com.ehtsoft.fw.core.dto.ResultList;
import com.ehtsoft.fw.core.sso.User;
import com.ehtsoft.fw.core.services.SqlBasicService;
import com.ehtsoft.fw.core.sso.SingleSignOnClient;
import com.ehtsoft.fw.utils.NumberUtil;
import com.ehtsoft.fw.utils.StringUtil;
import com.ehtsoft.fw.utils.Util;
import com.ehtsoft.user.api.UserConst;
import com.ehtsoft.user.utils.MenuUtil;

/**
 * 菜单管理
 * @author 王宝
 */
public class MenuService extends SqlBasicService {

	@Resource
	private SingleSignOnClient ssoClient;
	
	/**
	 * 查找菜单tree数据
	 * @return
	 * @throws AppException
	 */
	public List<BasicMap<String, Object>> findTree(BasicMap<String,Object> filter) throws AppException {
		if(filter!=null){
			filter.put("DEL[eq]", 0);
		}
		List<BasicMap<String, Object>> rtn = find(
				UserConst.Collections.CORE_MENU, filter);
		return Util.list2Tree(rtn, "parentid", "sysid","children");
	}

	/**
	 * 存储数据
	 * @return
	 * @throws AppException
	 */
	public void saveMenu(BasicMap<String, Object> data) throws AppException {
		super.save(UserConst.Collections.CORE_MENU, data);

	}

	/**
	 * 查找菜单datagrid数据
	 * @return
	 * @throws AppException
	 */
	public ResultList<BasicMap<String, Object>> findGrid(
			BasicMap<String, Object> query, Paginate paginate)
			throws AppException {
		return find(UserConst.Collections.CORE_MENU, query, paginate);
	}
	
	
	/***************************
	 * 以下方法在登录后主页面调用
	 * 根据当前用户id获取快捷方式
	 ***************************/
	
	public List<? extends Map<String,Object>> findShortcut(Boolean treedata) throws AppException{
		String sqlstr = "SELECT DISTINCT M.SYSID,M.PARENTID,M.MENUCODE,M.MENUNAME,M.ACTIONURI,M.SORT,M.ICON,A.REQADDRESS,A.PROJECT, " +
				"S.MENUID AS SELECTED " +
				"FROM CORE_ACCOUNT_ROLE AR "+
				"INNER JOIN CORE_ROLE R ON AR.ROLEID=R.SYSID AND R.FLAG=1 "+
				"INNER JOIN CORE_ROLE_MENU RM ON AR.ROLEID=RM.ROLEID "+
				"INNER JOIN CORE_MENU M ON RM.MENUID = M.SYSID "+
				"INNER JOIN CORE_APPLICATION A ON M.APPID = A.SYSID "+
				"INNER JOIN CORE_SHORTCUT S ON S.MENUID=M.SYSID";
		
		User user = ssoClient.getUser();
		SQLAdapter sql = new SQLAdapter(sqlstr);
		sql.setFilter(new SqlDbFilter()
		.eq("S.ACCOUNTID",user.getAid())
		.eq("M.DEL", 0)
		.asc("SORT"));
		
		List<BasicMap<String,Object>> menus = this.sqlDbClient.find(sql,new RowDataListener() {
			@Override
			public void processData(BasicMap<String, Object> rowData) {
				//"CASE WHEN S.MENUID IS NULL THEN 0 ELSE 1 END SELECTED " + 
				if(Util.isEmpty(rowData.get("SELECTED"))){
					rowData.put("SELECTED", false);
				}else{
					rowData.put("SELECTED", true);
				}
				replaceUrl(rowData);//"url"
			}
		});
		
		List<BasicMap<String,Object>> tree = Util.list2Tree(menus, "PARENTID", "SYSID","children");
		if(treedata){
			return tree;
		}
		
		return Util.tree2List(tree, "PARENTID", "SYSID", null, null,"children",new Util.Tree2List() {
			@Override
			public void processData(Map<String, Object> parent,
					Map<String, Object> child) {
				if(child!=null){//child==null 表示 parent 为叶子节点
					
					if(Util.isNotEmpty(parent.get("disable"))){
						//parent 的上级已经存在 url 了，次数的 下级应该全部为 disable 
						child.put("disable", true);
						return;
					}
					//父节点url不为空时，快捷方式显示父节点图标，子节点不显示
					if(Util.isNotEmpty(parent.get("url"))){
						child.put("disable", true);
						if(parent.get("ids")==null){
							List<Long> list = new ArrayList<Long>();
							list.add(NumberUtil.toLong(parent.get("SYSID")));
							list.add(NumberUtil.toLong(child.get("SYSID")));
							parent.put("ids", list);
							String url = String.valueOf(parent.get("url"));
							if(url.contains("?")){
								String s = url + "&label=" + parent.get("MENUNAME");
								parent.put("url",s);
							}
						}else{
							((List<Long>)parent.get("ids")).add(NumberUtil.toLong(child.get("SYSID")));
						}
					}else{
						parent.put("dis", true);
						if(Util.isEmpty(child.get("url"))){
							child.put("disable", true);
						}
					}
				}
			}
		});
	}
	/**
	 * 获取全部的应用及功能菜单
	 * @param query
	 * @return
	 * main-cool.jsp 用
	 */
	public List<BasicMap<String,Object>> findAllMenus(BasicMap<String,Object> query){
		User user = ssoClient.getUser();
		String sqlstr = "select M.SYSID,M.PARENTID,M.MENUCODE,M.MENUNAME,M.ACTIONURI,M.SORT,M.ICON,M.REMARK,"
						+ " A.APPCODE,A.APPNAME,A.PROJECT,A.REQADDRESS,rma.MENUID SELECTED from core_menu m "
						+ " inner join core_application a on m.appid = a.sysid "
						+ " left join "
						+ " (select distinct menuid from core_role_menu rm,core_account_role ar where rm.roleid = ar.roleid and ar.accountid = '"+user.getAid()+"') rma "
						+ " on rma.menuid = m.sysid";
		
		SQLAdapter sql = new SQLAdapter(sqlstr);
		sql.getFilter()
				.eq("M.DEL", 0)
				.asc("SORT");
		if(user.isPsa()){
			sql.getFilter().eq("FRULE", "PSA");
		}else{
			sql.getFilter().eq("FRULE", "OSA");
		}
		
		List<BasicMap<String,Object>> list = sqlDbClient.find(sql,new RowDataListener() {
			public void processData(BasicMap<String, Object> rowData) {
				if(Util.isNotEmpty(rowData.get("SELECTED"))){
					rowData.put("selected",true);
				}else{
					rowData.put("selected",false);
				}
				replaceUrl(rowData);//"url"
			}
		});
		return Util.list2Tree(list, "PARENTID", "SYSID","children");
	}
	/**
	 * 返回当前用户功能权限列表（一卡通 客户端使用）非 tree 结构
	 * @return
	 * [
	 * 	 {
	 *     SYSID:菜单的主键,
	 *     PARENTID:父级ID,
	 *     MENUCODE:"功能菜单的编码",
	 *     MENUNAME:"功能菜单的名称",
	 *     URL:"功能点访问url路径",
	 *     PROJECT:"部署应用的名称"
	 *   }
	 * ]
	 * @throws AppException
	 */
	public List<BasicMap<String,Object>> findCurrentMenus() throws AppException{
		/*
		String sqlstr = "SELECT DISTINCT M.SYSID,M.PARENTID,M.MENUCODE,M.MENUNAME,M.ACTIONURI,M.SORT,M.ICON,A.REQADDRESS,A.PROJECT " +
				//",CASE WHEN S.MENUID IS NULL THEN 0 ELSE 1 END SELECTED " + 
				"FROM CORE_ACCOUNT_ROLE AR "+
				"INNER JOIN CORE_ROLE R ON AR.ROLEID=R.SYSID AND R.FLAG=1 "+
				"INNER JOIN CORE_ROLE_MENU RM ON AR.ROLEID=RM.ROLEID "+
				"INNER JOIN CORE_MENU M ON RM.MENUID = M.SYSID "+
				"INNER JOIN CORE_APPLICATION A ON M.APPID = A.SYSID ";
				//+"LEFT  JOIN CORE_SHORTCUT S ON S.MENUID=M.SYSID";
		*/
		User user = ssoClient.getUser();
		String sqlstr = "SELECT M.SYSID,M.PARENTID,M.MENUCODE,M.MENUNAME,M.ACTIONURI,M.SORT,M.ICON,M.REMARK,"
				+" A.APPCODE,A.APPNAME,A.PROJECT,A.REQADDRESS FROM CORE_MENU M "
				+" INNER JOIN CORE_APPLICATION A ON M.APPID = A.SYSID "
				+" INNER JOIN "
				+" ("
				+" SELECT DISTINCT MENUID FROM CORE_ROLE_MENU RM,CORE_ACCOUNT_ROLE AR "
				+" WHERE RM.ROLEID = AR.ROLEID AND AR.ACCOUNTID = '" + user.getAid() + "' "
				+" UNION "
				+" SELECT MENUID FROM CORE_ACCOUNT_MENU AM WHERE AM.ACCOUNTID = '" + user.getAid() + "'"
				+" ) RMA "
				+" ON RMA.MENUID = M.SYSID";
		SQLAdapter sql = new SQLAdapter(sqlstr);
		sql.setFilter(new SqlDbFilter()
		.eq("M.DEL", 0)
		.asc("SORT"));
	
		List<BasicMap<String,Object>> menus = this.sqlDbClient.find(sql,new RowDataListener() {
			@Override
			public void processData(BasicMap<String, Object> rowData) {
				replaceUrl(rowData);//"url"
			}
		});
		return menus;
	}
	/**
	 * 得到当前用户的功能菜单权限
	 * @return
	 * @throws AppException
	 */
 	public List<BasicMap<String,Object>> findMenusByUser() throws AppException{
		return Util.list2Tree(findCurrentMenus(), "parentid", "sysid","children");
	}
 	
 	
	/**
	 * 获取当前功能中的子功能内容（权限之内的功能）
	 * ################################################################################################ ?????
	 * 参数采用 menucode like 过了，该方式需要 编码规则
	 * @return
	 * @throws AppException
	 */
 	public List<BasicMap<String,Object>> findMenusByUser(String menucode) throws AppException{
		/*
		String sqlstr = "SELECT DISTINCT M.SYSID,M.PARENTID,M.MENUCODE,M.MENUNAME,M.ACTIONURI,M.SORT,M.ICON,A.REQADDRESS,A.PROJECT " +
				//",CASE WHEN S.MENUID IS NULL THEN 0 ELSE 1 END SELECTED " + 
				"FROM CORE_ACCOUNT_ROLE AR "+
				"INNER JOIN CORE_ROLE R ON AR.ROLEID=R.SYSID AND R.FLAG=1 "+
				"INNER JOIN CORE_ROLE_MENU RM ON AR.ROLEID=RM.ROLEID "+
				"INNER JOIN CORE_MENU M ON RM.MENUID = M.SYSID "+
				"INNER JOIN CORE_APPLICATION A ON M.APPID = A.SYSID ";
				//+"LEFT  JOIN CORE_SHORTCUT S ON S.MENUID=M.SYSID";
		*/
		User user = ssoClient.getUser();
		String sqlstr = "SELECT M.SYSID,M.PARENTID,M.MENUCODE,M.MENUNAME,M.ACTIONURI,M.SORT,M.ICON,M.REMARK,"
				+" A.APPCODE,A.APPNAME,A.PROJECT,A.REQADDRESS FROM CORE_MENU M "
				+" INNER JOIN CORE_APPLICATION A ON M.APPID = A.SYSID "
				+" INNER JOIN "
				+" ("
				+" SELECT DISTINCT MENUID FROM CORE_ROLE_MENU RM,CORE_ACCOUNT_ROLE AR "
				+" WHERE RM.ROLEID = AR.ROLEID AND AR.ACCOUNTID = '" + user.getAid() + "' "
				+" UNION "
				+" SELECT MENUID FROM CORE_ACCOUNT_MENU AM WHERE AM.ACCOUNTID = '" + user.getAid() + "'"
				+" ) RMA "
				+" ON RMA.MENUID = M.SYSID";
		SQLAdapter sql = new SQLAdapter(sqlstr);
		sql.setFilter(new SqlDbFilter()
			.rLike("M.MENUCODE", menucode)
			.eq("M.DEL", 0)
			.asc("SORT"));
	
		List<BasicMap<String,Object>> menus = this.sqlDbClient.find(sql,new RowDataListener() {
			
			@Override
			public void processData(BasicMap<String, Object> rowData) {
				replaceUrl(rowData);//"url"
			}
		});
		return Util.list2Tree(menus, "parentid", "sysid","children");
	}
	/**
	 * 根据当前用户id获取快捷菜单的设置信息
	 * @return
	 * @throws AppException
	 */
 	public List<BasicMap<String,Object>> findShortcutSetting() throws AppException{
		User user = ssoClient.getUser();
		String sqlstr = "SELECT DISTINCT M.SYSID,M.PARENTID,M.MENUCODE,M.MENUNAME,M.ACTIONURI,M.SORT,M.ICON,A.REQADDRESS,A.PROJECT, " +
				"S.MENUID SELECTED " +  //"CASE WHEN S.MENUID IS NULL THEN 0 ELSE 1 END SELECTED " + 
				"FROM CORE_ACCOUNT_ROLE AR "+
				"INNER JOIN CORE_ROLE R ON AR.ROLEID=R.SYSID AND R.FLAG=1 "+
				"INNER JOIN CORE_ROLE_MENU RM ON AR.ROLEID=RM.ROLEID "+
				"INNER JOIN CORE_MENU M ON RM.MENUID = M.SYSID "+
				"INNER JOIN CORE_APPLICATION A ON M.APPID = A.SYSID "+
				"LEFT  JOIN CORE_SHORTCUT S ON S.MENUID=M.SYSID AND S.ACCOUNTID = '" + user.getAid() + "'";
		
		SQLAdapter sql = new SQLAdapter(sqlstr);
		sql.setFilter(new SqlDbFilter()
			.eq("AR.ACCOUNTID",user.getAid())
			.eq("M.DEL", 0)
			.asc("SORT"));
	
		List<BasicMap<String,Object>> menus = this.sqlDbClient.find(sql,new RowDataListener() {
			@Override
			public void processData(BasicMap<String, Object> rowData) {
				if(Util.isNotEmpty(rowData.get("SELECTED"))){
					rowData.put("selected",true);
				}else{
					rowData.put("selected",false);
				}
				replaceUrl(rowData);//"url"
			}
		});
		return Util.list2Tree(menus, "parentid", "sysid","children");
	}
 	
	/**
	 * 根据当前用户id 获取具备权限的功能菜单
	 *   排除已经设置的快捷菜单
	 * 注：只需要没有设置的并且具有权限的功能菜单
	 * @return
	 * @throws AppException
	 * main-cool.jsp 用
	 */
 	public List<BasicMap<String,Object>> findMenuSetting() throws AppException{
		User user = ssoClient.getUser();
		String sqlstr = "SELECT M.SYSID,M.PARENTID,M.MENUCODE,M.MENUNAME,M.ACTIONURI,M.SORT,M.ICON,M.REMARK,"
						+" A.APPCODE,A.APPNAME,A.PROJECT,A.REQADDRESS,RMA.MENUID SELECTED FROM CORE_MENU M "
						+" INNER JOIN CORE_APPLICATION A ON M.APPID = A.SYSID "
						+" INNER JOIN "
						+" ("
						+" SELECT DISTINCT MENUID FROM CORE_ROLE_MENU RM,CORE_ACCOUNT_ROLE AR "
						+" WHERE RM.ROLEID = AR.ROLEID AND AR.ACCOUNTID = '" + user.getAid() + "' "
						+" UNION "
						+" SELECT MENUID FROM CORE_ACCOUNT_MENU AM WHERE AM.ACCOUNTID = '" + user.getAid() + "'"
						+" ) RMA "
						+" ON RMA.MENUID = M.SYSID "
						+" WHERE "
						//+" M.SYSID NOT IN (SELECT MENUID FROM CORE_SHORTCUT WHERE ACCOUNTID = '4a847440-a394-4b4c-93f3-01411e402dae') " //等同下面的条件不采用not in 采用 not exists
						+" NOT EXISTS (SELECT MENUID FROM CORE_SHORTCUT S WHERE S.ACCOUNTID = '" + user.getAid() + "' AND M.SYSID = S.MENUID)"  
						+" AND M.DEL = 0 ORDER BY SORT ASC";
		
		SQLAdapter sql = new SQLAdapter(sqlstr);
		
		final Map<String,String> map = new HashMap<>();
		this.sqlDbClient.find(new SQLAdapter("SELECT MENUID,audit FROM CORE_ACCOUNT_MENU WHERE ACCOUNTID = '"+user.getAid()+"'"),new RowDataListener() {
			@Override
			public void processData(BasicMap<String, Object> rowData) {
				map.put(StringUtil.toString(rowData.get("MENUID")), StringUtil.toString(rowData.get("audit")));
			}
		});
		
		List<BasicMap<String,Object>> menus = this.sqlDbClient.find(sql,new RowDataListener() {
			@Override
			public void processData(BasicMap<String, Object> rowData) {
				String sysid = StringUtil.toString(rowData.get("SYSID"));
				String audit = StringUtil.toString(map.get(sysid));
				if(audit==null){ 
					//audit = null 说明，菜单不是从 CORE_ACCOUNT_MENU 表中出来的，是默认已经授权的功能角色菜单
					//授权通过的再页面不允许删除
					rowData.put("delable", "0");
				}else if("1".equals(audit)){ //审核通过的
					//audit !=null 说明功能菜单是用户申请订阅过来的，需要上级审核通过后才能使用  0 为审核  1 审核通过 2 审核未通过
					//授权通过的再页面不允许删除
					rowData.put("delable", "0");
				}else{
					rowData.put("delable", "1");
				}
				replaceUrl(rowData);//"url"
			}
		});
		return Util.list2Tree(menus, "parentid", "sysid","children");
	}
	
	private void replaceUrl(BasicMap<String,Object> menu){
			MenuUtil.getMenuUrl(menu, ssoClient);
	}
	
	
	/**
	 * 保存快捷功能菜单（批量）
	 * @param roleData
	 * @throws AppException
	 */
	public void saveShortcut(List<BasicMap<String,Object>> menuData ) throws AppException{
		User user = ssoClient.getUser();
		for(BasicMap<String,Object> bm:menuData){
			bm.put("ACCOUNTID", user.getAid());
		}
		
		SqlDbFilter filter = new SqlDbFilter();
		filter.eq("ACCOUNTID",user.getAid());
		sqlDbClient.remove(UserConst.Collections.CORE_SHORTCUT, filter);
		super.save(UserConst.Collections.CORE_SHORTCUT, menuData);
		
	}
	/**
	 * 添加到快捷菜单的时候调用（单个）
	 * main-cool.jsp 使用
	 * @param menuid
	 */
	public void insertShortcut(BasicMap<String,Object> menu){
		List<BasicMap<String,Object>> list = new ArrayList<>();
		list.add(menu);
		User user = ssoClient.getUser();
		
		List<Map<String,Object>> menus = Util.tree2List(list, "PARENTID", "SYSID", null, null,"children");
		for(Map<String,Object> m : menus){
			BasicMap<String,Object> data = new BasicMap<String,Object>();
			data.put("ACCOUNTID", user.getAid());
			data.put("MENUID", StringUtil.toString(m.get("SYSID")));
			sqlDbClient.insert(UserConst.Collections.CORE_SHORTCUT, data);
		}
	}
	/**
	 * 移除快捷菜单的时候（单个移除）
	 * main-cool.jsp 使用
	 * @param menuid
	 */
	public void removeShortcut(BasicMap<String,Object> menu){
		List<BasicMap<String,Object>> list = new ArrayList<>();
		list.add(menu);
		User user = ssoClient.getUser();
		
		List<Map<String,Object>> menus = Util.tree2List(list, "PARENTID", "SYSID", null, null,"children");
		for(Map<String,Object> m : menus){
			String menuid = StringUtil.toString(m.get("SYSID"));
			sqlDbClient.updateSql("DELETE FROM CORE_SHORTCUT WHERE ACCOUNTID = ? AND MENUID = ?", user.getAid(),menuid);
		}
	}
	
	/**
	 * 功能菜单订阅申请
	 * CORE_ACCOUNT_MENU
	 * main-cool.jsp 用
	 * 添加没有权限的功能菜单的时候
	 * @param menuid
	 */
	public void subscribe(BasicMap<String,Object> menu){
		User user = ssoClient.getUser();
		List<BasicMap<String,Object>> list = new ArrayList<>();
		list.add(menu);
		List<Map<String,Object>> menus = Util.tree2List(list, "PARENTID", "SYSID", null, null,"children");
		for(Map<String,Object> map : menus){
			BasicMap<String,Object> data = new BasicMap<String,Object>();
			data.put("ACCOUNTID", user.getAid());
			data.put("MENUID", StringUtil.toString(map.get("SYSID")));
			sqlDbClient.insert(UserConst.Collections.CORE_ACCOUNT_MENU, data);
		}
	}
	
	public void removeSub(BasicMap<String,Object> menu){
		User user = ssoClient.getUser();
		List<BasicMap<String,Object>> list = new ArrayList<>();
		list.add(menu);
		List<Map<String,Object>> menus = Util.tree2List(list, "PARENTID", "SYSID", null, null,"children");
		for(Map<String,Object> map : menus){
			String menuid = StringUtil.toString(map.get("SYSID"));
			sqlDbClient.updateSql("DELETE FROM CORE_ACCOUNT_MENU WHERE ACCOUNTID = ? AND MENUID = ?", user.getAid(),menuid);
		}
	}
}
