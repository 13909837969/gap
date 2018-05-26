package com.ehtsoft.supervise.services;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.stereotype.Service;

import com.ehtsoft.fw.core.db.MongoClient;
import com.ehtsoft.fw.core.db.RowDataListener;
import com.ehtsoft.fw.core.db.SQLAdapter;
import com.ehtsoft.fw.core.db.SqlDbClient;
import com.ehtsoft.fw.core.db.SqlDbFilter;
import com.ehtsoft.fw.core.dto.BasicMap;
import com.ehtsoft.fw.core.dto.Paginate;
import com.ehtsoft.fw.core.dto.ResultList;
import com.ehtsoft.fw.core.services.AbstractService;
import com.ehtsoft.fw.utils.DateUtil;
import com.ehtsoft.fw.utils.StringUtil;
import com.ehtsoft.fw.utils.Util;
import com.ehtsoft.im.api.ImConst;
import com.ehtsoft.supervise.api.SupConst;
import com.ibm.icu.text.SimpleDateFormat;

/**
 * 进入特定区域信息
 * @author   :dd
 * @创建时间 :2017年11月26日 下午3:48:33
 * @修改人	 :
 * @创建时间 :2017年11月26日
 */
 
@Service("JzryJrtsqyspService")
public class JzryJrtsqyspService  extends AbstractService  {
	
	@Resource(name = "sqlDbClient")
	private SqlDbClient dbClient;
	
	
	@Resource(name="mongoClient")
	private MongoClient mongoClient;
	
	/**
	 * 矫正人员个人基本信息表 + 进入特定区域（场所）信息采集表
	 * 根据	
	 * 		个人基本信息表内的ID=进入特定区域（场所）信息采集表内的F_AID	获取进入特定区域（场所）信息
	 * @param id
	 * @return
	 */
	public BasicMap<String, Object> findOne(String id){
		String sqlstr = "select * from JZ_JZRYJBXX where id=?";//sql
		BasicMap<String, Object> basicMap = dbClient.findOne(sqlstr, id);//根据ID获取个人基本信息
		/**
		 * 根据	个人基本信息表内的ID=进入特定区域（场所）信息采集表内的F_AID	获取进入特定区域（场所）信息
		 */
		List<BasicMap<String,Object>> jrtdqy = dbClient.find(SupConst.Collections.JZ_SQJZRYJRTDQYSPB, new SqlDbFilter().eq("f_aid", id),new RowDataListener(){
			public void processData(BasicMap<String, Object> rowData) {
				/**
				 * 处理表内相关字段的时间格式
				 */
				rowData.put("sqrq",  DateUtil.format(rowData.get("sqrq"),"yyyy-MM-dd"));
				rowData.put("sqjrrq",  DateUtil.format(rowData.get("sqjrrq"),"yyyy-MM-dd"));
				rowData.put("sqjsrq",  DateUtil.format(rowData.get("sqjsrq"),"yyyy-MM-dd"));
				rowData.put("sfsshsj",  DateUtil.format(rowData.get("sfsshsj"),"yyyy-MM-dd"));
				rowData.put("xsfjspsj",  DateUtil.format(rowData.get("xsfjspsj"),"yyyy-MM-dd"));
			}
		});
		basicMap.put("jrtdqy", jrtdqy);
		/**
		 * 根据	个人基本信息表内的ID=禁止令信息采集表内的F_AID	获取禁止令信息
		 */
		List<BasicMap<String,Object>> jzl = dbClient.find(SupConst.Collections.JZ_JZLXXCJB, new SqlDbFilter().eq("f_aid", id),new RowDataListener(){
			public void processData(BasicMap<String, Object> rowData) {
				/**
				 * 处理禁止令信息采集表内的时间格式
				 */
				rowData.put("jzqxksrq",  DateUtil.format(rowData.get("jzqxksrq"),"yyyy-MM-dd"));
				rowData.put("jzqxjsrq",  DateUtil.format(rowData.get("jzqxjsrq"),"yyyy-MM-dd"));
			}
			
		});
		basicMap.put("jzl", jzl);
		if(basicMap!=null){//限定时间格式为：“yyyy-MM-dd”；
			//个人基本信息表
			basicMap.put("sqjzksrq",  DateUtil.format(basicMap.get("sqjzksrq"),"yyyy-MM-dd"));
			basicMap.put("sqjzjsrq",  DateUtil.format(basicMap.get("sqjzjsrq"),"yyyy-MM-dd"));
			
		}
		return basicMap;
	}
	
	/**
	 * 根据	
	 * 		个人基本信息表内的【XM】模糊查询
	 * 			个人信息表与进入特定区域信息采集表关联查询得到的结果	获取进入特定区域信息
	 * @param id
	 * @return
	 */
	public List<BasicMap<String, Object>> findName(String name, Paginate paginate){
		String sql = "select b.xm,b.sfzh,b.grlxdh,a.* from JZ_SQJZRYJRTDQYSPB a,JZ_JZRYJBXX b WHERE a.f_aid=b.id and xm like '%" +name+ "%'";
		SQLAdapter sqlAdapter = new SQLAdapter(sql);
		
		return dbClient.find(sqlAdapter, paginate,new RowDataListener() {
			public void processData(BasicMap<String, Object> rowData) {
				rowData.put("sqrq",  DateUtil.format(rowData.get("sqrq"),"yyyy-MM-dd"));
				rowData.put("sqjrrq",  DateUtil.format(rowData.get("sqjrrq"),"yyyy-MM-dd HH:mm"));
				rowData.put("sqjsrq",  DateUtil.format(rowData.get("sqjsrq"),"yyyy-MM-dd HH:mm"));
				rowData.put("sfsshsj",  DateUtil.format(rowData.get("sfsshsj"),"yyyy-MM-dd HH:mm"));
				rowData.put("xsfjspsj",  DateUtil.format(rowData.get("xsfjspsj"),"yyyy-MM-dd HH:mm"));
			}
		}).getRows();
	} 
	
	/**
	 * 全部进入特定区域（场所）信息
	 * @param id
	 * @return
	 */
	public List<BasicMap<String, Object>> findAll(BasicMap<String, Object> query, Paginate paginate){
		SqlDbFilter filter = toSqlFilter(query);
		String sql = "select b.xm,b.sfzh,b.grlxdh,a.*  from JZ_SQJZRYJRTDQYSPB a,JZ_JZRYJBXX b WHERE a.f_aid=b.id order by a.sqrq desc";
		SQLAdapter sqlAdapter = new SQLAdapter(sql);
		sqlAdapter.setFilter(filter);

		return dbClient.find(sqlAdapter, paginate,new RowDataListener() {
			public void processData(BasicMap<String, Object> rowData) {
				rowData.put("sqrq",  DateUtil.format(rowData.get("sqrq"),"yyyy-MM-dd"));
				rowData.put("sqjrrq",  DateUtil.format(rowData.get("sqjrrq"),"yyyy-MM-dd HH:mm"));
				rowData.put("sqjsrq",  DateUtil.format(rowData.get("sqjsrq"),"yyyy-MM-dd HH:mm"));
				rowData.put("sfsshsj",  DateUtil.format(rowData.get("sfsshsj"),"yyyy-MM-dd HH:mm"));
				rowData.put("xsfjspsj",  DateUtil.format(rowData.get("xsfjspsj"),"yyyy-MM-dd HH:mm"));
			}
		}).getRows();
	} 
	
}
