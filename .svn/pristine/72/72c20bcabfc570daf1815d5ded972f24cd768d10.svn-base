package com.ehtsoft.supervise.services;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ehtsoft.common.services.SSOService;
import com.ehtsoft.fw.core.db.MongoClient;
import com.ehtsoft.fw.core.db.RowDataListener;
import com.ehtsoft.fw.core.db.SQLAdapter;
import com.ehtsoft.fw.core.db.SqlDbClient;
import com.ehtsoft.fw.core.dto.BasicMap;
import com.ehtsoft.fw.core.services.AbstractService;
import com.ehtsoft.fw.core.sso.User;
import com.ehtsoft.fw.utils.DateUtil;
import com.ehtsoft.fw.utils.NumberUtil;
import com.ehtsoft.fw.utils.StringUtil;
import com.ehtsoft.supervise.utils.DateUtils;

/**
 * 
 * pad端综合统计分析页面
 * @创建人  ：liuzhih
 */
@Service("PadZhtjService")
public class PadZhtjService  extends AbstractService  {
	
	@Resource(name = "sqlDbClient")
	private SqlDbClient dbClient;
	
	@Resource(name="SSOService")
	private SSOService sso;
	
	@Resource(name="mongoClient")
	private MongoClient mongoClient;

	
	/**
	 *  当日综合指标统计
	 */
	public BasicMap<String, Object> findZhtjCount(BasicMap<String, Object> query){
		User user=sso.getUser();
		String orgId=user.getOrgidsByWhereIn();
		SimpleDateFormat sf=new SimpleDateFormat("yyyyMMdd");
		String cdate=sf.format(new Date());
		BasicMap<String, Object> map = new BasicMap<>();
		//矫正人数
		String jzryCount = "select count(*) as jzryCount from jz_jzryjbxx where JCJZ='0' and  SFJS = '1' and orgid in ( "+orgId+ " ) ";
		//签到类型人数
		String qdlxCount = "select count(*) as qdsl,qdlx  from rep_qdxxb  where   aid in (select id  from jz_jzryjbxx  where  orgid in ( "+orgId+ " )  )   and cdate='"+cdate+"'   group by qdlx ";
		//调结案件总数
		String caseNum = "select count(*) as caseNum from rmtj_tjajxx   where  orgid in ( "+orgId+ " )";
		//心跳检查总数
		String xtjcCount = "select  count(*) as xtjcCount from REP_XTJC where orgid  in  ( "+orgId+" )";
		//会面次数
		String hmCount = "select  count(*) as  hmCount from REP_HMQK where orgid in (  "+orgId+" ) ";
	    //报警次数
		String alarmCount = "select count(*) as alarmCount from jz_alarm where  f_aid in (select id  from jz_jzryjbxx  where  orgid in ( "+orgId+ " )  )   and cdate='"+cdate+"' ";
		//接受矫正人员数
		String jzryCount_js = "SELECT count(*) as jzryCount_js FROM jz_jzryjbxx where  sfcj = 1 and orgid in("+ orgId+ ") and  cdate= '"+ cdate+ "'";
		BasicMap<String, Object> jzryMap=dbClient.findOne(jzryCount);
		if(jzryMap!=null){
			map.put("jzryCount",jzryMap.get("jzryCount"));
		}else{
			map.put("jzryCount","0");
		}
		
		SQLAdapter sqlAdapter = new SQLAdapter(qdlxCount);
		List<BasicMap<String, Object>> ListQdMap=dbClient.find(sqlAdapter);
		if(ListQdMap!=null&&ListQdMap.size()>0){
			for(BasicMap<String,Object>  tempmap:ListQdMap){
				//1 指纹签到  2 声纹签到  3 人脸签到
				if("1".equals(tempmap.get("qdlx").toString())){
					map.put("zwqdCount",tempmap.get("qdsl"));
				}
				if("2".equals(tempmap.get("qdlx").toString())){
					map.put("swqdCount",tempmap.get("qdsl"));
				}
				if("3".equals(tempmap.get("qdlx").toString())){
					map.put("rlqdCount",tempmap.get("qdsl"));
				}
			}
		}else{
			map.put("zwqdCount","0");
			map.put("swqdCount","0");
			map.put("rlqdCount","0");
		}
		
		BasicMap<String, Object> caseMap=dbClient.findOne(caseNum);
		if(caseMap!=null){
			map.put("caseNum",caseMap.get("caseNum"));
		}else{
			map.put("caseNum","0");
		}
		
	
		BasicMap<String, Object> xtjcMap=dbClient.findOne(xtjcCount);
		if(xtjcMap!=null){
			map.put("xtjcCount",xtjcMap.get("xtjcCount"));
		}else{
			map.put("xtjcCount","0");
		}

		BasicMap<String, Object> hmMap=dbClient.findOne(hmCount);
		if(hmMap!=null){
			map.put("hmCount",hmMap.get("hmCount"));
		}else{
			map.put("hmCount","0");
		}
		
		BasicMap<String, Object> alarmMap=dbClient.findOne(alarmCount);
		if(alarmMap!=null){
			map.put("alarmCount",alarmMap.get("alarmCount"));
		}else{
			map.put("alarmCount","0");
		}
		
		//接收矫正人员数【新增】
		BasicMap<String, Object> jzryCount_jsMap=dbClient.findOne(jzryCount_js);
		if(alarmMap!=null){
			map.put("jzryCount_js",jzryCount_jsMap.get("jzryCount_js"));
		}else{
			map.put("jzryCount_js","0");
		}
		return map;
	}
	
