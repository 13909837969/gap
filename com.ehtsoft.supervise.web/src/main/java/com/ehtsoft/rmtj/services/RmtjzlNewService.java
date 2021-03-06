package com.ehtsoft.rmtj.services;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map.Entry;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ehtsoft.fw.core.db.SQLAdapter;
import com.ehtsoft.fw.core.db.SqlDbClient;
import com.ehtsoft.fw.core.db.SqlDbFilter;
import com.ehtsoft.fw.core.dto.BasicMap;
import com.ehtsoft.fw.core.dto.Paginate;
import com.ehtsoft.fw.core.services.AbstractService;

@Service("RmtjzlNewService")
public class RmtjzlNewService extends AbstractService {

	@Resource(name="sqlDbClient")
	SqlDbClient dbClient;
	
	//调解总数;调解成功数;调解不成功;人民调解员总数;调委会总数;协议涉及金额
	public List<BasicMap<String,Object>> find_zs(BasicMap<String,Object> query){
		String sqlstr = "select sum(cnt1) cnt1,sum(cnt2) cnt2,sum(cnt3) cnt3,sum(cnt4) cnt4,"
				+ "sum(cnt5) cnt5,sum(cnt6) cnt6 from view_zl_rmtj_zs";
		SQLAdapter sql = new SQLAdapter(sqlstr);
		sql.setFilter(toSqlFilter(query));
		return dbClient.find(sql);
	}
	
	//履行情况
	public List<BasicMap<String,Object>> find_lxqk(BasicMap<String,Object> query){
		StringBuffer sqlstr = new StringBuffer();
		sqlstr.append("select rq,sum(cnt1) cnt1,sum(cnt2) cnt2,sum(cnt3) cnt3,sum(cnt4) cnt4,sum(cnt5) cnt5 from view_zl_rmtj_lxqk ");
		
		if(query != null){
			sqlstr.append("where ");
			Iterator<Entry<String, Object>> iterator = query.entrySet().iterator();
			while (iterator.hasNext()) {
				Entry<String, Object> entry = iterator.next();
				sqlstr.append(entry.getKey() + "'" + entry.getValue() + "'");
				
				sqlstr.append(" and ");
			}
			sqlstr.append("1=1 ");
		}
		
		sqlstr.append(" group by rq order by rq asc");
		
		SQLAdapter sql = new SQLAdapter(sqlstr.toString());
		List<BasicMap<String,Object>> list = dbClient.find(sql);
		return list;
	}
	
	//案件来源  
	public List<BasicMap<String,Object>> find_ajly(BasicMap<String,Object> query){
		StringBuffer sqlstr = new StringBuffer();
		sqlstr.append("select ajly,sum(cnt) cnt FROM ");
		sqlstr.append("(select c.provinceid,c.province,c.cityid,c.city,c.districtid,c.district,d.jgbm,d.jgmc,b.f_name ajly,count(1) as cnt from rmtj_tjajxx a inner join sys_dictionary b on a.ajly = b.f_code ");
		sqlstr.append("inner join jc_sfxzjgjbxx d on a.orgid = d.id inner join view_sys_region c on d.regionid = c.districtid ");
		sqlstr.append("where b.f_typecode = 'SYS111' ");
		sqlstr.append("group by c.provinceid,c.province,c.cityid,c.city,c.districtid,c.district,d.jgbm,d.jgmc,b.f_name ");
		sqlstr.append(") t ");
		
		if(query != null){
			sqlstr.append("where ");
			Iterator<Entry<String, Object>> iterator = query.entrySet().iterator();
			while (iterator.hasNext()) {
				Entry<String, Object> entry = iterator.next();
				sqlstr.append(entry.getKey() + "'" + entry.getValue() + "'");
				
				sqlstr.append(" and ");
			}
			sqlstr.append("1=1 ");
		}
		sqlstr.append(" group by ajly");
		
		SQLAdapter sql = new SQLAdapter(sqlstr.toString());
		List<BasicMap<String, Object>> list = dbClient.find(sql);
		return list;
	}
	
	//实时监控  地图
	public List<BasicMap<String,Object>> find_ssjk(){
		return null;
	}
	
	//案件难易
	public List<BasicMap<String,Object>> find_ajny(BasicMap<String,Object> query){
		StringBuffer sqlstr = new StringBuffer();
		sqlstr.append("select city,sum(cnt1) cnt1,sum(cnt2) cnt2,sum(cnt3) cnt3,sum(cnt4) cnt4,sum(cnt5) cnt5 from view_zl_rmtj_ajny ");
		if(query != null){
			sqlstr.append("where ");
			Iterator<Entry<String, Object>> iterator = query.entrySet().iterator();
			while (iterator.hasNext()) {
				Entry<String, Object> entry = iterator.next();
				sqlstr.append(entry.getKey() + "'" + entry.getValue() + "'");
				
				sqlstr.append(" and ");
			}
			sqlstr.append("1=1 ");
		}
		sqlstr.append(" group by city");
		SQLAdapter sql = new SQLAdapter(sqlstr.toString());
		return dbClient.find(sql);
	}
	
	//案件纠纷情况
	public List<BasicMap<String,Object>> find_ajjf(BasicMap<String,Object> query){
		StringBuffer sqlstr = new StringBuffer();
		sqlstr.append("select jflx,sum(cnt) cnt from ");
		sqlstr.append("(select c.provinceid,c.province,c.cityid,c.city,c.districtid,c.district,d.jgbm,d.jgmc,b.f_name jflx,count(1) as cnt from rmtj_tjajxx a ");
		sqlstr.append("inner join sys_dictionary b on a.jflb = b.f_code inner join jc_sfxzjgjbxx d on a.orgid = d.id inner join view_sys_region c on d.regionid = c.districtid ");
		sqlstr.append("where b.f_typecode = 'SYS104' ");
		sqlstr.append("group by c.provinceid,c.province,c.cityid,c.city,c.districtid,c.district,d.jgbm,d.jgmc,b.f_name ) t ");
		if(query != null){
			sqlstr.append("where ");
			Iterator<Entry<String, Object>> iterator = query.entrySet().iterator();
			while (iterator.hasNext()) {
				Entry<String, Object> entry = iterator.next();
				sqlstr.append(entry.getKey() + "'" + entry.getValue() + "'");
				
				sqlstr.append(" and ");
			}
			sqlstr.append("1=1 ");
		}
		sqlstr.append(" group by jflx");
		SQLAdapter sql = new SQLAdapter(sqlstr.toString());
		return dbClient.find(sql);
	}
	
	//调解结果
	public List<BasicMap<String,Object>> find_tjjg(BasicMap<String,Object> query){
		StringBuffer sqlstr = new StringBuffer();
		sqlstr.append("select rq,sum(cnt1) cnt1,sum(cnt2) cnt2,sum(cnt3) cnt3,sum(cnt4) cnt4 from view_zl_rmtj_tjjg ");
		if(query != null){
			sqlstr.append("where ");
			Iterator<Entry<String, Object>> iterator = query.entrySet().iterator();
			while (iterator.hasNext()) {
				Entry<String, Object> entry = iterator.next();
				sqlstr.append(entry.getKey() + "'" + entry.getValue() + "'");
				
				sqlstr.append(" and ");
			}
			sqlstr.append("1=1 ");
		}
		sqlstr.append(" group by rq order by rq asc");
		SQLAdapter sql = new SQLAdapter(sqlstr.toString());
		return dbClient.find(sql);
	}
}
