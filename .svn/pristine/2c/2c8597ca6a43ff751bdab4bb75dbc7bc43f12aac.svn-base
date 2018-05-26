package com.ehtsoft.user.services;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import com.ehtsoft.fw.core.db.RowDataListener;
import com.ehtsoft.fw.core.db.SqlDbClient;
import com.ehtsoft.fw.core.db.SqlDbFilter;
import com.ehtsoft.fw.core.dto.BasicMap;
import com.ehtsoft.fw.core.sso.SingleSignOnClient;
import com.ehtsoft.fw.utils.NumberUtil;
import com.ehtsoft.fw.utils.StringUtil;
import com.ehtsoft.user.api.IOrganizationSynchronize;
import com.ehtsoft.user.api.UserConst;
import com.ehtsoft.user.dto.Organization;

/**
 * 组织机构同步服务
 * @author wangbao
 */
public class OrganizationSynchronizeService {

	@Resource
	private SingleSignOnClient sso;

	@Resource(name = "sqlDbClient")
	private SqlDbClient dbClient;

	private IOrganizationSynchronize organizationSynchronize;

	/**
	 * <b>uids 为 core_organization.sysid 值数组</b>
	 * @param uids
	 */
	public void synchronize(List<String> orgids) {
		if(organizationSynchronize!=null && orgids!=null && !orgids.isEmpty()){
			final List<Organization> orgs = new ArrayList<>();
			dbClient.find(UserConst.Collections.CORE_ORGANIZATION,new SqlDbFilter().in("SYSID", orgids),new RowDataListener() {
				public void processData(BasicMap<String, Object> rowData) {
					Organization o = new Organization();
					o.setOrgid(StringUtil.toString(rowData.get("SYSID")));
					o.setParentid(StringUtil.toString(rowData.get("PARENTID")));
					o.setOrgcode(StringUtil.toString(rowData.get("ORGCODE")));
					o.setOrgname(StringUtil.toString(rowData.get("ORGNAME")));
					o.setRegioncode(StringUtil.toString(rowData.get("REGIONCODE")));
					o.setFlag(NumberUtil.toInteger(rowData.get("FLAG")));
					o.setLvl(NumberUtil.toInteger(rowData.get("LVL")));
					o.setAccid(StringUtil.toString(rowData.get("ACCID")));
					o.setAccpw(StringUtil.toString(rowData.get("ACCPW")));
					orgs.add(o);
				}
			});
			organizationSynchronize.synchronize(orgs);
		}
	}

	
	public void setOrganizationSynchronize(IOrganizationSynchronize organizationSynchronize) {
		this.organizationSynchronize = organizationSynchronize;
	}
	
	
}
