package com.ehtsoft.supervise.services;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ehtsoft.fw.core.db.MongoClient;
import com.ehtsoft.fw.core.db.SqlDbClient;
import com.ehtsoft.fw.core.db.SqlDbFilter;
import com.ehtsoft.fw.core.dto.BasicMap;
import com.ehtsoft.fw.core.services.AbstractService;
import com.ehtsoft.fw.utils.DateUtil;
import com.ehtsoft.supervise.api.SupConst;

/**
 * 法律文书
 * @创建人  ：dd
 * @创建时间：2017年11月23日 下午20:41
 * @修改人  ：dd
 * @修改时间：
 * @修改备注：
 *
 * @version 1.0
 */

@Service("JzFlwsService")
public class JzFlwsService  extends AbstractService{

	@Resource(name = "sqlDbClient")
	private SqlDbClient dbClient;
	
	
	@Resource(name="mongoClient")
	private MongoClient mongoClient;
	
	
	
	/**
	 * 矫正人员个人基本信息表
	 * 根据	矫正人员ID获取矫正人员个人基本信息表中和法律文书相关的信息
	 * 		
	 * @param id
	 * @return
	 */
	public BasicMap<String, Object> findOne(String id){
		String sqlstr = "select * from JZ_JZRYJBXX where id=?";//sql
		BasicMap<String, Object> basicMap = dbClient.findOne(sqlstr, id);//根据ID获取个人基本信息
		
		if(basicMap!=null){//限定时间格式为：“yyyy-MM-dd”
			//个人基本信息表
			basicMap.put("jfzxrq",  DateUtil.format(basicMap.get("jfzxrq"),"yyyy-MM-dd"));
			basicMap.put("zxtzsrq",  DateUtil.format(basicMap.get("zxtzsrq"),"yyyy-MM-dd"));
		}
		return basicMap;
	}
	
}
