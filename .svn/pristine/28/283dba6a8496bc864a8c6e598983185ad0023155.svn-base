package com.ehtsoft.common.services;

import java.util.List;

import javax.annotation.Resource;

import org.bson.Document;
import org.springframework.stereotype.Service;

import com.ehtsoft.fw.core.db.MongoClient;
import com.ehtsoft.fw.core.dto.BasicMap;
import com.ehtsoft.fw.core.dto.Paginate;
import com.ehtsoft.fw.core.services.AbstractService;
import com.ehtsoft.fw.utils.Util;
import com.mongodb.client.MongoCollection;

/**
 * 
 * pad、android 报错日志
 * @author Administrator
 * @date 2018年4月8日
 *
 */
@Service("LogService")
public class LogService extends AbstractService {
	
	@Resource(name="mongoClient")
	private MongoClient mongoClient;

	/**
	 * 
	 * 保存方法
	 * @param data<br>
	 * 返回值格式: void
	 *
	 * @author Administrator
	 * @date   2018年4月8日
	 * 方法的作用：TODO
	 */
	public void save(BasicMap<String,Object> data) {
		System.out.println("====================log_error start==========================");
		System.out.println(data);
		System.out.println("====================log_error end==============================");
		mongoClient.save("log_error", data);
	}
}
