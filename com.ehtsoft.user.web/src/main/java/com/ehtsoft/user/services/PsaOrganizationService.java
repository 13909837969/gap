package com.ehtsoft.user.services;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.ehtsoft.fw.core.context.AppException;
import com.ehtsoft.fw.core.db.InsertOperation;
import com.ehtsoft.fw.core.db.RowDataListener;
import com.ehtsoft.fw.core.db.SQLAdapter;
import com.ehtsoft.fw.core.db.SaveOperation;
import com.ehtsoft.fw.core.db.SqlDbClient;
import com.ehtsoft.fw.core.db.SqlDbFilter;
import com.ehtsoft.fw.core.dto.BasicMap;
import com.ehtsoft.fw.core.dto.Paginate;
import com.ehtsoft.fw.core.dto.ResultList;
import com.ehtsoft.fw.core.dto.UploadObject;
import com.ehtsoft.fw.core.services.AbstractService;
import com.ehtsoft.fw.core.services.api.IUploadService;
import com.ehtsoft.fw.core.utils.AppUtil;
import com.ehtsoft.fw.core.utils.EncryptUtil;
import com.ehtsoft.fw.utils.NumberUtil;
import com.ehtsoft.fw.utils.StringUtil;
import com.ehtsoft.fw.utils.Util;
import com.ehtsoft.user.api.UserConst;
import com.ehtsoft.user.utils.ExcelUtil;
import com.ehtsoft.user.utils.MenuUtil;
import com.ehtsoft.user.utils.SYSID;
import com.ehtsoft.user.utils.SysParamUtil;


/**
 * 
 * @author wangbao
 */
public class PsaOrganizationService extends AbstractService  implements IUploadService{

	private Log logger = LogFactory.getLog(getClass()); 
	
	@Resource
	private OrganizationSynchronizeService organizationSynchronizeService;

	@Resource(name="sqlDbClient")
	private SqlDbClient userClient;
	
