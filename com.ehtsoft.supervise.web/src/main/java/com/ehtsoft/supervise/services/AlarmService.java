package com.ehtsoft.supervise.services;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.stereotype.Service;

import com.ehtsoft.common.services.SSOService;
import com.ehtsoft.fw.core.context.AppException;
import com.ehtsoft.fw.core.db.MongoClient;
import com.ehtsoft.fw.core.db.RowDataListener;
import com.ehtsoft.fw.core.db.SQLAdapter;
import com.ehtsoft.fw.core.db.SqlDbClient;
import com.ehtsoft.fw.core.db.SqlDbFilter;
import com.ehtsoft.fw.core.dto.BasicMap;
import com.ehtsoft.fw.core.dto.Paginate;
import com.ehtsoft.fw.core.dto.ResultList;
import com.ehtsoft.fw.core.services.AbstractService;
import com.ehtsoft.fw.core.sso.User;
import com.ehtsoft.fw.core.utils.script.MongoScriptUtil;
import com.ehtsoft.fw.utils.DateUtil;
import com.ehtsoft.fw.utils.NumberUtil;
import com.ehtsoft.fw.utils.StringUtil;
import com.ehtsoft.fw.utils.Util;
import com.ehtsoft.im.api.ImConst;
import com.ehtsoft.im.dto.Userinfo;
import com.ehtsoft.im.protocol.Command;
import com.ehtsoft.im.protocol.CommandType;
import com.ehtsoft.im.services.IMSService;
import com.ehtsoft.im.services.UserinfoService;
import com.ehtsoft.rep.services.ActivityService;
import com.ehtsoft.supervise.api.SupConst;
import com.ehtsoft.supervise.dto.ActivityObj;
import com.ehtsoft.supervise.utils.ParameterUtil;
/**
 * 报警服务
 * @author wangbao
 */
@Service("AlarmService")
public class AlarmService extends AbstractService{
	
	@Resource(name = "sqlDbClient")
	private SqlDbClient dbClient;
	
	@Resource(name="mongoClient")
	private MongoClient mongoClient;
	
	@Resource
	private UserinfoService userinfoService;
	
	@Resource
	private IMSService broadcastService;
	
	@Resource(name="SSOService")
	private SSOService service;
	
	@Resource(name="ActivityService")
	private ActivityService activityService;
	
