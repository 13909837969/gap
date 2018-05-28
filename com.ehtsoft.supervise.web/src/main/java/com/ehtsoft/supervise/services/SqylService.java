package com.ehtsoft.supervise.services;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ehtsoft.common.services.SSOService;
import com.ehtsoft.fw.core.db.MongoClient;
import com.ehtsoft.fw.core.db.RowDataListener;
import com.ehtsoft.fw.core.db.SQLAdapter;
import com.ehtsoft.fw.core.db.SqlDbClient;
import com.ehtsoft.fw.core.db.SqlDbFilter;
import com.ehtsoft.fw.core.dto.Basic;
import com.ehtsoft.fw.core.dto.BasicMap;
import com.ehtsoft.fw.core.dto.Paginate;
import com.ehtsoft.fw.core.dto.ResultList;
import com.ehtsoft.fw.utils.DateUtil;
import com.ehtsoft.fw.utils.NumberUtil;
import com.ehtsoft.fw.utils.StringUtil;
import com.ehtsoft.supervise.services.JzQdxxService;
import com.ehtsoft.supervise.utils.DateUtils;

/**
 * 
 * @author maruimin 2018-05-13
 *
 */
@Service("SqylService")
public class SqylService {
	
	@Resource(name="sqlDbClient")
	private SqlDbClient dbClient;
	
	public  BasicMap<String, Object> findSqyl() {
		BasicMap<String,Object> map =new BasicMap<>();
		//矫正人员总数
		String sql1="select count(1) as jzryzs from JZ_JZRYJBXX where jcjz='0' and sfjs='1' and orgid is not null";
		map.put("jzryzs", dbClient.findOne(sql1).get("jzryzs"));
		
		//宽管
		String sql2="select count(1) as jzrykg from JZ_JZRYJBXX where sfjs='1' and jcjz='0' and jglx='1' and orgid is not null";
		map.put("jzrykg", dbClient.findOne(sql2).get("jzrykg"));
		
		//普管
		String sql3="select count(1) as jzrypg from JZ_JZRYJBXX where sfjs='1' and jcjz='0' and jglx='2' and orgid is not null";		
		map.put("jzrypg",dbClient.findOne(sql3).get("jzrypg")); 
		
		//严管
		String sql4="select count(1) as jzryyg from JZ_JZRYJBXX where sfjs='1' and jcjz='0' and jglx='3' and orgid is not null";
		map.put("jzryyg", dbClient.findOne(sql4).get("jzryyg"));
		
		//外出申请
		String sql5="select count(1) as jzrywcsq from JZ_JZRYJBXX a join JZ_WCSQXXCJB b on a.id=b.f_aid where a.sfjs='1' and a.jcjz='0' and a.orgid is not null";
		map.put("jzrywcsq", dbClient.findOne(sql5).get("jzrywcsq"));
		
		//居住地变更
		String sql6="select count(1) as jzryjzdbg from JZ_JZRYJBXX a join JZ_JZDBGXXCJB b on a.id=b.f_aid where a.sfjs='1' and a.jcjz='0' and a.orgid is not null";
		map.put("jzryjzdbg", dbClient.findOne(sql6).get("jzryjzdbg"));
		
		//警告
		String sql7="select count(1) as jzryjg from JZ_JZRYJBXX a join JZ_JGXXCJB b on a.id=b.f_aid where a.sfjs='1' and a.jcjz='0' and a.orgid is not null";
		map.put("jzryjg", dbClient.findOne(sql7).get("jzryjg"));
		
		//治安处罚
		String sql8="select count(1) as zacf from JZ_JZRYJBXX a join JZ_TQZAQFXICJB b on a.id=b.aid where a.sfjs='1' and a.jcjz='0' and a.orgid is not null";
		map.put("zacf", dbClient.findOne(sql8).get("zacf"));
		
		//使用app情况
		String sql9="SELECT  sum(jzrys) as syqk from view_rep_jzry_appsh";
		map.put("syqk", dbClient.findOne(sql9).get("syqk"));
		
		//3天未登录
		List<BasicMap<String, Object>> list = findContinuousNoSignIn();
		List<BasicMap<String, Object>> list_wqd = new ArrayList<>();	
		for (int i = 0; i < list.size(); i++) {
			if (NumberUtil.toInt(list.get(i).get("ts")) <= 3) {
				list_wqd.add(list.get(i));//未签到的人员列表
			}
		}
		int s = list_wqd.size();
		map.put("wqdsl", s);
		map.put("jx", '0');
		map.put("cx", '0');
		
		return map;
	}
	
