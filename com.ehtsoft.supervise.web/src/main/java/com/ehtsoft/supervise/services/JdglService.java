package com.ehtsoft.supervise.services;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.alibaba.druid.filter.Filter;
import com.ehtsoft.common.services.SSOService;
import com.ehtsoft.fw.core.db.RowDataListener;
import com.ehtsoft.fw.core.db.SQLAdapter;
import com.ehtsoft.fw.core.db.SqlDbClient;
import com.ehtsoft.fw.core.db.SqlDbFilter;
import com.ehtsoft.fw.core.dto.BasicMap;
import com.ehtsoft.fw.core.dto.Paginate;
import com.ehtsoft.fw.core.dto.ResultList;
import com.ehtsoft.fw.core.services.AbstractService;
import com.ehtsoft.fw.core.sso.User;
import com.ehtsoft.fw.utils.DateUtil;
import com.ehtsoft.fw.utils.NumberUtil;
import com.ehtsoft.fw.utils.StringUtil;
import com.ehtsoft.fw.utils.Util;
import com.ehtsoft.supervise.api.SupConst;


/**
 * 走访检查管理
 * @author DENNYPC
 *
 */
@Service("JdglService")
public class JdglService extends AbstractService{

	@Resource(name="sqlDbClient")
	SqlDbClient dbClient;
	
	@Resource(name="SSOService")
	private SSOService service;
	
	/**
	 * 查询定期情况报告
	 * @param query
	 * @param paginate
	 * @return
	 * [
	 * 	{
	 * 		f_aid:人员id
	 * 		f_hbnr:汇报内容
	 * 		f_pf:评分
	 * 		cts:创建时间
	 * 		xm:姓名
	 * 	}
	 * ]
	 */
	public ResultList<BasicMap<String,Object>> findPeriodicReport(BasicMap<String, Object> query,Paginate paginate){
		ResultList<BasicMap<String, Object>> list = new ResultList<>();
		User user = service.getUser();
		if(user!=null){
			String sqlstr = "select a.f_id,a.f_aid,a.f_hbnr,a.f_pf,a.cts,a.bgsj,a.bgfs,b.xm from jz_sxhb a left join jz_jzryjbxx b on a.f_aid = b.id";
			SqlDbFilter sql =toSqlFilter(query);
			sql.in("b.orgid", user.getOrgidSet());
			if("1".equals(StringUtil.toEmptyString(query.get("range")))){
				sql.unEq("f_pf", "0");
			}else if("2".equals(StringUtil.toEmptyString(query.get("range")))){
				sql.eq("f_pf", "0");
			}
			SQLAdapter sqlAdapter = new SQLAdapter(sqlstr);
			sqlAdapter.setFilter(sql);
			sqlAdapter.getFilter().desc("a.cts");
			list = dbClient.find(sqlAdapter, paginate,new RowDataListener() {
				@Override
				public void processData(BasicMap<String, Object> rowData) {
					rowData.put("cts", DateUtil.format( rowData.get("cts"), "yyyy-MM-dd"));
				}
			});
		}
		return list;
	}
	/**
	 * 查询一条记录
	 * @param id
	 * @return
	 */
	public BasicMap<String,Object> findOne(String id){
		BasicMap<String,Object> data=new BasicMap<>();
		String sql="select a.f_id,a.f_aid,a.f_hbnr,a.f_pf,a.cts,b.xm from jz_sxhb a left join jz_jzryjbxx b on a.f_aid = b.id";
		SQLAdapter adapter=new SQLAdapter(sql);
		adapter.getFilter().eq("a.f_id", id);
		data=dbClient.findOne(adapter);
		return data;
	}
	/**
	 * 矫正人员思想汇报评分
	 * @param aid
	 * @param status
	 */
	public void updateStatus(Integer status,String id){
		BasicMap<String,Object> data = new BasicMap<>();
		data.put("f_id", id);
		data.put("f_pf", status);
		dbClient.update(SupConst.Collections.JZ_SXHB, data);
	}
	/**
	 * 查询走访检查情况
	 * @param query
	 * @param paginate
	 * @return
	 * [
	 * 	{
	 * 		f_aid:人员ID
	 * 		f_dz:地址
	 * 		f_thr:谈话人
	 * 		f_jlr:记录人
	 * 		f_blnr:笔录内容
	 * 		del:删除标记 
	 * 		cts:创建时间
	 * 		xm:姓名
	 * 		xb:性别
	 * 		nl:年龄
	 * 		grlxdh:个人联系电话
	 * 		grzjdmx:个人居住地明细
	 * 		whcd：文化程度
	 * 	}
	 * ]
	 */
	public ResultList<BasicMap<String,Object>> findVisitCheck(BasicMap<String, Object> data,Paginate paginate){
		User user = service.getUser();
		ResultList<BasicMap<String, Object>> list = new ResultList<>();
		if(user!=null){
			String sqlstr = "SELECT " + 
					" A .f_id, A .f_aid, A .f_dz, A .f_thr, A .f_jlr, A .f_blnr, A .del, A .cts, A .orgid, d.gdjzdmx, b.xm, " + 
					" b.xb, b.csrq, b.grlxdh, b.whcd " + 
					" FROM jz_zfjcqk A " + 
					"LEFT JOIN jz_jzryjbxx b ON A .f_aid = b. ID " + 
					"LEFT JOIN JZ_JZRYJBXX_DZ d ON b. ID = d. ID ";
			SqlDbFilter filter = new SqlDbFilter();
			filter.like("b.xm",StringUtil.toString(data.get("xm"))).eq("a.orgid", user.getOrgid()).desc("A .cts");
			SQLAdapter sqlAdapter = new SQLAdapter(sqlstr);
		    sqlAdapter.setFilter(filter);
		    list = dbClient.find(sqlAdapter, paginate, new RowDataListener() {
				@Override
				public void processData(BasicMap<String, Object> rowData) {
					rowData.put("cts", DateUtil.format(rowData.get("cts"),"yyyy-MM-dd"));
					rowData.put("csrq", DateUtil.getAge(StringUtil.toEmptyString(rowData.get("csrq"))));
				}
			});
		}
		return list;
	}
	/**
	 * 新增走访检查情况
	 * @param data
	 */
	public void saveVisitCheck(BasicMap<String, Object> data){
		dbClient.save(SupConst.Collections.JZ_ZFJCQK, data);
	}
	/**
	 * 修改走访情况
	 * @param query
	 */
	public void updateVisitCheck(BasicMap<String, Object> query){
		dbClient.updateSql("update jz_zfjcqk set f_thr = ? ,f_jlr = ?,f_aid = ?,f_blnr = ? where f_aid = ?", query.get("f_thr"),query.get("f_jlr"),query.get("f_aid"),query.get("f_blnr"),query.get("f_aid"));
	}
	/**
	 * 删除走访情况(不做物理删除)
	 * @param query
	 */
	public void deleteVisitCheck(BasicMap<String, Object> query){
		dbClient.updateSql("update jz_zfjcqk set del = ? where f_aid = ?", query.get("del"),query.get("f_aid"));
	}
	
	/**
	 * 删除走访信息
	 * @param id
	 */
	public void delete(String id) {
		dbClient.remove(SupConst.Collections.JZ_ZFJCQK, new SqlDbFilter().eq("F_AID", id));	
		
	}

	/**
	 * 新增日常报告
	 * @param query
	 */
	public void saveOne(BasicMap<String, Object> query) {
		dbClient.save(SupConst.Collections.JZ_SXHB, query);
	}
}
