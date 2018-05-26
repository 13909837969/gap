package com.ehtsoft.supervise.services;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.ListIterator;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ehtsoft.common.services.SSOService;
import com.ehtsoft.fw.core.db.MongoClient;
import com.ehtsoft.fw.core.db.OperationListener;
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
 * 调查评估信息表
 *
 * @version 1.0
 */
@Service("JzDcpgxxService")
public class JzDcpgxxService extends AbstractService{

	@Resource(name = "sqlDbClient")
	private SqlDbClient dbClient;
	
	
	@Resource(name="mongoClient")
	private MongoClient mongoClient;
	
	@Resource(name="SSOService")
	private SSOService service;
	/**
	 * 调查评估信息
	 * @param id
	 * @return
	 */
	public BasicMap<String, Object> findOne(String id){
		String sqlstr = "select * from JZ_DCPGXX where id=?";
		BasicMap<String, Object> basicMap = dbClient.findOne(sqlstr, id);
		return basicMap;
	}
	
	/**
	 * 任何条件查询	调查评估信息
	 * @param 
	 * @return
	 */
	public List<BasicMap<String, Object>> findAll(BasicMap<String, Object> query, Paginate paginate){
		SqlDbFilter filter = toSqlFilter(query);
		String sql = "select * from JZ_DCPGXX";
		SQLAdapter sqlAdapter = new SQLAdapter(sql);
		sqlAdapter.setFilter(filter);
		filter.desc("dcsj");
		return dbClient.find(sqlAdapter, paginate,new RowDataListener() {
			@Override
			public void processData(BasicMap<String, Object> rowData) {
				rowData.put("bgrcsrq", DateUtil.format(rowData.get("bgrcsrq"),"yyyy-MM-dd"));
				rowData.put("ypxqksrq",  DateUtil.format(rowData.get("ypxqksrq"),"yyyy-MM-dd"));
				rowData.put("ypxqjsrq",  DateUtil.format(rowData.get("ypxqjsrq"),"yyyy-MM-dd"));
				rowData.put("pjrq",  DateUtil.format(rowData.get("pjrq"),"yyyy-MM-dd"));
				rowData.put("dcsj",  DateUtil.format(rowData.get("dcsj"),"yyyy-MM-dd HH:mm"));
				
			}
		}).getRows();
	} 
	/**
	 * 插入与修改考核内容
	 * @param dd
	 */
	public void save(BasicMap<String, Object> data){
		dbClient.save(SupConst.Collections.JZ_DCPGXX, data);
	}
	
