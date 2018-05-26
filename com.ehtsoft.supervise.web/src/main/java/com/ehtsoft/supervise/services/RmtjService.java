package com.ehtsoft.supervise.services;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;

import org.apache.velocity.tools.generic.ClassTool.Sub;
import org.springframework.stereotype.Service;

import com.ehtsoft.common.services.SSOService;
import com.ehtsoft.fw.core.db.InsertOperation;
import com.ehtsoft.fw.core.db.RowDataListener;
import com.ehtsoft.fw.core.db.SQLAdapter;
import com.ehtsoft.fw.core.db.SqlDbClient;
import com.ehtsoft.fw.core.db.SqlDbFilter;
import com.ehtsoft.fw.core.dto.BasicMap;
import com.ehtsoft.fw.core.dto.Paginate;
import com.ehtsoft.fw.core.services.AbstractService;
import com.ehtsoft.fw.core.sso.User;
import com.ehtsoft.fw.utils.DateUtil;
import com.ehtsoft.fw.utils.StringUtil;
import com.ehtsoft.fw.utils.Util;
import com.ehtsoft.supervise.api.SupConst;
import com.ibm.icu.impl.StringRange;

@Service("RmtjService")
public class RmtjService extends AbstractService{

	@Resource(name="sqlDbClient")
	SqlDbClient dbClient;
	