	/**
	 * 报警信息【签到失败】
	 * @param data
	 * {
	 *   f_id:"主键",
	 *   f_type:"报警类型",
	 *   f_content:"报警内容",
	 *   f_address:"报警地址",
	 *   f_lat:"纬度",
	 *   f_lng:"经度"，
	 *   f_score:"分数（相似度）",
	 *   f_aid:"矫正人员ID",
	 *   f_flag: 0 报警  1 提醒,
	 *   orgid:"机构ID"
	 * }
	 */
	public void save(BasicMap<String,Object> data){
		dbClient.getInterceptor().setSkipSso(true);
		if(Util.isEmpty(data.get("orgid"))){
			User user = service.getUser();
			if(user!=null) {
				data.put("orgid", user.getOrgid());
			}
		}
		dbClient.save(SupConst.Collections.JZ_ALARM, data);
		String aid = StringUtil.toString(data.get("f_aid"));
		String content = StringUtil.toEmptyString(data.get("f_content"));
		Userinfo ui = userinfoService.findUserinfo(aid);
		
		int cdate = NumberUtil.toInt(DateUtil.format(new Date(), "yyyyMMdd"));
		String sqlstr ="select * from REP_ALARM where F_AID = ? and cdate = ? ";	
	    int flag = NumberUtil.toInt(data.get("F_FLAG"));
	    if(flag==0) {//0 报警
			BasicMap<String, Object> baseMap = dbClient.findOne(sqlstr,aid,cdate);
			//活动信息
			ActivityObj activityObj = new ActivityObj();
			activityObj.setYwid(StringUtil.toString(data.get("F_AID")));
			activityObj.setYwcts(new Date());
			//"address" : "中国内蒙古自治区呼和浩特市玉泉区", "describe" : "在育德幼儿园附近"
			activityObj.setAddr(StringUtil.toString(data.get("F_ADDRESS")));
			activityObj.setAid(StringUtil.toString(data.get("F_AID")));
			activityObj.setHdjg(NumberUtil.to_double(data.get("F_SCORE"))); 
			activityObj.setHdjgms(StringUtil.toString(data.get("F_CONTENT")));
			activityObj.setLng(NumberUtil.to_double(data.get("F_LNG")));
			activityObj.setLat(NumberUtil.toDouble(data.get("F_LAT")));
			switch(NumberUtil.toInt(data.get("F_TYPE"))){
				//人脸签到失败
				case CommandType.COMMAND_FACE_CHECKIN_FAILURE:
				case CommandType.COMMAND_FACE_CHECKIN_SUCCESS:
					// 2.人脸签到 
					activityObj.setHdlx("2");
					activityObj.setHdlxms("人脸签到");
					break;
				//声纹签到失败
				case CommandType.COMMAND_VOICE_CHECKIN_FAILURE:
				case CommandType.COMMAND_VOICE_CHECKIN_SUCCESS:
					// 3.声纹签到 
					activityObj.setHdlx("3");
					activityObj.setHdlxms("声纹签到");
					break;
				//指纹签到失败
				case CommandType.COMMAND_FINGER_CHECKIN_FAILURE:
				case CommandType.COMMAND_FINGER_CHECKIN_SUCCESS:
					//4.指纹签到  
					activityObj.setHdlx("4");
					activityObj.setHdlxms("指纹签到");
					break;
				//5.步数抽检 6.心跳抽检 7.越界报警  8.进入特定区域 9.步行 10.骑车 11.驾车 等信息
			}
			if(baseMap == null) {
				data.put("F_COUNT", 1);
				dbClient.insert(SupConst.Collections.REP_ALARM, data);
				activityService.insert(activityObj);
			}else {
				String data_type = StringUtil.toEmptyString(data.get("F_TYPE"));
				String data_content = StringUtil.toEmptyString(data.get("F_CONTENT"));
				
				String f_type = StringUtil.toEmptyString(baseMap.get("F_TYPE"));
				String f_content = StringUtil.toEmptyString(baseMap.get("F_CONTENT"));
				if(!hasContainType(f_type,data_type)) {				
					f_type = f_type + "," + data_type;
					activityService.insert(activityObj);
				}
				if(!hasContainType(f_content,data_content)) {				
					f_content=f_content+"," + data_content;
				}
				data.put("F_TYPE",f_type );
				data.put("F_CONTENT", f_content);
				data.put("F_COUNT", NumberUtil.toInt(baseMap.get("F_COUNT"))+1);
				data.put("F_SOLVE", 0);
				if(NumberUtil.toInt(data.get("F_LNG"))==0){
					data.remove("F_LNG");
				}
				if(NumberUtil.toInt(data.get("F_LAT"))==0){
					data.remove("F_LAT");
				}
				dbClient.update(SupConst.Collections.REP_ALARM, data);
			}
	    }
		Command command = new Command();
		command.setAlarm(true);
		command.setDirection(Command.DIRECTION_PHONE_TO_PAD);
		command.setFrom(StringUtil.toString(data.get("f_aid")));
		/**
		 * 人脸 ，指纹， 声纹的时候报警的时候，修改成  疑似人机分离，请确认
		 */
		//指纹签到是吧
		if(command.getCommand() == CommandType.COMMAND_FINGER_CHECKIN_FAILURE ||
		   command.getCommand() ==  CommandType.COMMAND_FACE_CHECKIN_FAILURE||
		   command.getCommand() ==  CommandType.COMMAND_VOICE_CHECKIN_FAILURE){
		   command.setContent("疑似人机分离");
		}
			
		if(ui!=null){
			command.setName(ui.getNickname());
		}else{
			command.setName("");
		}
		command.setContent(content);
		command.setCommand(NumberUtil.toInt(data.get("f_type")));
		broadcastService.sendCommand(command);
		dbClient.getInterceptor().setSkipSso(false);
	}
	
