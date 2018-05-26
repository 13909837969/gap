package com.ehtsoft.rmtj.services;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ehtsoft.fw.core.db.SQLAdapter;
import com.ehtsoft.fw.core.db.SqlDbClient;
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
		String sqlstr = "select * from view_rmtj_tjajxx_lxqk";
		SQLAdapter sql = new SQLAdapter(sqlstr);
		sql.setFilter(toSqlFilter(query));
		return null;//dbClient.find(sql);
	}
	
	//案件来源
	public List<BasicMap<String,Object>> find_ajly(){
		String sqlstr = "select b.f_name ajly,count(1) as cnt from rmtj_tjajxx a inner join "
				+ "sys_dictionary b on a.ajly = b.f_code where b.f_typecode = 'SYS111' "
				+ "group by b.f_name,b.f_code order by b.f_code asc";
		SQLAdapter sql = new SQLAdapter(sqlstr);
		return dbClient.find(sql);
	}
	
	//实时监控  地图
	public List<BasicMap<String,Object>> find_ssjk(){
		return null;
	}
	
	//案件难易
	public List<BasicMap<String,Object>> find_ajny(){
		String sqlstr = "select * from view_rmtj_tjajxx_ajny";
		SQLAdapter sql = new SQLAdapter(sqlstr);
		return dbClient.find(sql);
	}
	
	//案件纠纷情况
	public List<BasicMap<String,Object>> find_ajjf(){
		String sqlstr = "select b.f_name jflx,count(1) as cnt from rmtj_tjajxx a "
				+ "inner join sys_dictionary b on a.jflb = b.f_code "
				+ "where b.f_typecode = 'SYS104' group by b.f_name,b.f_code order by b.f_code asc";
		SQLAdapter sql = new SQLAdapter(sqlstr);
		return dbClient.find(sql);
	}
	
	//调解结果
	public List<BasicMap<String,Object>> find_tjjg(){
		String sqlstr = "select * from view_rmtj_tjajxx_tjjg";
		SQLAdapter sql = new SQLAdapter(sqlstr);
		return dbClient.find(sql);
	}
}
