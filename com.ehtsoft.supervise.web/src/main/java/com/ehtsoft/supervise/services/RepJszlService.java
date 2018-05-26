package com.ehtsoft.supervise.services;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;

import com.ehtsoft.common.services.SSOService;
import com.ehtsoft.fw.core.db.MongoClient;
import com.ehtsoft.fw.core.db.RowDataListener;
import com.ehtsoft.fw.core.db.SQLAdapter;
import com.ehtsoft.fw.core.db.SqlDbClient;
import com.ehtsoft.fw.core.dto.BasicMap;
import com.ehtsoft.fw.utils.NumberUtil;
import com.ehtsoft.fw.utils.StringUtil;

/**
 * 决策总揽
 * @author Administrator
 *
 */
@Service("RepJszlService")
public class RepJszlService {
	
	@Resource(name = "sqlDbClient")
	private SqlDbClient dbClient;
	
	
	@Resource(name="mongoClient")
	private MongoClient mongoClient;
	
	@Resource(name="SSOService")
	private SSOService service;
	
	
	/**
	 * 区域检索 【通过返回的 省市区的级别做判断】
	 * @param cityid
	 * @param areaid
	 * @return
	 */
	public BasicMap<String, Object> findRegionLvl(String cityid,String areaid) {
		BasicMap<String, Object> map = new BasicMap<>();
		List<BasicMap<String, Object>> list1 = new ArrayList<>();
		List<BasicMap<String, Object>> list2 = new ArrayList<>();
		String sql = "";
		SQLAdapter sqlAdapter;
		if (!"".equals(cityid)) {
			sql = "SELECT lvl,lat,lng,region_name FROM sys_region WHERE regionid = '"+cityid+ "'";
			sqlAdapter = new SQLAdapter(sql);
			list1.addAll(dbClient.find(sqlAdapter));
		}
		if (!"".equals(areaid)) {
			sql = "SELECT lvl,lat,lng,region_name FROM sys_region WHERE regionid = '"+areaid+ "'";
			sqlAdapter = new SQLAdapter(sql);
			list2.addAll(dbClient.find(sqlAdapter));
		}
		if (list2.size() > 0) {
			if (list1.get(0).get("lvl") == list2.get(0).get("lvl")) {
				map.put("data", "");
			}else {
				map.put("data", list2);
			}
		}else {
			map.put("data", list1);
		}
		return map;
	}
	
	/**
	 * 决策总揽页面,统计矫正人员总数【完成】,统计概管制人员总数【未完成】，统计假释的人员总数【未完成】，统计缓刑人员总数【未完成】，统计暂予监外执行人员总数【未完成】
	 * @param query
	 * @return
	 */
	public BasicMap<String, Object>  findAllCount_JZ(String lat,String lng){
		BasicMap<String, Object> map = new BasicMap<>();
		//查询视图
		String sql="";
		if ("".equals(lat)) {
			sql = "select sum(jzrys) as jzrys from view_rep_jzryss WHERE 1 = 1";
		}else {
			sql = "select sum(jz.jzrys) as jzrys from view_rep_jzryss  as jz LEFT JOIN sys_region as reg ON (jz.city_code = reg.regionid or jz.district_code = reg.regionid)  WHERE 1 = 1 "
					+ "AND reg.lat = '"+ lat+ "' AND reg.lng = '"+lng + "'";
		}
		SQLAdapter sqlAdapter = new SQLAdapter(sql);
		map.put("total", dbClient.find(sqlAdapter));
		return map;
	}

	/**
	 * 决策总揽页面,机构查询【完成】
	 * @param query
	 * @return
	 */
	public BasicMap<String, Object> findAllCount_JG(String lat,String lng){
		BasicMap<String, Object> map = new BasicMap<>();
		//查询机构的名称 + 数量
		String sql = "";
		if ("".equals(lat)) {
			sql = "select JGLXMC,GZRYLXMC,sum(JGSL) as JGSL,sum(GZRYS) as GZRYS from REP_JGJSJGHZ WHERE 1 = 1 GROUP BY JGLXMC,GZRYLXMC,JGSL,GZRYS";
		}else {
			sql="select jz.JGLXMC,jz.GZRYLXMC,sum(jz.JGSL) as JGSL,sum(jz.GZRYS) as GZRYS from REP_JGJSJGHZ  as jz LEFT JOIN sys_region as reg ON (jz.cityid = reg.regionid or jz.districtid = reg.regionid)  "
					+ "WHERE 1 = 1 AND reg.lat = '"+ lat+ "' AND reg.lng = '"+ lng+ "' GROUP BY JGLXMC,GZRYLXMC,JGSL,GZRYS ";
		}
		SQLAdapter sqlAdapter = new SQLAdapter(sql);
		map.put("jg_xx", dbClient.find(sqlAdapter));
 		return map;
	}
	