	/**
	 * 3天内为签到的数据列表
	 * @return
	 */
	public List<BasicMap<String, Object>> findQD() {
		
		String sql="select region_name as city_name,regionid as city_id, 0 as jzry from sys_region where lvl = '2' and parentid='150000'";
		SQLAdapter adapter=new SQLAdapter(sql);
		List<BasicMap<String,Object>> data=dbClient.find(adapter,new RowDataListener() {
			
			@Override
			public void processData(BasicMap<String, Object> rowData) {
				int data = NumberUtil.toInt(DateUtil.format(new Date(), "yyyyMMdd"));
				String sql = "SELECT reg.region_name as city_name,DB.parentid as city_code,COUNT(DB.parentid)as jzrys " + 
						"FROM " + 
						"( SELECT A .cts,MAX (b.cdate) AS max_date,A .orgid, " + 
						"	C .regionid,d.region_name AS CITY_NAME,d.parentid " + 
						"FROM jz_jzryjbxx A  " + 
						"LEFT JOIN rep_qdxxb b ON A . ID = b.aid  " + 
						"LEFT JOIN jc_sfxzjgjbxx C ON A .orgid = C . ID  " + 
						"LEFT JOIN sys_region d ON C .regionid = d.regionid  " + 
						"WHERE A .sfcj = '1' " + 
						"AND A .JCJZ = '0'  " + 
						"AND A .SFJS = '1'  " + 
						"AND b.cdate >('"+data +"' - 3)" + 
						"GROUP BY A . ID,A .xm,A .grlxdh,A .cts,A .orgid,C .regionid,CITY_NAME,d.parentid " + 
						"ORDER BY " + 
						"	MAX (b.cdate) ASC ) DB LEFT JOIN sys_region reg ON DB.parentid = reg.regionid  " + 
						"GROUP BY reg.region_name,DB.parentid";
				SQLAdapter adapter  = new SQLAdapter(sql);
				List<BasicMap<String, Object>> li = dbClient.find(adapter);
				for (int i = 0; i < li.size(); i++) {
					if (rowData.get("city_name").equals(li.get(i).get("city_name"))) {
						rowData.put("jzry", li.get(i).get("jzrys"));
					}
				}
				
			}
		});
		return data;
	}
	
	/**
	 * 3天内为签到的数据的详情
	 * @param code
	 * @return
	 */
	public List<BasicMap<String, Object>> findQdDetils(String code) {
		if ("".equals(code)) {
			code = "150100";
		}		
		List<BasicMap<String, Object>> list = findContinuousNoSignIn(code);
		List<BasicMap<String, Object>> list_wqd = new ArrayList<>();	
		for (int i = 0; i < list.size(); i++) {
			if (NumberUtil.toInt(list.get(i).get("ts")) <= 3) {
				String regionid = StringUtil.toEmptyString(list.get(i).get("regionid")); 
					list_wqd.add(list.get(i)); 
			}
		}
		return list_wqd;
	}

