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
 * 用于司法奖惩页面
 * 
 * @author   :dd
 * @创建时间 :2017年11月28日 下午2:57:15
 * @修改人	 :
 * @创建时间 :2017年11月28日
 */
@Service("JzrySfjcService")
public class JzrySfjcService  extends AbstractService  {
	
	@Resource(name = "sqlDbClient")
	private SqlDbClient dbClient;
	
	
	@Resource(name="mongoClient")
	private MongoClient mongoClient;
	
	/**
	 * 矫正人员个人基本信息表 + 奖惩信息
	 * 根据	
	 * 		奖惩信息采集表内的F_AID=个人基本信息表内的ID	获取个人信息
	 * @param id
	 * @return
	 */
	public BasicMap<String, Object> findOne(String id){
		String sqlstr = "select b.xm,b.id,b.sqjzrybh,b.xb,b.mz,b.sfzh,b.grlxdh,b.jtzm,b.jzlb,a.*  from JZ_SQJZRYJCXXCJB a left join JZ_JZRYJBXX b on a.f_aid=b.id where a.jcid=?";//sql
		BasicMap<String, Object> basicMap = dbClient.findOne(sqlstr, id);//根据ID获取个人基本信息
		if(basicMap!=null){//限定时间格式为：“yyyy-MM-dd”；
			basicMap.put("jcsj",  DateUtil.format(basicMap.get("jcsj"),"yyyy-MM-dd HH:mm:ss"));
		}
		return basicMap;
	}
	
	/**
	 * 全部奖惩信息
	 * 		关联查询个人基本信息表，或许人员姓名等基本信息
	 * @param id
	 * @return
	 */
	public ResultList<BasicMap<String, Object>> findAll(BasicMap<String, Object> query, Paginate paginate){
		SqlDbFilter filter = toSqlFilter(query);
		String sql = "select b.xm,b.xb,b.mz,b.sfzh,b.grlxdh,b.jtzm,b.jzlb,a.*  from JZ_SQJZRYJCXXCJB a left join JZ_JZRYJBXX b on a.f_aid=b.id order by a.jcsj desc";
		SQLAdapter sqlAdapter = new SQLAdapter(sql);
		sqlAdapter.setFilter(filter);

		  ResultList<BasicMap<String,Object>>  list = dbClient.find(sqlAdapter, paginate,new RowDataListener() {
			public void processData(BasicMap<String, Object> rowData) {
				
				rowData.put("jcsj",  DateUtil.format(rowData.get("jcsj"),"yyyy-MM-dd HH:mm:ss"));
				rowData.put("sqsj",  DateUtil.format(rowData.get("sqsj"),"yyyy-MM-dd HH:mm:ss"));
				rowData.put("ksqr",  DateUtil.format(rowData.get("ksqr"),"yyyy-MM-dd"));
				rowData.put("sfsshsj",  DateUtil.format(rowData.get("sfsshsj"),"yyyy-MM-dd HH:mm:ss"));
				rowData.put("xsfjspsj",  DateUtil.format(rowData.get("xsfjspsj"),"yyyy-MM-dd HH:mm:ss"));
			}
		});
		
		return list;
	} 
	
	
	
	/**
	 * 全部个人基本信息
	 * @param id
	 * @return
	 */
	public List<BasicMap<String, Object>> findA(BasicMap<String, Object> query, Paginate paginate){
		SqlDbFilter filter = toSqlFilter(query);
		String sql = "select * from JZ_JZRYJBXX ";
		SQLAdapter sqlAdapter = new SQLAdapter(sql);
		sqlAdapter.setFilter(filter);

		return dbClient.find(sqlAdapter, paginate).getRows();
	} 
	
	/**
	 * 插入与修改考核内容
	 * @param dd
	 */
	public void save(BasicMap<String, Object> data){
		dbClient.save(SupConst.Collections.JZ_SQJZRYJCXXCJB, data);
	}

}