	//获取组织机构信息树(BS应用)
	public List<BasicMap<String, Object>> getOrgTree(BasicMap<String,Object> filter) throws AppException{	
		return AppUtil.list2Tree(userClient.find(UserConst.Collections.CORE_ORGANIZATION, toSqlFilter(filter).asc("orgcode")),"parentid","sysid");
	}
	/**
	 * 获取 非 PSA 的角色列表
	 * @return
	 */
	public  List<BasicMap<String, Object>> getRole(String orgid){
		if(Util.isEmpty(orgid)){
			orgid = "-1000";
		}
		String sqlstr = "SELECT R.*,COR.ROLEID FROM CORE_ROLE R " +
				" LEFT JOIN CORE_ORGANIZATION_ROLE COR ON R.SYSID = COR.ROLEID AND COR.ORGID =  '" + orgid + "'" +
				" WHERE R.FRULE <> 'PSA' OR (R.FRULE IS NULL AND R.ORGID IS NULL)";
		SQLAdapter sql = new SQLAdapter(sqlstr);
		return userClient.find(sql,new RowDataListener() {
			@Override
			public void processData(BasicMap<String, Object> rowData) {
				if(Util.isNotEmpty(rowData.get("ROLEID"))){
					rowData.put("selected", true);
				}
			}
		});
	}
	private String __save(BasicMap<String,Object> data,List<BasicMap<String, Object>> rolelist,List<String> orgids,boolean load){
		if(data.get("SYSID")==null || load){//新增行政区划数据时
			//新增行政区划及组织机构时采用预排序算法，对机构进行于排序
			Integer baseValue = 0;
			if(data.containsKey("parentid")){//具有上级编码的时候（子机构数据）
				BasicMap<String,Object> map = userClient.findOne(UserConst.Collections.CORE_ORGANIZATION,new SqlDbFilter().eq("SYSID", data.get("parentid")));
				if(map!=null && map.get("RGT")!=null){
					baseValue = NumberUtil.toInteger(map.get("RGT"));
					data.put("LFT", baseValue);
					data.put("RGT", baseValue+1);
				}else{
					data.put("LFT", 1);
					data.put("RGT", 2);
				}
			}else{
				String sqlstr = "SELECT COUNT(SYSID) count,MAX(RGT) maxrgt FROM CORE_ORGANIZATION WHERE PARENTID IS NULL";
				BasicMap<String,Object> map = userClient.findOne(new SQLAdapter(sqlstr));
				if(map==null ||NumberUtil.toInt(map.get("count"))==0){
					data.put("LFT", 1);
					data.put("RGT", 2);
				}else{
					if(NumberUtil.toInteger(map.get("count"))>0){
						if(map.get("maxrgt")==null){
							data.put("LFT", 1);
							data.put("RGT", 2);
						}else{
							baseValue = NumberUtil.toInteger(map.get("maxrgt")) + 1;
							data.put("LFT", baseValue);//右的最大值放到 平级节点的 left 中
							data.put("RGT", baseValue+1);		
						}
					}
				}
			}
			if(baseValue!=0){
				userClient.updateSql("UPDATE CORE_ORGANIZATION SET LFT=LFT+2  WHERE LFT >= ?",baseValue);
				userClient.updateSql("UPDATE CORE_ORGANIZATION SET RGT=RGT+2  WHERE RGT >= ?",baseValue);		
			}
		}
		
		//CORE_ORGANIZATION 数据
		final BasicMap<String,Object> orgdata = new BasicMap<String,Object>();
		String[] corefields = new String[]{"sysid","parentid","orgcode","orgname","lvl","appurl","SCENEID","LFT","RGT","ACCID","INNERCODE","regioncode"};
		for(String field : corefields){
			orgdata.put(field, data.get(field));
		}
		//保存组织机构信息
		userClient.save(UserConst.Collections.CORE_ORGANIZATION,orgdata);
		final String orgid = StringUtil.toString(orgdata.get("SYSID"));
		final List<String> roleids = new ArrayList<String>();
		if(rolelist!=null){
			//CORE_ORGANIZATION_ROLE  
			//机构角色关联表(每个机构具有不同的角色，机构管理员，可以根据所有存在的角色功能，自定义角色)
			userClient.remove(UserConst.Collections.CORE_ORGANIZATION_ROLE, new SqlDbFilter().eq("ORGID", orgid));
			//保存角色到机构角色关联表中
			userClient.insert(UserConst.Collections.CORE_ORGANIZATION_ROLE, rolelist,new InsertOperation() {
				public void insertBefore(BasicMap<String, Object> data) {
					data.put("ORGID", orgid);
					data.put("ROLEID", data.get("SYSID"));
					roleids.add(StringUtil.toString(data.get("SYSID")));
				}
				public void insertAfter(BasicMap<String, Object> data) {
				}
			});
		}
		
		//CORE_ACCOUNT 数据
		BasicMap<String,Object> account = new BasicMap<String,Object>();
		if(Util.isEmpty(data.get("SYSID")) || load){ //第一次创建的时候生成初密码
			//新建的时候生成随机的密码
			String initpw = StringUtil.getRandomNumber(6);//初始密码
			String psw = EncryptUtil.md5(initpw);
			account.put("password", psw);
			userClient.updateSql("UPDATE CORE_ORGANIZATION SET ACCPW = ? WHERE SYSID = ?",initpw,orgid);
		}
		account.put("SYSID", orgid);
		account.put("accountid", data.get("ACCID"));
		account.put("frule", "OSA");
		account.put("flag", "1");
		account.put("status", "0");
		userClient.save(UserConst.Collections.CORE_ACCOUNT,account);

		//在创建的时候，创建用户-机构关联信息
		//CORE_ACCOUNT_ORGANIZATION 数据
		BasicMap<String,Object> ao = new BasicMap<String,Object>();
		ao.put("accountid",orgid); // ACCOUNTID,ORGID
		ao.put("orgid", orgid);
		ao.put("defaultorg",1);    //默认组织机构(1默认)   
		ao.put("FRULE", "OSA");    //机构管理员
		userClient.updateSql("DELETE FROM CORE_ACCOUNT_ORGANIZATION WHERE orgid = ? AND accountid = ?",orgid,orgid);
		userClient.insert(UserConst.Collections.CORE_ACCOUNT_ORGANIZATION,ao);
		if(rolelist!=null){
			updateAccountRole(orgid,rolelist);
		}
		if(Util.isNotEmpty(orgid) && orgids!=null && !orgids.isEmpty()){
			userClient.updateSql("DELETE FROM CORE_ACCOUNT_ORGANIZATION WHERE defaultorg = 0 AND accountid = '"+orgid+"'");
			for(String oid : orgids){
				BasicMap<String,Object> aoData = new BasicMap<String,Object>();
				aoData.put("accountid", orgid);
				aoData.put("orgid", oid);
				aoData.put("defaultorg",0);//0 非默认的组织机构
				aoData.put("FRULE", "OSA");//机构管理员
				userClient.insert(UserConst.Collections.CORE_ACCOUNT_ORGANIZATION,aoData);
			}
		}
		//删除快捷功能
		userClient.updateSql("DELETE FROM CORE_SHORTCUT WHERE ACCOUNTID = ?", orgid);
		String sqlstr = "SELECT DISTINCT RM.MENUID,M.PARENTID FROM CORE_MENU M " +
						" INNER JOIN CORE_ROLE_MENU RM ON RM.MENUID = M.SYSID ";
		if(roleids.size()>0){
			SQLAdapter sql = new SQLAdapter(sqlstr);
			sql.getFilter().in("RM.ROLEID", roleids);
			List<BasicMap<String,Object>> ls = userClient.find(sql,new RowDataListener() {
				public void processData(BasicMap<String, Object> rowData) {
					rowData.put("ACCOUNTID", orgid);
				}
			});
			ls = Util.list2Tree(ls, "PARENTID", "MENUID");
			
			List<BasicMap<String,Object>> list = null;
			if(ls.size()>8){
			   list = ls.subList(0, 8);
			}else{
			   list = ls;
			}
			userClient.insert(UserConst.Collections.CORE_SHORTCUT, Util.tree2List(list, "PARENTID", "MENUID"));
		}
		if(organizationSynchronizeService!=null){
			List<String> oids = new ArrayList<>();
			oids.add(orgid);
			organizationSynchronizeService.synchronize(oids);
		}
		return orgid;
	}
	//将前台填写的组织信息保存在数据库中(BS应用)
	public String save(BasicMap<String,Object> data,List<BasicMap<String, Object>> rolelist,List<String> orgids) throws AppException{
		return __save(data,rolelist,orgids,false);
	}
		