	/**
	 * 决策总揽页面,人民调解查询【未完成】【饼状图】
	 * @param query
	 * @return
	 */
	public BasicMap<String, Object> findAllCount_RMTJ_B(String lat,String lng){
		BasicMap<String, Object> map = new BasicMap<>();
		//人民调解【基础数据】
		String sql ="" ;
		if ("".equals(lat)) {
			sql = "select LXMC,sum(TJSL) as TJSL from REP_RMTJ_LXFX WHERE 1 = 1 GROUP BY LXMC,TJSL";
		} else {
			sql="select jz.LXMC as LXMC,sum(jz.TJSL) as TJSL from REP_RMTJ_LXFX as jz LEFT JOIN sys_region as reg ON (jz.cityid = reg.regionid or jz.districtid = reg.regionid) "
					+ "WHERE 1 = 1 AND reg.lat = '"+ lat+ "' AND reg.lng = '"+ lng+ "' GROUP BY LXMC,TJSL";
		}
		SQLAdapter sqlAdapter = new SQLAdapter(sql);
		map.put("jg_xx", dbClient.find(sqlAdapter));
		return map;
	}
	/**
	 * 决策总揽页面,人民调解查询【完成】【总数】
	 * @param query
	 * @return
	 */
	public BasicMap<String, Object> findAllCount_RMTJ(String lat,String lng){
		BasicMap<String, Object> map = new BasicMap<>();
		//人民调解【基础数据】
		String sql = "";
		if ("".equals(lat)) {
			sql = "select sum(TJSL) as TJSL,sum(TJCGS) as TJCGS from REP_RMTJ_LXFX WHERE 1 = 1";
		}else {
			sql = "select sum(jz.TJSL) as TJSL,sum(jz.TJCGS) as TJCGS from REP_RMTJ_LXFX  as jz LEFT JOIN sys_region as reg ON (jz.cityid = reg.regionid or jz.districtid = reg.regionid)  "
					+ "WHERE 1 = 1 AND reg.lat = '"+ lat+ "' AND reg.lng = '"+ lng+ "' ";
		}
		SQLAdapter sqlAdapter = new SQLAdapter(sql);
		map.put("jg_xx", dbClient.find(sqlAdapter));
		return map;
	}
	
	/**
	 * 决策总揽页面,安置帮教查询【未完成】
	 * @param query
	 * @return
	 */
	public BasicMap<String, Object> findAllCount_AZBJ(String lat,String lng){
		BasicMap<String, Object> map = new BasicMap<>();
		//安置帮教【基础数据】
		String sql = "";
		if ("".equals(lat)) {
			sql = "select sum(BJSL) as BJSL from REP_AZBJ_RYLYHZ WHERE 1 = 1";
		}else {
			sql = "select sum(jz.BJSL) as BJSL from REP_AZBJ_RYLYHZ  as jz LEFT JOIN sys_region as reg ON (jz.cityid = reg.regionid or jz.districtid = reg.regionid)  "
					+ "WHERE 1 = 1 AND reg.lat = '"+ lat+ "' AND reg.lng = '"+ lng+ "' ";
		}
		SQLAdapter sqlAdapter = new SQLAdapter(sql);
		map.put("jg_xx", dbClient.find(sqlAdapter));
 		return map;
	}
	/**
	 * 决策总揽页面,安置帮教查询【未完成】【饼状图】
	 * @param query
	 * @return
	 */
	public BasicMap<String, Object> findAllCount_AZBJ_B(String lat,String lng){
		BasicMap<String, Object> map = new BasicMap<>();
		//安置帮教【基础数据】
		String sql = "";
		if ("".equals(lat)) {
			sql = "select LYMC,sum(BJSL) as BJSL from REP_AZBJ_RYLYHZ WHERE 1 = 1 GROUP BY LYMC,BJSL";
		}else {
			sql = "select jz.LYMC as LYMC,sum(jz.BJSL) as BJSL from REP_AZBJ_RYLYHZ as jz LEFT JOIN sys_region as reg ON (jz.cityid = reg.regionid or jz.districtid = reg.regionid) "
					+ "WHERE 1 = 1 AND reg.lat = '"+lat+ "' AND reg.lng = '" + lng + "' GROUP BY LYMC,BJSL";
		}
		SQLAdapter sqlAdapter = new SQLAdapter(sql);
		map.put("jg_xx", dbClient.find(sqlAdapter));
 		return map;
	}
	