	/**
	 * 社区矫正预览【总览app使用】
	 * @param paginate
	 * @return
	 */
	public  List<BasicMap<String, Object>> findContinuousNoSignIn(String regionid){
		List<BasicMap<String, Object>> list = new ArrayList<>();
			String sqlstr = "SELECT A . ID,A .xm as name ,A .grlxdh,"
					+ "A .cts,A.uts ,MAX (b.cdate) AS max_date ,a.orgid,c.regionid,"
					+ "d.region_name as city_name," + 
					" d.parentid " + 
					"FROM jz_jzryjbxx A   " + 
					"LEFT JOIN rep_qdxxb b ON A . ID = b.aid " + 
					"LEFT JOIN jc_sfxzjgjbxx c ON a.orgid = c.id " + 
					"LEFT JOIN sys_region d ON c.regionid = d.regionid " + 
					"WHERE A .sfcj = '1' " + 
					"AND A .JCJZ = '0' " + 
					"AND A .SFJS = '1'  " + 
					"AND d.parentid = '"+ regionid +"'  " + 
					"GROUP BY A . ID,name ,A .grlxdh,A.uts,A .cts,a.orgid,c.regionid,city_name,d.parentid " + 
					"ORDER BY MAX (b.cdate) ASC";
			SQLAdapter adapter = new SQLAdapter(sqlstr);
		list = 	dbClient.find(adapter, new RowDataListener() {
				@Override
				public void processData(BasicMap<String, Object> rowData) {
					rowData.put("time", rowData.get("uts"));
					if(rowData.get("max_date")!=null){
					long days = DateUtils.getDaySub( 
								StringUtil.toString(DateUtil.format(new Date(), "yyyy-MM-dd")),
								StringUtil.toString(DateUtil.format(DateUtil.toDate(StringUtil.toString(rowData.get("max_date")),"yyyyMMdd"),"yyyy-MM-dd"))
								);
						rowData.put("ts", Math.abs(NumberUtil.toInt(days)));//Math.abs(NumberUtil.toInt(rowData.get("max_date"))-NumberUtil.toInt(DateUtil.format(new Date(), "yyyyMMdd"))));
					}else{
						long days = DateUtils.getDaySub( 
								StringUtil.toString(DateUtil.format(new Date(), "yyyy-MM-dd")),
								StringUtil.toString(DateUtil.format(DateUtil.toDate(StringUtil.toString(rowData.get("cts")),"yyyyMMdd"),"yyyy-MM-dd"))
								);
						rowData.put("ts", Math.abs(NumberUtil.toInt(days)));
						//rowData.put("date", Math.abs(NumberUtil.toInt(DateUtil.format(rowData.get("cts"), "yyyyMMdd"))-NumberUtil.toInt(DateUtil.format(new Date(), "yyyyMMdd"))));
					}
					if (NumberUtil.toInt(rowData.get("online"))==1) {
						rowData.put("ifOnline", "在线");
					}else {
						rowData.put("ifOnline", "离线");
					}
					if(NumberUtil.toInt(rowData.get("ts"))==0){
						rowData.clear();
					}
				}
			});
			Collections.sort(list,new Comparator<BasicMap<String, Object>>() {
				@Override
				public int compare(BasicMap<String, Object> o1, BasicMap<String, Object> o2) {
					int r = 0;
					if(NumberUtil.toInt(o1.get("ts"))< NumberUtil.toInt(o2.get("ts"))){
						r = 1;
					}else if(NumberUtil.toInt(o1.get("ts"))== NumberUtil.toInt(o2.get("ts"))){
						r = 0;
					}else{
						r = -1;
					}
					return r;
				}
			});
		return list;
	}
	
	/**
	 * 重载
	 * @return
	 */
	public  List<BasicMap<String, Object>> findContinuousNoSignIn(){
		List<BasicMap<String, Object>> list = new ArrayList<>();
			String sqlstr = "SELECT A . ID,A .xm as name ,A .grlxdh,"
					+ "A .cts,A.uts ,MAX (b.cdate) AS max_date ,a.orgid,c.regionid,"
					+ "d.region_name as city_name," + 
					" d.parentid " + 
					"FROM jz_jzryjbxx A   " + 
					"LEFT JOIN rep_qdxxb b ON A . ID = b.aid " + 
					"LEFT JOIN jc_sfxzjgjbxx c ON a.orgid = c.id " + 
					"LEFT JOIN sys_region d ON c.regionid = d.regionid " + 
					"WHERE A .sfcj = '1' " + 
					"AND A .JCJZ = '0' " + 
					"AND A .SFJS = '1'  " + 
					"GROUP BY A . ID,name ,A .grlxdh,A.uts,A .cts,a.orgid,c.regionid,city_name,d.parentid " + 
					"ORDER BY MAX (b.cdate) ASC";
			SQLAdapter adapter = new SQLAdapter(sqlstr);
		list = 	dbClient.find(adapter, new RowDataListener() {
				@Override
				public void processData(BasicMap<String, Object> rowData) {
					rowData.put("time", rowData.get("uts"));
					if(rowData.get("max_date")!=null){
					long days = DateUtils.getDaySub( 
								StringUtil.toString(DateUtil.format(new Date(), "yyyy-MM-dd")),
								StringUtil.toString(DateUtil.format(DateUtil.toDate(StringUtil.toString(rowData.get("max_date")),"yyyyMMdd"),"yyyy-MM-dd"))
								);
						rowData.put("ts", Math.abs(NumberUtil.toInt(days)));//Math.abs(NumberUtil.toInt(rowData.get("max_date"))-NumberUtil.toInt(DateUtil.format(new Date(), "yyyyMMdd"))));
					}else{
						long days = DateUtils.getDaySub( 
								StringUtil.toString(DateUtil.format(new Date(), "yyyy-MM-dd")),
								StringUtil.toString(DateUtil.format(DateUtil.toDate(StringUtil.toString(rowData.get("cts")),"yyyyMMdd"),"yyyy-MM-dd"))
								);
						rowData.put("ts", Math.abs(NumberUtil.toInt(days)));
						//rowData.put("date", Math.abs(NumberUtil.toInt(DateUtil.format(rowData.get("cts"), "yyyyMMdd"))-NumberUtil.toInt(DateUtil.format(new Date(), "yyyyMMdd"))));
					}
					if (NumberUtil.toInt(rowData.get("online"))==1) {
						rowData.put("ifOnline", "在线");
					}else {
						rowData.put("ifOnline", "离线");
					}
					if(NumberUtil.toInt(rowData.get("ts"))==0){
						rowData.clear();
					}
				}
			});
			Collections.sort(list,new Comparator<BasicMap<String, Object>>() {
				@Override
				public int compare(BasicMap<String, Object> o1, BasicMap<String, Object> o2) {
					int r = 0;
					if(NumberUtil.toInt(o1.get("ts"))< NumberUtil.toInt(o2.get("ts"))){
						r = 1;
					}else if(NumberUtil.toInt(o1.get("ts"))== NumberUtil.toInt(o2.get("ts"))){
						r = 0;
					}else{
						r = -1;
					}
					return r;
				}
			});
		return list;
	}
	
	
	/**
	 * 对接 echarts 数据
	 * @return
	 */
    public List<BasicMap<String, Object>> finddataToecharts() {
		String sql = "SELECT city_code, city_name, SUM (jzrys) AS jzrys, jglx " + 
				"FROM view_rep_jzrys_lx " + 
				"WHERE jglx <> ''  " + 
				"GROUP BY city_code, city_name, jglx ORDER BY city_code asc";
		SQLAdapter adapter =  new SQLAdapter(sql);
		final Map<String,BasicMap<String, Object>> map = new HashMap<>();
		final List<BasicMap<String, Object>> rtn = new ArrayList<>();
		dbClient.find(adapter,new RowDataListener() {
			@Override
			public void processData(BasicMap<String, Object> rowData) {
				String citycode = StringUtil.toEmptyString(rowData.get("city_name"));
				String jglx = StringUtil.toEmptyString(rowData.get("jglx"));
				if(map.get(citycode)==null) {
					rowData.put("jzrys"+jglx, NumberUtil.toInt(rowData.get("jzrys")));
					map.put(citycode, rowData);
					rtn.add(rowData);
				}else {
					map.get(citycode).put("jzrys"+jglx, NumberUtil.toInt(rowData.get("jzrys")));
				}
			}
		});
		return  rtn;
	}
		