	private void updateAccountRole(final Object accountid,List<BasicMap<String,Object>> roleList) throws AppException{
		List<BasicMap<String,Object>> osalist = new ArrayList<BasicMap<String,Object>>();
		for(BasicMap<String,Object> role : roleList){
			if("OSA".equals(role.get("FRULE"))){
				osalist.add(role);
			}
		}
		//更加 账户 id 删除 account_role 数据
		userClient.remove(UserConst.Collections.CORE_ACCOUNT_ROLE,new SqlDbFilter().eq("ACCOUNTID", accountid));
		//保存该账户的角色
		userClient.insert(UserConst.Collections.CORE_ACCOUNT_ROLE,osalist, new InsertOperation() {
			@Override
			public void insertBefore(BasicMap<String, Object> data) {
				data.put("ROLEID", data.get("sysid"));
				data.put("ACCOUNTID",accountid);
			}
			@Override
			public void insertAfter(BasicMap<String, Object> data) {
			}
		});
	}
		
	//获取树节点中的组织机构具体信息(BS应用)
	/**
	 * 获取机构信息列表（包含了account.sysid as accountid）
	 * @param data
	 * @param paginate
	 * @return
	 */
	public ResultList<BasicMap<String, Object>> find(BasicMap<String,Object> data,Paginate paginate) {
		if(data!=null){
			data.put("lvl[eq]", NumberUtil.toInteger(data.get("lvl[eq]")));
		}
		//创建SqlDbfilter对象
		SqlDbFilter filter = toSqlFilter(data);
		filter.asc("O.ORGCODE");
		//如果该字段不为空，把编码都传给sysids
		if(Util.isNotEmpty(data.get("sysids")) ){
			List sysids = (List)data.get("sysids");
				//如果接收到的sysids不为空，把他当成条件传到filter中
				if(!sysids.isEmpty()){
					filter.in("sysid",sysids);
				}
		}
		//用上面得到的条件在postgre查询
		String sqlstr = "SELECT OA.ACCOUNTID,O.* FROM CORE_ORGANIZATION O "+
						" LEFT JOIN "+
						" ("+
						" SELECT AO.ACCOUNTID,AO.ORGID FROM CORE_ACCOUNT_ORGANIZATION AO"+
						" INNER JOIN CORE_ACCOUNT A ON AO.ACCOUNTID = A.SYSID "+
						" WHERE A.FRULE = 'OSA' AND AO.DEFAULTORG = 1 ) OA"+
						" ON O.SYSID = OA.ORGID";
		SQLAdapter sql = new SQLAdapter(sqlstr);
		sql.setFilter(filter);
		ResultList<BasicMap<String,Object>> rtn = userClient.find(sql,paginate);
		 //返回该数据集合到前台
		  return rtn;
		}
	
