package com.ehtsoft.supervise.services;

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
import com.ehtsoft.im.services.UserinfoService;
import com.ehtsoft.supervise.api.SupConst;

/**
 * 报警管理
 * @author sunhailong
 *
 */
@Service("BjglService")
public class BjglService extends AbstractService{
	
	@Resource(name = "sqlDbClient")
	private SqlDbClient dbClient;
	
	@Resource
	private UserinfoService userinfoService;
	
	/**
	 * 查询签到信息
	 * @param query
	 * @param paginate
	 * @return
	 */
	public List<BasicMap<String, Object>> findAll(BasicMap<String, Object> query, Paginate paginate){
		SqlDbFilter filter = toSqlFilter(query);
		String sql = "select a.*,b.sqjzksrq,b.sqjzjsrq from JZ_JZRYJBXX a LEFT JOIN JZ_JZRYJBXX_JZ b on a.id = b.id";
		SQLAdapter sqlAdapter = new SQLAdapter(sql);
		sqlAdapter.setFilter(filter);
		return dbClient.find(sqlAdapter, paginate,new RowDataListener() {
			@Override
			public void processData(BasicMap<String, Object> rowData) {
				rowData.put("csrq", DateUtil.format(rowData.get("csrq"),"yyyy-MM-dd"));
				rowData.put("zxtzsrq",  DateUtil.format(rowData.get("zxtzsrq"),"yyyy-MM-dd"));
				rowData.put("jfzxrq",  DateUtil.format(rowData.get("jfzxrq"),"yyyy-MM-dd"));
				rowData.put("sqjzksrq",  DateUtil.format(rowData.get("sqjzksrq"),"yyyy-MM-dd"));
				rowData.put("sqjzjsrq",  DateUtil.format(rowData.get("sqjzjsrq"),"yyyy-MM-dd"));
				//rowData.put("sqjajsrq",  DateUtil.format(rowData.get("sqjajsrq"),"yyyy-MM-dd"));
				rowData.put("ypxqksrq",  DateUtil.format(rowData.get("ypxqksrq"),"yyyy-MM-dd"));
				rowData.put("ypxqjsrq",  DateUtil.format(rowData.get("ypxqjsrq"),"yyyy-MM-dd"));
				rowData.put("sqjzryjsrq",  DateUtil.format(rowData.get("sqjzryjsrq"),"yyyy-MM-dd"));
			}
		}).getRows();
	} 
	/**
	 * 新增与修改签到信息
	 * @param tablename
	 * @param query
	 */
	public void update(BasicMap<String, Object> data){
		dbClient.update(SupConst.Collections.JZ_ALARM, data);
	}
	/**
	 * 删除签到信息
	 * @param tablename
	 * @param query
	 */
	public void remove(BasicMap<String, Object> query){
		dbClient.remove(SupConst.Collections.JZ_ALARM, query);
	}
	
	
}
