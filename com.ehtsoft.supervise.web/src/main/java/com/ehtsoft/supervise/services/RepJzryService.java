package com.ehtsoft.supervise.services;

import java.sql.Date;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ehtsoft.fw.core.db.MongoClient;
import com.ehtsoft.fw.core.db.RowDataListener;
import com.ehtsoft.fw.core.db.SQLAdapter;
import com.ehtsoft.fw.core.db.SqlDbClient;
import com.ehtsoft.fw.core.db.SqlDbFilter;
import com.ehtsoft.fw.core.dto.BasicMap;
import com.ehtsoft.fw.core.dto.Paginate;
import com.ehtsoft.fw.utils.DateUtil;
import com.ehtsoft.fw.utils.NumberUtil;
import com.ehtsoft.fw.utils.StringUtil;
import com.ehtsoft.fw.utils.Util;
import com.ehtsoft.supervise.api.SupConst;
import com.ehtsoft.supervise.utils.ParameterUtil;
@Service("RepJzryService")
public class RepJzryService {

	@Resource(name = "sqlDbClient")
	private SqlDbClient dbClient;
	
	
	@Resource(name="mongoClient")
	private MongoClient mongoClient;
	/***
	 * 社区矫正页面,统计矫正人员总数,统计某一时间段新增矫正人员总数，统计解除矫正的人员总数
	 * @author sunhailong
	 */
	public BasicMap<String,Object> findCount(BasicMap<String,Object> query){
		final BasicMap<String, Object> map = new BasicMap<>();
		StringBuffer sql1 = new StringBuffer("select count(id) as count from JZ_JZRYJBXX WHERE JCJZ = '0' ");
		//统计矫正人员总数 total
		map.put("total", dbClient.countSql(sql1.toString()));
		
		String sql2 = "select jglx,count(id) as cnt from JZ_JZRYJBXX  where jcjz = '0' group by jglx";
		
		dbClient.find(new SQLAdapter(sql2),new RowDataListener() {
			@Override
			public void processData(BasicMap<String, Object> rowData) {
				int cnt = NumberUtil.toInt(rowData.get("cnt"));
				int jglx = NumberUtil.toInt(rowData.get("jglx"));
				if(jglx==1){
					map.put("pgs",cnt);//普管
				}
				if(jglx==2){
					map.put("kgs",cnt);//宽管
				}
				if(jglx==3){
					map.put("ygs",cnt);//严管
				}
			}
		});
		
 		return map;
	}
	/**
	 * 查询统计每个盟市有多少矫正人员
	 * @param query
	 * @return
	 */
	public List<BasicMap<String,Object>> findProvince(){
	
		String province_code = ParameterUtil.getParameter(dbClient).get(SupConst.ParameterKey.KEY_SYSTEM_017).getValue();
		
		String sql2 = "select city_code,city_name,jglx,count(id) as cnt from view_rep_qyjzrysmx " + 
				"where province_code = '" + province_code + "' " +
				"group by jglx,city_code,city_name";
		final Map<String,Object> map = new BasicMap<String,Object>();
		dbClient.find(new SQLAdapter(sql2),new RowDataListener() {
			@Override
			public void processData(BasicMap<String, Object> rowData) {
				String city_code = StringUtil.toEmptyString(rowData.get("city_code"));
				String jglx = StringUtil.toEmptyString(rowData.get("jglx"));
				int cnt = NumberUtil.toInt(rowData.get("cnt"));
				map.put(city_code + jglx, cnt);
			}
		});
		
		String sql = "select city_code,city_name ,count(id) as jzrys from view_rep_qyjzrysmx WHERE province_code = '"+province_code+"' group by city_name,city_code order by city_code asc";
		SQLAdapter adapter = new SQLAdapter(sql);
		List<BasicMap<String,Object>> list = dbClient.find(adapter,new RowDataListener() {
			@Override
			public void processData(BasicMap<String, Object> rowData) {
				String city_code = StringUtil.toEmptyString(rowData.get("city_code"));
				rowData.put("pgs",NumberUtil.toInt(map.get(city_code+"1")));//普管
				rowData.put("kgs",NumberUtil.toInt(map.get(city_code+"2")));//宽管
				rowData.put("ygs",NumberUtil.toInt(map.get(city_code+"3")));//严管
			}
		});
		return list;
	}
	/**
	 * 查询统计每个区县有多少矫正人员
	 */
	public List<BasicMap<String,Object>> findDistrict(String parentId){
		String string = "select district_code,district_name,jglx,count(id) as cnt from view_rep_qyjzrysmx " +
						" where jcjz = '0'  and city_code = '"+parentId+"'" +
						" group by district_code,district_name,jglx ";
		final Map<String,Object> map = new BasicMap<String,Object>();
		dbClient.find(new SQLAdapter(string),new RowDataListener() {
			@Override
			public void processData(BasicMap<String, Object> rowData) {
				String district_code = StringUtil.toEmptyString(rowData.get("district_code"));
				String jglx = StringUtil.toEmptyString(rowData.get("jglx"));
				int cnt = NumberUtil.toInt(rowData.get("cnt"));
				map.put(district_code + jglx, cnt);
			}
		});
		
		String sql = "select city_code,district_code, district_name,count(id) as qxjzrys from view_rep_qyjzrysmx where city_code = '"+parentId+"' and jcjz = '0' "
					+ " group by district_code,district_name,city_code";
		SQLAdapter adapter = new SQLAdapter(sql);
		List<BasicMap<String,Object>> list = dbClient.find(adapter,new RowDataListener() {
			@Override
			public void processData(BasicMap<String, Object> rowData) {
				String district_code = StringUtil.toEmptyString(rowData.get("district_code"));
				rowData.put("pgs",NumberUtil.toInt(map.get(district_code+"1")));//普管
				rowData.put("kgs",NumberUtil.toInt(map.get(district_code+"2")));//宽管
				rowData.put("ygs",NumberUtil.toInt(map.get(district_code+"3")));//严管
			}
		});
		return list;
	}
	/*统计矫管类型*/
	public List<BasicMap<String,Object>> findJglx(String parentId){
		String sql ;
		if(parentId.equals("150000")) {
			sql = "SELECT COUNT(*) AS lxs,jglx FROM view_rep_qyjzrysmx WHERE jglx NOTNULL and jglx<>'' GROUP BY jglx";
		}else {
			sql = "SELECT COUNT(*) AS lxs,jglx FROM view_rep_qyjzrysmx WHERE jglx NOTNULL and jglx<>'' and district_code = '"+parentId+"'"
					+" and jcjz = '0' "
					+ " GROUP BY jglx";
		}
		SQLAdapter adapter = new SQLAdapter(sql);
		List<BasicMap<String,Object>> list = dbClient.find(adapter);
		return list;
	}
}
