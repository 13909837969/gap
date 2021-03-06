package com.ehtsoft.supervise.services;


import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ehtsoft.fw.core.db.SqlDbClient;
import com.ehtsoft.fw.core.dto.BasicMap;
import com.ehtsoft.fw.utils.NumberUtil;
import com.ehtsoft.supervise.api.SupConst;

@Service("InitOrgService")
public class InitOrgService {

	@Resource(name = "sqlDbClient")
	private SqlDbClient dbClient;
	
	public boolean hasOrgGis(String aid){
		boolean rtn = false;
		BasicMap<String,Object> one = dbClient.findOne("SELECT HASGIS FROM JC_SFXZJGJBXX WHERE ID = ?", aid);
		if(one!=null){
			rtn = NumberUtil.toInt(one.get("HASGIS"))==1;
		}
		return rtn;
	}
	
	/**
	 * 保存司法行政机构的信息
	 * @param data
	 */
	public void saveOrg(BasicMap<String,Object> data){
		data.put("HASGIS", 1);
		dbClient.update(SupConst.Collections.JC_SFXZJGJBXX, data);
	}
	
	public BasicMap<String,Object> findOne(String aid){
		return dbClient.findOne("SELECT * FROM JC_SFXZJGJBXX WHERE ID = ?", aid);
	}
}