	/**
	 * 查询矫正人员调查评估信息
	 * @param aid
	 * @return
	 * {
	 * 	WTDW:委托单位
	 * 	WTDCS:委托调查书
	 * 	BDCRXM:被调查人姓名
	 * 	YBGRGX:与被告人（罪犯）关系
	 * 	DCSX:调查事项
	 * 	DCSJ:调查时间
	 * 	DCDD:调查地点
	 * 	NSYJZLB:拟适用矫正类别
	 * 	DCDWSFS:调查单位（司法所）
	 * 	DCDWXQJ:调查单位（县区局）
	 * 	DCR:调查人
	 * 	DCYJSHR:调查意见审核人
	 * 	DCPGYJS:调查评估意见书
	 * }
	 */
	/*public BasicMap<String, Object> findInvestigationEvaluation(String aid){
		
		
		BasicMap<String,Object> rtn = new BasicMap<>();
		
			rtn = dbClient.findOne("select * from JZ_DCPGXX where ", aid);
			rtn.put("DCSJ", DateUtil.format(rtn.get("DCSJ"),"yyyy-MM-dd"));
		
		return rtn;
	}*/
	/**
	 * 司法局查询调查评估委托书信息
	 * [{
	 * 	"":"","":""
	 * },{},{}]JZ_WTSJLB
	 * @param query
	 * @param paginate
	 * @return
	 */
	public ResultList<BasicMap<String,Object>> findMore(BasicMap<String,Object> query,Paginate paginate){
		User user = service.getUser();
		ResultList<BasicMap<String,Object>> list=new ResultList<>();
		if(user!=null) {
			if(!query.get("ks_cdate").equals("")) {
		        query.put("a.cdate[gtEq]",NumberUtil.toInt(DateUtil.format(query.get("ks_cdate").toString(),"yyyyMMdd")));
		    }
		    if(!query.get("js_cdate").equals("")) {
		        query.put("a.cdate[ltEq]",NumberUtil.toInt(DateUtil.format(query.get("js_cdate").toString(),"yyyyMMdd")));
		    }
			SqlDbFilter filter = toSqlFilter(query);
			String sql = "SELECT a.*,c.jgmc from JZ_DCPGXX a left join JC_SFXZJGJBXX c on a.sfsid=c.id";
			SQLAdapter adapter = new SQLAdapter(sql);
			
			filter.in("a.orgid", user.getOrgidSet());
			filter.asc("a.bgrxm");
			
			adapter.setFilter(filter);
			list = dbClient.find(adapter, paginate,new RowDataListener() {
				
				@Override
				public void processData(BasicMap<String, Object> rowData) {
					rowData.put("ypxqksrq",DateUtil.format(rowData.get("ypxqksrq"), "yyyy-MM-dd"));
					rowData.put("ypxqjsrq", DateUtil.format(rowData.get("ypxqjsrq"), "yyyy-MM-dd"));
					rowData.put("pjrq", DateUtil.format(rowData.get("pjrq"), "yyyy-MM-dd"));
					rowData.put("dcsj", DateUtil.format(rowData.get("dcsj"), "yyyy-MM-dd"));
					rowData.put("bgrcsrq", DateUtil.format(rowData.get("bgrcsrq"), "yyyy-MM-dd"));
					
				}
			});
		}
		return list;
	}
	
	public ResultList<BasicMap<String,Object>> findPgwc(BasicMap<String,Object> query,Paginate paginate){
		User user = service.getUser();
		ResultList<BasicMap<String,Object>> list=new ResultList<>();
		if(user!=null) {
			SqlDbFilter filter = toSqlFilter(query);
			String sql = "SELECT a.*,b.jgmc  from jz_dcpgxx a left join jc_sfxzjgjbxx b on a.sfsid=b.id";
					
			List<String> set = new ArrayList<String>();
			set.add("04");
			set.add("06");
			filter.in("a.dcpgzt", set);
			
			filter.in("a.orgid", user.getOrgidSet());
			filter.desc("a.bgrxm");
			SQLAdapter adapter = new SQLAdapter(sql);
			adapter.setFilter(filter);
			list = dbClient.find(adapter, paginate,new RowDataListener() {
				
				@Override
				public void processData(BasicMap<String, Object> rowData) {
					rowData.put("ypxqksrq", DateUtil.format(rowData.get("ypxqksrq"), "yyyy-MM-dd"));
					rowData.put("ypxqjsrq", DateUtil.format(rowData.get("ypxqjsrq"), "yyyy-MM-dd"));
					rowData.put("pjrq", DateUtil.format(rowData.get("pjrq"), "yyyy-MM-dd"));
					rowData.put("dcsj", DateUtil.format(rowData.get("dcsj"), "yyyy-MM-dd"));
					rowData.put("bgrcsrq", DateUtil.format(rowData.get("bgrcsrq"), "yyyy-MM-dd"));
				}
				
			});
			
		}
		return list;
	}
	/**
	 * 查询被委托机构信息
	 * [{
	 * 	"":"","":""
	 * },{},{}]
	 * @param query
	 * @param paginate
	 * @return
	 */
	public List<BasicMap<String,Object>> findOrgid(BasicMap<String,Object> query){
		User user = service.getUser();
		List<BasicMap<String,Object>> list=new ArrayList<>();
		if(user!=null) {
			SqlDbFilter filter = toSqlFilter(query);
			
			String sql = "  SELECT" + 
					"   b.id," + 
					"	b.jgmc," + 
				    "   b.fzr, " +
					"	b.parentid," + 
					"	b.regionid," + 
					"	b.lxdh," + 
					"   c.region_name" + 
					"   FROM" + 
					"   jc_sfxzjgjbxx b" + 
					"   LEFT JOIN sys_region c ON b.regionid=c.regionid";
			SQLAdapter adapter = new SQLAdapter(sql);
			filter.eq("b.parentid", user.getOrgid());
			filter.like("b.jgmc", "司法所");
			adapter.setFilter(filter);
			list = dbClient.find(adapter);
		}
		return list;
	}
	/**
	 * 保存调查评估委托书记录表信息
	 * @param data
	 */
	public void saveOne(BasicMap<String,Object> data){
			dbClient.save(SupConst.Collections.JZ_DCPGXX,data);
		
		/*BasicMap<String,Object> map = new BasicMap<>();
		if(data.get("fname")!=null) {
			dbClient.save(SupConst.Collections.JZ_WTSJLB_FJ, data);
			map.put("wtsjlbid", data.get("id"));
			dbClient.update(SupConst.Collections.JZ_WTSJLB_FJ, map);
		}
		System.out.println("JZ_WTSJLB.ID:"+data.get("id"));
		map.put("id", data.get("wtsjlbid"));*/
	}
	
