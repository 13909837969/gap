package com.ehtsoft.im.services;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ehtsoft.fw.core.db.SqlDbClient;
import com.ehtsoft.fw.core.dto.BasicMap;

/**
 * @Description 更新状态服务
 * @author wangbao
 * @date 2018年5月2日
 *
 */
@Service("UpdateStatusService")
public class UpdateStatusService {

	@Resource(name="sqlDbClient")
	private SqlDbClient dbClient;
	
	public BasicMap<String, Object> findUserinfo(String aid){
		BasicMap<String,Object> one = dbClient.findOne("SELECT * FROM IM_USERINFO WHERE F_AID = ?", aid);
		return one;
	}
	
	public void updateOnlineStatus(String aid,String online){
		dbClient.getInterceptor().setSkipSso(true);
		dbClient.update("JZ_JZRYJBXX", new BasicMap<String,Object>("ID",aid,"ONLINE",online));
		dbClient.getInterceptor().setSkipSso(false);
	}
}
