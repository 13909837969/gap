package com.ehtsoft.user.services;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import com.ehtsoft.fw.core.context.AppException;
import com.ehtsoft.fw.core.context.GlobalsName;
import com.ehtsoft.fw.core.db.RowDataListener;
import com.ehtsoft.fw.core.db.SQLAdapter;
import com.ehtsoft.fw.core.db.SaveOperation;
import com.ehtsoft.fw.core.db.SqlDbFilter;
import com.ehtsoft.fw.core.dto.BasicMap;
import com.ehtsoft.fw.core.dto.Paginate;
import com.ehtsoft.fw.core.dto.ResultList;
import com.ehtsoft.fw.core.services.SqlBasicService;
import com.ehtsoft.fw.core.sso.SingleSignOnClient;
import com.ehtsoft.fw.core.sso.User;
import com.ehtsoft.fw.core.utils.AppUtil;
import com.ehtsoft.fw.core.utils.EncryptUtil;
import com.ehtsoft.fw.utils.StringUtil;
import com.ehtsoft.fw.utils.Util;
import com.ehtsoft.user.api.UserConst;


/**
 * 应用管理
 * @author 王宝
 */
public class OsaOrganizationService extends SqlBasicService {
	
	@Resource
	private SingleSignOnClient ssoClient;
	
	@Resource
	private UserSynchronizeService userSynchronizeService;
	/**
	 * 查找组织机构tree数据
	 * @return
	 * @throws AppException
	 * 
	 * 机构用户管理，左侧机构 tree 使用
	 */
	public List<BasicMap<String,Object>> findOrg() throws AppException{
		List<BasicMap<String,Object>> rtn = null;
		final User user = ssoClient.getUser();
		if(user.isPsa()){			
			rtn = find(UserConst.Collections.CORE_ORGANIZATION,null);
			return AppUtil.list2Tree(rtn, "parentid", "sysid");
		}else{
			rtn = this.sqlDbClient.find(UserConst.Collections.CORE_ORGANIZATION,new SqlDbFilter().rLike("orgcode", user.getOrgcode()));
			return AppUtil.list2Tree(rtn, "parentid", "sysid",new AppUtil.List2Tree() {
				public boolean isFirstNode(BasicMap<String, Object> obj) {
					if(obj.get("orgcode").equals(user.getOrgcode())){
						return true;
					}
					return false;
				}
			});
		}
	}
	
	/**
	 * 获取当前用户（机构管理员）所能查看的机构细心
	 */
	public List<BasicMap<String,Object>> findOrgs(String accountid){
		User user = ssoClient.getUser();
		String sqlstr = "select o.sysid as orgid,o.parentid,o.orgcode,o.orgname,ao.orgid as selectedOrgid,o.lvl from core_organization o"
						+ " left join core_account_organization ao on o.sysid = ao.orgid and ao.accountid = '"+accountid+"'"
						+ " where  o.sysid in ("
						+ " select orgid from core_account_organization where ACCOUNTID = '"+user.getAid()+"' AND DEFAULTORG = 0"
						+ ")";
		List<BasicMap<String,Object>> rtn = new ArrayList<BasicMap<String,Object>>();
		BasicMap<String,Object> child = new BasicMap<String,Object>();
		rtn.add(child);
		child.put("orgid", null);
		child.put("orgname", "设置查看机构权限");
		child.put("children",this.sqlDbClient.find(new SQLAdapter(sqlstr),new RowDataListener() {
			public void processData(BasicMap<String, Object> rowData) {
				if(Util.isNotEmpty(rowData.get("selectedOrgid"))){
					rowData.put("selected", true);
				}
			}
		}));
		return rtn;
	}
	/**
	 *  查找 人员信息表数据
	 * @return
	 * @throws AppException
	 */
	public ResultList<BasicMap<String,Object>> findPer(BasicMap<String,Object> query,Paginate paginate) throws AppException{
		User user = ssoClient.getUser();
		//医疗机构管理员
		if(!user.isPsa()){
			if(Util.isEmpty(query.get("B.ORGID[eq]"))){
				query.put("B.ORGID[eq]", user.getOrgid());
			}
		}
		String sqlstr = "SELECT B.*,O.ORGNAME from CORE_PERSONNEL B INNER JOIN CORE_ORGANIZATION O ON B.ORGID = O.SYSID";
		SQLAdapter sql = new SQLAdapter(sqlstr);
		sql.setFilter(toSqlFilter(query).asc("B.CTS"));
		return this.sqlDbClient.find(sql,paginate);
	}
	
	
	/**
	 *  查找 账户信息表数据
	 * @return
	 * @throws AppException
	 */
	public ResultList<BasicMap<String,Object>> findAcc(BasicMap<String,Object> query,Paginate paginate) throws AppException{
		SQLAdapter sql = new SQLAdapter("SELECT A.*,B.ORGID,C.ORGNAME,P.NAME FROM CORE_ACCOUNT A " +
				"INNER JOIN CORE_ACCOUNT_ORGANIZATION B ON A.SYSID = B.ACCOUNTID " +
				"INNER JOIN CORE_ORGANIZATION C ON C.SYSID = B.ORGID " +
				"LEFT JOIN CORE_PERSONNEL P ON P.SYSID = A.USERID");
		User user = ssoClient.getUser();
		if(!user.isPsa()){
			if(Util.isEmpty(query.get("B.ORGID[eq]"))){
				query.put("B.ORGID[eq]", user.getOrgid());
			}
			sql.setFilter(this.toSqlFilter(query).asc("A.CTS"));
		}else{
			sql.setFilter(this.toSqlFilter(query));
		}
		return this.sqlDbClient.find(sql, paginate,new RowDataListener() {
			public void processData(BasicMap<String, Object> rowData) {
				rowData.remove("password");
			}
		});
	}
	