	/**
	 * 地图的初始定位信息【获取已有的位置，定位到市级区域】
	 * @return
	 * 决策总揽页面,地图数据
	 *   返回格式 ： [{name:"锡林郭勒盟",value:[lng,lat,value,v2,]}]
	 * @param query
	 * @return
	 */
	//TODO
	public List<BasicMap<String, Object>> findAllCount_TD(String city_code){
		String sql="";
		if ("".equals(city_code)) {
			 sql = "SELECT  SUM (rep.jzrys) AS value, reg.REGION_NAME AS NAME, reg.lat as lat,reg.lng as lng,reg.lvl as lvl "
					+ "FROM view_rep_jzrys AS rep LEFT JOIN SYS_REGION AS reg ON rep.city_code = reg.regionid "
					+ "WHERE 1 = 1 GROUP BY REGION_NAME, LAT, LNG,LVL ORDER BY VALUE DESC";
		}else {
			sql="SELECT SUM (rep.jzrys) AS VALUE, reg.REGION_NAME AS NAME, reg.lat AS lat, reg.lng AS lng,reg.lvl AS lvl  " + 
					"FROM view_rep_jzrys AS rep "+ 
					"LEFT JOIN SYS_REGION AS reg ON rep.district_code = reg.regionid " + 
					"WHERE 1 = 1 AND (rep.city_code = '"+city_code+"' OR rep.district_code ='"+city_code+"')" + 
					"GROUP BY REGION_NAME, LAT, LNG,LVL ORDER BY VALUE DESC";
		}
			SQLAdapter sqlAdapter = new SQLAdapter(sql);
			List<BasicMap<String, Object>> list1 = new ArrayList<>();
			List<BasicMap<String, Object>> list = dbClient.find(sqlAdapter,new RowDataListener() {
				@Override
				public void processData(BasicMap<String, Object> rowData) {
					String str = rowData.get("lng")+","+rowData.get("lat")+","+rowData.get("value");
					String[] a = str.split(",");
					List l = Arrays.asList(str.split(","));
					rowData.put("value", l);
					rowData.put("name", rowData.get("NAME"));
					list1.add(rowData);
				}
			});
			return list1;
		}
	
