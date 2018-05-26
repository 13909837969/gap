package com.ehtsoft.im.services;


import javax.annotation.Resource;

import org.bson.Document;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.stereotype.Service;

import com.ehtsoft.fw.core.context.GlobalsName;
import com.ehtsoft.fw.core.db.MongoClient;
import com.ehtsoft.fw.core.dto.BasicMap;
import com.ehtsoft.fw.core.utils.ReflectUtil;
import com.ehtsoft.im.protocol.Location;
import com.mongodb.client.model.UpdateOptions;
/**
 * 缓存服务
 * @author wangbao
 * 考虑到集群的部署，不能采用 本地缓存，通过 mongodb 或 redio 进行数据的缓存
 * 用于计算当前的业务数据信息
 */
@Service
public class CacheService {

	@Resource(name="mongoClient")
	private MongoClient dbClient;
	private String cacheCollectionName = "cache_common_collection";
	/**
	 * 根据key获取当前缓存的数据
	 * @param key
	 * @return
	 */
	public BasicMap<String,Object> getCacheMap(String key){
		return dbClient.findOne(cacheCollectionName, Query.query(Criteria.where(GlobalsName.MONGO_PK_FIELD).is(key)));
	}
	/**
	 * 将数据 data 缓存到 可以 中
	 * @param key
	 * @param data
	 */
	public void putCacheMap(String key,BasicMap<String,Object> data){
		Document query = new Document();
		query.put(GlobalsName.MONGO_PK_FIELD, key);
		Document setObj = new Document(data);
		long time = System.currentTimeMillis();
		setObj.put("cts", time);
		setObj.put("uts", time);
		Document doc = new Document(MongoClient.SET,setObj);
		dbClient.getCollection(cacheCollectionName).updateOne(query,doc,new UpdateOptions().upsert(true));
	}
	/**
	 * 根据 aid 获取当前的位置
	 * @param aid
	 * @return
	 */
	public Location getCacheLocation(String aid){
		BasicMap<String,Object> one = dbClient.findOne(cacheCollectionName, Query.query(Criteria.where(GlobalsName.MONGO_PK_FIELD).is(aid)));
		if(one!=null){
			return ReflectUtil.map2Bean(one, Location.class);
		}
		return null;
	}
	/**
	 * 缓存当前的位置信息
	 * @param aid
	 * @param location
	 */
	public void putCacheLocation(String aid,Location location){
		Document query = new Document();
		query.put(GlobalsName.MONGO_PK_FIELD, aid);
		Document setObj = new Document(ReflectUtil.bean2Map(location));
		long time = System.currentTimeMillis();
		setObj.put("cts", time);
		setObj.put("uts", time);
		Document doc = new Document(MongoClient.SET,setObj);
		dbClient.getCollection(cacheCollectionName).updateOne(query, doc,new UpdateOptions().upsert(true));
	}
	
}