	/**
	 * 初始账户信息（已经初始化完成的账户信息不能被初始化，防止已经修改的密码被初始化)
	 */
	public void initAccount(final List<BasicMap<String,Object>> data) throws AppException{
		List<String> accs = new ArrayList<String>();
		for(BasicMap<String,Object> b : data){
			String accountid = StringUtil.toString(b.remove("coding"));
			accs.add(accountid);
			b.put("ACCOUNTID", accountid);
			b.put("USERID", b.get("SYSID"));
			String psw = EncryptUtil.md5("000000");
			b.put("PASSWORD",psw);//初始密码  000000
			b.put("FLAG",1);
			//// b.remove("SYSID"); 初始化的时候  personnel.sysid = account.sysid
		}
		this.sqlDbClient.find(UserConst.Collections.CORE_ACCOUNT,new SqlDbFilter().in("ACCOUNTID", accs),new RowDataListener() {
			public void processData(BasicMap<String, Object> rowData) {
				for(BasicMap<String,Object> d : data){
					if(rowData.get("ACCOUNTID").equals(d.get("ACCOUNTID"))){
						d.put("SYSID", rowData.get("SYSID"));
					}
				}
			}
		});
		saveAcc(data);
	}
	
	/**
	 * 保存编辑组织机构
	 * @param data
	 * @throws AppException
	 */
	public void saveOrg(BasicMap<String,Object> data) throws AppException{
		/*
		//新增数据时
		if(data.get("SYSID")==null){
			Integer baseValue = 0;
			if(data.containsKey("parentid")){
				BasicMap<String,Object> map = sqlDbClient.findOne(UserConst.Collections.CORE_ORGANIZATION,new SqlDbFilter().eq("SYSID", data.get("parentid")));
				if(map!=null && map.get("RGT")!=null){
					baseValue = AppUtil.toInteger(map.get("RGT"));
					data.put("LFT", baseValue);
					data.put("RGT", baseValue+1);
				}else{
					data.put("LFT", 1);
					data.put("RGT", 2);
				}
			}else{
				String sqlstr = "SELECT COUNT(SYSID) count,MAX(RGT) maxrgt FROM CORE_ORGANIZATION WHERE PARENTID IS NULL";
				BasicMap<String,Object> map = sqlDbClient.findOne(new SQLAdapter(sqlstr));
				if(map==null){
					data.put("LFT", 1);
					data.put("RGT", 2);
				}else{
					if(AppUtil.toInteger(map.get("count"))>0){
						if(map.get("maxrgt")==null){
							data.put("LFT", 1);
							data.put("RGT", 2);
						}else{
							baseValue = AppUtil.toInteger(map.get("maxrgt")) + 1;
							data.put("LFT", baseValue);//右的最大值放到 平级节点的 left 中
							data.put("RGT", baseValue+1);
							
						}
					}
				}
			}
			if(baseValue!=0){
				sqlDbClient.update("UPDATE CORE_ORGANIZATION SET LFT=LFT+2  WHERE LFT >= ?",baseValue);
				sqlDbClient.update("UPDATE CORE_ORGANIZATION SET RGT=RGT+2  WHERE RGT >= ?",baseValue);		
			}
		}
		*/
		data.remove("LFT");
		data.remove("RGT");
		super.save(UserConst.Collections.CORE_ORGANIZATION, data);
	}
	
