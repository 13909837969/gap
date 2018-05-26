package com.ehtsoft.supervise.services;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ehtsoft.fw.core.db.RowDataListener;
import com.ehtsoft.fw.core.db.SQLAdapter;
import com.ehtsoft.fw.core.db.SqlDbClient;
import com.ehtsoft.fw.core.db.SqlDbFilter;
import com.ehtsoft.fw.core.dto.BasicMap;
import com.ehtsoft.fw.core.dto.Paginate;
import com.ehtsoft.fw.core.services.AbstractService;
import com.ehtsoft.fw.utils.DateUtil;
import com.ehtsoft.fw.utils.StringUtil;
import com.ehtsoft.supervise.api.SupConst;

@Service("JzjzlxxService")
public class JzjzlxxService extends AbstractService{

	@Resource(name="sqlDbClient")
	SqlDbClient dbClient;
	
	/**
	 * 保存或修改禁止令信息
	 * @param data
	 */
	public void saveJzlxx(BasicMap<String,Object> data){
		dbClient.save(SupConst.Collections.JZ_JZLXXCJB, data);
		if(!StringUtil.toString(data.get("jrlx")).equals("")){
			String code[] = StringUtil.toEmptyString(data.get("jrlx")).split(",");
			for(int i=0;i<code.length;i++){
				BasicMap<String, Object> a = new BasicMap<>();
				a.put("f_aid", data.get("f_aid"));
				a.put("f_jrlx", code[i]);
				dbClient.save(SupConst.Collections.SYS_JZRY_JRQY, a);
			}
		}
	}
	
	
	
	/**
	 * 查询当前矫正人员禁止令信息
	 * @param query
	 * @return
	 */
	public List<BasicMap<String, Object>> findJzlxx(BasicMap<String, Object> query){
		List<BasicMap<String,Object>> list = new ArrayList<>();
		String sqlstr = "select * from JZ_JZLXXCJB";
		SqlDbFilter sqlDbFilter = new SqlDbFilter();
		sqlDbFilter.like("jzllx", StringUtil.toEmptyString(query.get("jzllx")))
		.eq("f_aid", StringUtil.toEmptyString(query.get("f_aid")));
		SQLAdapter sqlAdapter = new SQLAdapter(sqlstr);
		sqlAdapter.setFilter(sqlDbFilter);
		list = dbClient.find(sqlAdapter,new RowDataListener() {
			@Override
			public void processData(BasicMap<String, Object> rowData) {
				rowData.put("jzqxksrq", DateUtil.format(rowData.get("jzqxksrq"), "yyyy-MM-dd"));
				rowData.put("jzqxjsrq", DateUtil.format(rowData.get("jzqxjsrq"), "yyyy-MM-dd"));
				if(rowData.get("jrlx")!=null){
					StringBuffer result = new StringBuffer();
					String type[] = StringUtil.toString(rowData.get("jrlx")).split(",");
					for(int i=0;i<type.length;i++){
						if("01".equals(type[i])){
							result.append("高档酒店,");
						}else if("02".equals(type[i])){
							result.append("娱乐场所,");
						}else if("03".equals(type[i])){
							result.append("网吧,");
						}else if("04".equals(type[i])){
							result.append("酒吧,");
						}else if("99".equals(type[i])){
							result.append("临时禁区,");
						}
					}
					rowData.put("jrlx", result.substring(0, result.lastIndexOf(",")));
				}
			}
		});
		
		if (list.size() <= 0) {
			BasicMap<String, Object> map = new BasicMap<>();
			map.put("nomessage", "0");
			list.add(map);
		}
		return list;
	}
	
	
	
	
	
	/**
	 * 查询当前矫正人员禁止令信息
	 * @param query
	 * @return
	 */
	public List<BasicMap<String, Object>> findJzlxx(String id,Paginate paginate){
		List<BasicMap<String,Object>> list = new ArrayList<>();
		String sqlstr = "select * from JZ_JZLXXCJB";
		SqlDbFilter sqlDbFilter = new SqlDbFilter();
		sqlDbFilter.eq("f_aid",id);
		SQLAdapter sqlAdapter = new SQLAdapter(sqlstr);
		sqlAdapter.setFilter(sqlDbFilter);
		list = dbClient.find(sqlAdapter,new RowDataListener() {
			@Override
			public void processData(BasicMap<String, Object> rowData) {
				rowData.put("jzqxksrq", DateUtil.format(rowData.get("jzqxksrq"), "yyyy-MM-dd"));
				rowData.put("jzqxjsrq", DateUtil.format(rowData.get("jzqxjsrq"), "yyyy-MM-dd"));
			}
		});
		
		return list;
	}
	
	/**
	 * 删除当前矫正人员禁止令信息
	 * @param query
	 */
	public void  deleteOne(BasicMap<String, Object> query){
		dbClient.remove(SupConst.Collections.JZ_JZLXXCJB,new SqlDbFilter().eq("jzlid", StringUtil.toEmptyString(query.get("id"))));
	}
}