	@Resource
	private SSOService ssoService;
	/**
	 * 新增/修改调解案件
	 * 截取split
	 * @param data
	 * @param sqrlist 申请人以及被申请人
	 */
	public void saveTjaj(BasicMap<String, Object> data,List<BasicMap<String,Object>> sqrlist){
		data.put("TJLX", "1");
		
		//保存 调解案件信息集  TJLX = 1 为口头调节
		dbClient.save(SupConst.Collections.RMTJ_TJAJXX, data);
		
		
		String tjajxxid = StringUtil.toString(data.get("ID"));
		
		dbClient.remove(SupConst.Collections.RMTJ_TJAJSQR, new SqlDbFilter().eq("TJAJXXID", tjajxxid));
		
		dbClient.insert(SupConst.Collections.RMTJ_TJAJSQR,sqrlist,new InsertOperation() {
			@Override
			public void insertBefore(BasicMap<String, Object> data) {
				data.put("TJAJXXID", tjajxxid);
			}
			@Override
			public void insertAfter(BasicMap<String, Object> data) {
			}
		});
	}
	/**
	 * 删除调解案件
	 * @param id
	 */
	public void deleteTjaj(String id){
		dbClient.remove(SupConst.Collections.RMTJ_TJAJXX, new SqlDbFilter().eq("ID", id));
	}
	/**
	 * 查询详细调解案件
	 * @param id
	 * @return
	 */
	public BasicMap<String, Object> findOneTjaj(String id){
		BasicMap<String, Object> rtn = new BasicMap<>();
		rtn = dbClient.findOne(SupConst.Collections.RMTJ_TJAJXX, new SqlDbFilter().eq("ID", id));
		return rtn;
	}
	/**
	 * 查询调解案件列表信息
	 * @param query
	 * @param paginate
	 * @return
	 */
	public List<BasicMap<String,Object>> findTjaj(BasicMap<String, Object> query,Paginate paginate){
		List<BasicMap<String, Object>> list = new ArrayList<>();
		User user = ssoService.getUser();
		String sqlstr = "select a.*,b.dsr1,b.dsr2,b.dsr3,c.TWHMC from RMTJ_TJAJXX a left join RMTJ_JJBJ b on a.id = b.id "
				+ "LEFT JOIN RMTJ_JWHJBXX c ON a.TWHBM = c.TWHBM ";
		SqlDbFilter sqlDbFilter = new SqlDbFilter();
		SQLAdapter sqlAdapter = new SQLAdapter(sqlstr);
		sqlDbFilter.eq("a.jflb", StringUtil.toEmptyString(query.get("jflb")))
		.eq("c.TWHBM", StringUtil.toString(query.get("twhbm")))
		.between("a.tjrq",  query.get("dateFrom"),  query.get("dateTo"))
		.in("a.orgid", user.getOrgidSet())
		.eq("a.tjlx", "1");
		sqlDbFilter.desc("a.cts");
		sqlAdapter.setFilter(sqlDbFilter);
		final Set<String> tjyids = new HashSet<>();
		final Set<String> cyryids =  new HashSet<>();
		list = dbClient.find(sqlAdapter, paginate, new RowDataListener() {
			@Override
			public void processData(BasicMap<String, Object> rowData) {
//				rowData.put("tjrq", DateUtil.format(rowData.get("tjrq"), "yyyy-MM-dd"));
//				rowData.put("cts", DateUtil.format(rowData.get("cts"), "yyyy-MM-dd"));
				if(Util.isNotEmpty(rowData.get("tjybm"))) {
					String tiybm_list =  StringUtil.toEmptyString(rowData.get("tjybm"));
					
					String[] tjy = tiybm_list.split(",");
					for (String tjyid : tjy) {
						tjyids.add(tjyid);
					}
					if(Util.isNotEmpty(rowData.get("id"))){
						cyryids.add(StringUtil.toEmptyString(rowData.get("id")));
					}
				}
				
			}
		}).getRows();
		

		//调解员信息（ID，姓名）
		final Map<String,String> tjyxms = new HashMap<>();
		/// a.TJYBM
		if(!tjyids.isEmpty()){
			String sql_name = "select XM,ID from VIEW_RMTJ_TJYJBXX";
			SQLAdapter sqlTjy = new SQLAdapter(sql_name);
			sqlTjy.getFilter().in("ID", tjyids);
		    //获取调解员姓名
			dbClient.find(sqlTjy,new RowDataListener() {
				@Override
				public void processData(BasicMap<String, Object> rowData) {
					tjyxms.put(StringUtil.toString(rowData.get("ID")), StringUtil.toEmptyString(rowData.get("XM")));
				}
			});
		}
		
		//获取涉案人员信息（参与人员或当事人信息）
		String sql = "select tjajxxid,xm from RMTJ_TJAJSQR";
		SQLAdapter adapter = new SQLAdapter(sql);
		adapter.getFilter().eq("lx","1").in("tjajxxid", cyryids);
		//获取涉案人员信息（参与人员或当事人信息）姓名信息
		final Map<String,StringBuffer> saryxms = new HashMap<>();
		dbClient.find(adapter,new RowDataListener() {
			@Override
			public void processData(BasicMap<String, Object> rowData) {
				String tjajxxid = StringUtil.toEmptyString(rowData.get("tjajxxid"));
				if(saryxms.get(tjajxxid)==null){
					StringBuffer sb = new StringBuffer();
					sb.append(StringUtil.toEmptyString(rowData.get("xm")));
					saryxms.put(tjajxxid, sb);	
				}else{
					saryxms.get(tjajxxid).append(","+StringUtil.toEmptyString(rowData.get("xm")));
				}
			}
		});	
		//遍历调解数据
		for(BasicMap<String, Object> bm:list){
			if(Util.isNotEmpty(bm.get("tjybm"))) {
				String tiybm_list =  StringUtil.toEmptyString(bm.get("tjybm"));
				String[] tjys = tiybm_list.split(",");
				StringBuffer sBuffer=new StringBuffer();
				for (String tjyid : tjys) {
					if(Util.isNotEmpty(tjyxms.get(tjyid))){
						sBuffer.append(tjyxms.get(tjyid));
						sBuffer.append(",");
					}
				}
				if(sBuffer.length()>0){
					sBuffer.deleteCharAt(sBuffer.length()-1);
				}
				bm.put("TJRXM", sBuffer.toString());
				String xm = StringUtil.toEmptyString(saryxms.get(StringUtil.toString(bm.get("ID"))));
				bm.put("xm", xm);
			}
		}
		return list;
	}
	