	/**
	 * 保存调查评估委托书记录表信息
	 * @param data
	 */
	public void saveZp(BasicMap<String,Object> data){
		if(Util.isNotEmpty(data.get("sfsid"))) {
			data.put("dcpgzt", "02");
			data.put("wtrq", DateUtil.format(new Date(), "yyyy-MM-dd"));
			dbClient.save(SupConst.Collections.JZ_DCPGXX,data);
		}
		/*BasicMap<String,Object> map = new BasicMap<>();
		if(data.get("fname")!=null) {
			dbClient.save(SupConst.Collections.JZ_WTSJLB_FJ, data);
			map.put("wtsjlbid", data.get("id"));
			dbClient.update(SupConst.Collections.JZ_WTSJLB_FJ, map);
		}
		System.out.println("JZ_WTSJLB.ID:"+data.get("id"));
		map.put("id", data.get("wtsjlbid"));*/
	}
	
	
	
	
	/**
	 * 保存委托书附件
	 * @param data
	 */
	public void saveWtsFj(BasicMap<String,Object> data){
		
		dbClient.save(SupConst.Collections.JZ_WTSJLB_FJ, data);
	}
	/**
	 * 保存调查评估工作分配信息
	 * @param data
	 */
	public void saveJg(BasicMap<String,Object> data){
		data.put("wtid",data.get("id"));
		dbClient.save(SupConst.Collections.JZ_DCPGGZFP, data);
		BasicMap<String,Object> map = new BasicMap<>();
		map.put("dcpgzt", data.get("dcpgzt"));
		map.put("wtrq", data.get("fpsj"));
		map.put("id", data.get("id"));
		dbClient.update(SupConst.Collections.JZ_DCPGXX, map);
	}
	
	
	
