package com.ehtsoft.supervise.services;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ehtsoft.common.services.SSOService;
import com.ehtsoft.fw.core.db.RowDataListener;
import com.ehtsoft.fw.core.db.SQLAdapter;
import com.ehtsoft.fw.core.db.SqlDbClient;
import com.ehtsoft.fw.core.db.SqlDbFilter;
import com.ehtsoft.fw.core.dto.BasicMap;
import com.ehtsoft.fw.core.services.AbstractService;
import com.ehtsoft.fw.utils.NumberUtil;
import com.ehtsoft.fw.utils.StringUtil;
import com.ehtsoft.fw.utils.Util;

/**
 * 
 * 决策总览及人民调解 的公共使用类
 * @author Administrator
 * @date 2018年4月19日
 *
 */
@Service("Rep_Rmtj_Test")
public class Rep_Rmtj_Test extends AbstractService {
	
	@Resource(name = "sqlDbClient")
	
	private SqlDbClient dbClient;
	
	@Resource(name="SSOService")
	private SSOService service;

	
	/**
	 * 
	 * 人民调解首页全区人民调解工作总览【图表】
	 * @return<br>
	 * 返回值格式:<br>
	 *
	 * @author Administrator
	 * @date   2018年4月20日
	 * 方法的作用：TODO
	 */
	public List<BasicMap<String, Object>> findQyrmtjzlzl() {
		
		String year1 = "2017";
		String year2 = "2016";
		
		//占比的计算
		String sqlstr = "SELECT sum(sl) as slz from REP_RMTJANJZL WHERE nd = '"+year1+"'";
		BasicMap<String, Object> map = dbClient.findOne(new SQLAdapter(sqlstr));
		Double slz = NumberUtil.to_double(map.get("slz"));//总案件数
		//同比的计算
		
		String sql = "select a.*,b.sl2 from " + 
				"(SELECT msbm,msmc,sum(sl) as sl1 from  REP_RMTJANJZL WHERE nd = '"+year1+"' GROUP BY msmc,msbm ORDER BY msbm asc ) as a " + 
				"LEFT JOIN  " + 
				"(SELECT msbm,msmc,sum(sl) as sl2 from  REP_RMTJANJZL WHERE nd = '"+year2+"' GROUP BY msmc,msbm ORDER BY msbm asc ) as b " + 
				"ON  a.msbm = b.msbm";
		
		SQLAdapter adapter = new SQLAdapter(sql);
		List<BasicMap<String, Object>> list = dbClient.find(adapter,new RowDataListener() {
			@Override
			public void processData(BasicMap<String, Object> rowData) {
				double sl2 = NumberUtil.to_double(rowData.get("sl2"));
				double sl1 = NumberUtil.to_double(rowData.get("sl1"));
				double tb = (sl1 - sl2)/sl2 * 100;
				double zb = sl1/slz*100;
				if (sl2 != 0.0 && sl1 != 0.0) {
					//占比
					rowData.put("zb", String.format("%.2f",zb));
					//同比增长
					rowData.put("tbzz", String.format("%.2f",tb));
					rowData.put("tbzzs", (int)(sl2 - sl1));
				}else {
					rowData.put("zb", "0.00");
					rowData.put("tbzz", "0.00");
					rowData.put("tbzzs","0");
				}
			}
		});
		return list;
	}
	
	
	
	
	/**
	 * 地图盟下的城市定位坐标的获取
	 * TODO(方法的描述，哪那个地方使用的等)
	 * @return<br>
	 * 返回值格式:  [{name:"锡林郭勒盟",value:[lng,lat,value,v2,]}]
	 *
	 * @author Administrator
	 * @date   2018年4月19日
	 * 方法的作用：【默认只检索 内蒙古自治区】【人民调解使用】
	 */
	public List<BasicMap<String, Object>> findMapInitialization_rmtj() {
		//获取设置好的盟市编码 【 KEY_SYSTEM_017 的常量标识 】
		String sqlstr = "SELECT f_value FROM SYS_PARAMETER WHERE f_id = 'KEY_SYSTEM_017'";
		SQLAdapter adapterstr = new SQLAdapter(sqlstr);
		BasicMap<String, Object> map = dbClient.findOne(adapterstr);
		String citycode =StringUtil.toString(map.get("f_value"));
		//地图所需数据【msmc，lat，lng,sl-人民调解总数【按年】】
		String sql="SELECT b.msmc,A .lat,A .lng,SUM (b.sl) AS sl,b.msbm " + 
				"FROM sys_region A   " + 
				"INNER JOIN REP_RMTJANJZL b ON b.msbm = A .regionid  " + 
				"WHERE A .lvl = '2'  " + 
				"AND A .parentid = '"+ citycode +"' " + 
				"AND nd = 2017 " + 
				"GROUP BY b.msmc, A .lat, A .lng, b.msbm " + 
				"ORDER BY  b.msbm asc ";
			SQLAdapter sqlAdapter = new SQLAdapter(sql);
			List<BasicMap<String, Object>> list1 = new ArrayList<>();
			List<BasicMap<String, Object>> list = dbClient.find(sqlAdapter,new RowDataListener() {
				@Override
				public void processData(BasicMap<String, Object> rowData) {
					if(NumberUtil.toInt(rowData.get("sl")) != 0) {
						System.out.println(rowData.get("sl") +"=========================");
						String str = rowData.get("lng")+","+rowData.get("lat")+","+rowData.get("sl");
						String[] a = str.split(",");
						List l = Arrays.asList(str.split(","));
						rowData.put("value", l);
						rowData.put("name", rowData.get("msmc"));
						list1.add(rowData);
					}
					
				}
			});
			return list1;
		}
	
	
	
