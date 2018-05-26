package com.ehtsoft.im.services;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.UUID;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.stereotype.Service;

import com.ehtsoft.fw.core.db.MongoClient;
import com.ehtsoft.fw.core.db.RowDataListener;
import com.ehtsoft.fw.core.db.SqlDbClient;
import com.ehtsoft.fw.core.dto.BasicMap;
import com.ehtsoft.fw.core.dto.Paginate;
import com.ehtsoft.fw.core.utils.script.MongoScriptUtil;
import com.ehtsoft.fw.utils.DateUtil;
import com.ehtsoft.fw.utils.NumberUtil;
import com.ehtsoft.fw.utils.StringUtil;
import com.ehtsoft.fw.utils.Util;
import com.ehtsoft.im.dto.GisMap;
import com.ehtsoft.im.protocol.Location;
import com.ehtsoft.supervise.api.SupConst;
import com.ehtsoft.supervise.dto.Parameter;
import com.ehtsoft.supervise.utils.DeployContext;
import com.ehtsoft.supervise.utils.ParameterUtil;

@Service("StayTimeService")
public class StayTimeService {
	
	@Resource(name="mongoClient")
	private MongoClient mongoClient;
	
	@Resource(name = "sqlDbClient")
	private SqlDbClient dbClient;
	
	private Log logger = LogFactory.getLog(StayTimeService.class);
	
	//停留区域半径  
	private int STAY_RANGE_RADIUS = 40;//米
	
	//停留时间调度计算（每隔 SCHEDULED_PERIOD 执行一次） 单位 ： 秒
	public int SCHEDULED_PERIOD = 600;//秒（每隔 10 分钟执行一次）
	
