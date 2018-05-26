package com.ehtsoft.supervise.services;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ehtsoft.fw.core.db.RowDataListener;
import com.ehtsoft.fw.core.db.SQLAdapter;
import com.ehtsoft.fw.core.db.SqlDbClient;
import com.ehtsoft.fw.core.db.SqlDbFilter;
import com.ehtsoft.fw.core.dto.BasicMap;
import com.ehtsoft.fw.core.services.AbstractService;
import com.ehtsoft.fw.utils.StringUtil;
import com.ehtsoft.supervise.api.SupConst;

@Service("JzjtcyService")
public class JzjtcyService extends AbstractService{

	@Resource(name="sqlDbClient")
	SqlDbClient dbClient;
	
	/**
	 * 新增或修改家庭成员
	 * @param data
	 */
	public void saveJtcy(BasicMap<String, Object> data){
		data.put("GX", data.get("fmgx"));
		dbClient.save(SupConst.Collections.JZ_JTCYJZYSHGX, data);
	}
	
	/**
	 * 查询当前矫正人员的家庭成员
	 * @param query
	 * @return
	 */
//	public List<BasicMap<String,Object>> findJtcy(BasicMap<String, Object> query){
//		List<BasicMap<String, Object>> list = new ArrayList<>();
//		String sqlstr = "select a.*,b.f_name from JZ_JTCYJZYSHGX a LEFT JOIN sys_dictionary b ON a.szdw = b.f_code ";
//		SqlDbFilter sqlDbFilter = new SqlDbFilter();
//		sqlDbFilter.like("a.xm", StringUtil.toEmptyString(query.get("xm"))).eq("b.f_typecode", "SYS090")
//		.eq("a.f_aid", StringUtil.toEmptyString(query.get("f_aid")));
//		SQLAdapter sqlAdapter = new SQLAdapter(sqlstr);
//		sqlAdapter.setFilter(sqlDbFilter);
//		list = dbClient.find(sqlAdapter,new RowDataListener() {
//			
//			@Override
//			public void processData(BasicMap<String, Object> rowData) {
//				String gxcode = StringUtil.toString(rowData.get("gx"));
//				BasicMap<String, Object> map = dbClient.findOne("select f_name as fmgx from sys_dictionary where f_typecode = 'SYS199' and f_code = '"+ gxcode +"'");
//				rowData.put("GX",StringUtil.toString(map.get("fmgx")));
//			}
//		});
//		//无数据的处理 返回 nomessage=0；
//		if (list.size() == 0 ) {
//			BasicMap<String, Object> nomessage = new BasicMap<>();
//			nomessage.put("nomessage", "0");
//			list.add(nomessage);
//		}
//		return list;
//	}
	
	
	public List<BasicMap<String,Object>> findJtcy(BasicMap<String, Object> query){
		List<BasicMap<String, Object>> list = new ArrayList<>();
		String sqlstr = "select a.* from JZ_JTCYJZYSHGX a ";
		SqlDbFilter sqlDbFilter = new SqlDbFilter();
		sqlDbFilter.like("a.xm", StringUtil.toEmptyString(query.get("xm")))
		.eq("a.f_aid", StringUtil.toEmptyString(query.get("f_aid")));
		SQLAdapter sqlAdapter = new SQLAdapter(sqlstr);
		sqlAdapter.setFilter(sqlDbFilter);
		list = dbClient.find(sqlAdapter,new RowDataListener() {
			
			@Override
			public void processData(BasicMap<String, Object> rowData) {
				String gxcode = StringUtil.toString(rowData.get("gx"));
				BasicMap<String, Object> map = dbClient.findOne("select f_name as fmgx from sys_dictionary where f_typecode = 'SYS199' and f_code = '"+ gxcode +"'");
				rowData.put("GX",StringUtil.toString(map.get("fmgx")));
				
				String sql1="select f_name from sys_dictionary where f_code='"+rowData.get("zw")+"' and f_typecode = 'SYS090'";
				SQLAdapter adapter=new SQLAdapter(sql1);
			    BasicMap<String,Object> data=dbClient.findOne(adapter);
			    if(null != data) {
			    	rowData.put("ZW", StringUtil.toEmptyString(data.get("f_name")));
			    }
			}
		});
		//无数据的处理 返回 nomessage=0；
		if (list.size() == 0 ) {
			BasicMap<String, Object> nomessage = new BasicMap<>();
			nomessage.put("nomessage", "0");
			list.add(nomessage);
		}
		return list;
	}
	
	
	/**
	 * 删除一条家庭成员信息
	 * @param query
	 */
	public void deleteOne(BasicMap<String, Object> query){
		dbClient.remove(SupConst.Collections.JZ_JTCYJZYSHGX, new SqlDbFilter().eq("f_id", StringUtil.toEmptyString(query.get("id"))));
	}
}