	//各市在矫人员数[在册矫正人员统计]
	public List<BasicMap<String,Object>> findZjrs(){
		String sql="select region_name as city_name, 0 as jzry from sys_region where lvl = '2' and parentid='150000'";
		SQLAdapter adapter=new SQLAdapter(sql);
		List<BasicMap<String,Object>> data=dbClient.find(adapter,new RowDataListener() {
			
			@Override
			public void processData(BasicMap<String, Object> rowData) {
				String sqlstr = "SELECT creg.region_name AS city_name,count(jzry.id) AS jzrys FROM sys_region region " + 
						" left JOIN jc_sfxzjgjbxx jg ON region.regionid = jg.regionid " + 
						" left JOIN jz_jzryjbxx jzry ON jg.id = jzry.orgid " + 
						" left JOIN sys_region creg ON creg.regionid = region.parentid " + 
						" WHERE jzry.JCJZ = '0'and jzry.SFJS = '1'  GROUP BY city_name ";
				List<BasicMap<String, Object>> li = dbClient.find(new SQLAdapter(sqlstr));
				for (int i = 0; i < li.size(); i++) {
					if (rowData.get("city_name").equals(li.get(i).get("city_name"))) {
						rowData.put("jzry", li.get(i).get("jzrys"));
					}
				}
				
			}
		});
		return data;
	}
	
	/**
	 * 服刑人员[矫正人员app使用情况]
	 * @return
	 */
	public List<BasicMap<String,Object>> findGssyqk(){
		//各地区使用app情况 
		String sql1="select region_name AS city_name,regionid as city_id, 0 as jzry from sys_region where lvl = '2' and parentid='150000'";
		SQLAdapter adapter=new SQLAdapter(sql1);
		List<BasicMap<String,Object>> list=dbClient.find(adapter,new RowDataListener() {
			@Override
			public void processData(BasicMap<String, Object> rowData) {
				List<BasicMap<String, Object>> li = dbClient.find(new SQLAdapter("SELECT city_name ,city_code as city_id, sum(jzrys) as jzrys from view_rep_jzry_appsh  GROUP BY city_name,city_code" ));
				for (int i = 0; i < li.size(); i++) {
					if (rowData.get("city_name").equals(li.get(i).get("city_name"))) {
						rowData.put("jzry", li.get(i).get("jzrys"));
					}
				}
			}
		});
		return list;
	}
	