	@PostConstruct
	public void init(){
		try{
			MongoScriptUtil.init("classpath:META-INF/script/mongo-cmd*.xml");
			
			Parameter p = ParameterUtil.getParameter(dbClient).get(SupConst.ParameterKey.KEY_SYSTEM_005);
			if(p!=null && Util.isNotEmpty(p.getValue())){
				//停留区域半径  
				SCHEDULED_PERIOD = NumberUtil.toInt(p.getValue());
			}
			//是否启动调度配置
			if(DeployContext.isEnableScheduled(DeployContext.DEPLOY_SCHEDULED_STAYTIME_ENABLE)){
				ScheduledExecutorService es = Executors.newSingleThreadScheduledExecutor();
				es.scheduleAtFixedRate(new Runnable() {
					@Override
					public void run() {
						try{
							Parameter p = ParameterUtil.getParameter(dbClient).get(SupConst.ParameterKey.KEY_SYSTEM_005);
							if(p!=null && Util.isNotEmpty(p.getValue())){
								//停留区域半径  
								SCHEDULED_PERIOD = NumberUtil.toInt(p.getValue());
							}
							mongoClient.find(SupConst.Collections.REP_STAY_MAP, new Query(),null,new RowDataListener() {
								@Override
								public void processData(BasicMap<String, Object> rowData) {
									String sid = StringUtil.toString(rowData.get("sid"));
									if(Util.isNotEmpty(sid)){
										//{"sid":sid,status:0} 查下条件
										Query query = Query.query(Criteria.where("sid").is(sid).and("status").is(0));
										//更新 status 及 outtime 数据
										mongoClient.update(SupConst.Collections.REP_STAY_DETAIL, query , new BasicMap<String,Object>("outtime",System.currentTimeMillis()));
										List<BasicMap<String,Object>> l = mongoClient.aggregate(SupConst.Collections.REP_STAY_DETAIL,"[{$match:{sid:\""+sid+"\"}},{$group:{_id:\"$sid\",time:{$sum:{$subtract:[\"$outtime\",\"$intime\"]}}}}]");
										if(!l.isEmpty()){
											BasicMap<String,Object> data = l.get(0);
											long time = NumberUtil.to_long(data.get("time"));
											long tm = time/1000;
											data.put("time", tm);//秒
											data.put("_id", sid);
											mongoClient.update(SupConst.Collections.REP_STAY_TIME,data);
										}
									}
								}
							});
						}catch(Exception e){
							logger.error(e.getMessage(),e);
						}
					}
				}, SCHEDULED_PERIOD, SCHEDULED_PERIOD, TimeUnit.SECONDS);
			}
		}catch(Exception ex){}
	}
	/**
	 * 停留时间的计算
	 * @param location
	 */
	public void calculateStayTime(Location location){
		Parameter p = ParameterUtil.getParameter(dbClient).get(SupConst.ParameterKey.KEY_SYSTEM_003);
		if(p!=null && Util.isNotEmpty(p.getValue())){
			//停留区域半径  
			STAY_RANGE_RADIUS = NumberUtil.toInt(p.getValue());
		}
		
		String aid=location.getAid();

		//上一次的位置 sid （REP_STAY_TIME）
		String psid="";
		//是否需要更新status
		Boolean flag=false;
		try{
			//获取上一次定位的sid
			BasicMap<String,Object> mBasicMap= mongoClient.findOne(SupConst.Collections.REP_STAY_MAP, Query.query(Criteria.where("aid").is(aid)));
			if(mBasicMap!=null){
				psid=(String) mBasicMap.get("sid");
			}
			BasicMap cmdMap = new BasicMap<String,Object>("aid",aid,"cdate",NumberUtil.toInt(DateUtil.format(new Date(), "yyyyMMdd")));
			cmdMap.put("distance", STAY_RANGE_RADIUS);
			cmdMap.put("lng", location.getLng());
			cmdMap.put("lat", location.getLat());
			
			//mongoClient.findOne(SupConst.Collections.REP_STAY_TIME, tfilter);
			BasicMap<String,Object> tBasicMap= null;
			//根据定位信息的经纬度 和 范围半径及当天日期（yyyymmdd），到 REP_STAY_TIME 获取数据
			String cmd = MongoScriptUtil.getMongoCommand("staytime-range-cmd01", cmdMap);
			List<BasicMap<String,Object>> ls = mongoClient.runGeoNearCommand(cmd);
			if(ls.size()>0){
				tBasicMap = ls.get(0);
			}
			//当前位置
			String csid = null;
			//当天已经保存过该范围
			if(tBasicMap!=null){
				csid = StringUtil.toString(tBasicMap.get("sid"));
				//在当前范围内
				BasicMap<String,Object> dBasicMap= mongoClient.findOne(SupConst.Collections.REP_STAY_DETAIL, 
						Query.query(Criteria.where("status").is(0).and("sid").is(csid)));
				if(dBasicMap!=null){
					//不为空的时候，表示该人定位还在原处，没有离开过（离开的时候，根据之前的 sid（psid）将 status 更新为 1 同时更新 ）
					//更新detail表的出去时间(outtime)
					dBasicMap.put("outtime",System.currentTimeMillis());
					mongoClient.update(SupConst.Collections.REP_STAY_DETAIL,dBasicMap);
					//更新time表的停留时间(time)  单位 秒
					tBasicMap.put("time", (System.currentTimeMillis() - NumberUtil.to_long(dBasicMap.get("intime")))/1000);
					mongoClient.update(SupConst.Collections.REP_STAY_TIME,tBasicMap);
				}else{
					//dBasicMap 为空的时候，表示该人已经离开过该区域重新回到该区域
					//保存REP_STAY_DETAIL表数据
					BasicMap<String,Object> savedMap=new BasicMap<>();
					savedMap.put("sid",csid);
					savedMap.put("lat",location.getLat());
					savedMap.put("lng",location.getLng());
					savedMap.put("address", location.getAddress());
					savedMap.put("describe", location.getDescribe());
					savedMap.put("intime",System.currentTimeMillis());
					savedMap.put("status",0);
					mongoClient.insert(SupConst.Collections.REP_STAY_DETAIL, savedMap);
					flag=true;
				}
				//保存aid和sid的对于关系
				BasicMap<String,Object> savemMap=new BasicMap<>();
				savemMap.put("sid",csid);
				savemMap.put("aid",aid);
				savemMap.put("_id",aid);
				mongoClient.remove(SupConst.Collections.REP_STAY_MAP, savemMap);
				mongoClient.insert(SupConst.Collections.REP_STAY_MAP, savemMap);
			}else{
				//当天没有保存过的范围
				//保存REP_STAY_TIME表数据
				String sid=UUID.randomUUID().toString();
				csid = sid;
				BasicMap<String,Object> savetMap=new BasicMap<>();
				savetMap.put("_id",sid);
				savetMap.put("sid",sid);
				savetMap.put("aid",aid);
				savetMap.put("time",0);
				savetMap.put("address", location.getAddress());
				savetMap.put("describe", location.getDescribe());
				savetMap.put("location",new GisMap<String,Object>("type","Point","coordinates",Arrays.asList(location.getLng(),location.getLat())));
				savetMap.put("intime",System.currentTimeMillis());
				savetMap.put("cdate",NumberUtil.toInt(DateUtil.format(new Date(), "yyyyMMdd")));
				mongoClient.insert(SupConst.Collections.REP_STAY_TIME, savetMap);
				//保存REP_STAY_DETAIL表数据
				BasicMap<String,Object> savedMap=new BasicMap<>();
				savedMap.put("sid",sid);
				savedMap.put("areaname",location.getDescribe());
				savedMap.put("location",Arrays.asList(location.getLng(),location.getLat()));
				savedMap.put("lng",location.getLng());
				long ct = System.currentTimeMillis();
				savedMap.put("intime",ct);
				savedMap.put("outtime", ct);
				savedMap.put("status",0);
				mongoClient.insert(SupConst.Collections.REP_STAY_DETAIL, savedMap);
				//保存aid和sid的对于关系
				BasicMap<String,Object> savemMap=new BasicMap<>();
				savemMap.put("sid",sid);
				savemMap.put("aid",aid);
				savemMap.put("_id",aid);
				mongoClient.remove(SupConst.Collections.REP_STAY_MAP, savemMap);
				mongoClient.insert(SupConst.Collections.REP_STAY_MAP, savemMap);
				flag=true;
			}
			
			//更新出去时间和status
			if(Util.isNotEmpty(psid)){ //上一个位置更新状态
				if(flag){ 
//					MongoFilter pfilter=new MongoFilter();
//					pfilter.eq("sid",psid);
//					pfilter.eq("status", 0);
					//更新 status 及 outtime 数据
					mongoClient.update(SupConst.Collections.REP_STAY_DETAIL,
							Query.query(Criteria.where("sid").is(psid).and("status").is(0)) , 
							new BasicMap<String,Object>("status", 1,"outtime",System.currentTimeMillis()));
					//暂时通过 聚合 方法进行停留时间合计（以后出现性能问题的时候，考虑采用 REP_STAY_TIME time 日期 + REP_STAY_DETAIL 的分段时间累加值 即： time = time + (outtime - intime)/1000 ） 单位秒
					//以下方法相当于 select sum(outtime - intime),sid from REP_STAY_DETAIL where sid = 'psid' group by sid
					List<BasicMap<String,Object>> l = mongoClient.aggregate(SupConst.Collections.REP_STAY_DETAIL,"[{$match:{sid:\""+psid+"\"}},{$group:{_id:\"$sid\",time:{$sum:{$subtract:[\"$outtime\",\"$intime\"]}}}}]");
					if(!l.isEmpty()){
						BasicMap<String,Object> data = l.get(0);
						long time = NumberUtil.to_long(data.get("time"));
						long tm = time/1000;
						//////////////////////////  如果 tm = 0 时，用当前日期 - intime 
						data.put("time", tm);//秒
						data.put("_id", psid);
						mongoClient.update(SupConst.Collections.REP_STAY_TIME,data);
					}
				}
			}
			flag=false;
		}catch(Exception ex){
			ex.printStackTrace();
			flag=false;
		}
	}
	