	/**
	 * 司法所查询调查评估委托书信息
	 * [{
	 * 	"":"","":""
	 * },{},{}]JZ_WTSJLB
	 * @param query
	 * @param paginate
	 * @return
	 */
	public ResultList<BasicMap<String,Object>> findMoreSfs(BasicMap<String,Object> query,Paginate paginate){
		User user = service.getUser();
		ResultList<BasicMap<String,Object>> list = new ResultList<>();
		if(user != null){
			SqlDbFilter filter = toSqlFilter(query);
			String sql = "select a.*,b.jgmc from JZ_DCPGXX a left join jc_sfxzjgjbxx b on a.sfsid=b.id";
			
			SQLAdapter adapter = new SQLAdapter(sql);
			filter.eq("a.sfsid", user.getOrgid());
			List<String> set = new ArrayList<String>();
			set.add("02");
			set.add("05");
			filter.in("a.dcpgzt", set);
			
			filter.desc("a.bgrxm");
			adapter.setFilter(filter);
			list = dbClient.find(adapter, paginate,new RowDataListener() {
				
				@Override
				public void processData(BasicMap<String, Object> rowData) {
					rowData.put("ypxqksrq", DateUtil.format(rowData.get("ypxqksrq"), "yyyy-MM-dd"));
					rowData.put("ypxqjsrq", DateUtil.format(rowData.get("ypxqjsrq"), "yyyy-MM-dd"));
					rowData.put("pjrq", DateUtil.format(rowData.get("pjrq"), "yyyy-MM-dd"));
					rowData.put("dcsj", DateUtil.format(rowData.get("dcsj"), "yyyy-MM-dd"));
					rowData.put("bgrcsrq", DateUtil.format(rowData.get("bgrcsrq"), "yyyy-MM-dd"));
					
				}
			});
		}
		return list;
	}
	public BasicMap<String,Object> findSfj(String id){
		
		BasicMap<String,Object> map = new BasicMap<>();
		
			SqlDbFilter filter = new SqlDbFilter();
			String sql = "SELECT jgmc FROM jc_sfxzjgjbxx b WHERE id=(SELECT "+ 
					"	parentid  "+ 
					"FROM "+ 
				 
					" jc_sfxzjgjbxx where id='"+id+"')";
					
			
			SQLAdapter adapter = new SQLAdapter(sql);
			
			
			adapter.setFilter(filter);
			map = dbClient.findOne(adapter);
		
		return map;
	}
	
	
	/**
	 * 保存司法所调查评估记录
	 * @param data
	 */
	public void saveTcpgxx(BasicMap<String,Object> data){
		
		data.put("dcpgzt","04");
		
		dbClient.update(SupConst.Collections.JZ_DCPGXX, data);
	}
	
	/**
	 * 根据id查询司法所对被调查人的调查记录
	 * @param id
	 * @return
	 */
	public BasicMap<String,Object> findOneDcjl(String id){
		
		BasicMap<String,Object> map = new BasicMap<>();
		String sql = "select * from JZ_DCPGXX where id='"+id+"'";
		SQLAdapter adapter = new SQLAdapter(sql);
		map = dbClient.findOne(adapter);
		map.put("dcsj",DateUtil.format(map.get("dcsj"), "yyyy-MM-dd"));
		
		return map;
	}
	/**
	 * 保存司法局评估意见
	 * @param data
	 */
	public void saveDcwc(BasicMap<String,Object> data){
		
		data.put("dcpgzt","06");
		
		dbClient.update(SupConst.Collections.JZ_DCPGXX, data);
	}
	/**
	 * 撤回指派
	 * @author yanyubo
	 */
	public void removeZp(BasicMap<String,Object> data){
		BasicMap<String,Object> map = new BasicMap<>();
		map.put("id",data.get("id"));
		map.put("dcpgzt", "01");
		map.put("wtrq", "");
		map.put("sfsid", "");
		dbClient.update(SupConst.Collections.JZ_DCPGXX,map);
		
	}
	
	/**
	 * 接收指派
	 * @author yanyubo
	 */
	public void applyOne(BasicMap<String,Object> data){
		BasicMap<String,Object> map = new BasicMap<>();
		map.put("id",data.get("id"));
		map.put("dcpgzt", "05");
		dbClient.update(SupConst.Collections.JZ_DCPGXX,map);
		
	}	
	/**
	 * 退回指派
	 * @author yanyubo
	 */
	public void deleteOne(BasicMap<String,Object> data){
		BasicMap<String,Object> map = new BasicMap<>();
		map.put("id",data.get("id"));
		map.put("dcpgzt", "03");
		map.put("wtrq", "");
		map.put("sfsid", "");
		dbClient.update(SupConst.Collections.JZ_DCPGXX,map);
		
	}	
		
	
	
	
}