	/**
	 * 地图盟下的城市定位坐标的获取
	 * TODO(方法的描述，哪那个地方使用的等)
	 * @return<br>
	 * 返回值格式:  [{name:"锡林郭勒盟",value:[lng,lat,value,v2,]}]
	 *
	 * @author Administrator
	 * @date   2018年4月19日
	 * 方法的作用：【默认只检索 内蒙古自治区】【决策总览使用】
	 */
	public List<BasicMap<String, Object>> findMapInitialization(String type) {
		if ("".equals(type)) {
			type = "15";
		}
		
		//获取设置好的盟市编码 【 KEY_SYSTEM_017 的常量标识 】
		String sqlstr = "SELECT f_value FROM SYS_PARAMETER WHERE f_id = 'KEY_SYSTEM_017'";
		SQLAdapter adapterstr = new SQLAdapter(sqlstr);
		BasicMap<String, Object> map = dbClient.findOne(adapterstr);
		String citycode =StringUtil.toString(map.get("f_value"));
		
		//地图所需数据【】
		String sql="SELECT b.msmc,A .lat,A .lng,sum(b.sl) as sl " + 
				"FROM  sys_region A " + 
				"INNER JOIN rep_jczlsjzs b ON b.msbm = A .regionid " + 
				"WHERE b.lx = '"+ type +"' " + 
				"AND A .lvl = '2' " +
				"AND a.parentid = '"+ citycode +"'" + 
				"GROUP BY b.msmc, A .lat, A .lng";
			SQLAdapter sqlAdapter = new SQLAdapter(sql);
			List<BasicMap<String, Object>> list1 = new ArrayList<>();
			List<BasicMap<String, Object>> list = dbClient.find(sqlAdapter,new RowDataListener() {
				@Override
				public void processData(BasicMap<String, Object> rowData) {
					if(NumberUtil.toInt(rowData.get("sl")) != 0) {
						System.out.println(rowData.get("sl") +"=========================");
						String str = rowData.get("lng")+","+rowData.get("lat")+","+rowData.get("sl");
						String[] a = str.split(",");
						List l = Arrays.asList(str.split(","));
						rowData.put("value", l);
						rowData.put("name", rowData.get("msmc"));
						list1.add(rowData);
					}
					
				}
			});
			return list1;
		}
	
	
	
	
	/**
	 * 
	 * 根据城市的名称检索数据
	 * 返回值格式:<br>
	 *
	 * @author Administrator
	 * @date   2018年4月16日
	 * 方法的作用：TODO
	 */
	public  BasicMap<String, Object> findDateByName(String name) {
		String sql = "select * from rep_rmtj_ys ";
		SQLAdapter adapter = new SQLAdapter(sql);
		SqlDbFilter filter = new SqlDbFilter();
		filter.like("name", name);
		adapter.setFilter(filter);
	return dbClient.findOne(adapter);
	}
	
	
	/**
	 * 
	 * 二级界面的【左上饼状图】- name,调解员人数
	 * @param name
	 * @return<br>
	 * 返回值格式:<br>
	 *
	 * @author Administrator
	 * @date   2018年4月16日
	 * 方法的作用：TODO
	 */
	public  List<BasicMap<String, Object>>  findDate_renyuan() {
		String sql = "select name,renyuan as value from rep_rmtj_ys ";
		SQLAdapter adapter = new SQLAdapter(sql);
	return dbClient.find(adapter);
	}
	
