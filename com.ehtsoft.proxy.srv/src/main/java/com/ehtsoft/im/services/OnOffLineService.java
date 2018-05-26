/**
 * @Description TODO(用一句话描述该文件是做什么功能的，哪个地方使用的，android 还是 jsp 用)
 * @author wangbao
 * @date 2018年5月2日
 */
package com.ehtsoft.im.services;

import java.util.Date;
import java.util.concurrent.Executor;
import java.util.concurrent.Executors;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ehtsoft.im.services.CacheService;
import com.ehtsoft.fw.core.context.GlobalsName;
import com.ehtsoft.fw.core.db.MongoClient;
import com.ehtsoft.fw.core.db.SqlDbClient;
import com.ehtsoft.fw.core.dto.BasicMap;
import com.ehtsoft.fw.utils.DateUtil;
import com.ehtsoft.fw.utils.NumberUtil;
import com.ehtsoft.im.api.ImConst;
import com.ehtsoft.im.api.OnConnectionNotify;
import com.ehtsoft.im.protocol.Location;

/**
 * @Description TODO(用一句话描述该文件是做什么功能的，哪个地方使用的)
 * @author wangbao
 * @date 2018年5月2日
 *
 */
@Service
public class OnOffLineService {
	
	@Resource(name="sqlDbClient")
	private SqlDbClient dbClient;
	
	@Resource(name="mongoClient")
	private MongoClient mongoClient;
	
	@Resource
	private CacheService cacheService;
	
	//消息推送服务
	@Resource
	private BroadcastService broadcastService;
	
	@Resource
	private UpdateStatusService updateStatusService;
	
	private static Executor executor = Executors.newFixedThreadPool(800);
	
	@PostConstruct  //只执行一次的处理
	public void init(){
		
		//添加连接连接通知事件
		broadcastService.setOnConnectionNotify(new OnConnectionNotify() {
			@Override
			public void onlineNotify(String aid) {
				executor.execute(new Runnable() {
					@Override
					public void run() {
						try {
							System.out.println(" =============== onlineNotify ===== " + aid);
							//获取 报到采集指纹等信息记录人员信息列表
							BasicMap<String, Object> aidData = dbClient.findOne("select f_id from jz_collect_user where f_id = ?", aid);
							if(aidData==null){
								return;
							}
							//在线
							Location loc = cacheService.getCacheLocation(aid);
							BasicMap<String,Object> m = new BasicMap<String,Object>();
							// pk 和 aid 相等
							m.put(GlobalsName.MONGO_PK_FIELD, aid);
							//1 表示有经纬度的  0 没有经纬度
							m.put("flag", 0);
							//在线通知
							if(loc != null){
								loc.setOnline(true);
								//发送矫正人员的位置
								broadcastService.sendLocation(loc);
								if(NumberUtil.toInt(loc.getLat())!=0 && NumberUtil.toInt(loc.getLng())!=0){
									m.put("lat", loc.getLat());
									m.put("lng", loc.getLng());
									m.put("flag", 1);
								}
							}
							m.put("online",true);
							m.put("udate", NumberUtil.toInt(DateUtil.format(new Date(), "yyyyMMdd")));
							
							BasicMap<String, Object> ui = updateStatusService.findUserinfo(aid);
							if(ui!=null){
								m.put("name", ui.get("F_NICKNAME"));
								m.put("gender", ui.get("F_GENDER"));
							}
							
							//更新最新位置
							mongoClient.save(ImConst.Collections.IM_CURRENT_LOCATION, m);
							
							//1:在线
							updateStatusService.updateOnlineStatus(aid, "1");
						}catch(Exception ex) {}
					}
				});
			}
			@Override
			public void offlineNotify(String aid) {
				executor.execute(new Runnable() {
					@Override
					public void run() {
						try {
							System.out.println(" =============== offlineNotify ===== " + aid);
							BasicMap<String, Object> aidData = dbClient.findOne("select f_id from jz_collect_user where f_id = ?", aid);
							if(aidData==null){
								return;
							}
							//离线通知
							Location loc = cacheService.getCacheLocation(aid);
			
							BasicMap<String,Object> m = new BasicMap<String,Object>();
							// pk 和 aid 相等
							m.put(GlobalsName.MONGO_PK_FIELD, aid);
							//1 表示有经纬度的  0 没有经纬度
							m.put("flag", 0);
							//离线通知
							if(loc != null){
								loc.setOnline(false);
								broadcastService.sendLocation(loc);
								if(NumberUtil.toInt(loc.getLat())!=0 && NumberUtil.toInt(loc.getLng())!=0){
									m.put("lat", loc.getLat());
									m.put("lng", loc.getLng());
									m.put("flag", 1);
								}
							}
							m.put("online",false);
							m.put("udate", NumberUtil.toInt(DateUtil.format(new Date(), "yyyyMMdd")));
							//更新最新位置
							mongoClient.save(ImConst.Collections.IM_CURRENT_LOCATION, m);
							//0:不在线 
							updateStatusService.updateOnlineStatus(aid, "0");
						}catch(Exception ex) {}
					}
				});
			}
		});
	}

}
