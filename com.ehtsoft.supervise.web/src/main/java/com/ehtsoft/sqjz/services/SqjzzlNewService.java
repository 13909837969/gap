package com.ehtsoft.sqjz.services;

import java.util.Iterator;
import java.util.List;
import java.util.Map.Entry;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ehtsoft.fw.core.db.SQLAdapter;
import com.ehtsoft.fw.core.db.SqlDbClient;
import com.ehtsoft.fw.core.dto.BasicMap;
import com.ehtsoft.fw.core.services.AbstractService;

@Service("SqjzzlNewService")
public class SqjzzlNewService extends AbstractService {

	@Resource(name="sqlDbClient")
	SqlDbClient dbClient;
	
	//在册人员总数  宽管；普管；严管（在册）
	public List<BasicMap<String,Object>> find_ryzs(BasicMap<String,Object> query){
		String sqlstr = "select sum(cnt1) cnt1,sum(cnt2) cnt2,sum(cnt3) cnt3,sum(cnt4) cnt4 from view_zl_sqjz_ryzs";
		SQLAdapter sql = new SQLAdapter(sqlstr);
		sql.setFilter(toSqlFilter(query));
		return dbClient.find(sql);
	}
	
	//教育矫正
	public List<BasicMap<String,Object>> find_jyjz(BasicMap<String,Object> query){
		StringBuffer sqlstr = new StringBuffer();
		sqlstr.append("select cast(to_char(rq,'mm') as int)||'月' rq,sum(cnt1) cnt1,sum(cnt2) cnt2,sum(cnt3) cnt3 from view_zl_sqjz_jyjz ");
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
		sql.setFilter(toSqlFilter(query));
		return dbClient.find(sql);
	}
	
	//全年服刑人员使用情况
	public List<BasicMap<String,Object>> find_syqk(BasicMap<String,Object> query){
		StringBuffer sqlstr = new StringBuffer();
		sqlstr.append("select cast(to_char(rq,'mm') as int)||'月' rq,sum(cnt1) cnt1,sum(cnt2) cnt2,sum(cnt3) cnt3 from view_zl_sqjz_jyjz ");
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
		sql.setFilter(toSqlFilter(query));
		return dbClient.find(sql);
	}
	
	//奖惩情况
	public List<BasicMap<String,Object>> find_jcqk(BasicMap<String,Object> query){
		StringBuffer sqlstr = new StringBuffer();
		sqlstr.append("select lbname,sum(cnt) cnt from view_zl_sqjz_jcqk ");
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
		sqlstr.append(" group by lbname");
		SQLAdapter sql = new SQLAdapter(sqlstr.toString());
		sql.setFilter(toSqlFilter(query));
		return dbClient.find(sql);
	}
		
}
