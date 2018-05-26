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
import com.ehtsoft.fw.utils.DateUtil;
import com.ehtsoft.fw.utils.StringUtil;
import com.ehtsoft.fw.utils.Util;
import com.ehtsoft.supervise.api.SupConst;

@Service("JzgrjlService")
public class JzgrjlService extends AbstractService{

	@Resource(name="sqlDbClient")
	SqlDbClient dbClient;
	
	/**
	 * 新增矫正人员个人简历
	 * @param data
	 */
	public void saveGrjl(BasicMap<String, Object> data){
		dbClient.save(SupConst.Collections.JZ_SQJZRYGRJL, data);
	}
	
//	public List<BasicMap<String,Object>> findGrjl(BasicMap<String, Object> query){
//		List<BasicMap<String, Object>> list = new ArrayList<>();
//		String sqlstr = "select a.*,b.f_name from JZ_SQJZRYGRJL a LEFT JOIN sys_dictionary b ON a.zw = b.f_code ";
//		SqlDbFilter sqlDbFilter = new SqlDbFilter();
//		sqlDbFilter.eq("a.f_aid", StringUtil.toEmptyString(query.get("f_aid"))).eq("b.f_typecode", "SYS090")
//		.like("a.szdw", StringUtil.toEmptyString(query.get("szdw")));
//		SQLAdapter sqlAdapter = new SQLAdapter(sqlstr);
//		sqlAdapter.setFilter(sqlDbFilter);
//		list = dbClient.find(sqlAdapter, new RowDataListener() {
//			@Override
//			public void processData(BasicMap<String, Object> arg0) {
//				arg0.put("zw", StringUtil.toString(arg0.get("f_name")));
//				arg0.put("qs", DateUtil.format(arg0.get("qs"), "yyyy-MM-dd"));
//				arg0.put("zr", DateUtil.format(arg0.get("zr"), "yyyy-MM-dd"));
//			}
//		});
//		//无数据的处理 返回 nomessage=0；
//		if (list.size() == 0 ) {
//			BasicMap<String, Object> nomessage = new BasicMap<>();
//			nomessage.put("nomessage", "0");
//			list.add(nomessage);
//		}
//			return list;
//	}
	
	//个人简历列表
	public List<BasicMap<String,Object>> findGrjl(BasicMap<String, Object> query){
		List<BasicMap<String, Object>> list = new ArrayList<>();
		String sqlstr = "select a.* from JZ_SQJZRYGRJL a ";
		SqlDbFilter sqlDbFilter = new SqlDbFilter();
		sqlDbFilter.like("a.szdw", StringUtil.toEmptyString(query.get("szdw")))
		           .eq("a.f_aid", StringUtil.toEmptyString(query.get("f_aid")));
		SQLAdapter sqlAdapter = new SQLAdapter(sqlstr);
		sqlAdapter.setFilter(sqlDbFilter);
		list = dbClient.find(sqlAdapter, new RowDataListener() {
			@Override
			public void processData(BasicMap<String, Object> arg0) {
				arg0.put("qs", DateUtil.format(arg0.get("qs"), "yyyy-MM-dd"));
//				arg0.put("zr", DateUtil.format(arg0.get("zr"), "yyyy-MM-dd"));
                
				String sql1="select f_name from sys_dictionary where f_code='"+arg0.get("zw")+"' and f_typecode = 'SYS090'";
				SQLAdapter adapter=new SQLAdapter(sql1);
			    BasicMap<String,Object> data=dbClient.findOne(adapter);
			    if(null != data) {
			    		arg0.put("ZW", StringUtil.toEmptyString(data.get("f_name")));
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
	 * 查询一条个人简历
	 * @param query
	 * @return
	 */
	public BasicMap<String, Object> findOne(BasicMap<String, Object> query){
		BasicMap<String,Object> rtn = new BasicMap<>();
		rtn = dbClient.findOne(SupConst.Collections.JZ_SQJZRYGRJL, new SqlDbFilter().eq("id", StringUtil.toEmptyString(query.get("id"))));
		rtn.put("qs", DateUtil.format(rtn.get("qs"), "yyyy-MM-dd"));
		rtn.put("zr", DateUtil.format(rtn.get("zr"), "yyyy-MM-dd"));
		return rtn;
	}
	/**
	 * 删除一条个人简历
	 * @param query
	 */
	public void deleteOne(BasicMap<String, Object> query){
		dbClient.remove(SupConst.Collections.JZ_SQJZRYGRJL, new SqlDbFilter().eq("id", StringUtil.toEmptyString(query.get("id"))));
	}
}
