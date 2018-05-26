package com.ehtsoft.user.services;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import com.ehtsoft.fw.core.db.RowDataListener;
import com.ehtsoft.fw.core.db.SQLAdapter;
import com.ehtsoft.fw.core.db.SqlDbClient;
import com.ehtsoft.fw.core.dto.BasicMap;
import com.ehtsoft.fw.core.sso.SingleSignOnClient;
import com.ehtsoft.fw.utils.NumberUtil;
import com.ehtsoft.fw.utils.StringUtil;
import com.ehtsoft.user.api.IUserSynchronize;
import com.ehtsoft.user.dto.Personnel;

/**
 * 用户信息同步服务
 * @author wangbao
 */
public class UserSynchronizeService {

	@Resource
	private SingleSignOnClient sso;

	@Resource(name = "sqlDbClient")
	private SqlDbClient dbClient;

	private IUserSynchronize userSynchronize;

	/**
	 * <b>uids 为 core_personnel.sysid 值数组</b>
	 * @param uids
	 */
	public void synchronize(List<String> uids) {
		if (userSynchronize != null && uids!=null && !uids.isEmpty()) {
			String sqlstr = "select a.sysid as aid,a.accountid,a.password,a.nickname,"
							+" p.sysid as uid,p.name,p.coding,p.sex as gender,p.post,p.cardid,"
							+" p.birthday,p.telephone as mobile,email,p.orgid,"
							+" o.orgcode,o.orgname,o.regioncode,o.lvl as orgtype "
							+" from core_account a "
							+" inner join core_personnel p on a.userid = p.sysid "
							+" inner join core_organization o on o.sysid = p.orgid "
							+" inner join core_account_organization ao on a.sysid = ao.accountid and p.orgid = ao.orgid and defaultorg = 1";
			SQLAdapter sql = new SQLAdapter(sqlstr);
			sql.getFilter().in("p.sysid", uids);
			final List<Personnel> personnels = new ArrayList<Personnel>();
			dbClient.find(sql, new RowDataListener() {
				@Override
				public void processData(BasicMap<String, Object> rowData) {
					Personnel per = new Personnel();
					per.setAid(StringUtil.toString(rowData.get("aid")));
					per.setAccountid(StringUtil.toString(rowData.get("accountid")));
					per.setNickname(StringUtil.toString(rowData.get("nickname")));
					per.setPassword(StringUtil.toString(rowData.get("password")));
					per.setCode(StringUtil.toString(rowData.get("coding")));
					per.setOrgid(StringUtil.toString(rowData.get("orgid")));
					
					per.setOrgcode(StringUtil.toString(rowData.get("orgcode")));
					per.setRegioncode(StringUtil.toString(rowData.get("regioncode")));
					per.setOrgname(StringUtil.toString(rowData.get("orgname")));
					per.setOrgType(NumberUtil.toInteger(rowData.get("orgtype")));
					per.setUid(StringUtil.toString(rowData.get("uid")));
					per.setName(StringUtil.toString(rowData.get("name")));
					per.setGender(StringUtil.toString(rowData.get("gender")));
					per.setPost(StringUtil.toString(rowData.get("post")));
					per.setCardid(StringUtil.toString(rowData.get("cardid")));
					per.setBirthday(StringUtil.toString(rowData.get("birthday")));
					per.setMobile(StringUtil.toString(rowData.get("mobile")));
					per.setEmail(StringUtil.toString(rowData.get("email")));
					personnels.add(per);
				}
			});
			if (personnels.size() > 0) {
				userSynchronize.synchronize(personnels);
			}
		}
	}

	public void setUserSynchronize(IUserSynchronize userSynchronize) {
		this.userSynchronize = userSynchronize;
	}
		
}
