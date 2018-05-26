package com.ehtsoft.user.services;

import java.util.List;

import javax.annotation.Resource;

import com.ehtsoft.fw.core.context.AppException;
import com.ehtsoft.fw.core.db.RowDataListener;
import com.ehtsoft.fw.core.db.SQLAdapter;
import com.ehtsoft.fw.core.db.SqlDbClient;
import com.ehtsoft.fw.core.dto.BasicMap;
import com.ehtsoft.fw.core.services.AbstractService;
import com.ehtsoft.fw.core.sso.SingleSignOnClient;
import com.ehtsoft.fw.core.sso.User;
import com.ehtsoft.fw.core.utils.AppUtil;
import com.ehtsoft.fw.utils.Util;
import com.ehtsoft.user.api.UserConst;
import com.ehtsoft.user.utils.MenuUtil;
/**
 * 登录首页信息设置 
 * @author wangbao
 */
public class FirstPageService extends AbstractService{
	@Resource(name="sqlDbClient")
	private SqlDbClient dbClient;
	
	@Resource
	private SingleSignOnClient sso;
	
	/**
	 * 保存首页设置信息及场景风格数据
	 * @param data
	 */
	public void save(BasicMap<String,Object> data) throws AppException{
		//保存 SCENEID 
		dbClient.update(UserConst.Collections.CORE_ACCOUNT, data);
		if(Util.isNotEmpty(data.get("menuid"))){
			data.put("ACCOUNTID", data.get("SYSID"));
			dbClient.save(UserConst.Collections.CORE_ACCOUNT_FIRSTPAGE, data);
		}
	}
	
	public List<BasicMap<String,Object>> findMenu(Integer accountId){
			
			String sqlstr ="SELECT  DISTINCT M.SYSID,M.PARENTID,M.MENUCODE,M.MENUNAME,M.ACTIONURI,M.SORT,M.ICON,S.MENUID "+
			" FROM  CORE_MENU M "+
			" INNER JOIN CORE_ROLE_MENU RM ON M.SYSID = RM.MENUID"+
			" INNER JOIN CORE_ROLE R ON RM.ROLEID=R.SYSID AND R.FLAG=1 "+
			" INNER JOIN CORE_ACCOUNT_ROLE AR ON AR.ROLEID = R.SYSID " + 
			" LEFT JOIN CORE_ACCOUNT_FIRSTPAGE S ON S.MENUID = M.SYSID AND S.ACCOUNTID = " + accountId;
			
			SQLAdapter sql = new SQLAdapter(sqlstr);
			sql.getFilter().eq("AR.ACCOUNTID", accountId).eq("M.DEL", 0).asc("M.MENUCODE");
			List<BasicMap<String,Object>> list=dbClient.find(sql,new RowDataListener() {
				public void processData(BasicMap<String, Object> rowData) {
					//CASE WHEN S.MENUID IS NULL THEN 0 ELSE 1 END SELECTED
					if(Util.isEmpty(rowData.get("MENUID"))){
						rowData.put("SELECTED",0);
					}else{
						rowData.put("SELECTED",1);
					}
				}
			});
			return AppUtil.list2Tree(list, "parentid", "sysid");
	}
	
	public BasicMap<String,Object> findFirstPage() throws AppException{
		User user = sso.getUser();
		String sqlstr = "SELECT M.MENUNAME,M.MENUCODE,M.ACTIONURI,A.PROJECT,A.APPNAME,A.FRULE,A.REQADDRESS,ACC.SCENEID " +
				"FROM CORE_MENU M " +
				"INNER JOIN CORE_ACCOUNT_FIRSTPAGE AF ON M.SYSID = AF.MENUID " +
				"INNER JOIN CORE_APPLICATION A ON A.SYSID = M.APPID " +
				"INNER JOIN CORE_ACCOUNT ACC ON ACC.SYSID = AF.ACCOUNTID " +
				" WHERE AF.ACCOUNTID = " + user.getAid();
		BasicMap<String,Object> rtn = dbClient.findOne(new SQLAdapter(sqlstr));
		//根据 application 及 menu 获取请求的 url
		if(rtn!=null){
			MenuUtil.getMenuUrl(rtn, sso);
		}
		return rtn;
	}
}
