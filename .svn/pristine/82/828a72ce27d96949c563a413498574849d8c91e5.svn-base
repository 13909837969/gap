package com.ehtsoft.user.plugin.services;

import java.util.List;

import javax.annotation.Resource;

import com.ehtsoft.fw.core.db.SqlDbClient;
import com.ehtsoft.fw.core.dto.BasicMap;
import com.ehtsoft.user.api.IOrganizationSynchronize;
import com.ehtsoft.user.dto.Organization;

/**
 * 组织机构数据同步
 * @author wangbao
 */
public class SuperviseOrgSyncService implements IOrganizationSynchronize {

	@Resource(name="supSqlDbClient")
	private SqlDbClient dbClient;
	
	@Override
	public void synchronize(List<Organization> orgs) {
		for(Organization o : orgs){
			BasicMap<String,Object> data = new BasicMap<>();
			data.put("ID", o.getOrgid());
			data.put("PARENTID", o.getParentid());
			data.put("JGBM", o.getOrgcode());
			data.put("JGMC", o.getOrgname());
			data.put("REGIONID", o.getRegioncode());
			//司法行政机关（单位）基本信息采集表
			dbClient.save("JC_SFXZJGJBXX", data);
			
			/**
			 * im_userinfo;
               im_group;
			 */
			data = new BasicMap<>();
			data.put("F_AID", o.getOrgid());
			data.put("F_CODE", o.getOrgcode()); //编码
			data.put("F_NICKNAME", o.getOrgname());
			data.put("F_PASSWORD", o.getAccpw());
			data.put("F_DISABLE", 0);
			// 0 矫正人员  1 工作人员 	2 机构
			data.put("F_FLAG", 2);
			dbClient.save("IM_USERINFO", data);
			
			data.put("F_GID", o.getOrgid());
			data.put("F_NAME", o.getOrgname());
			data.put("F_TYPE", o.getLvl());
			data.put("ORGID", o.getOrgid());
			dbClient.save("IM_GROUP", data);
		}
	}

}