	/**
	 * 查询当前报警信息
	 * @param f_type
	 * [
	 * 	{
	 * 		f_id:报警信息id
	 * 		f_level:报警级别
	 * 		f_type:报警类型
	 * 		f_content:报警内容
	 * 		f_address:报警位置
	 * 		f_lat:当前经度
	 * 		f_lng:当前纬度
	 * 		f_score:分数
	 * 		f_aid:用户id
	 * 	}
	 * ]
	 */
	public ResultList<BasicMap<String,Object>> findAlarm(BasicMap<String, Object> query,Paginate paginate){
		ResultList<BasicMap<String, Object>> resultList = new ResultList<>();
		String types = StringUtil.toString(query.get("types"));
		String sqlstr = "select a.f_id,a.f_content,a.f_address,a.f_aid,a.cts,b.xm from JZ_ALARM a left join JZ_JZRYJBXX b on a.f_aid = b.id "
				+ " where a.f_type in ("+types+") and f_solve = 0 and f_flag = 0";
		SQLAdapter sqlAdapter = new SQLAdapter(sqlstr);
		resultList = dbClient.find(sqlAdapter, paginate, new RowDataListener() {
			@Override
			public void processData(BasicMap<String, Object> rowData) {
				rowData.put("cts", DateUtil.format(rowData.get("cts"), "yyyy-MM-dd HH:mm:ss"));
				String aid = StringUtil.toString(rowData.get("f_aid"));
				BasicMap<String, Object> data = mongoClient.findOne(ImConst.Collections.IM_CURRENT_LOCATION, Query.query(new Criteria().where("_id").is(aid)));
				if(data!=null){
					rowData.put("lng", data.get("lng"));
					rowData.put("lat", data.get("lat"));
				}
			}
		});
		return resultList;
	}
	
	
	/**
	 * 电脑端
	 * 查询一个人员一段时间的报警信息
	 * @param ｛"aid":'',"startTime":'',endTime:''｝
	 * [
	 * 	{
	 * 		f_id:报警信息id
	 * 		f_level:报警级别
	 * 		f_type:报警类型
	 * 		f_content:报警内容
	 * 		f_address:报警位置
	 * 		f_lat:经度
	 * 		f_lng:纬度
	 * 		f_score:分数
	 * 		f_aid:用户id
	 * 	}
	 * ]
	 */
	public ResultList<BasicMap<String,Object>> findAlarmList(BasicMap<String, Object> query,Paginate paginate){
		SqlDbFilter filter = toSqlFilter(query);
		String date = DateUtil.format(new Date(), "yyyyMMdd");
		String sqlstr = "select a.f_id,a.f_level,a.f_type,a.f_content,a.f_address,a.f_lat,a.f_lng,a.f_score,a.f_aid,b.xm,b.xb,b.mz,b.sfzh from JZ_ALARM a left join JZ_JZRYJBXX b on a.f_aid = b.id ";
		SQLAdapter sqlAdapter = new SQLAdapter(sqlstr);
		sqlAdapter.setFilter(filter);
		ResultList<BasicMap<String,Object>> list = dbClient.find(sqlAdapter, paginate, new RowDataListener() {
			
			@Override
			public void processData(BasicMap<String, Object> rowData) {
				if(NumberUtil.toInt(rowData.get("xb"))==1){
					rowData.put("xb", "男");
				}else if(NumberUtil.toInt(rowData.get("xb"))==2){
					rowData.put("xb", "女");
				}
			}
		});
		return list;
	}
	
