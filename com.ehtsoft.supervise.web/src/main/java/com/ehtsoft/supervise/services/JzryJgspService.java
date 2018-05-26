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
 * 用于警告信息
 * 
 * @author   :dd
 * @创建时间 :2017年11月28日 下午1:12:10
 * @修改人	 :
 * @创建时间 :2017年11月28日
 */
@Service("JzryJgspService")
public class JzryJgspService  extends AbstractService  {
	
	@Resource(name = "sqlDbClient")
	private SqlDbClient dbClient;
	
	
	@Resource(name="mongoClient")
	private MongoClient mongoClient;
	
	/**
	 * 矫正人员个人基本信息表 + 警告信息
	 * 根据	
	 * 		个人基本信息表内的ID=警告信息采集表内的F_AID	获取警告信息
	 * @param id
	 * @return
	 */
	public BasicMap<String, Object> findOne(String id){
		String sqlstr = "select * from JZ_JZRYJBXX where id=?";
		BasicMap<String, Object> basicMap = dbClient.findOne(sqlstr, id);//根据ID获取个人基本信息
		/**
		 * 根据	个人基本信息表内的ID=外出申请信息采集表内的F_AID	获取警告信息
		 */
		List<BasicMap<String,Object>> jg = dbClient.find(SupConst.Collections.JZ_JGXXCJB, new SqlDbFilter().eq("f_aid", id),new RowDataListener(){
			public void processData(BasicMap<String, Object> rowData) {
				/**
				 * 处理表内相关字段的时间格式
				 */
				rowData.put("sfsspsj",  DateUtil.format(rowData.get("sfsspsj"),"yyyy年MM月dd日 HH:mm:ss"));
				rowData.put("xsfjspsj",  DateUtil.format(rowData.get("xsfjspsj"),"yyyy-MM-dd HH:mm:ss"));
			}
		});
		basicMap.put("jg", jg);
		
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
	
	
}
