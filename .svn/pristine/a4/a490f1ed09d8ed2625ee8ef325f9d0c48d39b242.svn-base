package com.ehtsoft.supervise.services;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ehtsoft.common.services.SFCodeService;
import com.ehtsoft.common.services.SSOService;
import com.ehtsoft.fw.core.db.InsertOperation;
import com.ehtsoft.fw.core.db.RowDataListener;
import com.ehtsoft.fw.core.db.SQLAdapter;
import com.ehtsoft.fw.core.db.SaveOperation;
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
import com.ehtsoft.im.api.ImConst;
import com.ehtsoft.supervise.api.SupConst;
import com.ehtsoft.supervise.utils.ParameterUtil;
@Service("DjjsService")
public class DjjsService extends AbstractService{
	
	@Resource(name = "sqlDbClient")
	private SqlDbClient dbClient;
	
	@Resource(name="SSOService")
	private SSOService service;
	
	@Resource(name="SFCodeService")
	private SFCodeService sfCodeService;
	/**
	 * 4个页签
	 * @param id
	 * @return
	 * @author yanyubo
	 */
	public BasicMap<String,Object> findDaxx(String id){
		BasicMap<String,Object> map = new BasicMap<>();
		
			String sql = "select a.*,b.jgmc from jz_jzryjbxx a inner join jc_sfxzjgjbxx b on a.orgid=b.id where a.id='"+id+"'";
			SQLAdapter adapter = new SQLAdapter(sql);
			//服刑人员基本信息
			BasicMap<String,Object> daxx=dbClient.findOne(sql);
			BasicMap<String,Object> daws=dbClient.findOne(sql);
			if(daxx!=null) {
				daxx.put("csrq",DateUtil.format(daxx.get("csrq"), "yyyy-MM-dd"));
			
				daxx.putAll(dbClient.findOne(SupConst.Collections.JZ_JZRYJBXX_SF,new SqlDbFilter().eq("id", id)));
				daxx.putAll(dbClient.findOne(SupConst.Collections.JZ_JZRYJBXX_JZ,new SqlDbFilter().eq("id", id)));
				daxx.putAll(dbClient.findOne(SupConst.Collections.JZ_JZRYJBXX_DZ,new SqlDbFilter().eq("id", id)));
				daxx.putAll(dbClient.findOne(SupConst.Collections.JZ_JZRYJBXX_JK,new SqlDbFilter().eq("id", id)));
				daws.putAll(dbClient.findOne(SupConst.Collections.JZ_JZRYJBXX_WS,new SqlDbFilter().eq("id", id)));
				daws.putAll(dbClient.findOne(SupConst.Collections.JZ_JZRYJBXX_JZ,new SqlDbFilter().eq("id", id)));
				daws.putAll( dbClient.findOne(SupConst.Collections.JZ_JZRYJBXX_FZ,new SqlDbFilter().eq("id", id)));
				map.put("daxx", daxx);
				map.put("daws", daws);
			}
		
		return map;
	}
	
	
	
	/**
	 * 新增或修改(4个页签)
	 * @author yanyubo
	 */
	public void saveDaxx(final BasicMap<String, Object> datajbxx,
					final BasicMap<String,Object> dataWs,
			         List<BasicMap<String,Object>> grjls,
			         List<BasicMap<String,Object>> shgxs
			        ){
		dataWs.put("sfdcpg",datajbxx.get("sfdcpg"));
		dataWs.put("dcpgyj",datajbxx.get("dcpgyj"));
		dataWs.put("dcyjcxqk",datajbxx.get("dcyjcxqk"));
		dataWs.put("jzlb",datajbxx.get("jzlb"));
		User user = service.getUser();
		if(Util.isNotEmpty(datajbxx.get("sfsid"))) {
			datajbxx.put("orgid", datajbxx.get("sfsid"));
			datajbxx.put("sfzp", "1");
			datajbxx.put("sqjzryjsrq",DateUtil.format(new Date(),"yyyy-MM-dd"));
		}
		
		dbClient.save(SupConst.Collections.JZ_JZRYJBXX, datajbxx,new InsertOperation() {
			@Override
			public void insertBefore(BasicMap<String, Object> data) {
				data.put("sfjid",user.getOrgid());
				//生成流水号
				String code = sfCodeService.getCorrectCode();
				data.put("sqjzrybh", code);
			}
			@Override
			public void updateBefore(BasicMap<String, Object> data){
				data.remove("sqjzrybh");
			}
			@Override
			public void insertAfter(BasicMap<String, Object> data) {
			}
		});
		
		String getid = (String) datajbxx.get("id");
		datajbxx.put("id", getid);
		dbClient.save(SupConst.Collections.JZ_JZRYJBXX_DZ,datajbxx);
		dbClient.save(SupConst.Collections.JZ_JZRYJBXX_JK,datajbxx);
		dbClient.save(SupConst.Collections.JZ_JZRYJBXX_JZ,datajbxx);
		dbClient.save(SupConst.Collections.JZ_JZRYJBXX_SF,datajbxx);
		dbClient.remove(SupConst.Collections.JZ_SQJZRYGRJL,  new SqlDbFilter().eq("f_aid", getid));
		dbClient.remove(SupConst.Collections.JZ_JTCYJZYSHGX,  new SqlDbFilter().eq("f_aid", getid));
		//社区矫正人员个人简历
		if(grjls != null){
			dbClient.insert(SupConst.Collections.JZ_SQJZRYGRJL, grjls,new InsertOperation() {
				@Override
				public void insertBefore(BasicMap<String, Object> data) {
					data.put("f_aid", getid);
				}

				@Override
				public void insertAfter(BasicMap<String, Object> data) {
					
				}
			});
		}
		//社会关系及家庭成员
		if(shgxs != null){
			dbClient.insert(SupConst.Collections.JZ_JTCYJZYSHGX, shgxs,new InsertOperation() {
				@Override
				public void insertBefore(BasicMap<String, Object> data) {
					data.put("f_aid", getid);
				}
				@Override
				public void insertAfter(BasicMap<String, Object> data) {
				}
			});
		}
		//基本信息文书信息
		if(dataWs !=null){
			dataWs.put("id", getid);
			dbClient.save(SupConst.Collections.JZ_JZRYJBXX_WS,dataWs);
			dbClient.save(SupConst.Collections.JZ_JZRYJBXX_JZ,dataWs);
			dbClient.save(SupConst.Collections.JZ_JZRYJBXX_FZ,dataWs);
		}
		
	}
	/**
	 * 查询已登记接收人员信息
	 * @param query
	 * @param paginate
	 * @return
	 */
	