	/**
	 * 查询一个人所有报警信息
	 * @param query
	 * @return
	 * [
	 * 	{
	 * 		f_id:报警ID
	 * 		f_content:报警内容
	 * 		f_address:报警地点
	 * 		cts:报警时间
	 * 	}
	 * ]
	 */
	public List<BasicMap<String, Object>> findPersonAlarms(BasicMap<String, Object> query, Paginate paginate){
		List<BasicMap<String, Object>> list = new ArrayList<>();
		String sqlstr = "select f_id,f_content,f_address,cts from jz_alarm";
		SqlDbFilter sqlDbFilter = toSqlFilter(query);
		sqlDbFilter.eq("f_aid", StringUtil.toEmptyString(query.get("aid"))).eq("f_solve", NumberUtil.toInt(query.get("f_solve")));
		SQLAdapter sqlAdapter = new SQLAdapter(sqlstr);
		sqlAdapter.setFilter(sqlDbFilter);
		list = dbClient.find(sqlAdapter,paginate, new RowDataListener() {
			@Override
			public void processData(BasicMap<String, Object> rowData) {
				rowData.put("cts", DateUtil.format(rowData.get("cts"), "yyyy-MM-dd HH:mm:ss"));
			}
		}).getRows();
		
		
		return list;
	}
	
	/**
	 * 更新报警信息状态(改为已处理)
	 * @param query
	 */
	public void updateStatus(BasicMap<String, Object> data){
		List<String> ids = (List<String>) data.get("ids");
		String aid = StringUtil.toString(data.get("F_AID"));
		if(Util.isEmpty(aid)) {
			throw new AppException("处理警告人的 ID 不能为空（F_AID)");
		}
		if(ids!=null && ids.size()>0) {
			BasicMap<String,Object> ds = new BasicMap<>(); 
			ds.put("f_solve",1);
			for(String alarmid : ids) {
				//更新警报处理状态
				ds.put("F_ID", alarmid);
				dbClient.update(SupConst.Collections.JZ_ALARM, ds,null);
				data.put("ALARMID", alarmid);
				//data.put("F_ID",alarmid);
				dbClient.save(SupConst.Collections.JZ_ALARM_SOLVE, data);
			}
			long c = dbClient.countSql("SELECT COUNT(1) AS CNT FROM JZ_ALARM WHERE  f_solve = '0' and  F_AID = '"+aid+"'");
			System.out.println(c + "================================================");
			if(c == 0) {
				dbClient.updateSql("UPDATE REP_ALARM SET F_SOLVE = 1 WHERE F_AID = ? ", aid);
			}
		}
	}