	//各市区中每个区安装情况 
	public List<BasicMap<String,Object>> findGsqsyqk(String city_code){
		if ("".equals(city_code)) {
			city_code = "150100";//默認返回呼和浩特市
		}
		String sql1="SELECT district_name,city_code, " + 
				"district_code, sum(jzrys) AS zcrs   " + 
				"FROM view_sqyl_sfs " + 
				"WHERE city_code = '"+ city_code +"' " + 
				"GROUP BY district_name,city_code,district_code";
		SQLAdapter adapter=new SQLAdapter(sql1);
		List<BasicMap<String,Object>> list=dbClient.find(adapter,new RowDataListener() {
			
			@Override
			public void processData(BasicMap<String, Object> arg0) {
				if(arg0.get("district_code")!=null) {
					String sql="select count(a.id) from JZ_JZRYJBXX a inner join jc_sfxzjgjbxx b on a.orgid=b.id " + 
							" where b.regionid = '"+ arg0.get("district_code")+"' and a.sfjs='1' and a.jcjz='0' and a.sfcj='1' ";
					SQLAdapter adapter=new SQLAdapter(sql);
					BasicMap<String,Object> data=dbClient.findOne(adapter);
					arg0.put("citys", data.get("count"));
				}	
			}
		});
		return list;
	}
	
	//任意个市区安装app数
    public List<BasicMap<String,Object>> findGsqAzqk(String district_name){
	    String sql="select orgid,jgmc,count(f_aid) from view_sqyl_sfs where district_name='"+district_name+"' group by orgid,jgmc";
		SQLAdapter adapter=new SQLAdapter(sql);
	    List<BasicMap<String,Object>> data=dbClient.find(adapter);
		return data;
	}
	
	
    /**
     * 检索司法所
     */
    public List<BasicMap<String, Object>> findYazfxry(String code,String name) {
    	
    	String sql = "SELECT  district_name,city_code,orgname,orgid,jzrys as citys from view_rep_jzry_appsh WHERE district_code = '"+code+"' and  orgname like '%"+name+"%'";
    List<BasicMap<String, Object>> list = dbClient.find(new SQLAdapter(sql),new RowDataListener() {
		@Override
		public void processData(BasicMap<String, Object> rowData) {
			String sqlstr = "SELECT count(1) as zcrs from jz_jzryjbxx WHERE sfjs = '1' and jcjz = '0' AND "
					+ "orgid = '"+rowData.get("orgid") +"' ";
			rowData.put("zcrs", dbClient.findOne(new SQLAdapter(sqlstr)).get("zcrs"));
		}
	});
	return list;
    }
    
    /**
     * 各盟市外出申请列表
     * @return
     */
    public List<BasicMap<String,Object>> findWcsqList(){
    	     List<BasicMap<String,Object>> list=new ArrayList<>();
    	     String sql="select region_name AS city_name,regionid as city_id, 0 as jzry from sys_region where lvl = '2' and parentid='150000'";
    	     SQLAdapter adapter=new SQLAdapter(sql);
    	     list=dbClient.find(adapter, new RowDataListener() {
				
				@Override
				public void processData(BasicMap<String, Object> rowData) {
					String sql1="SELECT creg.region_name AS city_name,count(jzry.id) AS jzrys FROM sys_region region " + 
							"inner JOIN jc_sfxzjgjbxx jg ON region.regionid = jg.regionid " + 
							"inner JOIN (select a.* from jz_jzryjbxx a join JZ_WCSQXXCJB b on a.id=b.f_aid where a.sfjs='1' and a.jcjz='0') jzry ON jg.id = jzry.orgid " + 
							"JOIN sys_region creg ON creg.regionid = region.parentid " + 
							"GROUP BY city_name";
					SQLAdapter adapter1=new SQLAdapter(sql1);
					List<BasicMap<String,Object>> li=dbClient.find(adapter1);
					for (int i = 0; i < li.size(); i++) {
						if(rowData.get("city_name").equals(li.get(i).get("city_name"))) {
							rowData.put("jzry",li.get(i).get("jzrys"));
						}
					}
				}
			});
    	     return list;
    }
    
