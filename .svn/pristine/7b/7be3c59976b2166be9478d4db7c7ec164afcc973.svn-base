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
import com.ehtsoft.fw.core.services.SqlBasicService;
import com.ehtsoft.fw.core.sso.SingleSignOnClient;
import com.ehtsoft.fw.core.utils.AppUtil;
import com.ehtsoft.fw.utils.NumberUtil;
import com.ehtsoft.user.api.UserConst;

public class WebCommunicationService extends SqlBasicService  {
	
	
	@Resource
	private SingleSignOnClient ssoClient;
	
	
	//获取组织机构信息树
	public List<BasicMap<String, Object>> getTree(Boolean currentOrg) throws AppException{	
		final List<Long> sysids= new ArrayList<Long>();
		SqlDbFilter filter = new SqlDbFilter();
		/*
		final BasicMap<String,Object> org = sqlDbClient.findOne(UserConst.Collections.CORE_ORGANIZATION, new SqlDbFilter().eq("SYSID", ssoClient.getCurrentUser().getUnitId()));
		if(currentOrg){
			String insql = "SELECT SYSID FROM CORE_ORGANIZATION WHERE LFT>= " + org.get("LFT") +" AND RGT <= " + org.get("RGT");
			filter.in("SYSID", insql);
		}
		*/
		if(currentOrg){
			filter.eq("SYSID", ssoClient.getUser().getOrgid());
		}else{
			filter.in("SYSID", "SELECT DISTINCT ORGID FROM CORE_PERSONNEL");
		}
		final StringBuffer orgIn = new  StringBuffer();
		/*一级节点*/
		final List<BasicMap<String,Object>> list=sqlDbClient.find(UserConst.Collections.CORE_ORGANIZATION, filter,new RowDataListener() {
			public void processData(BasicMap<String, Object> rowData) {
				sysids.add(NumberUtil.toLong(rowData.get("sysid")));
				rowData.put("id", rowData.get("sysid"));
				rowData.remove("parentid");//一级节点 父节点为空
				
				orgIn.append(NumberUtil.toLong(rowData.get("sysid")));
				orgIn.append(",");
			}
		});	
		if(orgIn.length()>0){
			orgIn.deleteCharAt(orgIn.length()-1);
		}
		String sqlstr = "SELECT ACCOUNTID FROM CORE_ACCOUNT_ORGANIZATION "+(orgIn.length()!=0?"WHERE ORGID IN ("+orgIn+")":"");
		final Map<Object,String> status = new HashMap<Object,String>();
		//获取账户信息（根据当前机构或全部）
		sqlDbClient.find(UserConst.Collections.CORE_ACCOUNT, new SqlDbFilter().in("SYSID", sqlstr),new RowDataListener() {
			public void processData(BasicMap<String, Object> rowData) {
				status.put(rowData.get("userid"), (String)rowData.get("status"));
			}
		});
		//获取存在账户的用户信息
		SQLAdapter sql = new SQLAdapter("SELECT DISTINCT P.* FROM CORE_PERSONNEL P " +
				"INNER JOIN CORE_ACCOUNT A ON P.SYSID = A.USERID");
		sql.setFilter(new SqlDbFilter().in("P.ORGID", sysids));
		sqlDbClient.find(sql,new RowDataListener() {
			public void processData(BasicMap<String, Object> rowData) {
				rowData.put("ORGCODE", rowData.remove("CODING"));
				rowData.put("PARENTID", rowData.get("ORGID"));
				rowData.put("ORGNAME", rowData.remove("NAME"));
				rowData.put("id", NumberUtil.toLong((rowData.get("ORGID").toString()+"000000"+rowData.get("sysid").toString())));
				rowData.put("status", status.get(rowData.get("sysid")));
				list.add(rowData);
			}
		});
		//当前组织下的所有的信息转换成tree
			return AppUtil.list2Tree(list, "parentid", "id");
	}
	
}