	/**保存人员信息
	 * save 
	 * @param data
	 * @throws AppException
	 */
	public void savePer(List<BasicMap<String,Object>> data) throws AppException{
		final List<String> ids = new ArrayList<String>();
		sqlDbClient.save(UserConst.Collections.CORE_PERSONNEL, data,new SaveOperation() {
			public void saveBefore(BasicMap<String, Object> data) {
			}
			public void saveAfter(BasicMap<String, Object> data) {
				ids.add(StringUtil.toString(data.get("sysid")));
			}
		});
		//用户信息同步接口
		userSynchronizeService.synchronize(ids);
	}
	/**保存账户信息
	 * save 
	 * @param data
	 * @throws AppException
	 */
	public void saveAcc(List<BasicMap<String,Object>> data) throws AppException{
		final User cuser = ssoClient.getUser();
		final List<String> ids = new ArrayList<String>();
		sqlDbClient.save(UserConst.Collections.CORE_ACCOUNT, data,new SaveOperation() {
			public void saveBefore(BasicMap<String, Object> data) {
			}
			public void saveAfter(BasicMap<String, Object> data) {
				ids.add(StringUtil.toString(data.get("USERID")));
			}
		});
		
		//定义一个List对象 接受数据  区循环保存的data属性 
		List<BasicMap<String,Object>> accorgs = new ArrayList<BasicMap<String,Object>>();
		for(BasicMap<String,Object> bm : data){
			BasicMap<String,Object> accorg = new BasicMap<String,Object>();
			accorg.put("ACCOUNTID", bm.get(GlobalsName.SQLDB_PK_FIELD));
			accorg.put("ORGID",bm.get("ORGID"));
			accorg.put("DEFAULTORG",1);
			accorgs.add(accorg);
			
			SqlDbFilter filter = new SqlDbFilter();
			filter.eq("ACCOUNTID",bm.get(GlobalsName.SQLDB_PK_FIELD));
			filter.eq("DEFAULTORG", 1);
			sqlDbClient.remove(UserConst.Collections.CORE_ACCOUNT_ORGANIZATION, filter);
		}
		
		super.save(UserConst.Collections.CORE_ACCOUNT_ORGANIZATION, accorgs);
		//用户信息同步接口
		userSynchronizeService.synchronize(ids);
		
	}
	
	/**删除人员信息
	 * save 
	 * @param data
	 * @return 
	 * @throws AppException
	 */
	public void removePer(List<BasicMap<String, Object>> data) throws AppException{
		/**
		 * 更加  人员的 sysid 查 core_account.userid，如果有数据，就不能删除，提示"数据已经被使用，不能删除" 
		 */
		List<String> sysids = new ArrayList<String>();
		for(BasicMap<String,Object> bm : data){
			sysids.add(StringUtil.toString(bm.get("sysid")));
		}
		SqlDbFilter filter = new SqlDbFilter();
		filter.in("userid", sysids);
		List<BasicMap<String, Object>> lb=sqlDbClient.find(UserConst.Collections.CORE_ACCOUNT, filter);
		String rs=null;
		if(lb!=null && !lb.isEmpty()){
			 rs="数据已经被使用，不能删除";
			 throw new AppException(rs);
		}else{
			remove(UserConst.Collections.CORE_PERSONNEL, data);
		}
	}
	
	/**删除账户信息
	 * save 
	 * @param data
	 * @throws AppException
	 */
	public void removeAcc(List<BasicMap<String, Object>> data) throws AppException{
		List<String> sysids = new ArrayList<String>();
		//定义一个List对象 接受数据  区循环保存的data属性 
		for(BasicMap<String,Object> bm : data){
			sysids.add(StringUtil.toString(bm.get("sysid")));
		}
		SqlDbFilter filter = new SqlDbFilter();
		filter.in("accountid", sysids);
		sqlDbClient.remove(UserConst.Collections.CORE_ACCOUNT_ORGANIZATION, filter);
		
		remove(UserConst.Collections.CORE_ACCOUNT, data);
	}
	
	/**
	 * @param data
	 * {
	 *  SYSID:CORE_ACCOUNTID, NUMBER
	 *  BINDID:"第三方系统对照用户id"
	 * }
	 * @throws AppException
	 */
	@Deprecated
	public void updateAccount(List<BasicMap<String,Object>> data) throws AppException{
		sqlDbClient.update(UserConst.Collections.CORE_ACCOUNT, data);
	}
}