	/**
	 * pad端签到统计分析
	 * 查询签到信息
	 * @param query
	 * @return
	 * [
	 * 	{
	 * 		aid:签到人员id
	 * 		qdlx:签到类型
	 * 		cts:签到时间
	 * 		xm:姓名
	 * 		qdwz:签到位置
	 * 	}
	 * ]
	 */
	public List<BasicMap<String,Object>> findQdList(BasicMap<String, Object> query){
		SimpleDateFormat sf=new SimpleDateFormat("yyyyMMdd");
		String qdlx=query.get("qdlx").toString();
		User user=sso.getUser();
		String orgId=user.getOrgidsByWhereIn();
		String cdate=sf.format(new Date());
		String sqlstr = "select a.aid,a.qdlx,a.qdwz,a.cts,b.xm,a.lng,a.lat from rep_qdxxb a join JZ_JZRYJBXX b on a.aid = b.id  where   b.orgid  in  ( "+orgId+" )   and a.cdate='"+cdate+"'  and a.qdlx='"+qdlx+"' order by cts desc";
		SQLAdapter sqlAdapter = new SQLAdapter(sqlstr);
		List<BasicMap<String,Object>> list = dbClient.find(sqlAdapter,new RowDataListener() {
			@Override
			public void processData(BasicMap<String, Object> rowData) {
				rowData.put("cts", DateUtil.format(rowData.get("cts"), "yyyy-MM-dd HH:mm:ss"));
				if(NumberUtil.toInt(rowData.get("qdlx"))==1){
					rowData.put("jdlxm", "指纹签到");
				}
				if(NumberUtil.toInt(rowData.get("qdlx"))==2){
					rowData.put("jdlxm", "声纹签到");
				}
				if(NumberUtil.toInt(rowData.get("qdlx"))==3){
					rowData.put("jdlxm", "人脸签到");
				}
			}
		});
		return list;
	}
	
