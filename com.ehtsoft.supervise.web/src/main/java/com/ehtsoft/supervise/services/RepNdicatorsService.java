package com.ehtsoft.supervise.services;

import java.text.SimpleDateFormat;
import java.util.Date;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ehtsoft.common.services.AuditService;
import com.ehtsoft.common.services.SSOService;
import com.ehtsoft.fw.core.db.SqlDbClient;
import com.ehtsoft.fw.core.dto.BasicMap;
import com.ehtsoft.fw.core.services.AbstractService;
import com.ehtsoft.fw.core.sso.SingleSignOnClient;
import com.ehtsoft.fw.core.sso.User;
import com.ehtsoft.fw.utils.DateUtil;
import com.ehtsoft.fw.utils.NumberUtil;

/**
 * 管理指标报表服务
 * @author wangbao
 */
@Service("RepNdicatorsService")
public class RepNdicatorsService extends AbstractService{

	@Resource(name = "sqlDbClient")
	private SqlDbClient dbClient;
	
	@Resource
	private SingleSignOnClient sso;
	
	@Resource
	private AuditService auditService;
	/**
	 * 平板地图监控上方的  在线人数/报到总人数，当日签到人数，报警数量，审核数量（以后添加）
	 * <br>
	 * android 平板上的指标
	 */
	public BasicMap<String,Object> findMapNdicator(){
		User user = sso.getUser();
		String orgid = user.getOrgid();
		BasicMap<String, Object> data = new BasicMap<>();
		String date = DateUtil.format(new Date(), "yyyyMMdd");
		
		String alarm_sql = "select count(1) as alarm from REP_ALARM where f_solve = 0 and orgid = '"+orgid+"'" ;//当日报警数量
		String checkin_sql = "select count(AID) as checkin from REP_QDXXB where udate="+date + " and orgid = '"+orgid+"'" ;//当日已签到人数 AID,udate
		String total_sql = "select count(1) as total from JZ_JZRYJBXX where JCJZ = '0' and SFJS = '1' and orgid = '"+orgid+"'";//报道总人数
		String online_sql = "select count(1) as online from JZ_JZRYJBXX where online = '1' and orgid = '"+orgid+"'";//在线人数
		
		data.putAll(dbClient.findOne(alarm_sql));
		data.putAll(dbClient.findOne(checkin_sql));
		data.putAll(dbClient.findOne(total_sql));
		data.putAll(dbClient.findOne(online_sql));
		data.put("auditCount",auditService.getUnauditedCount());
		
		return data;
	}
}