    /**
     * 各盟市中各区外出申请人员总数
     * @param city_code
     * @return
     */
    public List<BasicMap<String,Object>> findWcsqSqDetail(String city_code){
      	if ("".equals(city_code)) {
			city_code = "150100";//默认返回呼和浩特市
		 }
      	List<BasicMap<String,Object>> list=new ArrayList<>();
      	String sql="select count(wc.id) as wcsqs,sys.region_name as q_name,sys.region_code as q_code from jc_sfxzjgjbxx jc inner join  " + 
      			"(select a.* from jz_jzryjbxx a join JZ_WCSQXXCJB b on a.id=b.f_aid where a.sfjs='1' and a.jcjz='0') wc  " + 
      			"on jc.id=wc.orgid  " + 
      			"left join (select b.region_name,b.regionid,b.region_code,b.parentid from sys_region a inner join sys_region b  " + 
      			"on a.region_code=b.regionid ) sys on jc.regionid = sys.regionid  where sys.parentid='"+city_code+"' group by sys.region_name,sys.region_code";
      	SQLAdapter adapter=new SQLAdapter(sql);
      	list=dbClient.find(adapter);
      	return list;
    	
    }
    
    /**
     * 各司法所的外出申请人数
     * @param city_code
     * @return
     */
    public List<BasicMap<String,Object>> findWcsqSfsDetail(BasicMap<String,Object> query){
    	     List<BasicMap<String,Object>> list=new ArrayList<>();
    	     String sql="select count(wc.id) as wcsqs,jc.jgmc as jgmc from jc_sfxzjgjbxx jc inner join  " + 
    	     		"(select a.* from jz_jzryjbxx a join JZ_WCSQXXCJB b on a.id=b.f_aid where a.sfjs='1' and a.jcjz='0') wc " + 
    	     		" on jc.id=wc.orgid " + 
    	     		"left join (select b.region_name,b.regionid,b.region_code,b.parentid from sys_region a inner join sys_region b  " + 
    	     		"on a.region_code=b.regionid ) sys on jc.regionid = sys.regionid  where sys.region_code='"+StringUtil.toEmptyString(query.get("q_code"))+"' and jc.jgmc like '%"+StringUtil.toEmptyString(query.get("jgmc"))+"%' group by jc.jgmc";
    	     SQLAdapter adapter=new SQLAdapter(sql);
    	     list=dbClient.find(adapter);
    	     return list;
    }
    
    /**
     * 各盟市居住地变更总人数
     */
    public List<BasicMap<String,Object>> findJzdbgList(){
    	    List<BasicMap<String,Object>> list=new ArrayList<>();
    	    String sql="select regionid,region_name,0 as jzry from sys_region where lvl='2' and parentid='150000'";
    	    SQLAdapter adapter=new SQLAdapter(sql);
    	    list=dbClient.find(adapter, new RowDataListener() {
				
				@Override
				public void processData(BasicMap<String, Object> rowData) {
                     String sql1="SELECT creg.region_name AS city_name,count(jzry.id) AS jzrys FROM sys_region region  " + 
                     		"inner JOIN jc_sfxzjgjbxx jg ON region.regionid = jg.regionid " + 
                     		"inner JOIN (select a.* from jz_jzryjbxx a join JZ_JZDBGXXCJB b on a.id=b.f_aid where a.sfjs='1' and a.jcjz='0') jzry ON jg.id = jzry.orgid " + 
                     		"JOIN sys_region creg ON creg.regionid = region.parentid  " + 
                     		"GROUP BY city_name";
                     SQLAdapter adapter1=new SQLAdapter(sql1);
                     List<BasicMap<String,Object>> lists=dbClient.find(adapter1);
                     for (int i = 0; i < lists.size(); i++) {
						if(lists.get(i).get("city_name").equals(rowData.get("region_name"))) {
							rowData.put("jzry", lists.get(i).get("jzrys"));
						}
					}
				}
			});
    	    return list;
    }
    
    /**
     * 各盟市中各区居住地变更人员总数
     * @param city_code
     * @return
     */
    public List<BasicMap<String,Object>> findJzdbgSqDetail(String city_code){
      	if ("".equals(city_code)) {
			city_code = "150100";//默认返回呼和浩特市
		 }
      	List<BasicMap<String,Object>> list=new ArrayList<>();
      	String sql="select count(wc.id) as qjzds,sys.region_name as q_name,sys.region_code as q_code from jc_sfxzjgjbxx jc inner join " + 
      			"(select a.* from jz_jzryjbxx a join JZ_JZDBGXXCJB b on a.id=b.f_aid where a.sfjs='1' and a.jcjz='0') wc " + 
      			"on jc.id=wc.orgid " + 
      			"left join (select b.region_name,b.regionid,b.region_code,b.parentid from sys_region a inner join sys_region b " + 
      			"on a.region_code=b.regionid ) sys on jc.regionid = sys.regionid where sys.parentid='"+city_code+"' group by sys.region_name,sys.region_code ";
      	SQLAdapter adapter=new SQLAdapter(sql);
      	list=dbClient.find(adapter);
      	return list;
    	
    }
    