	/**
	 * 查询已处理的报警信息
	 * @param query
	 * @param paginate
	 * @return
	 * [
	 * 	{
	 * 	}
	 * ]
	 */
	public ResultList<BasicMap<String, Object>> findProcessAlarm(BasicMap<String, Object> query,Paginate paginate){
		ResultList<BasicMap<String, Object>> rtn = new ResultList<BasicMap<String, Object>>();
		User user = service.getUser();
		if(user!=null){
			String orgids = user.getOrgidsByWhereIn();
	    	String	sqlstr = "select a.f_aid,f_type,f_content,a.cts as mincts,a.cts as maxcts,a.f_address as location,b.xm,b.grlxdh,b.jglx,b.SQJZRYBH as code " + 
					" from rep_alarm a " + 
					" inner join jz_jzryjbxx b on a.f_aid = b.id " + 
					" where f_solve = " + NumberUtil.toInt(query.get("status"))  + 
					" and  a.orgid in ("+orgids+")" + 
					" order by a.cts desc";
			SQLAdapter sqlAdapter = new SQLAdapter(sqlstr);
			rtn = dbClient.find(sqlAdapter,paginate,new RowDataListener() {
				@Override
				public void processData(BasicMap<String, Object> rowData) {
					//查询报警时间间隔
					rowData.put("maxcts", DateUtil.format(rowData.get("maxcts"), "yyyy-MM-dd HH:mm:ss"));
					rowData.put("mincts", DateUtil.format(rowData.get("mincts"), "yyyy-MM-dd HH:mm:ss"));
				}
			});
		}
		return rtn;
	}
	
	
	/**
	 * 查询当前矫正人员一段时间路程内的签到、报警、停留时间的信息
	 * @param query
	 * @param paginate
	 * @return
	 * [
	 * 	{qdlx:签到类型、qdwz:签到位置、lat:纬度、lng:经度、}
	 * 	{f_content:报警内容、f_address:报警地点、f_lat:纬度、f_lng:经度、f_solve:处理标识(0:未处理 1:已处理)、}
	 * 	{location:{coordinates:[lat,lng]},time:停留时间、}
	 * ]
	 */
	@Deprecated
	public List<BasicMap<String, Object>> findFootDetail(BasicMap<String, Object> query,Paginate paginate){
		String parameterTimeString = ParameterUtil.getParameter(dbClient).get(SupConst.ParameterKey.KEY_SYSTEM_002).getValue();
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		long time = System.currentTimeMillis() - NumberUtil.toInt(query.get("hour"))*60*60*1000;
		String fromTime = simpleDateFormat.format(new Date(time));
		String toTime = simpleDateFormat.format(new Date());
		final List<BasicMap<String,Object>> rtn = new ArrayList<>();
		String signIn = "select qdlx,qdwz,lat,lng,cts from jz_qdxxb where aid = '"+StringUtil.toEmptyString(query.get("aid"))+"' "
				+ "and cts between '"+fromTime+"' and '"+toTime+"'";
		String alarm ="select f_content,f_address,f_lat as lat,f_lng as lng,f_solve,cts from jz_alarm where f_aid = '"+StringUtil.toEmptyString(query.get("aid"))+"' "
				+ "and cts between '"+fromTime+"' and '"+toTime+"'";
		Query mongoQuery = new Query();
		mongoQuery.addCriteria(Criteria.where("aid").is(StringUtil.toString(query.get("aid"))).and("time").gte(NumberUtil.toInt(parameterTimeString)*60).and("cts").gte(time));
		dbClient.find(new SQLAdapter(signIn),paginate,new RowDataListener() {
			@Override
			public void processData(BasicMap<String, Object> rowData) {
				rowData.put("time", DateUtil.format(rowData.get("cts"), "yyyy-MM-dd HH:mm:ss"));
				rowData.put("cts", DateUtil.format(rowData.get("cts"), "yyyyMMddHHmmss"));
				rowData.put("type", "1");
				rtn.add(rowData);
			}
		});
		dbClient.find(new SQLAdapter(alarm),paginate,new RowDataListener() {
			@Override
			public void processData(BasicMap<String, Object> rowData) {
				rowData.put("time", DateUtil.format(rowData.get("cts"), "yyyy-MM-dd HH:mm:ss"));
				rowData.put("cts", DateUtil.format(rowData.get("cts"), "yyyyMMddHHmmss"));
				rowData.put("type", "2");
				rtn.add(rowData);
			}
		});
		mongoClient.find(SupConst.Collections.REP_STAY_TIME, mongoQuery,paginate,new String[]{"location","time","cts","describe","address"},new RowDataListener() {
			@Override
			public void processData(BasicMap<String, Object> rowData) {
				long cts = NumberUtil.to_long(rowData.get("cts"));
				long time = NumberUtil.to_long(rowData.get("time"));
				int hour = (int) (time/3600);
				int minute = (int) ((time%3600)/60);
				int second = (int) ((time%3600)%60);
				rowData.put("stayTime", hour+":"+minute+":"+second);
				rowData.put("time", DateUtil.format(new Date(cts), "yyyy-MM-dd HH:mm:ss"));
				rowData.put("cts", DateUtil.format(new Date(cts), "yyyyMMddHHmmss"));
				rowData.put("type", "3");
				Object o = rowData.get("location");
				if(o!=null&& o instanceof Map){
					Map map = (Map)o;
					Object coordinates = map.get("coordinates");
					if(coordinates!=null && coordinates instanceof List){
						List ls = (List)coordinates;
						rowData.put("lng", (NumberUtil.toDouble(ls.get(0))));
						rowData.put("lat", (NumberUtil.toDouble(ls.get(1))));
					}
				}
				rtn.add(rowData);
			}
		});
		Collections.sort(rtn, new Comparator<BasicMap<String, Object>>(){
			@Override
			public int compare(BasicMap<String, Object> o1, BasicMap<String, Object> o2) {
				int r = 0;
				if(NumberUtil.to_long(o1.get("cts"))>NumberUtil.to_long(o2.get("cts"))){//toint导致排序失败，原因是位数不够造成精度损失
					r = 1;
				}else if (NumberUtil.to_long(o1.get("cts"))==NumberUtil.to_long(o2.get("cts"))) {
					r = 0;
				}else{
					r = -1;
				}
				return r;
			}
		});
		return rtn;
	}
	
