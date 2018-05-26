/**
 * @Description TODO(用一句话描述该文件是做什么功能的，哪个地方使用的，android 还是 jsp 用)
 * @author wangbao
 * @date 2018年5月11日
 */
package com.ehtsoft.common.services;

import javax.annotation.Resource;

import com.ehtsoft.fw.core.db.MongoClient;
import com.ehtsoft.fw.core.db.SqlDbClient;
import com.ehtsoft.supervise.services.SqjzYwjgSjbbService;

/**
 * 
 * @author wlbrs
 *
 */
public class UPdateService {
	
	@Resource(name="sqlDbClient")
	private SqlDbClient dbClient;
	
	@Resource(name="mongoClient")
	private MongoClient mongoClient;
	
	@Resource(name = "SqjzYwjgSjbbService")
	private  SqjzYwjgSjbbService sqjzYwjgSjbbService;
	
	/**
	 * 每晚12点更新
	 * 工作监管设计报表
	 */
	public void updateGzjgsjbb(){
		//每天晚上12点计算增量入库
		sqjzYwjgSjbbService.saveIncrement();
		
	}
}
