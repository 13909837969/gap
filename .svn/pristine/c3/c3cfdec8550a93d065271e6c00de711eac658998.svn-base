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
import com.ehtsoft.fw.utils.DateUtil;
import com.ehtsoft.fw.utils.StringUtil;
import com.ehtsoft.supervise.api.SupConst;

@Service("JzysxxService")
public class JzysxxService {
	
	@Resource(name="sqlDbClient")
	SqlDbClient dbClient;

	
	/**
	 * 
	 * 修改/保存矫正人员相关地址
	 * 返回值格式:<br>
	 *
	 * @author Administrator
	 * @date   2018年4月22日
	 * 方法的作用：TODO
	 */
	public void saveXgdz(BasicMap<String, Object> data) {
		dbClient.save(SupConst.Collections.JZ_JZRYJBXX_DZ, data);

	}
	
	
	/**
	 * 
	 * 查询服刑人员基本信息
	 * @return<br>
	 * 返回值格式:<br>
	 *
	 * @author Administrator
	 * @date   2018年4月7日
	 * 方法的作用：TODO
	 */
	public BasicMap<String, Object> findFxryjbxx(String id) {
		String sql = "SELECT  a.ID, a.jzlb,a.JZSSSQ, a.SQJZJDJG,a.YJZFJG,a.SQJZQX,a.SQJZKSRQ, a.SQJZJSRQ, a.JFZXRQ, a.FZLX, a.JTZM, a.GZQX,a.HXKYQX, a.YPXF, a.YPXQ, a.YPXQKSRQ, " + 
				"a.YPXQJSRQ,a.YQTXQX,a.FJX,a.SQJZRYJSRQ,a.SQJZRYJSFS,a.JCQK, a.SFDCPG,a.DCPGYJ,a.DCYJCXQK ,b.gj,b.YXJTCYJZYSHGX,b.HJDSFYJZDXT,b.GDJZDSZS,b.GDJZDSZDS,b.GDJZDSZXQ,b.GDJZD, " + 
				"b.GDJZDMX,b.HJSZS,b.HJSZDS,b.HJSZXQ,b.HJSZD,b.HJSZDMX " + 
				"FROM  JZ_JZRYJBXX_JZ a LEFT JOIN JZ_JZRYJBXX_DZ b ON a.ID = b.id  where a.id = '"+ id +"' " + 
				" ORDER BY  a.cts  DESC";
		SQLAdapter adapter = new SQLAdapter(sql);
		return dbClient.findOne(adapter);
	}
	
	/**
	 * 
	 * 修改服刑人员基本信息
	 * @param data<br>
	 * 返回值格式:<br>
	 *
	 * @author Administrator
	 * @date   2018年4月7日
	 * 方法的作用：TODO
	 */
	public void updateFxryjbxx(BasicMap<String, Object> data) {
		dbClient.save(SupConst.Collections.JZ_JZRYJBXX_JZ, data);
	}
	
	
	
	
	/**
	 * 新增或修改矫正人员押送信息
	 * @param data
	 */
	public void saveYsxx(BasicMap<String, Object> data){
		dbClient.save(SupConst.Collections.JZ_YSXX, data);
	}
	
	
	
	/**
	 * 查询矫正人员押送警察信息
	 * @param query
	 * @return
	 */
	public List<BasicMap<String,Object>> findYsxx(BasicMap<String, Object> query){
		List<BasicMap<String, Object>> list = new ArrayList<>();
		String sqlstr = "select * from JZ_YSXX ";
		SqlDbFilter sqlDbFilter = new SqlDbFilter();
		SQLAdapter sqlAdapter = new SQLAdapter(sqlstr);
		sqlDbFilter.like("ZXYSJCXM", StringUtil.toString(query.get("zxysjcxm")))
		.eq("f_aid", StringUtil.toEmptyString(query.get("f_aid")));
		sqlAdapter.setFilter(sqlDbFilter);
		list = dbClient.find(sqlAdapter, new RowDataListener() {
			@Override
			public void processData(BasicMap<String, Object> rowData) {
				rowData.put("ysrq", DateUtil.format(rowData.get("ysrq"), "yyyy-MM-dd"));
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
	 * 查询矫正人员押送警察信息
	 * @param query
	 * @return
	 */
	public List<BasicMap<String,Object>> findYsxx(String id,Paginate paginate){
		List<BasicMap<String, Object>> list = new ArrayList<>();
		String sqlstr = "select * from JZ_YSXX ";
		SqlDbFilter sqlDbFilter = new SqlDbFilter();
		SQLAdapter sqlAdapter = new SQLAdapter(sqlstr);
		sqlDbFilter.eq("f_aid", id);
		sqlAdapter.setFilter(sqlDbFilter);
		list = dbClient.find(sqlAdapter, new RowDataListener() {
			@Override
			public void processData(BasicMap<String, Object> rowData) {
				rowData.put("ysrq", DateUtil.format(rowData.get("ysrq"), "yyyy-MM-dd"));
			}
		});
		return list;
	}
	
	/**
	 * 删除当前矫正人员同案犯信息
	 * @param query
	 */
	public void  deleteOne(BasicMap<String, Object> query){
		dbClient.remove(SupConst.Collections.JZ_YSXX,new SqlDbFilter().eq("id", StringUtil.toEmptyString(query.get("id"))));
	}
	
	/**
	 * 健康状况
	 * @param id
	 * @return
	 */
	public BasicMap<String,Object> findHealth(String id){
		String sql="select a.id,a.xm,b.* from JZ_JZRYJBXX a left join JZ_JZRYJBXX_JK b on a.id=b.id ";
		SQLAdapter adapter=new SQLAdapter(sql);
		SqlDbFilter filter=new SqlDbFilter();
		filter.eq("a.id", id);
		adapter.setFilter(filter);
		BasicMap<String,Object> data=dbClient.findOne(adapter);
		return data;
	}
	
	/**
	 * 健康状况保存
	 * @param data
	 */
	public void saveHealth(BasicMap<String,Object> data) {
		dbClient.save(SupConst.Collections.JZ_JZRYJBXX_JK, data);
		
	}
	
}
