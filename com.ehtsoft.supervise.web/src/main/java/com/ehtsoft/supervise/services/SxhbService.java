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
import com.ehtsoft.fw.core.dto.ResultList;
import com.ehtsoft.fw.core.services.AbstractService;
import com.ehtsoft.fw.utils.DateUtil;
import com.ehtsoft.fw.utils.StringUtil;
import com.ehtsoft.im.services.UserinfoService;
import com.ehtsoft.supervise.api.SupConst;

/**
 * 思想汇报
 * @author sunhailong
 *
 */
@Service("SxhbService")
public class SxhbService extends AbstractService{
	
	@Resource(name = "sqlDbClient")
	private SqlDbClient dbClient;
	
	@Resource
	private UserinfoService userinfoService;
	
	/**
	 * 根据矫正人员的查询思想汇报的内容
	 * @param id
	 * @return
	 */
	public BasicMap<String, Object> findone(Integer id){
		String sql = "select j.id,j.xm,j.xb,j.sfzh,j.fzlx,j.bz,s.f_pf,s.f_hbnr from JZ_SXHB s left join JZ_JZRYJBXX j on j.id=s.f_aid";
		return dbClient.findOne(sql, id);
	}
	/**
	 * 根据矫正人员ID给矫正人员评分
	 * @param data
	 */
	public void update(Integer status,String aid){
		String sql = "update JZ_SXHB set F_PF=?  where F_AID=?";
		dbClient.updateSql(sql, status,aid);
	}
	/**
	 * 全部矫正人员个人基本信息
	 * @param id
	 * @return
	 */
	public ResultList<BasicMap<String, Object>> findAll(BasicMap<String, Object> query, Paginate paginate){
		ResultList<BasicMap<String, Object>> list = new ResultList<BasicMap<String, Object>>();
		SqlDbFilter filter = new SqlDbFilter();
		String sql = "select j.id,j.xm,j.xb,j.mz,j.sfzh,j.fzlx,s.f_pf,s.f_hbnr from JZ_SXHB s left join JZ_JZRYJBXX j on j.id=s.f_aid";
		filter.like("xm", StringUtil.toEmptyString(query.get("xm")));
		filter.like("sfzh", StringUtil.toEmptyString(query.get("sfzh")));
		SQLAdapter sqlAdapter = new SQLAdapter(sql);
		sqlAdapter.setFilter(filter);
		 list =  dbClient.find(sqlAdapter, paginate,new RowDataListener() {
			@Override
			public void processData(BasicMap<String, Object> rowData) {
				rowData.put("csrq", DateUtil.format(rowData.get("csrq"),"yyyy-MM-dd"));
				rowData.put("zxtzsrq",  DateUtil.format(rowData.get("zxtzsrq"),"yyyy-MM-dd"));
				rowData.put("jfzxrq",  DateUtil.format(rowData.get("jfzxrq"),"yyyy-MM-dd"));
				rowData.put("sqjzksrq",  DateUtil.format(rowData.get("sqjzksrq"),"yyyy-MM-dd"));
				rowData.put("sqjajsrq",  DateUtil.format(rowData.get("sqjajsrq"),"yyyy-MM-dd"));
				rowData.put("ypxqksrq",  DateUtil.format(rowData.get("ypxqksrq"),"yyyy-MM-dd"));
				rowData.put("ypxqjsrq",  DateUtil.format(rowData.get("ypxqjsrq"),"yyyy-MM-dd"));
				rowData.put("sqjzryjsrq",  DateUtil.format(rowData.get("sqjzryjsrq"),"yyyy-MM-dd"));
			}
		});
		 return list;
	} 
	
	/**
	 * 新增思想汇报(手机端)
	 * @param date
	 */
	public void insertThoughReport(BasicMap<String, Object> date){
		dbClient.insert(SupConst.Collections.JZ_SXHB, date);
	}
	
	/**
	 * 查询矫正人员自己填写的思想汇报
	 * @param query
	 * @param paginate
	 * @return
	 * [
	 * 	{
	 * 		F_ID:主键
	 * 		F_AID:矫正人员ID
	 * 		F_HBNR:汇报内容
	 * 		F_PF:评分
	 * 	}
	 * ]
	 */
	public ResultList<BasicMap<String, Object>> findSelfReport(BasicMap<String, Object> query,Paginate paginate){
		ResultList<BasicMap<String, Object>> resultList = new ResultList<>();
		String sqlstr = "select * from JZ_SXHB";
		SqlDbFilter sqlDbFilter = new SqlDbFilter();
		sqlDbFilter.desc("cts").eq("f_aid", StringUtil.toEmptyString(query.get("f_aid")));
		SQLAdapter sqlAdapter = new SQLAdapter(sqlstr);
		sqlAdapter.setFilter(sqlDbFilter);
		resultList = dbClient.find(sqlAdapter, paginate, new RowDataListener() {
			@Override
			public void processData(BasicMap<String, Object> rowData) {
				rowData.put("cts", DateUtil.format(rowData.get("cts"), "yyyy-MM-dd HH:mm:ss"));
			}
		});
		return resultList;
	}
}
