package com.ehtsoft.supervise.services;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ehtsoft.common.services.SSOService;
import com.ehtsoft.fw.core.db.SQLAdapter;
import com.ehtsoft.fw.core.db.SqlDbClient;
import com.ehtsoft.fw.core.dto.BasicMap;
import com.ehtsoft.fw.core.services.AbstractService;
import com.ehtsoft.fw.core.sso.User;
import com.ehtsoft.supervise.api.SupConst;

@Service("SfsYwyfService")
public class SfsYwyfService extends AbstractService{

	@Resource(name = "sqlDbClient")
	private SqlDbClient dbClient;
	@Resource(name="SSOService")
	private SSOService service;
	
	/**
	 * 保存司法所业务用房信息
	 * @param data
	 */
	public void save(BasicMap<String,Object> data) {
		User user=service.getUser();
		String orgid=user.getOrgid();
		String orgidcode=user.getOrgcode();
		data.put("id", orgid);
		data.put("SFSBM", orgidcode);
		dbClient.save(SupConst.Collections.SFS_SFSYWYFXXB, data);
	}
	
	/**
	 * 司法所业务用房信息
	 * @param id
	 * @return
	 */
    public BasicMap<String,Object> findOne(String id){
	   User user=service.getUser();
	   String orgid=user.getOrgid();
	   String sql="select * from SFS_SFSYWYFXXB where id='"+orgid+"'";
	   SQLAdapter aapter=new SQLAdapter(sql);
	   BasicMap<String,Object> data = dbClient.findOne(aapter);
	   return data;
	   
    }
}