	/**
	 * 决策总揽页面,地图数据【区域检索】
	 * 1.矫正人员数  rep_jzry  2.机构数  工作人员数  rep_jg_gzru 3.人民调解数  rep_rmtj 4.安置帮教数  rep_azbj
	 * @param query
	 * @return
	 */
	public BasicMap<String, Object> findAllCount_TDFQ(Double lat,Double lng){
		BasicMap<String, Object> map = new BasicMap<>();
		SQLAdapter sqlAdapter;
		//1.矫正人员数
		BasicMap<String, Object> map1 = new BasicMap<>();
		String sql1 = "SELECT  sum(rep.jzrys) as jzrys,reg.LAT as LAT,reg.LNG as LNG,reg.REGION_NAME as REGION_NAME " +
				"FROM view_rep_jzrys as rep LEFT JOIN  SYS_REGION as reg ON (rep.city_code = reg.regionid or rep.district_code = reg.regionid) " + 
				"WHERE 1 = 1 AND reg.LAT = " +lat +  "AND reg.LNG = " + lng +  " GROUP BY REGION_NAME,LAT,LNG";
		sqlAdapter = new SQLAdapter(sql1);
		map1.put("rep_jzry", dbClient.find(sqlAdapter));
		map.put("rep_jzry", map1);
		//2.机构数
		BasicMap<String, Object> map2 = new BasicMap<>();
		String sql2 = "SELECT sum(rep.JGSL) as JGSL, sum(rep.GZRYS) as GZRYS, reg.LAT as LAT, reg.LNG as LNG, " + 
				"reg.REGION_NAME as REGION_NAME FROM REP_JGJSJGHZ AS rep LEFT JOIN SYS_REGION as reg " + 
				"ON (rep.cityid = reg.regionid or rep.districtid = reg.regionid) "
				+ "WHERE 1 = 1 AND reg.LAT = " +lat+  " AND reg.LNG = " + lng + " GROUP BY REGION_NAME,LAT,LNG";
		sqlAdapter = new SQLAdapter(sql2);
		map2.put("rep_jg_gzru", dbClient.find(sqlAdapter));
		map.put("rep_jg_gzru", map2);
		//3.机构数
		BasicMap<String, Object> map3 = new BasicMap<>();
		String sql3 = "SELECT SUM (rep.TJSL) AS TJSL,reg.LAT as LAT,reg.LNG as LNG,reg.REGION_NAME as REGION_NAME " + 
				"FROM REP_RMTJ_LXFX AS rep LEFT JOIN SYS_REGION as reg ON (rep.cityid = reg.regionid or rep.districtid = reg.regionid) " + 
				"WHERE 1 = 1 AND reg.LAT = " +lat+  " AND reg.LNG = " + lng + " GROUP BY REGION_NAME,LAT,LNG";
		sqlAdapter = new SQLAdapter(sql3);
		map3.put("rep_rmtj", dbClient.find(sqlAdapter));
		map.put("rep_rmtj", map3);
		//4.安置帮教数  
		BasicMap<String, Object> map4 = new BasicMap<>();
		String sql4 = "SELECT sum(rep.BJSL) as BJSL,reg.LAT as LAT,reg.LNG as LNG,reg.REGION_NAME as REGION_NAME "+ 
				"FROM  REP_AZBJ_RYLYHZ AS rep LEFT JOIN SYS_REGION as reg ON (rep.cityid = reg.regionid or rep.districtid = reg.regionid)" + 
				"WHERE 1 = 1 AND reg.LAT = " +lat+  " AND reg.LNG = " + lng + " GROUP BY REGION_NAME,LAT,LNG";
		sqlAdapter = new SQLAdapter(sql4);
		map4.put("rep_azbj", dbClient.find(sqlAdapter));
		map.put("rep_azbj", map4);
 		return map;
	}
	
	
	//二级界面部分
	/**
	 * 
	 * @return<br>
	 * 返回值格式:List<BasicMap<String, Object>>
	 *
	 * @author Administrator
	 * @date   2018年3月17日
	 * 方法的作用：机构建设的详情, 安置帮教情况, 人民调解情况及合计总览【市级】
	 */
	public List<BasicMap<String, Object>> findBuilDing() {
		String sql = "SELECT A .regionid,A .region_name, " + 
				"b.JGLXMC,b.GZRYLXMC, " + 
				"SUM (b.JGSL) AS JGSL, " + 
				"SUM (b.GZRYS) AS GZRYS " + 
				"FROM sys_region A  LEFT JOIN REP_JGJSJGHZ b ON  a.regionid = b.CITYID " + 
				"WHERE A .lvl = 2 " + 
				"GROUP BY A.regionid, A.region_name, b.JGLXMC, b.GZRYLXMC " + 
				"ORDER BY JGSL desc";
		SQLAdapter adapter = new SQLAdapter(sql);
		List<BasicMap<String, Object>> list = dbClient.find(adapter);
		return list;
	}
	
	/**
	 * 
	 * TODO(方法的描述，哪那个地方使用的等)
	 * @param districtid
	 * @return<br>
	 * 返回值格式:<br>
	 *
	 * @author Administrator
	 * @date   2018年4月9日
	 * 方法的作用：机构建设的详情, 安置帮教情况, 人民调解情况及合计总览【旗县级】
	 */
	public List<BasicMap<String, Object>> findBuilDing_QY(String districtid) {
		String sql = "SELECT A .regionid, A .region_name, b.JGLXMC, " + 
				"	b.GZRYLXMC, SUM (b.JGSL) AS JGSL, SUM (b.GZRYS) AS GZRYS " + 
				"FROM sys_region A  LEFT JOIN REP_JGJSJGHZ b ON  a.regionid = b.DISTRICTID " + 
				"WHERE  A .lvl = 3 " + 
				" AND a.parentid = '"+ districtid +"' " + 
				"GROUP BY regionid, region_name, b.JGLXMC, b.GZRYLXMC " + 
				"ORDER BY JGSL desc";
		SQLAdapter adapter = new SQLAdapter(sql);
		List<BasicMap<String, Object>> list = dbClient.find(adapter);
		return list;
	}
	
}
