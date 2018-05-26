package com.ehtsoft.user.services;

import java.util.List;

import javax.annotation.Resource;

import com.ehtsoft.fw.core.db.RowDataListener;
import com.ehtsoft.fw.core.db.SQLAdapter;
import com.ehtsoft.fw.core.db.SqlDbClient;
import com.ehtsoft.fw.core.db.SqlDbFilter;
import com.ehtsoft.fw.core.dto.BasicMap;
import com.ehtsoft.fw.core.dto.Paginate;
import com.ehtsoft.fw.core.dto.ResultList;
import com.ehtsoft.fw.core.services.AbstractService;
import com.ehtsoft.fw.core.sso.SingleSignOnClient;
import com.ehtsoft.fw.core.sso.User;
import com.ehtsoft.fw.utils.StringUtil;
import com.ehtsoft.fw.utils.Util;
import com.ehtsoft.user.api.UserConst;
/**
 * 获取当前机构人员的数据接口（子机构中的人员没有考虑）
 * @author 王宝
 */
public class PersonnelService extends AbstractService{

	@Resource(name="sqlDbClient")
	private SqlDbClient client;
	
	@Resource
	private SingleSignOnClient sso;
	
	public List<BasicMap<String, Object>> find(){
		final User user = sso.getUser();
		return client.find(UserConst.Collections.CORE_PERSONNEL, new SqlDbFilter().eq("ORGID", user.getOrgid()),new RowDataListener() {
			@Override
			public void processData(BasicMap<String, Object> rowData) {
				if(Util.isNotEmpty(user.getUid()) && StringUtil.toEmptyString(rowData.get("SYSID")).equals(user.getUid())){
					rowData.put("current",true);
				}
			}
		});
	}
	
	/**
	 * 获取人员信息（通讯录信息）
	 * @param query
	 * @param paginate
	 * @return
	 * {
	 * 	rows:[{
	 *   uid:"人员ID",
	 *   orgid:"机构ID",
	 *   coding:"编码",
	 *   name:"名字",
	 *   sex:"性别",
	 *   post:"职务",
	 *   cardid:"身份证号码",
	 *   birthday:"出生日期",
	 *   telephone:"电话号码",
	 *   email:"Email",
	 *   orgcode:"机构编码",
	 *   orgname:"机构名称",
	 *   lvl:"机构类型  1,2,3  4 社区 5 学校 6 安全隐患主管部门"
	 *   }
	 *  ]
	 * }
	 */
	public ResultList<BasicMap<String, Object>> find(BasicMap<String,Object> query,Paginate paginate){
		String sqlstr = "select p.sysid as uid,orgid,coding,name,sex,"
						+ " post,cardid,birthday,telephone,email,"
						+ " orgcode,orgname,lvl,a.sysid as aid from core_personnel p "
						+ " inner join core_organization o "
						+ " on p.orgid = o.sysid "
						+ " inner join core_account a "
						+ " on p.sysid = a.userid";
		SQLAdapter sql = new SQLAdapter(sqlstr);
		sql.setFilter(toSqlFilter(query).asc("name"));
		return client.find(sql,paginate);
	}
	
	/**
	 * 机构的账户信息
	 * @param orgid  机构的ID
	 * @return
	 */
	public List<BasicMap<String,Object>> findAccounts(String orgid){
		String sqlstr ="select a.sysid,a.accountid,a.password,p.name,p.telephone,email from core_account a "
					 + " inner join core_personnel p on a.userid = p.sysid ";
		SQLAdapter sql = new SQLAdapter(sqlstr);
		sql.getFilter().eq("flag", 1).eq("p.orgid", orgid);
		return client.find(sql);
	}
}