	/**
	 * 自动生成编码
	 * @param orgcode  机构编码
	 * @return
	 * @throws AppException
	 */
	public String createBm(String orgcode) throws AppException{
		StringBuffer rtn = new StringBuffer();
		for(int i=0;i<SysParamUtil.getOrgCodeDigit();i++){
			rtn.append("0");
		}
		rtn.append(this.userClient.getProxyPrimary("ORG_"+orgcode, null));
		
		return orgcode + rtn.substring(rtn.length() - SysParamUtil.getOrgCodeDigit());
	}
	
	/**
	 * 自动生成编码
	 * @param orgcode  机构编码
	 * @return
	 * @throws AppException
	 */
	public String createBm(String parentid,Integer flag) throws AppException{
		String sqlstr = "SELECT orgcode FROM CORE_ORGANIZATION WHERE SYSID = '"+parentid+"'";
		BasicMap<String,Object> org = userClient.findOne(new SQLAdapter(sqlstr));
		if(org!=null){
			String parentCode = StringUtil.toString(org.get("orgcode"));
			sqlstr = "SELECT max(orgcode) as maxorgcode FROM CORE_ORGANIZATION WHERE LVL = "+flag+" AND PARENTID = '"+parentid+"'";
			BasicMap<String,Object> maxOne = userClient.findOne(new SQLAdapter(sqlstr));
			String value = getInitcode(flag);// 1 省 2 市 3 区  4 社区（从社区开始编码 0001）
			int l = SysParamUtil.getOrgCodeDigit();
			if(maxOne!=null && maxOne.get("maxorgcode")!=null){
				String maxCode = StringUtil.toString(maxOne.get("maxorgcode")).replace(parentCode, "");
				String[] vs = maxCode.split("[A-Z]+");
				String pre = maxCode.replace(vs[vs.length-1], "");
				int seqv = NumberUtil.toInt(vs[vs.length-1]) + 1;
				value = String.format(pre+"%0" + vs[vs.length-1].length() + "d" , seqv);
			}
			return parentCode + value;
		}
		return null;
	}
	
	private String getInitcode(int flag){
		int preNum = flag - 4;
		String pre = preNum + "";
		if(preNum > 9){
			int c = preNum - 10;
			int l = (int)Math.floor((c*1.0/26));
			pre = (char)(65 + (c % 26)) + "";
			if(l>=1 && l<=9){
				pre = l + pre;
			}else if(l>9){
				pre = ((char)(65 + (l-10))) + pre;
			}
		}
		StringBuffer rtn = new StringBuffer("0001");
		rtn.replace(0, pre.length(), pre);
		return rtn.toString();
	}
	
	
	/**
	 * 点击查询，输入条件，查询满足条件的记录
	 * @param data
	 * @param paginate
	 * @return
	 * 
	 * 哪个位置使用的 ？忘记了，以后查找下
	 */
	public ResultList<BasicMap<String, Object>> findOrg(BasicMap<String,Object> data,Paginate paginate) {		
		//用上面得到的条件在postgre查询
		data.put("lvl[eq]", NumberUtil.toInteger(data.get("lvl[eq]")));
		ResultList<BasicMap<String,Object>> rtn = userClient.find("core_organization",toSqlFilter(data),paginate);
		
		//返回该数据集合到前台
		return rtn;
	}

