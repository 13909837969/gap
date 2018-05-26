package com.ehtsoft.supervise.services;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ehtsoft.common.services.SSOService;
import com.ehtsoft.fw.core.db.RowDataListener;
import com.ehtsoft.fw.core.db.SQLAdapter;
import com.ehtsoft.fw.core.db.SqlDbClient;
import com.ehtsoft.fw.core.db.SqlDbFilter;
import com.ehtsoft.fw.core.dto.BasicMap;
import com.ehtsoft.fw.core.dto.Paginate;
import com.ehtsoft.fw.core.services.AbstractService;
import com.ehtsoft.fw.core.sso.User;
import com.ehtsoft.fw.utils.StringUtil;
import com.ehtsoft.supervise.api.SupConst;

/**
 * 人民调解-人民调解机构浏览
 * @author DENNYPC
 *
 */
@Service("RmtjrmtjjgService")
public class RmtjrmtjjgService extends AbstractService{
	@Resource(name="sqlDbClient")
	private SqlDbClient dbClient;
	@Resource(name="SSOService")
	private SSOService service;
	
	/**
	 * 查询所有人民调解机构
	 * @param query
	 * @param paginate
	 * @return
	 */
	public List<BasicMap<String,Object>> findAll(BasicMap<String,Object> query,Paginate paginate){
		List<BasicMap<String,Object>> list=new ArrayList<>();
		User user = service.getUser();
		String sql="select * from RMTJ_JWHJBXX";
		SQLAdapter adapter=new SQLAdapter(sql);
		SqlDbFilter filter=new SqlDbFilter();
		filter.like("TWHMC", StringUtil.toEmptyString(query.get("TWHMC")));
		adapter.setFilter(filter);
		filter.in("orgid", user.getOrgidSet());
		list=dbClient.find(adapter, paginate).getRows();
		return list;
	}
	
	
	/**
	 * 查询调解委员会主任名单；
	 * @param id
	 * @return
	 */
	public List<BasicMap<String,Object>> findTWHZWzr(String twhid,Paginate paginate){	
		List<BasicMap<String,Object>> list=new ArrayList<>();
		String sql="select b.id as imgId,* from RMTJ_JWHJBXX a inner join RMTJ_TJYJBXX b on a.id=b.TWHID "
				+ " where b.TWHZW in ('03','04') "
				+ " and twhid = '"+twhid+"' order by b.TWHZW";
		SQLAdapter adapter=new SQLAdapter(sql);
		list=dbClient.find(adapter, paginate).getRows();
		return list;
	}
	
	/**
	 * 查询调解委员会调解员名单； 
	 * @param id
	 * @return
	 * 平板调解委员会调取人员信息用
	 */
	public List<BasicMap<String,Object>> findTWHZW(String twhid,Paginate paginate){	
		List<BasicMap<String,Object>> list=new ArrayList<>();
		String sql="select b.id as imgId,b.xm,b.TWHZW from RMTJ_JWHJBXX a inner join RMTJ_TJYJBXX b on a.id=b.TWHID where b.TWHZW!='03' and b.TWHZW!='04' and twhid = '"+twhid+"' order by b.TWHZW desc";
		SQLAdapter adapter=new SQLAdapter(sql);  
//		SqlDbFilter filter=new SqlDbFilter();
//		filter.unEq("b.TWHZW", "03").unEq("b.TWHZW", "04");
//		filter.eq("twhid",twhid);
//		filter.desc("b.TWHZW");
		list=dbClient.find(adapter, paginate).getRows();
		return list;
	}

	
	/**
	 * 查询人民调解机构的详细信息
	 * @param id
	 * @return
	 */
	public BasicMap<String,Object> findOne(String id){
		BasicMap<String,Object> data=new BasicMap<>();
		String sql="select * from RMTJ_JWHJBXX";
		SQLAdapter adapter=new SQLAdapter(sql);
		adapter.getFilter().eq("id",id);
		data=dbClient.findOne(adapter);
		return data;	
	}
	
	/**
	 * 查询所有调解员信息
	 * @param query
	 * @param paginate
	 * @return
	 */
	public List<BasicMap<String,Object>> findAlltjy(BasicMap<String,Object> query,Paginate paginate){
		
		User user = service.getUser();
		
		List<BasicMap<String,Object>> list=new ArrayList<>();
		//String sql="select * from RMTJ_TJYJBXX";
		if(null!=user) {
		String sql="select * from RMTJ_TJYJBXX a inner join RMTJ_JWHJBXX b on a.TWHID=b.ID";
		SQLAdapter adapter=new SQLAdapter(sql);
		SqlDbFilter filter=new SqlDbFilter();
		filter.in("b.orgid", user.getOrgidSet());
		filter.like("xm", StringUtil.toEmptyString(query.get("name")));
		adapter.setFilter(filter);
		list=dbClient.find(adapter, paginate).getRows();
		}
		return list;
	}
	
	
	
	/**
	 * 查询调解员的基本信息
	 * @param id
	 * @return
	 */
	public BasicMap<String,Object> findOnetjy(String id){
		BasicMap<String,Object> data=new BasicMap<>();
		String sql="select * from RMTJ_TJYJBXX";
		SQLAdapter adapter=new SQLAdapter(sql);
		adapter.getFilter().eq("id",id);
		data=dbClient.findOne(adapter );
		return data;	
	}
	
	
//	/**
//	 * 查询调解员的照片
//	 * @param id
//	 * @return
//	 */
//	public List<BasicMap<String, Object>> getTjyImageList(String id){
//		List<BasicMap<String, Object>> data  = new ArrayList<>();
//	    String sqlStr = "select imgid from RMTJ_TJYJBXX_IMG";
//	    SQLAdapter adapter = new SQLAdapter(sqlStr);
//	    adapter.getFilter().eq("bfid", id);
//	    data = dbClient.find(adapter);
//		return data;
//	}
	
	/**
	 * 删除调委会
	 * @param id
	 */
	public void deleteRegLegal(String id){
		dbClient.remove(SupConst.Collections.RMTJ_JWHJBXX, new SqlDbFilter().eq("ID", id));
	}
	
	/**
	 * 新增或修改调委会的基本信息
	 * 
	 * @param data
	 */
	public void saveRegLegal(BasicMap<String, Object> data) {
		dbClient.save(SupConst.Collections.RMTJ_JWHJBXX, data);
	}
	
	/**
	 * 删除调解员
	 * @param id
	 */
	public void deleteMediator(String id){
		dbClient.remove(SupConst.Collections.RMTJ_TJYJBXX, new SqlDbFilter().eq("ID", id));
	}
	
	/**
	 * 新增或修改调解员的基本信息
	 * 
	 * @param data
	 */
	public void saveMediator(BasicMap<String, Object> data) {
		dbClient.save(SupConst.Collections.RMTJ_TJYJBXX, data);
	}
	
	/**
	 * 人民调解委员会基本情况图片
	 * @param id
	 * @return
	 */
	public List<BasicMap<String, Object>> getImageList(String id){
		List<BasicMap<String, Object>> data  = new ArrayList<>();
	    String sqlStr = "select imgid from RMTJ_JWHJBXX_IMG";
	    SQLAdapter adapter = new SQLAdapter(sqlStr);
	    adapter.getFilter().eq("JWHJBXX_ID", id);
	    data = dbClient.find(adapter);
		return data;
	}
	
	

}
