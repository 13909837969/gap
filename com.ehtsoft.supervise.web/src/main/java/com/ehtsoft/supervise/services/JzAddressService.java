package com.ehtsoft.supervise.services;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ehtsoft.common.services.SSOService;
import com.ehtsoft.fw.core.db.SQLAdapter;
import com.ehtsoft.fw.core.db.SqlDbClient;
import com.ehtsoft.fw.core.dto.BasicMap;
import com.ehtsoft.fw.core.services.AbstractService;
import com.ehtsoft.supervise.api.SupConst;
@Service("JzAddressService")
public class JzAddressService extends AbstractService{
	
	@Resource(name = "sqlDbClient")
	private SqlDbClient dbClient;
	
	@Resource(name="SSOService")
	private SSOService ssoService;
	
	/**
	 * 保存地址
	 * @param data
	 */
	public void save(BasicMap<String,Object> data) {
		dbClient.save(SupConst.Collections.JZ_JZRYJBXX_DZ, data);
	}
	
	/**
	 * 查看地址详情
	 * @param id
	 * @return
	 */
	public BasicMap<String,Object> findOne(String id){
		String sql="select * from JZ_JZRYJBXX_DZ where id='"+id+"'";
		SQLAdapter adapter=new SQLAdapter(sql);
	    BasicMap<String,Object> data=dbClient.findOne(adapter);
	    return data;
		
	}

}
