package com.ehtsoft.im.services;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.LinkedBlockingQueue;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.bson.Document;
import org.bson.types.ObjectId;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.CriteriaDefinition;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.stereotype.Service;

import com.ehtsoft.common.services.CacheService;
import com.ehtsoft.common.services.SSOService;
import com.ehtsoft.fw.core.context.AppContext;
import com.ehtsoft.fw.core.context.GlobalsName;
import com.ehtsoft.fw.core.db.MongoClient;
import com.ehtsoft.fw.core.db.RowDataListener;
import com.ehtsoft.fw.core.db.SQLAdapter;
import com.ehtsoft.fw.core.db.SqlDbClient;
import com.ehtsoft.fw.core.dto.BasicMap;
import com.ehtsoft.fw.core.dto.Paginate;
import com.ehtsoft.fw.core.services.AbstractService;
import com.ehtsoft.fw.core.sso.User;
import com.ehtsoft.fw.core.utils.ReflectUtil;
import com.ehtsoft.fw.core.utils.script.MongoScriptUtil;
import com.ehtsoft.fw.utils.DateUtil;
import com.ehtsoft.fw.utils.NumberUtil;
import com.ehtsoft.fw.utils.StringUtil;
import com.ehtsoft.fw.utils.Util;
import com.ehtsoft.im.api.ImConst;
import com.ehtsoft.im.protocol.Location;
import com.ehtsoft.supervise.api.SupConst;
import com.ehtsoft.supervise.services.JzJzryjbxxService;
import com.ehtsoft.supervise.services.SysJzryJrqyService;
import com.ehtsoft.supervise.utils.DeployContext;
import com.ehtsoft.supervise.utils.GisUtil;
import com.ehtsoft.supervise.utils.ParameterUtil;
import com.mongodb.Block;
import com.mongodb.client.FindIterable;

/**
 * 足迹服务类【公共法律服务平台定位监控系统】
 * @author wangbao
 */
@Service("FootprintService")
public class FootprintService   extends  AbstractService{

	@Resource(name="sqlDbClient")
	private SqlDbClient dbClient;
	
	@Resource(name="mongoClient")
	private MongoClient mongoClient;
	
	//矫正人员基本信息
	@Resource
	private JzJzryjbxxService jbxxService;
	//消息用户信息服务
	@Resource
	private UserinfoService userinfoService;
	//消息推送服务
	@Resource
	private IMSService broadcastService; // 【处理集群】
	//停留处理 -- 时间、区域半径【 10分钟获取一次】
	@Resource
	private StayTimeService stayTimeService;
	//矫正人员的矫正区域【禁止】
	@Resource
	private SysJzryJrqyService sysJzryJrqyService;
	
	@Resource(name="SSOService")
	private SSOService service;
	
	private Log logger = LogFactory.getLog(FootprintService.class);
	
	//配置序列，通过位置序列来进行停留时间的计算
	private LinkedBlockingQueue<Location> locationQueue = new LinkedBlockingQueue<>();
	
	//字段前缀
	private String fieldPrefix = "f_";
	
	//抖动点平均值去重 时间间隔
	@Resource
	private CacheService cacheService; 
	private int SCHEDULED_PERIOD = 600;//秒（每隔 10 分钟执行一次）
	
	@Resource
	private SSOService ssoService;
	