    /**
     * 各司法所的居住地变更人数
     * @return
     */
    public List<BasicMap<String,Object>> findJzdbgSfsDetail(BasicMap<String,Object> query){
    	     List<BasicMap<String,Object>> list=new ArrayList<>();
    	     String sql="select count(wc.id) as sfsjzs,jc.jgmc as jgmc from jc_sfxzjgjbxx jc inner join  " + 
    	     		"(select a.* from jz_jzryjbxx a join JZ_JZDBGXXCJB b on a.id=b.f_aid where a.sfjs='1' and a.jcjz='0') wc " + 
    	     		"on jc.id=wc.orgid " + 
    	     		"left join (select b.region_name,b.regionid,b.region_code,b.parentid from sys_region a inner join sys_region b " + 
    	     		"on a.region_code=b.regionid ) sys on jc.regionid = sys.regionid where sys.region_code='"+StringUtil.toEmptyString(query.get("q_code"))+"' and jc.jgmc like '%"+StringUtil.toEmptyString(query.get("jgmc"))+"%' group by jc.jgmc ";
    	     SQLAdapter adapter=new SQLAdapter(sql);
    	     list=dbClient.find(adapter);
    	     return list;
    }
    
    /**
     * 各盟市治安处罚人员总数
     * @return
     */
    public List<BasicMap<String,Object>> findZacfList(){
    	     List<BasicMap<String,Object>> list=new ArrayList<>();
    	     String sql="select regionid,region_name,0 as jzry from sys_region where lvl='2' and parentid='150000'";
    	     SQLAdapter adapter=new SQLAdapter(sql);
    	     list=dbClient.find(adapter,new RowDataListener() {
				@Override
				public void processData(BasicMap<String, Object> rowData) {
					String sql1="SELECT creg.region_name AS city_name,count(jzry.id) AS jzrys FROM sys_region region " + 
							"inner JOIN jc_sfxzjgjbxx jg ON region.regionid = jg.regionid " + 
							"inner JOIN (select a.* from jz_jzryjbxx a join JZ_TQZAQFXICJB b on a.id=b.aid where a.sfjs='1' and a.jcjz='0') jzry ON jg.id = jzry.orgid  " + 
							"JOIN sys_region creg ON creg.regionid = region.parentid " + 
							"GROUP BY city_name";
					SQLAdapter adapter1=new SQLAdapter(sql1);
					List<BasicMap<String,Object>> lists=dbClient.find(adapter1);
					for (int i = 0; i < lists.size(); i++) {
						if(rowData.get("region_name").equals(lists.get(i).get("city_name"))) {
							rowData.put("jzry", lists.get(i).get("jzrys"));
						}
					}
				}
			});
    	     return list;
    }
    
    /**
     * 各盟市中各区治安处罚人员总数
     * @param city_code
     * @return
     */
    public List<BasicMap<String,Object>> findZacfSqDetail(String city_code){
      	if ("".equals(city_code)) {
			city_code = "150100";//默认返回呼和浩特市
		 }
      	List<BasicMap<String,Object>> list=new ArrayList<>();
      	String sql="select count(wc.id) as qzacs,sys.region_name as q_name,sys.region_code as q_code from jc_sfxzjgjbxx jc inner join " + 
      			"(select a.* from jz_jzryjbxx a join JZ_TQZAQFXICJB b on a.id=b.aid where a.sfjs='1' and a.jcjz='0') wc  " + 
      			"on jc.id=wc.orgid  " + 
      			"left join (select b.region_name,b.regionid,b.region_code,b.parentid from sys_region a inner join sys_region b  " + 
      			"on a.region_code=b.regionid ) sys on jc.regionid = sys.regionid where sys.parentid='"+city_code+"' group by sys.region_name,sys.region_code";
      	SQLAdapter adapter=new SQLAdapter(sql);
      	list=dbClient.find(adapter);
      	return list;
    	
    }
    
    
    /**
     * 各司法所治安处罚人员总数
     * @param city_code
     * @return
     */
    public List<BasicMap<String,Object>> findZacfSfsDetail(BasicMap<String,Object> query){
	    List<BasicMap<String,Object>> list=new ArrayList<>();
	    String sql="select count(wc.id) as sfszacfs,jc.jgmc as jgmc from jc_sfxzjgjbxx jc inner join  " + 
	    		"(select a.* from jz_jzryjbxx a join JZ_TQZAQFXICJB b on a.id=b.aid where a.sfjs='1' and a.jcjz='0') wc  " + 
	    		"on jc.id=wc.orgid  " + 
	    		"left join (select b.region_name,b.regionid,b.region_code,b.parentid from sys_region a inner join sys_region b  " + 
	    		"on a.region_code=b.regionid ) sys on jc.regionid = sys.regionid where sys.region_code='"+StringUtil.toEmptyString(query.get("q_code"))+"' and jc.jgmc like '%"+StringUtil.toEmptyString(query.get("jgmc"))+"%' group by jc.jgmc";
	     SQLAdapter adapter=new SQLAdapter(sql);
	     SqlDbFilter filter=new SqlDbFilter();
	     list=dbClient.find(adapter);
	     return list;
    }
    