	/**
	 * 
	 * 查询当前的司法所下的 调解委会
	 * @param orgid
	 * @return<br>
	 * 返回值格式:   List<BasicMap<String, Object>>
	 *
	 * @author Administrator
	 * @date   2018年4月6日
	 * 方法的作用：TODO
	 */
	public List<BasicMap<String, Object>> findTwh(String orgid) {
		String sql = "SELECT id,twhmc,twhbm,fzr FROM VIEW_RMTJ_JWHJBXX  WHERE del = '0' and orgid = '"+ orgid +"' ";
		SQLAdapter adapter = new SQLAdapter(sql);
	  return	dbClient.find(adapter);
		
	}
	
	/**
	 * 
	 * 获取调委会工作人员
	 * @param orgid
	 * @return<br>
	 * 返回值格式: List<BasicMap<String, Object>>
	 *
	 * @author Administrator
	 * @date   2018年4月6日
	 * 方法的作用：TODO
	 */
	public List<BasicMap<String, Object>> findTwhRy(String id){
		List<BasicMap<String, Object>> list = new ArrayList<>();
		String sqlstr = "SELECT id,xm,twhzw,TWHBM,TWHID,TJYBM FROM VIEW_RMTJ_TJYJBXX ";
		SQLAdapter sqlAdapter = new SQLAdapter(sqlstr);
		sqlAdapter.getFilter().eq("twhid", id);
		list = dbClient.find(sqlAdapter);
		return list;
	}
	
	
	
	
	/**
	 * 查询当前司法所工作人员(调解员)
	 * @param orgid
	 * @return
	 * 
	 */
	public List<BasicMap<String, Object>> findMediator(String orgid){
		List<BasicMap<String, Object>> list = new ArrayList<>();
		String sqlstr = "select * from JC_SFXZJGGZRYJBXX";
		SQLAdapter sqlAdapter = new SQLAdapter(sqlstr);
		sqlAdapter.getFilter().eq("orgid", orgid);
		list = dbClient.find(sqlAdapter);
		return list;
	}
	
	/**
	 * 新增调解笔记照片
	 * @param data
	 */
	public void saveTjbi(BasicMap<String, Object> data){
		dbClient.save(SupConst.Collections.RMTJ_JJBJ, data);
	}
	/**
	 * 查询调解笔记对应照片id
	 * @param id
	 * @return
	 */
	public List<BasicMap<String, Object>> findImgIds(String id){
		List<BasicMap<String, Object>> list = new ArrayList<>();
		String strsql = "select imgid from RMTJ_JJBJ_MEDIA";
		SqlDbFilter sqlDbFilter = new SqlDbFilter();
		sqlDbFilter.eq("jjbjid", id);
		SQLAdapter sqlAdapter = new SQLAdapter(strsql);
		sqlAdapter.setFilter(sqlDbFilter);
		list = dbClient.find(sqlAdapter);
		return list;
	}
	
	/**
	 * 查询当前调解信息的调解笔录
	 * @param id
	 * @return
	 */
	public BasicMap<String, Object> findTjbi(String id){
		BasicMap<String, Object> rtn = new BasicMap<>();
		String sqlstr = "select * from RMTJ_JJBJ";
		SqlDbFilter sqlDbFilter = new SqlDbFilter();
		sqlDbFilter.eq("id", id);
		SQLAdapter sqlAdapter = new SQLAdapter(sqlstr);
		sqlAdapter.setFilter(sqlDbFilter);
		rtn = dbClient.findOne(sqlAdapter);
		return rtn;
	}
	
	/**
	 * 查询申请人和被申请人
	 * @param id
	 * @return
	 */
	public BasicMap<String, List<BasicMap<String, Object>>> findSqr(String id){
		BasicMap<String, List<BasicMap<String, Object>>> rtn = new BasicMap<>();
		rtn.put("sqr", dbClient.find(SupConst.Collections.RMTJ_TJAJSQR, new SqlDbFilter().eq("lx", "1").eq("tjajxxid", id)));
		rtn.put("bsqr", dbClient.find(SupConst.Collections.RMTJ_TJAJSQR, new SqlDbFilter().eq("lx", "2").eq("tjajxxid", id)));
		return rtn;
	}
}