	/**
	 * 查询矫正人员位置停留时间排名
	 * 
	 * @param aid 矫正人员id
	 * @param hour 小时   
	 * @return
	 * List<BasicMap<String,Object>>
	 * @创建人  ：Administrator
	 * @创建时间：2017年9月28日下午11:00:44
	 * @修改人  ：Administrator
	 * @修改时间：2017年9月28日下午11:00:44
	 * @修改备注：
	 * @version 1.0
	 *
	 */
	public List<BasicMap<String,Object>> getStayTime(String aid,Integer hour){
		Paginate p = new Paginate();
		Query q = Query.query(Criteria.where("cts").gte(System.currentTimeMillis() - hour * 60 * 60 * 1000));
		q.with(Sort.by(Direction.DESC, "time"));
		List<BasicMap<String,Object>> tList= mongoClient.find(SupConst.Collections.REP_STAY_TIME, 
				q,p).getRows();
		return tList;
	}
	/**
	 * 查询矫正人员步数
	 * @param aid
	 * @param hour
	 * @return
	 * [
	 * 	{
	 * 		step:步数
	 * 	}
	 * ]
	 */
	public List<BasicMap<String,Object>> findStepCount(String aid,Integer hour){
		List<BasicMap<String,Object>> list = new ArrayList<>();
		float time = System.currentTimeMillis()-hour*60*60*1000;
		BasicMap<String, Object> map = new BasicMap<>("aid",aid,"time",time);
		String cmd = MongoScriptUtil.getMongoCommand("step-count", map);
		list = mongoClient.aggregate(SupConst.Collections.IM_FOOTPRINT_SOURCE,  cmd);
		return list;
	}
}