	public ResultList<BasicMap<String, Object>> findOwn(BasicMap<String, Object> query, Paginate paginate){
		User user = service.getUser();
		ResultList<BasicMap<String, Object>> list = new ResultList<>();
		if(user!=null){
			SqlDbFilter filter = toSqlFilter(query);
			String sql = "select a.*,b.jgmc "
					+ "from JZ_JZRYJBXX a left join JC_SFXZJGJBXX b on a.orgid=b.id ";
			SQLAdapter sqlAdapter = new SQLAdapter(sql);
			filter.in("a.orgid", user.getOrgidSet());
			filter.asc("a.xm");
			sqlAdapter.setFilter(filter);
			list =  dbClient.find(sqlAdapter, paginate,new RowDataListener() {
				@Override
				public void processData(BasicMap<String, Object> rowData) {
					if(NumberUtil.toInt(rowData.get("a.sfcj"))==1){
						rowData.put("a.sfcj", "是");
					}else if(NumberUtil.toInt(rowData.get("a.sfcj"))==0){
						rowData.put("a.sfcj", "否");
					}
					if(NumberUtil.toInt(rowData.get("sfzp"))==0){
						rowData.put("jgmc", "");
					}
					rowData.put("a.sfjid", user.getOrgid());
				}
			});
		}
		return list;
	}
	
	/**
	 * 根据矫正人员id查询矫正人员个人简历
	 * @param id
	 * @return
	 */
	public List<BasicMap<String,Object>>  findAllJl(String id){
		List<BasicMap<String,Object>> list = new ArrayList<>();
		if(Util.isNotEmpty(id)){
			SqlDbFilter filter = new SqlDbFilter();
			String sql = "select * from JZ_SQJZRYGRJL";
			filter.eq("f_aid", id);
			SQLAdapter adapter = new SQLAdapter(sql);
			adapter.setFilter(filter);
			list = dbClient.find(adapter,new RowDataListener() {
				@Override
				public void processData(BasicMap<String, Object> rowData) {
					rowData.put("qs",DateUtil.format(rowData.get("qs"),"yyyy-MM-dd"));
					rowData.put("zr",DateUtil.format(rowData.get("zr"), "yyyy-MM-dd"));
					
				}
			});
		}
		return list;
	}
	/**
	 * 根据矫正人员id查询矫正人员家庭及社会关系信息
	 * @param id
	 * @return
	 */
	public List<BasicMap<String,Object>> findJtcyjshgx(String id){
		List<BasicMap<String,Object>> list = new ArrayList<>();
		if(Util.isNotEmpty(id)){
			SqlDbFilter filter = new SqlDbFilter();
			list = dbClient.find(SupConst.Collections.JZ_JTCYJZYSHGX, filter.eq("f_aid", id));
		}
		return list;
	}
	/**
	 * 转派机构查询
	 * @param query
	 * @param paginate
	 * @return
	 */
	public List<BasicMap<String,Object>> findOrgid(BasicMap<String,Object> query){
		User user = service.getUser();
		List<BasicMap<String,Object>> list=new ArrayList<>();
		if(user!=null) {
			SqlDbFilter filter = toSqlFilter(query);
			String sql = "SELECT" + 
					"   a.id," + 
					"	a.jgmc," + 
					"	b.region_name," + 
					"	a.fzr," +  
					"	a.lxdh" +  
					"   FROM" + 
					"   jc_sfxzjgjbxx a"+
					"   LEFT JOIN sys_region b ON a.regionid=b.regionid";;
			SQLAdapter adapter = new SQLAdapter(sql);
			filter.eq("a.parentid", user.getOrgid());
			filter.like("a.jgmc", "司法所");
			adapter.setFilter(filter);
			list = dbClient.find(adapter);
		  }
		return list;
	}
	
	//撤回转派
	public BasicMap<String,Object> removeZp(String id){
		
		BasicMap<String,Object> map=new BasicMap<>();
		SqlDbFilter filter = new SqlDbFilter();
		String sql = "SELECT" + 
					"	a.parentid " + 
					"   FROM" + 
					"   jc_sfxzjgjbxx a"+
					"   LEFT JOIN jz_jzryjbxx b ON a.id=b.orgid";
			SQLAdapter adapter = new SQLAdapter(sql);
			filter.eq("b.id", id);
			adapter.setFilter(filter);
			map = dbClient.findOne(adapter);
		map.put("sfzp", "0");
		map.put("orgid", map.get("parentid"));
		map.put("id", id);
		dbClient.update("jz_jzryjbxx", map);
		return map;
	
	}
}