	public List<BasicMap<String, Object>> findPersonActiviteInfo(BasicMap<String, Object> query,Paginate paginate){
		List<BasicMap<String, Object>> rtn = new ArrayList<>();
		// day1   day2
		int fromTime = NumberUtil.toInt(DateUtil.format(new Date(), "yyyyMMdd"));
		int toTime = fromTime;
		if(Util.isNotEmpty(query.get("day1"))){
			fromTime = NumberUtil.toInt(StringUtil.toEmptyString(query.get("day1")).replaceAll("\\-", ""));
			if(fromTime==0){
				fromTime =  NumberUtil.toInt(DateUtil.format(new Date(), "yyyyMMdd"));
			}
		}
		if(Util.isNotEmpty(query.get("day2"))){
			toTime = NumberUtil.toInt(StringUtil.toEmptyString(query.get("day2")).replaceAll("\\-", ""));
			if(toTime==0){
				toTime =  NumberUtil.toInt(DateUtil.format(new Date(), "yyyyMMdd"));
			}
		}
		
		String sqlstr = "select * from rep_jzryhdxxb  where f_aid = '"+StringUtil.toEmptyString(query.get("aid"))+"' "
					+ " and cdate >= "+fromTime+" and cdate <= "+toTime;
		SQLAdapter sqlAdapter = new SQLAdapter(sqlstr);
		rtn = dbClient.find(sqlAdapter, paginate, new RowDataListener() {
			@Override
			public void processData(BasicMap<String, Object> arg0) {
				arg0.put("time", DateUtil.format(arg0.get("cts"), "yyyy-MM-dd HH:mm:ss"));
			}
		}).getRows();
		
		Collections.sort(rtn, new Comparator<BasicMap<String, Object>>() {
			@Override
			public int compare(BasicMap<String, Object> o1, BasicMap<String, Object> o2) {
				Date d1 = (Date)(o1.get("cts"));
				Date d2 = (Date)(o2.get("cts"));
				return d2.compareTo(d1);
			}
		});
		return rtn;
	}
	