	/**
	 * pad端报警信息列表
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
	public List<BasicMap<String, Object>>  findAlarmList(BasicMap<String, Object> query){
		SimpleDateFormat sf=new SimpleDateFormat("yyyyMMdd");
		String cdate=sf.format(new Date());
		User user=sso.getUser();
		String orgId=user.getOrgidsByWhereIn();
		String sqlstr = "select a.f_aid  aid,a.f_lat lat,a.f_lng lng,a.f_type,a.f_content,a.f_address  address ,a.cts,b.xm,b.xb,b.mz,b.sfzh,a.cdate from JZ_ALARM a left join JZ_JZRYJBXX b on a.f_aid = b.id ";
		sqlstr=sqlstr+"  where b.orgid  in  ( "+orgId+" )   and  a.cdate='"+cdate+"'     order  by a.cts  desc ";
		SQLAdapter sqlAdapter = new SQLAdapter(sqlstr);
		List<BasicMap<String,Object>> list = dbClient.find(sqlAdapter, new RowDataListener() {
			@Override
			public void processData(BasicMap<String, Object> rowData) {
				rowData.put("cts", DateUtil.format(rowData.get("cts"), "yyyy-MM-dd HH:mm:ss"));
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
	 * pad端心跳检查信息列表
	 */
	public List<BasicMap<String, Object>>  findXtjcList(BasicMap<String, Object> query){
		SimpleDateFormat sf=new SimpleDateFormat("yyyyMMdd");
		String cdate=sf.format(new Date());
		User user=sso.getUser();
		String orgId=user.getOrgidsByWhereIn();
		String sqlstr = "select a.aid  aid,a.xlz,b.xm,b.xb,b.mz,b.sfzh,a.cdate,a.cts from rep_xtjc a left join JZ_JZRYJBXX b on a.aid = b.id ";
		sqlstr=sqlstr+"  where  b.orgid  in  ( "+orgId+" )  and  a.cdate='"+cdate+"'   order  by a.cts  desc ";
		SQLAdapter sqlAdapter = new SQLAdapter(sqlstr);
		List<BasicMap<String,Object>> list = dbClient.find(sqlAdapter, new RowDataListener() {
			@Override
			public void processData(BasicMap<String, Object> rowData) {
				rowData.put("cts", DateUtil.format(rowData.get("cts"), "yyyy-MM-dd HH:mm:ss"));
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
	 * pad端会面信息列表
	 */
	public List<BasicMap<String, Object>>  findHmqkList(BasicMap<String, Object> query){
		SimpleDateFormat sf=new SimpleDateFormat("yyyyMMdd");
		String cdate=sf.format(new Date());
		User user=sso.getUser();
		String orgId=user.getOrgidsByWhereIn();
		String sqlstr = "select a.aid  aid,a.HMSJ,a.HMRYMC,a.HMWZ,b.xm,b.xb,b.mz,b.sfzh,a.cdate,a.cts from REP_HMQK  a left join JZ_JZRYJBXX b on a.aid = b.id ";
		sqlstr=sqlstr+"  where  b.orgid  in  ( "+orgId+" )  and  a.cdate='"+cdate+"'   order  by a.cts  desc ";
		SQLAdapter sqlAdapter = new SQLAdapter(sqlstr);
		List<BasicMap<String,Object>> list = dbClient.find(sqlAdapter, new RowDataListener() {
			@Override
			public void processData(BasicMap<String, Object> rowData) {
				rowData.put("hmsj", DateUtil.format(rowData.get("HMSJ"), "yyyy-MM-dd HH:mm:ss"));
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
	 * 
	 * pad人民调节分析
	 * @param query
	 * @return<br>
	 * 返回值格式:List<BasicMap<String, Object>>
	 *
	 * @author Administrator
	 * @date   2018年3月21日
	 * 检索条件：按天【前推7天】、按月【前推7月】、按季度【前推3个季度】
	 */
	public List<BasicMap<String, Object>> findAdjustment(BasicMap<String, Object> query) {
		List<BasicMap<String, Object>> list = new ArrayList<>();
		BasicMap<String , Object> map = new BasicMap<>();
		//根据获取的type： 0 天  1 月   2 季度 进行检索
		String date = ""; //当前日期【天/月/季度】
		String Beforedate = "";//前推的日期
		String sql ="";
		//按天
		if ("0".equals(query.get("type"))) {
			date = DateUtils.getDays();
			Beforedate = DateUtils.getAfterDayDate("-6");
		}
		//按月
		if ("1".equals(query.get("type"))) {
			date = DateUtils.getSdfMonths()+"0"+1+"";
			Beforedate = DateUtils.getFrontSdfMonthSev()+"0"+1+"";
		}
		//按季度【当前季度】
		if ("2".equals(query.get("type"))) {
				//调用
			  list = findAdjustmentByQuarter();
			  return list;
		}
		//统计柱状图
		 sql = "select count(*) AS TJZS,cdate  from RMTJ_TJAJXX WHERE cdate between "
					+ Beforedate+ " and "+ date+ " GROUP BY cdate ORDER BY cdate asc";
		SQLAdapter sqlAdapter = new SQLAdapter(sql);
		List<BasicMap<String, Object>> list1 = dbClient.find(sqlAdapter);
		map.put("total", list1);
		//口头调节
		String sqlstr = "select count(tjlx) as tjlx_kt from RMTJ_TJAJXX WHERE tjlx = '1' and cdate between "
				+ Beforedate+ " and "+ date+ "";
		SQLAdapter sqlAdapter1 = new SQLAdapter(sqlstr);
		List<BasicMap<String, Object>> list2 = dbClient.find(sqlAdapter1);
		map.put("total_kt", list2);	
		//书面调节
		String sqlstrs = "select count(tjlx) as tjlx_sm from RMTJ_TJAJXX WHERE tjlx = '2' and cdate between "
				+ Beforedate+ " and "+ date+ "";
		SQLAdapter sqlAdapter2 = new SQLAdapter(sqlstrs);
		List<BasicMap<String, Object>> list3 = dbClient.find(sqlAdapter2);
		map.put("total_sm", list3);
		
		list.add(map);
		return list;

	}
	
	/**
	 * 
	 * 根据返回的季度集合进行 检索 【被 findAdjustment 调用】
	 * @return<br>
	 * 返回值格式:List<BasicMap<String, Object>>
	 *
	 * @author Administrator
	 * @date   2018年3月21日
	 * 
	 */
	public List<BasicMap<String, Object>>  findAdjustmentByQuarter() {
		List<BasicMap<String, Object>> list = new ArrayList<>();
		List<BasicMap<String, Object>> li = DateUtils.getBeforQuarterThree(DateUtil.getMonth(),DateUtil.getYear());
		if (li.size() > 0) {
			for (int i = 0; i < li.size(); i++) {
				
				BasicMap<String, Object> map = new BasicMap<>();
				
				String date =StringUtil.toString(li.get(i).get("quarterend"));
				String Beforedate =StringUtil.toString(li.get(i).get("quarterstart"));
				
				String sql = "select count(*) AS TJZS from RMTJ_TJAJXX WHERE cdate between "+ Beforedate+ " and "+ date+ "";
				SQLAdapter sqlAdapter = new SQLAdapter(sql);
				List<BasicMap<String, Object>> list1 = dbClient.find(sqlAdapter);
				String total =StringUtil.toString(li.get(i).get("quarterstart"));//total为季度的开始日期作为换算【排序】季度的条件
				map.put(total, list1);
				
				//口头调节
				String sqlstr = "select count(tjlx) as tjlx_kt from RMTJ_TJAJXX WHERE tjlx = '1' and cdate between "
						+ Beforedate+ " and "+ date+ "";
				SQLAdapter sqlAdapter1 = new SQLAdapter(sqlstr);
				List<BasicMap<String, Object>> list2 = dbClient.find(sqlAdapter1);
				map.put("total_kt", list2);	
				
				//书面调节
				String sqlstrs = "select count(tjlx) as tjlx_sm from RMTJ_TJAJXX WHERE tjlx = '2' and cdate between "
						+ Beforedate+ " and "+ date+ "";
				SQLAdapter sqlAdapter2 = new SQLAdapter(sqlstrs);
				List<BasicMap<String, Object>> list3 = dbClient.find(sqlAdapter2);
				map.put("total_sm", list3);
				
				list.add(map);
				
			}
		}
	return list;
 
	}
	
	/**
	 * 
	 * 矫正饼状图
	 * @return<br>
	 * 返回值格式: BasicMap<String, Object>
	 *
	 * @author Administrator
	 * @date   2018年3月24日
	 * 方法的作用：TODO
	 */
	public BasicMap<String, Object> findJzTwo() {
		List<BasicMap<String, Object>> li = new ArrayList<>();
		BasicMap<String, Object> map1 = new BasicMap<>();
		//矫正类别
		List<BasicMap<String, Object>> list_lx = new ArrayList<>();
		String sql_lx = "SELECT count(a.*) as value, b.f_name as name FROM JZ_JZRYJBXX a LEFT JOIN sys_dictionary b ON a.jglx = b.f_code WHERE b.f_typecode ='SYS114' GROUP BY name";
		SQLAdapter adapter1 = new SQLAdapter(sql_lx);
		List<BasicMap<String, Object>> list = dbClient.find(adapter1);
		for (int i = 0; i < list.size(); i++) {
			BasicMap<String, Object> map = new BasicMap<>();
			map.put("value", list.get(i).get("value"));
			map.put("name", list.get(i).get("name"));
			list_lx.add(map);
		}
		
		//年龄分布
		List<BasicMap<String, Object>> list_nl = new ArrayList<>();
		String sql_nl = "SELECT count(a.*) as value, b.f_name as name FROM JZ_JZRYJBXX a LEFT JOIN sys_dictionary b ON a.WCN = b.f_code WHERE b.f_typecode ='SYS035' GROUP BY name";
		SQLAdapter adapter2 = new SQLAdapter(sql_nl);
		List<BasicMap<String, Object>> list2 = dbClient.find(adapter2);
		for (int i = 0; i < list2.size(); i++) {
			BasicMap<String, Object> map = new BasicMap<>();
			map.put("value", list2.get(i).get("value"));
			map.put("name", list2.get(i).get("name"));
			list_nl.add(map);
		}
		
		map1.put("li_lx", list_lx);
		map1.put("li_nl", list_nl);
		li.add(map1);
		return map1;
	}
	
	//人民调节
	/**
	 * 
	 * 人民调节分析
	 * @return<br>
	 * 返回值格式: List<BasicMap<String, Object>>
	 *
	 * @author Administrator
	 * @date   2018年3月24日
	 * 方法的作用：TODO
	 */
	public BasicMap<String, Object> findRmtj() {
		List<BasicMap<String, Object>> list = new ArrayList<>();
		BasicMap<String, Object> map = new BasicMap<>();
		String sql = "SELECT count(a.*) as value, b.f_name as name FROM rmtj_tjajxx a "
					+ "LEFT JOIN sys_dictionary b ON a.jflb = b.f_code "
					+ "WHERE b.f_typecode ='SYS104' GROUP BY name ORDER BY VALUE DESC";
		SQLAdapter adapter  = new SQLAdapter(sql);
		List<BasicMap<String, Object>> list1 = dbClient.find(adapter);
		
		String sqlstr = "SELECT count(a.*) as value, b.f_name as name FROM rmtj_tjajxx a "
					+ "LEFT JOIN sys_dictionary b ON a.TJJG = b.f_code "
					+ "WHERE b.f_typecode ='SYS110' GROUP BY name ORDER BY VALUE DESC";
		SQLAdapter adapterstr  = new SQLAdapter(sqlstr);
		List<BasicMap<String, Object>> list2 = dbClient.find(adapterstr);
		
		map.put("list_lb", list1);//调节类型
		map.put("list_jg", list2);//调节结果
		list.add(map);
		return map;
	}
	
	/**
	 * 
	 * 法律援助分析
	 * @return<br>
	 * 返回值格式: List<BasicMap<String, Object>>
	 *
	 * @author Administrator
	 * @date   2018年3月24日
	 * 方法的作用：TODO
	 */
	public BasicMap<String, Object> findFlyz() {
		List<BasicMap<String, Object>> list = new ArrayList<>();
		BasicMap<String, Object> map = new BasicMap<>();
		//事项类型
		String sql = "SELECT COUNT (A .*) AS VALUE , b.f_name AS NAME " + 
				"FROM sys_dictionary b " + 
				"LEFT JOIN FLYZ_AJB A ON A .SXLX = b.f_code " + 
				"WHERE b.f_typecode = 'SYS118' " + 
				"GROUP BY NAME";
		SQLAdapter adapter = new SQLAdapter(sql);
		List<BasicMap<String, Object>> list1 = dbClient.find(adapter);
		
		//TODO
		//受援人类别  
		String sqlstr = "SELECT COUNT (*) AS  VALUE, c.f_name as name FROM  FLYZ_SARY A "
				+ "LEFT JOIN FLYZ_SQRSFLBB b ON A .AJID = b.SYRID "
				+ "LEFT JOIN sys_dictionary c ON b.SQRSFLB = c.f_code  "
				+ "WHERE  c.f_typecode ='SYS132'  AND  a.RYXXLB = '1'  "
				+ "GROUP BY  name";
		SQLAdapter adapterstr = new SQLAdapter(sqlstr);
		List<BasicMap<String, Object>> list2 = dbClient.find(adapterstr);
		
		map.put("list_sx", list1);
		map.put("list_syrlb", list2);
		list.add(map);
		return map;

	}
	
	//法律咨询情况分析
	public BasicMap<String, Object> findFlzx() {
		List<BasicMap<String, Object>> list = new ArrayList<>();
		BasicMap<String, Object> map = new BasicMap<>();
		//咨询事项类型
		String sql = "SELECT count(*),b.f_name as name FROM FLYZ_ZXB  a LEFT JOIN sys_dictionary b ON a.ZXSXLXBM = b.f_code WHERE b.f_typecode ='SYS118' GROUP BY name";
		SQLAdapter adapter = new SQLAdapter(sql);
		List<BasicMap<String, Object>> list1 = dbClient.find(adapter);
		
		//身份类别 	
		String sqlstr = "SELECT COUNT (*) AS  VALUE, c.f_name as name FROM  FLYZ_SARY A " + 
				"LEFT JOIN FLYZ_SQRSFLBB b ON A .AJID = b.SYRID " + 
				"LEFT JOIN sys_dictionary c ON b.SQRSFLB = c.f_code " + 
				"WHERE  c.f_typecode ='SYS132'  AND  a.RYXXLB = '2'  " + 
				"GROUP BY  name";
		SQLAdapter adapterstr = new SQLAdapter(sqlstr);
		List<BasicMap<String, Object>> list2 = dbClient.find(adapterstr);
		
		map.put("list_zxsx", list1);
		map.put("list_zxsf", list2);
		list.add(map);
		return map;
		
	}
	
	//法治宣传情况分析
	public BasicMap<String, Object> findFlxc() {
		List<BasicMap<String, Object>> list = new ArrayList<>();
		BasicMap<String, Object> map = new BasicMap<>();
		//针对人群
		String sql = "SELECT count(*) as value,F_ZDRQ as name FROM FZXC_PFHDDJ GROUP BY name";
		SQLAdapter adapter = new SQLAdapter(sql);
		List<BasicMap<String, Object>> list1 = dbClient.find(adapter);
		
		//活动形式
		String sqlstr = "SELECT count(*) as value,F_HDXS as name FROM FZXC_PFHDDJ GROUP BY name"; //
		SQLAdapter adapterstr = new SQLAdapter(sqlstr);
		List<BasicMap<String, Object>> list2 = dbClient.find(adapterstr);
		
		map.put("list_sx", list1);
		map.put("list_sf", list2);
		list.add(map);
		return map;
		
	}
	//基层法律服务登记情况分析   FLFW_JCFLFWDJB 
	public BasicMap<String, Object> findJcflfw() {
		List<BasicMap<String, Object>> list = new ArrayList<>();
		BasicMap<String, Object> map = new BasicMap<>();
		//工作类型
		String sql = "SELECT count(*) as total ,b.f_name as name FROM FLFW_JCFLFWDJB a LEFT JOIN sys_dictionary b ON a.gzlx = b.f_code WHERE b.f_typecode ='SYS139' GROUP BY name";
		SQLAdapter adapter = new SQLAdapter(sql);
		List<BasicMap<String, Object>> list1 = dbClient.find(adapter);
		map.put("list_sx", list1);
		list.add(map);
		return map;
		
	}
	//安置帮教分析
	public List<BasicMap<String, Object>> findAzbj() {
		List<BasicMap<String, Object>> list1 = new ArrayList<>();
		//按天
		String date = DateUtils.getDays();
		String Beforedate = DateUtils.getFrontSdfMonthSev();
		//统计柱状图
		String sql = "SELECT count(*) as azzs,cdate FROM REP_AZBJ_RYLYHZ WHERE cdate between "
					+ Beforedate+"01"+ " and "+ date+ " GROUP BY cdate ORDER BY cdate asc";
		SQLAdapter sqlAdapter = new SQLAdapter(sql);
		List<BasicMap<String, Object>> list = dbClient.find(sqlAdapter,new RowDataListener() {
			@Override
			public void processData(BasicMap<String, Object> rowData) {
				String str = StringUtil.toString(rowData.get("cdate")).substring(0, 4)+"年"+ StringUtil.toString(rowData.get("cdate")).substring(4, 6)+"月";
				String[] a = str.split(",");
				List l = Arrays.asList(str.split(","));
				rowData.put("value", StringUtil.toString(rowData.get("azzs")));
				rowData.put("name", str);
				list1.add(rowData);
			}
		});
		
		return list1;

	}
	
}