	/**
	 * 
	 * 人民调解二级界面[右下角]
	 * @param name
	 * @return<br>
	 * 返回值格式:<br>
	 *
	 * @author Administrator
	 * @date   2018年4月17日
	 * 方法的作用：TODO
	 */
	public  List<BasicMap<String, Object>> findJfTotal(String year ,String name){
		String msmc = "A.msmc,";
		if(Util.isEmpty(name)) {
			msmc = "";
			name = "";
		}
		String sql = "select * from (SELECT "+msmc+"a.jflx,b.f_name AS NAME,sum(sl) sl " + 
				"FROM rep_rmtjajjf A   " + 
				"LEFT JOIN sys_dictionary b ON A .jflx = b.f_code  " + 
				"WHERE b.f_typecode = 'SYS104' and a.nd = '"+ NumberUtil.toInt(year) +"' and msmc like '"+ name +"%'" + 
				"group by "+msmc+"a.jflx,b.f_name) b " + 
				"order by 	CAST(jflx as INTEGER) desc ";
		SQLAdapter adapter = new SQLAdapter(sql);
		return dbClient.find(adapter);
	}
	
	/*
	 * 2017
	 */
	public  List<BasicMap<String, Object>> findJfTotals(String name){
		String msmc = "A.msmc,";
		if(Util.isEmpty(name)) {
			msmc = "";
			name = "";
		}
		String sql = "select * from (SELECT "+msmc+"a.jflx,b.f_name AS NAME,sum(sl) sl " + 
				"FROM rep_rmtjajjf A   " + 
				"LEFT JOIN sys_dictionary b ON A .jflx = b.f_code  " + 
				"WHERE b.f_typecode = 'SYS104' and a.nd = 2017 and msmc like '"+ name +"%'" + 
				"group by "+msmc+"a.jflx,b.f_name) b " + 
				"order by 	CAST(jflx as INTEGER) desc ";
		SQLAdapter adapter = new SQLAdapter(sql);
		return dbClient.find(adapter);
	}
	
	
	/**
	 * 
	 * 决策总览
	 * @return<br>
	 * 返回值格式:<br>
	 *
	 * @author Administrator
	 * @date   2018年4月17日
	 * 方法的作用：TODO
	 */
	public List<BasicMap<String, Object>> findAll(String type) {
		String sql = "SELECT * from REP_JCZLSJZS ";
		SqlDbFilter filter = new SqlDbFilter();
		filter.eq("lx",type);
		SQLAdapter adapter = new SQLAdapter(sql);
		adapter.setFilter(filter);
		return dbClient.find(adapter);

	}
	
	
	
