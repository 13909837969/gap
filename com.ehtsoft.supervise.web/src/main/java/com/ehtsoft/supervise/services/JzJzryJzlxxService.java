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
 * 刑罚执行所需信息
 * @创建人  ：dd
 * @创建时间：2017年11月24日 下午14:39:25
 * @修改人  ：dd
 * @修改时间：2017年11月24日 下午17:13:25
 * @修改备注：
 *
 * @version 1.0
 */
@Service("JzJzryJzlxxService")
public class JzJzryJzlxxService  extends AbstractService  {
	
	@Resource(name = "sqlDbClient")
	private SqlDbClient dbClient;
	
	
	@Resource(name="mongoClient")
	private MongoClient mongoClient;
	
	
	
	/**
	 * 矫正人员个人基本信息表
	 * 根据	
	 * 		个人基本信息表内的ID=禁止令信息采集表内的F_AID	获取禁止令信息
	 * @param id
	 * @return
	 */
	public BasicMap<String, Object> findOne(String id){
		String sqlstr = "select * from JZ_JZRYJBXX where id=?";//sql
		BasicMap<String, Object> basicMap = dbClient.findOne(sqlstr, id);//根据ID获取个人基本信息
		/**
		 * 根据	个人基本信息表内的ID=禁止令信息采集表内的F_AID	获取禁止令信息
		 */
		List<BasicMap<String,Object>> jzl = dbClient.find(SupConst.Collections.JZ_JZLXXCJB, new SqlDbFilter().eq("f_aid", id),new RowDataListener() {
			public void processData(BasicMap<String, Object> rowData) {
				/**
				 * 处理禁止令信息采集表内的时间格式
				 */
				rowData.put("jzqxksrq",  DateUtil.format(rowData.get("jzqxksrq"),"yyyy-MM-dd"));
				rowData.put("jzqxjsrq",  DateUtil.format(rowData.get("jzqxjsrq"),"yyyy-MM-dd"));
			}
		});
		basicMap.put("jzl", jzl);
		/**
		 * 根据	个人基本信息表内的ID=托管信息采集表内的F_AID	获取托管信息
		 */
		List<BasicMap<String,Object>> tgxx = dbClient.find(SupConst.Collections.JZ_TGXXCJB, new SqlDbFilter().eq("f_aid", id),new RowDataListener(){
			public void processData(BasicMap<String, Object> rowData) {
				/**
				 * 处理禁止令信息采集表内的时间格式
				 */
				rowData.put("fxtgsj",  DateUtil.format(rowData.get("fxtgsj"),"yyyy-MM-dd"));
				rowData.put("tqsjjyrq",  DateUtil.format(rowData.get("tqsjjyrq"),"yyyy-MM-dd"));
			}
		});
		basicMap.put("tgxx", tgxx);
		/**
		 * 根据	个人基本信息表内的ID=奖惩信息采集表内的F_AID	获取奖惩信息
		 */
		List<BasicMap<String,Object>> jcxx = dbClient.find(SupConst.Collections.JZ_SQJZRYJCXXCJB, 
				new SqlDbFilter().eq("f_aid", id),new RowDataListener() {
					public void processData(BasicMap<String, Object> rowData) {
						System.out.println(rowData.get("jcsj"));
						rowData.put("jcsj",  DateUtil.format(rowData.get("jcsj"),"yyyy-MM-dd HH:mm:ss"));
					}
				});
		basicMap.put("jcxx", jcxx);
		if(basicMap != null){//限定时间格式为：“yyyy-MM-dd”；
			//个人基本信息表
			basicMap.put("csrq",  DateUtil.format(basicMap.get("csrq"),"yyyy-MM-dd"));
			basicMap.put("zxtzsrq",  DateUtil.format(basicMap.get("zxtzsrq"),"yyyy-MM-dd"));
			basicMap.put("jfzxrq",  DateUtil.format(basicMap.get("jfzxrq"),"yyyy-MM-dd"));
			basicMap.put("sqjzksrq",  DateUtil.format(basicMap.get("sqjzksrq"),"yyyy-MM-dd"));
			basicMap.put("sqjajsrq",  DateUtil.format(basicMap.get("sqjajsrq"),"yyyy-MM-dd"));
			basicMap.put("ypxqksrq",  DateUtil.format(basicMap.get("ypxqksrq"),"yyyy-MM-dd"));
			basicMap.put("ypxqjsrq",  DateUtil.format(basicMap.get("ypxqjsrq"),"yyyy-MM-dd"));
			basicMap.put("sqjzryjsrq",  DateUtil.format(basicMap.get("sqjzryjsrq"),"yyyy-MM-dd"));
			basicMap.put("sqjzjsrq",  DateUtil.format(basicMap.get("sqjzjsrq"),"yyyy-MM-dd"));
		}
		return basicMap;
	}

	
}