	@PostConstruct  //只执行一次的处理
	public void init(){
		//保存定位人员在一个范围内的停留时间
		//  -> :Lambda表达式【类似匿名内部类】
		new Thread(()->{  
			while(true){
				try {
					Location location = locationQueue.take();
					if(location==null){
						continue;
					}
					//计算停留时间
					stayTimeService.calculateStayTime(location);
					//判断是否进入特定区域或越界  add by liuzh at 2018/01/12
					sysJzryJrqyService.judgeOutOfBounds(location);
					
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}).start();
		
		//是否启动调度配置
		if(DeployContext.isEnableScheduled(DeployContext.DEPLOY_SCHEDULED_FOOTPRINT_ENABLE)){
			/*
			ScheduledExecutorService es = Executors.newSingleThreadScheduledExecutor();
			es.scheduleAtFixedRate(new Runnable() {
				@Override
				public void run() {
					try{
						calculateFootprint();
					}catch(Exception ex){
						logger.error(ex.getMessage(),ex);
					}
				}
			}, SCHEDULED_PERIOD, SCHEDULED_PERIOD, TimeUnit.SECONDS); //每隔10分钟执行一次调度来计算
			*/
		}
	}
	
	/**
	 * 心跳记录
	 */
	public List<BasicMap<String, Object>> findHeartBeat (BasicMap<String, Object> query) {
		int cdate=NumberUtil.toInt(query.get("datestr").toString().replace("-", ""));
		List<BasicMap<String, Object>> list = new ArrayList<>();
		String sql = "SELECT  XLZ FROM REP_XTJC WHERE AID = '"
				+ query.get("aid") + "'"
				+ " AND cdate = '"
				+ cdate + "'";
		list = dbClient.find(new SQLAdapter(sql));
		return list;
	}
	
	
	
	
	/**
	 * 定位位置误差范围(去重复点范围)。默认 5 米（android）
	 * @return
	 */
	public double getRangeDistance(){
		double rtn = 5;// 5 米
		int d = NumberUtil.toInt(ParameterUtil.getParameter(dbClient).get(SupConst.ParameterKey.KEY_SYSTEM_004).getValue());
		if(d>0){
			rtn = NumberUtil.to_double(d);
		}
		return rtn;
	}
	/**
	 * "轨迹采集频率设置（秒数)"
	 */
	public int getCollectRate(){
		int rtn = 3;//默认 3 秒
		int d = NumberUtil.toInt(ParameterUtil.getParameter(dbClient).get(SupConst.ParameterKey.KEY_SYSTEM_001).getValue());
		if(d > 3){
			rtn = d;
		}
		return rtn;
	}
	
	int pday = NumberUtil.toInt(DateUtil.format(new Date(),"yyyyMMdd"));
	
	/**
	 * 保存数据到 IM_FOOTPRINT
	 * @param location
	 * JGLX:矫管类型(SYS14)
	 */
	public void insert(Location location){
		System.out.println("================================:" + AppContext.getRemoteAddr() + ":"  + DateUtil.format(new Date(), "yyyy-MM-dd HH:mm:ss") + 
				":" + "("+location.getLng()+","+location.getLat()+")");
		if(location == null || location.getAid() == null){
			return;
		}
		if(NumberUtil.toInt(location.getLat())==0 || NumberUtil.toInt(location.getLng()) == 0){
			return;
		}
		String aid = location.getAid();
		float gpsSpeed = location.getSpeed();
		BasicMap<String, Object> aidData = dbClient.findOne("select f_id from jz_collect_user where f_id = ?", aid);
		if(aidData==null){
			return;
		}
		//推送该管理人员的ID
		//location.setTo(to);
		location.setOnline(true);
		broadcastService.sendLocation(location);
		location.setSpeed(0);
		try {
			locationQueue.put(location);
		} catch (InterruptedException e) {
		}
		BasicMap<String,Object> cloc = ReflectUtil.bean2Map(location);
		// pk 和 aid 相等
		cloc.put(GlobalsName.MONGO_PK_FIELD, location.getAid());
		cloc.put("online",true);
		cloc.put("udate", NumberUtil.toInt(DateUtil.format(new Date(), "yyyyMMdd")));
		//1 表示有经纬度的
		cloc.put("flag", 1);
		cloc.put("step", location.getStep());//步数信息（当前最大步数）
		BasicMap<String, Object> jglxData = dbClient.findOne("select jglx from jz_jzryjbxx where id = ?", aid);
		if(jglxData==null){
			return;
		}
		if(jglxData.get("jglx")!=null){
			String jglx =StringUtil.toEmptyString( jglxData.get("jglx"));
			cloc.put("jglx", jglx);
		}
		//更新最新位置
		mongoClient.save(ImConst.Collections.IM_CURRENT_LOCATION, cloc);
		//1:在线
		jbxxService.updateOnlineStatus(aid, "1");
		
		int cday = NumberUtil.toInt(DateUtil.format(new Date(),"yyyyMMdd"));
		Location tmp = null;
		BasicMap<String,Object> tmpMap=null;
		synchronized (this) {
			tmpMap = cacheService.getCacheMap(location.getAid());
			if(tmpMap!=null){
				tmp = ReflectUtil.map2Bean(tmpMap, Location.class);
				if(Math.abs(tmp.getLat() - location.getLat()) <= 0.000001 && Math.abs(tmp.getLng() - location.getLng()) <= 0.000001){
					return;
				}
			}
		}
		
		double distance = 0;
		double step = 0;
		int sec = 0; //两点间的时间差
		
		if(tmp!=null){
			distance = GisUtil.getDistance(tmp, location);
			step = location.getStep() - tmp.getStep();
			if(step<0){
				step = 0;
			}
			long s = NumberUtil.to_long(tmpMap.get("cts"));
			long t = System.currentTimeMillis();
			sec = (int)((t - s)/1000);
			if(sec==0){
				sec = 3;
			}
			float speed = (float)(distance / sec);
			location.setSpeed((float)NumberUtil.toDigits(speed, 6));
		}
		
		cacheService.putCacheLocation(location.getAid(), location);
		
		if(distance < getRangeDistance()){
			 if(cday - pday == 0){
				 return;
		     }
			 pday = cday;
		}
		
		BasicMap<String,Object> data = ReflectUtil.bean2Map(location);
		//location: {type: "Point",coordinates: [-73.856077, 40.848447]} // lng , lat
		data.remove("lng");
		data.remove("lat");
		data.remove("online");
		data.put("cdate", NumberUtil.toInt(DateUtil.format(new Date(), "yyyyMMdd")));
		data.put("location", new BasicMap<String,Object>("type","Point","coordinates",Arrays.asList(location.getLng(),location.getLat())));
		data.put(GlobalsName.MONGO_PK_FIELD, new ObjectId().toString());
		data.put("step",step);//步数信息（当前最大步数）
		data.put("distance", distance);
		data.put("flag", 0);
		data.put("gpsSpeed", gpsSpeed);
		mongoClient.insert(ImConst.Collections.IM_FOOTPRINT_SOURCE, data);
	}
	
	/**
	 * 获取最后一次位置信息（最新的地理信息位置）
	 * @return
	 */
	public List<Location> getLastLocations(){
		final List<Location> rtn = new ArrayList<>();
		User user = service.getUser();
		if(user!=null&&user.getOrgidSet()!=null){
			mongoClient.find(ImConst.Collections.IM_CURRENT_LOCATION,Query.query(Criteria.where("flag").is(1).and("orgid").in(user.getOrgidSet())),null,new RowDataListener(){
				@Override
				public void processData(BasicMap<String, Object> rowData) {
					Location location = ReflectUtil.map2Bean(rowData, Location.class, fieldPrefix);
					rtn.add(location);
				}
			});
		}
		return rtn;
	}
	
	public Location getLastLocation(String aid){
		BasicMap<String,Object> bm = mongoClient.findOne(ImConst.Collections.IM_CURRENT_LOCATION, Query.query(Criteria.where("flag").is(1).and("_id").is(aid)));
		Location location = ReflectUtil.map2Bean(bm, Location.class, fieldPrefix);
		return location;
	}
	/**
	 * 获取足迹信息
	 * @param aid
	 * @param hour
	 * @param paginate
	 * @return
	 */
	public List<Location> getFootprint(String aid,String day1,String day2){
		final List<Location> rtn = new ArrayList<>();
		//BasicMap<String,Object> m = mongoClient.findOne(ImConst.Collections.IM_CURRENT_LOCATION, Query.query(Criteria.where("_id").is(aid)));
		int fromDay = NumberUtil.toInt(DateUtil.format(new Date(), "yyyyMMdd"));
		int toDay = fromDay;
		if(Util.isNotEmpty(day1)){
			fromDay = NumberUtil.toInt(day1.replaceAll("\\-", ""));
			if(fromDay==0){
				fromDay = NumberUtil.toInt(DateUtil.format(new Date(), "yyyyMMdd"));
			}
		}
		if(Util.isNotEmpty(day2)){
			toDay = NumberUtil.toInt(day2.replaceAll("\\-", ""));
			if(toDay==0){
				toDay = NumberUtil.toInt(DateUtil.format(new Date(), "yyyyMMdd"));
			}
		}
		
		Query query = new Query();
		query.addCriteria(Criteria.where("aid").is(aid).and("cdate").gte(fromDay).lte(toDay));
		
		mongoClient.find(ImConst.Collections.IM_FOOTPRINT_SOURCE, query,new String[]{"location"},new RowDataListener() {
			@Override
			public void processData(BasicMap<String, Object> rowData) {
				Object o = rowData.get("location");
				if(o!=null && o instanceof Map){
					Map m = (Map)o;
					Object coordinates = m.get("coordinates");
					if(coordinates!=null && coordinates instanceof List){
						List ls = (List)coordinates;
						Location loc = new Location();
						loc.setAid(aid);
						loc.setLng(NumberUtil.toDouble(ls.get(0)));
						loc.setLat(NumberUtil.toDouble(ls.get(1)));
						rtn.add(loc);
					}
				}
			}
		});
		return rtn;
	}
	
	
	/**
	 * 电脑端
	 * 获取足迹信息【全部的详细位置信息】
	 * @param aid
	 * @param paginate
	 * @return
	 */
	@Deprecated
	public List<Location> getFootprintList(BasicMap<String, Object> query){
		//int cdate=NumberUtil.toInt(query.get("datestr").toString().replace("-", ""));
		final List<Location> rtn = new ArrayList<>();
		String aid=query.get("aid").toString();
		Query querym = new Query().with(Sort.by(Direction.DESC, GlobalsName.MONGO_PK_FIELD)); // _id desc
		querym.addCriteria(Criteria.where("aid").is(aid)); //
		
		Paginate paginate = new Paginate();
		paginate.setSkip(true);
		paginate.setPageCount(2000);
		mongoClient.find(ImConst.Collections.IM_FOOTPRINT_SOURCE, querym,paginate,new String[]{},new RowDataListener() {
			@Override
			public void processData(BasicMap<String, Object> rowData) {
				Object o = rowData.get("location");
				if(o!=null && o instanceof Map){
					Map m = (Map)o;
					Object coordinates = m.get("coordinates");
					if(coordinates!=null && coordinates instanceof List){
						List ls = (List)coordinates;
						Location loc = new Location();
						loc.setAid(aid);
						loc.setLng(NumberUtil.toDouble(ls.get(0)));
						loc.setLat(NumberUtil.toDouble(ls.get(1)));
						loc.setAddress(String.valueOf(rowData.get("address")));
						loc.setDistance(NumberUtil.to_float(rowData.get("distance").toString()));
						if(Util.isNotEmpty(rowData.get("speed"))){
							loc.setSpeed(NumberUtil.to_float(rowData.get("speed").toString()));
						}else{
							loc.setSpeed(0);
						}
						if(Util.isNotEmpty(rowData.get("step"))){
							loc.setStep(NumberUtil.toInt(rowData.get("step").toString()));
						}else{
							loc.setStep(0);
						}
						if(Util.isNotEmpty(rowData.get("floor"))){
							loc.setFloor(Integer.valueOf(String.valueOf(rowData.get("floor"))));
						}else{
							loc.setFloor(0);
						}
						rtn.add(loc);
					}
				}
			}
		});
		Collections.reverse(rtn);
		return rtn;
	}
	
	/**
	 * 电脑端
	 * 获取最后一次位置信息（最新的地理信息位置）【定位监控界面的检索人员】
	 * @return
	 */
	public List<Location> getAllPeopleLocations(BasicMap<String, Object> query){
		final List<Location> rtn = new ArrayList<>();
		Query  q= toMongoQuery(query);
		q.addCriteria(Criteria.where("flag").is(1));
		mongoClient.find(ImConst.Collections.IM_CURRENT_LOCATION,q,null,new RowDataListener(){
			@Override
			public void processData(BasicMap<String, Object> rowData) {
				Location location = ReflectUtil.map2Bean(rowData, Location.class, fieldPrefix);
				location.setName(String.valueOf(rowData.get("name")));
				location.setGender(String.valueOf(rowData.get("gender")));
				rtn.add(location);
			}
		});
		return rtn;
	}
	
	/**
	 * 根据aid获取一个人员的足迹信息【个人的详细位置信息】
	 * @param aid
	 * @param hour
	 * @param paginate
	 * @return
	 * 对点出现波动的时候，分析用函数
	 * 其他地方没有使用到  footPrint.jsp 
	 */
	public List<BasicMap<String,Object>> getFootprintByAid(String aid){ //NM0000000000000000JZ1504302014070011
		List<BasicMap<String,Object>> rtn = new ArrayList<BasicMap<String,Object>>();
		Query querym = new Query().with(Sort.by(Direction.ASC, GlobalsName.MONGO_PK_FIELD)); // _id desc
		querym.addCriteria(Criteria.where("aid").is(aid));
		rtn = mongoClient.find(ImConst.Collections.IM_FOOTPRINT_SOURCE, querym,null,new RowDataListener() {
			@Override
			public void processData(BasicMap<String, Object> rowData) {
				Object o = rowData.get("location");
				if(o!=null && o instanceof Map){
					Map m = (Map)o;
					Object coordinates = m.get("coordinates");
					if(coordinates!=null && coordinates instanceof List){
						List ls = (List)coordinates;
						rowData.put("lng",NumberUtil.toDouble(ls.get(0)));
						rowData.put("lat",NumberUtil.toDouble(ls.get(1)));
					}
				}
			}
		});
		return rtn;
	}
	/**
	 * 对点出现波动的时候，分析用函数
	 * 其他地方没有使用到  footPrint.jsp 
	 * @return
	 */
	public List<BasicMap<String,Object>> getJzryxx(){
		String sqlstr = "select a.id,xm,jgmc from jz_jzryjbxx a,jc_sfxzjgjbxx b where a.orgid = b.id and sfcj = 1 order by a.orgid asc";
		return dbClient.find(new SQLAdapter(sqlstr));
	}
	
	public void removePosition(String _id){
		mongoClient.remove(ImConst.Collections.IM_FOOTPRINT, Query.query(Criteria.where("_id").is(_id)));
	}
	
	private int interval =  SCHEDULED_PERIOD; 
	private void calculateFootprint(){
		
		Object minCts = mongoClient.min(ImConst.Collections.IM_FOOTPRINT_SOURCE, Query.query(Criteria.where("flag").is(0)), new String[]{"cts"});
		
		BasicMap<String,Object> param = new BasicMap<String,Object>();
		final long time = NumberUtil.to_long(minCts)  + interval * 1000;//System.currentTimeMillis();
		param.put("systime", time);
		
		String cmd = MongoScriptUtil.getMongoCommand("footprint-calculate-group", param);
		List<BasicMap<String,Object>> lists = mongoClient.aggregate(ImConst.Collections.IM_FOOTPRINT_SOURCE, cmd);
		
		ExecutorService es = Executors.newFixedThreadPool(100);
		for(BasicMap<String, Object> bm : lists){
			/**
			 * "_id"  : "矫正人员 aid",
			 * "step" : 总步数,
			 * "speed" : 平均速度（米/秒）
			 * "distance" : 总距离（米）
			 * "count": 点数
			 * "lng" : 经度（平均）
			 * "lat" : 纬度（平均）
			 */
			final String aid = StringUtil.toString(bm.get("_id"));
			/**
			 *  IM_FOOTPRINT_SOURCE
			 *  获取一定时间段的（系统自动生成，默认 600秒）的总步数，速度，总距离，判断其状态（步行，坐车，停留及抖动）
				有步数，速度低，距离及步数合理 - 步行 （10米范围求平均值）
				少步数，速度高，距离转换步数远大于步数  - 开车或坐车 （10米范围求平均值）
				少步速，速度特别小，距离累计值转换步数远大于步数  停留及抖动 （取平均数）
				
				步行速度 3 ~ 5KM/H = 0.7 ~ 1.37米/秒
				步幅 = 距离/步数  （人的步数应该在 0.4米 ~ 1米 之间）
			 */
			//平均速度
			final float speed = NumberUtil.to_float(bm.get("speed"));
			//总距离（米）
			final float distance =  NumberUtil.to_float(bm.get("distance"));
			//步数
			final int step = NumberUtil.toInt(bm.get("step"));
			//步幅
			final float stepsize = distance/step;
			//根据距离计算应该的步数
			final int jsstep = (int)(distance/0.7);  //距离除以 步幅 得到步数
			final int count = NumberUtil.toInt(bm.get("count"));
			final String cacheKey = "IM_FOOTPRINT" + aid;
			es.execute(new Runnable() { 
				public void run() {
					//{cts:{$lt:${systime}},{flag:0}} //
					mongoClient.update(ImConst.Collections.IM_FOOTPRINT_SOURCE,
								Query.query(Criteria.where("cts").lt(time).and("flag").is(0).and("aid").is(aid)),
								new BasicMap<String,Object>("flag",1)); 
					//计算结束后，将源数据标记为 1  ，0 表示为计算的数据
					
					String _id = new ObjectId().toString();
					BasicMap<String,Object> data = new BasicMap<>();
					data.put("aid", aid);
					/*
					 * "lng" : 经度（平均）
					 * "lat" : 纬度（平均）
					 */
					double lng = NumberUtil.to_double(bm.get("lng"));
					double lat = NumberUtil.to_double(bm.get("lat"));
					data.put("cdate", NumberUtil.toInt(DateUtil.format(new Date(), "yyyyMMdd")));
					//步行速度 3 ~ 5KM/H = 0.7 ~ 1.37米/秒
					/**
					 * 判断停留及抖动的状态 (速度小于步行最低速度，距离累计值转换步数远大于步数，计算的步幅大于人的步幅）定义为抖动的状态，点数 > 1
					 */
					if(speed<0.7 && jsstep > step && stepsize > 1.0 && count > 1 || count == 1){
						//抖动的状态 及 count = 1 //当前时间范围内点数为 1 的时候，表示未抖动
						//前一个点缓存
						Location preLoc = null;
						BasicMap<String,Object> map = cacheService.getCacheMap(cacheKey);
						if(map!=null){
							preLoc = ReflectUtil.map2Bean(map, Location.class);
						}
						//获取的坐标平均值及速度等放到 location 对象中
						Location location = new Location();
						location.setAid(aid);
						location.setLng(lng);
						location.setLat(lat);
						location.setSpeed(speed);
						location.setStep(step);
						location.setDistance(distance);
						if(preLoc==null){
							data.put("speed", speed);
							//第一个点的时候
							data.put("step",0);
							data.put("distance",0);
						}else{
							//步数
							data.put("step",location.getStep() - preLoc.getStep());
							data.put("distance",location.getDistance() - preLoc.getDistance());
							double dis = GisUtil.getDistance(location,preLoc);
							if(dis < getRangeDistance()){
								//范围内（5米）两点取平均值，将平均值保存
								lng = (location.getLng() + preLoc.getLng())/2;
								lat = (location.getLat() + preLoc.getLat())/2;
								_id = StringUtil.toString(map.get("locid"));
							}else{
								//第二个平均坐标点超长 5 米范围了，距离为 两点的距离
								data.put("distance",dis);
								data.put("speed", speed);
							}
						}
						data.put("location", new BasicMap<String,Object>("type","Point","coordinates",Arrays.asList(lng,lat)));
						data.put(GlobalsName.MONGO_PK_FIELD, _id);
						mongoClient.save(ImConst.Collections.IM_FOOTPRINT, data);
						
						BasicMap<String,Object> cmap = ReflectUtil.bean2Map(location);
						cmap.put("locid", _id);
						//缓存当前点
						cacheService.putCacheMap(cacheKey, cmap);
					}else if(speed >= 1.37 && stepsize > 1.0){
						Document q = Query.query(Criteria.where("cts").lt(time).and("flag").is(0).and("aid").is(aid)).getQueryObject();
						//开车的状态
						FindIterable<Document> docs = mongoClient.getCollection(ImConst.Collections.IM_FOOTPRINT_SOURCE).find(q);
						docs.forEach(new Block<Document>() {
							public void apply(Document t) {
								mongoClient.getCollection(ImConst.Collections.IM_FOOTPRINT).insertOne(t);
							}
						});
					//}else{
						//走路的状态
					}
				}
			});
		}
	}
}