	/**
	 * 
	 *  决策总览的 事务所 、人员分类的总数
	 * @return<br>
	 * 返回值格式:<br>
	 *
	 * @author Administrator
	 * @date   2018年4月17日
	 * 方法的作用：TODO
	 */
	public  List<BasicMap<String, Object>> findAllsl() {
		String sql = "SELECT sum(sl) as sl,lxmc,lx from rep_jczlsjzs GROUP BY lxmc,lx ORDER BY lx asc ";
		SQLAdapter adapter  = new SQLAdapter(sql);
		return dbClient.find(adapter);
	}
	
	
	/**
	 * 
	 * 返回同比增长 【人民调解  二级界面】
	 * @return<br>
	 * 返回值格式:<br>
	 *
	 * @author Administrator
	 * @date   2018年4月17日
	 * 方法的作用：TODO
	 */
	public List<BasicMap<String, Object>> findTbzz(String name) {
		String msmc = "msmc,";
		String onwhere = " a.msmc = b.msmc and  ";
		if(Util.isEmpty(name)) {
			msmc = "";
			name = "";
			onwhere = " ";
		}
		String sql = "select a.*,sl2,c.f_name as dictname from  " + 
				"(SELECT "+msmc+" jflx,sum(sl) sl1 from rep_rmtjajjf where msmc like '"+ name + "%' and nd = 2017 and jd = 1 group by "+msmc+"  jflx) a " + 
				"left join  " + 
				"(SELECT "+msmc+" jflx,sum(sl) sl2 from rep_rmtjajjf where msmc like '"+ name + "%' and nd = 2018 and jd = 1 group by "+msmc+" jflx) b " + 
				"on "+ onwhere +" a.jflx = b.jflx " + 
				"left join sys_dictionary c on c.f_code = a.jflx and c.f_typecode = 'SYS104' where 1 = 1 order by CAST(a.jflx as INTEGER) desc ";
		
		SQLAdapter adapter = new SQLAdapter(sql);
		List<BasicMap<String, Object>> list = dbClient.find(adapter,new RowDataListener() {
			@Override
			public void processData(BasicMap<String, Object> rowData) {
				double sl2 = NumberUtil.to_double(rowData.get("sl2"));
				double sl1 = NumberUtil.to_double(rowData.get("sl1"));
				double tb = (sl2 - sl1)/sl1 * 100;
				if (sl2 != 0.0 && sl1 != 0.0) {
					rowData.put("tbzz", String.format("%.2f",tb));
					rowData.put("tbzzs", (int)(sl2 - sl1));
				}else {
					rowData.put("tbzz", "0.00");
					rowData.put("tbzzs","0");
				}
				
				
			}
		});
		return list;
	
	}
	
	
	
	/**
	 * 
	 * 按月份检索人员调解案件数
	 * 返回值格式:<br>
	 *
	 * @author Administrator
	 * @date   2018年4月17日
	 * 方法的作用：TODO
	 */
	public List<BasicMap<String, Object>> findAllByMonth(String name) {
		
		String sql = "SELECT sum(sl) as sl,yf,nd from rep_rmtjbymonth "
				+ "where msmc like '"+ name +"%' GROUP BY yf,nd ORDER BY nd desc , yf DESC LIMIT 6 ";
		SQLAdapter adapter = new SQLAdapter(sql);
		List<BasicMap<String, Object>> list = dbClient.find(adapter,new RowDataListener() {
			@Override
			public void processData(BasicMap<String, Object> rowData) {
				rowData.put("name",rowData.get("nd")+"年"+rowData.get("yf")+"月");
			}
		});

		Collections.reverse(list);

		return list ;
	}
	
	
	/**
	 * 
	 * 左边四项的点击事件
	 * @return<br>
	 * 返回值格式:<br>
	 *
	 * @author Administrator
	 * @date   2018年4月17日
	 * 方法的作用：TODO
	 */
	public List<BasicMap<String, Object>> findJyzs(String type) {
		
		String sql = "SELECT sum(sl) as sl,msmc from rep_jczlsjzs  WHERE lx in ('"+ type +"') GROUP BY  msmc ";
		SQLAdapter adapter  = new SQLAdapter(sql);
		
		return dbClient.find(adapter);
	}
	
	
	/**
	 * 
	 * 进入检索地图数据
	 * @return<br>
	 * 返回值格式:<br>
	 *
	 * @author Administrator
	 * @date   2018年4月17日
	 * 方法的作用：TODO
	 */
	public List<BasicMap<String, Object>> findDtData() {
		String  sql = "SELECT sum(sl) as sl,msmc,msbm from rep_jczlsjzs  WHERE lx in ('15') GROUP BY  msmc,msbm order by msbm asc ";
		SQLAdapter adapter = new SQLAdapter(sql);
		return dbClient.find(adapter);

	}
	
	
}