	/**
	 * 查询禁止区域信息
	 * @param f_aid
	 * @return
	 */
	public List<BasicMap<String, Object>> findForbidArea(String f_aid){
		List<BasicMap<String, Object>> list = new ArrayList<>();
		/**
		 * 查询进入禁止区域报警经纬度
		 */
		List<BasicMap<String, Object>> alarmList = new ArrayList<>();
		String alarmSqlStr = "select f_lat,f_lng from jz_alarm";
		SqlDbFilter alarmSqlDbFilter = new SqlDbFilter();
		alarmSqlDbFilter.eq("f_aid", StringUtil.toEmptyString(f_aid))
		.eq("f_type", CommandType.COMMAND_IN_TDQY);
		SQLAdapter alarmAdapter = new SQLAdapter(alarmSqlStr);
		alarmAdapter.setFilter(alarmSqlDbFilter);
		alarmList = dbClient.find(alarmAdapter);
		/**
		 * 查询当前人员对应禁止区域类型
		 */
		List<BasicMap<String, Object>> forbidList = new ArrayList<>();
		String forbidType = "select f_jrlx from sys_jzry_jrqy";
		SqlDbFilter forbidSqlDbFilter = new SqlDbFilter();
		forbidSqlDbFilter.eq("f_aid", StringUtil.toEmptyString(f_aid));
		SQLAdapter forbidAdapter = new SQLAdapter(forbidType);
		forbidAdapter.setFilter(forbidSqlDbFilter);
		forbidList = dbClient.find(forbidAdapter);
		/**
		 * 根据当前禁止区域类型查询禁止区域经纬度范围
		 */
		Map<String,BasicMap<String,Object>> tmpMap = new BasicMap<>();
		String typeStr = "";
		for (BasicMap<String, Object> map : forbidList) {
			if (Util.isEmpty(typeStr)) {
				typeStr = "'" + map.get("f_jrlx") + "'";
			} else {
				typeStr = typeStr + ",'" + map.get("f_jrlx") + "'";
			}
		}
		for(int j=0;j<alarmList.size();j++){
			BasicMap<String, Object> mongoQuery = new BasicMap<String, Object>();
			if (forbidList != null && forbidList.size() > 0) {
				mongoQuery.put("code", typeStr);
				mongoQuery.put("lng", alarmList.get(j).get("f_lng"));
				mongoQuery.put("lat", alarmList.get(j).get("f_lat"));
				String cmd = MongoScriptUtil.getMongoCommand("boundary-range-cmd02", mongoQuery);
				BasicMap<String, Object> tBasicMap = mongoClient.findOne(SupConst.Collections.SYS_PROHIBIT, cmd,
						new String[] { "boundary" });
				if(null!=tBasicMap) {
				tBasicMap.put("f_aid", StringUtil.toEmptyString(f_aid));
				String _id = StringUtil.toString(tBasicMap.get("_id"));
				if(tmpMap.get(_id)==null){
					tmpMap.put(_id, tBasicMap);
					list.add(tBasicMap);
				}
				}
			}
		}
		return list;
	}
	
	/**
	 * 查询当前越界人员基本信息
	 * @param f_aid
	 * @return
	 */
	public BasicMap<String, Object> findAlarmPersonDetail(String f_aid){
		BasicMap<String, Object> rtn = new BasicMap<>();
		String sqlstr = "select a.id,a.online,a.jglx,b.gdjzdmx from jz_jzryjbxx a left join jz_jzryjbxx_dz b on a.id = b.id";
		SqlDbFilter sqlDbFilter = new SqlDbFilter();
		sqlDbFilter.eq("a.id", f_aid);
		SQLAdapter sqlAdapter = new SQLAdapter(sqlstr);
		sqlAdapter.setFilter(sqlDbFilter);
		rtn = dbClient.findOne(sqlAdapter);
		BasicMap<String, Object> mongoData = mongoClient.findOne(ImConst.Collections.IM_CURRENT_LOCATION, Query.query(Criteria.where("aid").is(f_aid)));
		if(mongoData!=null){
			rtn.put("lat", mongoData.get("lat"));
			rtn.put("lng", mongoData.get("lng"));
		}
		return rtn;
	}
	
	public static boolean hasContainType(String typestr,String type) {
		boolean rtn = false;
		if(typestr!=null) {
			String[] types = typestr.split(",");
			for(String t:types) {
				if(t.equals(type)){
					rtn = true;
					return rtn;
				}
			}
		}
		return rtn;
	}
}