	/**
	 * 获取机构信息（不为当前的机构信息）
	 * @param selectedOrgid  权限分配的时候，选择的机构id
	 * @param selectedAccountid 权限分配的时候，选择的用户id（accountid)
	 * @return
	 */
	public List<BasicMap<String,Object>> findOrgs(String selectedOrgid,String selectedAccountid){
		String sql1 = "select lft,rgt from core_organization where sysid = (select parentid from core_organization where sysid = '"+selectedOrgid+"')";
		BasicMap<String,Object> one = userClient.findFirstData(new SQLAdapter(sql1));
		int lft = 0;
		int rgt = 0;
		if(one!=null){
			lft = NumberUtil.toInt(one.get("lft"));
			rgt = NumberUtil.toInt(one.get("rgt"));
		}
		String sqlstr = "select o.sysid as orgid,o.parentid,o.orgcode,o.orgname,ao.orgid as selectedOrgid,o.lvl "
					   +" from core_organization o "
					   +" left join core_account_organization ao on o.sysid = ao.orgid "
					   +" and ao.accountid = '"+selectedAccountid+"'"
					   +" where lvl >=3 and o.sysid <> '"+selectedOrgid+"' "
					   +" and lft >= "+lft+" and rgt<= " + rgt
					   + " order by orgcode asc";
		
		
		
		List<BasicMap<String,Object>> l = userClient.find(new SQLAdapter(sqlstr),new RowDataListener() {
			@Override
			public void processData(BasicMap<String, Object> rowData) {
				if(Util.isNotEmpty(rowData.get("selectedOrgid"))){
					rowData.put("selected", true);
				}
			}
		});
		return AppUtil.list2Tree(l, "parentid", "orgid",new AppUtil.List2Tree() {
			public boolean isFirstNode(BasicMap<String, Object> obj) {
				if(NumberUtil.toInt(obj.get("lvl"))==3){
					return true;
				}
				return false;
			}
		});
	}
	
	public void removeOrg(String orgid){
		String sqlstr1 = "delete from core_organization_role where orgid = ?";
		String sqlstr2 = "delete from core_account_role where accountid in (select accountid from core_account_organization where orgid = ?)";
		String sqlstr3 = "delete from core_account_bill where accountid in (select accountid from core_account_organization where orgid = ?)";
		String sqlstr4 = "delete from core_account_firstpage where accountid in (select accountid from core_account_organization where orgid = ?)";
		String sqlstr5 = "delete from core_account_workgroup where accountid in (select accountid from core_account_organization where orgid = ?)";
		String sqlstr6 = "delete from core_account_menu where accountid in (select accountid from core_account_organization where orgid = ?)";
		String sqlstr7 = "delete from core_shortcut where accountid in (select accountid from core_account_organization where orgid = ?)";
		
		String sqlstr10 = "delete from core_role where orgid = ?";
		String sqlstr11 = "delete from core_personnel where orgid = ?";
		
		
		userClient.updateSql(sqlstr1, orgid);
		userClient.updateSql(sqlstr2, orgid);
		userClient.updateSql(sqlstr3, orgid);
		userClient.updateSql(sqlstr4, orgid);
		userClient.updateSql(sqlstr5, orgid);
		userClient.updateSql(sqlstr6, orgid);
		userClient.updateSql(sqlstr7, orgid);
		
		userClient.updateSql(sqlstr10, orgid);
		userClient.updateSql(sqlstr11, orgid);
		
		
		final List<String> list = new ArrayList<>();
		userClient.find(new SQLAdapter("select accountid from core_account_organization where orgid = '"+orgid+"'"),new RowDataListener() {
			public void processData(BasicMap<String, Object> rowData) {
				list.add(StringUtil.toString(rowData.get("accountid")));
			}
		});
		
		String sqlstr8 = "delete from core_account_organization where orgid = ?";
		userClient.updateSql(sqlstr8, orgid);
		
		userClient.remove("core_account", new SqlDbFilter().in("sysid", list));
		////String sqlstr9 = "delete from core_account where sysid in (select accountid from core_account_organization where orgid = ?)";
		String sqlstr12 = "delete from core_organization where sysid = ?";
		userClient.updateSql(sqlstr12, orgid);
	}
	
	@Override
	public String upload(UploadObject uploadObject, String dir) throws AppException {
		List<BasicMap<String,Object>> orgs = ExcelUtil.parseOrgXls(uploadObject.getInputStream());
		List<BasicMap<String,Object>> roles = getRole(null);
		for(BasicMap<String,Object> o:orgs){
			__save(o,roles,null,true);
		}
		return "应用数据导入成功";
	}
}