    /**
     * 各盟市警告人员总数
     * @return
     */
    public List<BasicMap<String,Object>> findJgList(){
    	     List<BasicMap<String,Object>> list=new ArrayList<>();
    	     String sql="select regionid,region_name,0 as jzry from sys_region where lvl='2' and parentid='150000'";
    	     SQLAdapter adapter=new SQLAdapter(sql);
    	     list=dbClient.find(adapter,new RowDataListener() {
				@Override
				public void processData(BasicMap<String, Object> rowData) {
					String sql1="SELECT creg.region_name AS city_name,count(jzry.id) AS jzrys FROM sys_region region " + 
							"inner JOIN jc_sfxzjgjbxx jg ON region.regionid = jg.regionid  " + 
							"inner JOIN (select a.* from jz_jzryjbxx a join JZ_JGXXCJB b on a.id=b.f_aid where a.sfjs='1' and a.jcjz='0') jzry ON jg.id = jzry.orgid  " + 
							"JOIN sys_region creg ON creg.regionid = region.parentid  " + 
							"GROUP BY city_name";
					SQLAdapter adapter1=new SQLAdapter(sql1);
					List<BasicMap<String,Object>> lists=dbClient.find(adapter1);
					for (int i = 0; i < lists.size(); i++) {
						if(rowData.get("region_name").equals(lists.get(i).get("city_name"))) {
							rowData.put("jzry", lists.get(i).get("jzrys"));
						}
					}
				}
			});
    	     return list;
    }
    
    /**
     * 各盟市中各区警告人员总数
     * @param city_code
     * @return
     */
    public List<BasicMap<String,Object>> findJgSqDetail(String city_code){
      	if ("".equals(city_code)) {
			city_code = "150100";//默认返回呼和浩特市
		 }
      	List<BasicMap<String,Object>> list=new ArrayList<>();
      	String sql="select count(wc.id) as qjgs,sys.region_name as q_name,sys.region_code as q_code from jc_sfxzjgjbxx jc inner join " + 
      			"(select a.* from jz_jzryjbxx a join JZ_JGXXCJB b on a.id=b.f_aid where a.sfjs='1' and a.jcjz='0') wc  " + 
      			"on jc.id=wc.orgid  " + 
      			"left join (select b.region_name,b.regionid,b.region_code,b.parentid from sys_region a inner join sys_region b  " + 
      			"on a.region_code=b.regionid ) sys on jc.regionid = sys.regionid where sys.parentid='"+city_code+"' group by sys.region_name,sys.region_code";
      	SQLAdapter adapter=new SQLAdapter(sql);
      	list=dbClient.find(adapter);
      	return list;
    	
    }
    
    
    /**
     * 各司法所警告人员总数
     * @param city_code
     * @return
     */
    public List<BasicMap<String,Object>> findJgSfsDetail(BasicMap<String,Object> query){
	    List<BasicMap<String,Object>> list=new ArrayList<>();
	    String sql="select count(wc.id) as sfsjgs,jc.jgmc as jgmc from jc_sfxzjgjbxx jc inner join  " + 
	    		"(select a.* from jz_jzryjbxx a join JZ_JGXXCJB b on a.id=b.f_aid where a.sfjs='1' and a.jcjz='0') wc  " + 
	    		"on jc.id=wc.orgid  " + 
	    		"left join (select b.region_name,b.regionid,b.region_code,b.parentid from sys_region a inner join sys_region b  " + 
	    		"on a.region_code=b.regionid ) sys on jc.regionid = sys.regionid where sys.region_code='"+StringUtil.toEmptyString(query.get("q_code"))+"' and jc.jgmc like '%"+StringUtil.toEmptyString(query.get("jgmc"))+"%' group by jc.jgmc";
	     SQLAdapter adapter=new SQLAdapter(sql);
	     SqlDbFilter filter=new SqlDbFilter();
	     list=dbClient.find(adapter);
	     return list;
    }
   
    
    
    
    
   
    
}
