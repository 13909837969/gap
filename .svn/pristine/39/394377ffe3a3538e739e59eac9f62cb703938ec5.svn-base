package com.ehtsoft.supervise.services;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ehtsoft.common.services.SSOService;
import com.ehtsoft.fw.core.db.SQLAdapter;
import com.ehtsoft.fw.core.db.SqlDbClient;
import com.ehtsoft.fw.core.db.SqlDbFilter;
import com.ehtsoft.fw.core.dto.BasicMap;
import com.ehtsoft.fw.core.dto.Paginate;
import com.ehtsoft.fw.core.services.AbstractService;
import com.ehtsoft.fw.utils.StringUtil;
import com.ehtsoft.supervise.api.SupConst;

@Service("AzbjBkfzService")
public class AzbjBkfzService extends AbstractService{
	
	@Resource(name="sqlDbClient")
	private SqlDbClient dbClient;
	@Resource(name="SSOService")
	private SSOService service;
	
	/**
	 * 保存帮困扶助信息
	 * @param data
	 */
	public void save(BasicMap<String,Object> data) {
		data.put("BSLX", "1");
		dbClient.save(SupConst.Collections.JZ_BFXXCJB, data);
	}
	
	/**
	 * 查看所有的帮困扶助信息
	 * @param query
	 * @param paginate
	 * @return
	 */
	public List<BasicMap<String,Object>> findAll(BasicMap<String,Object> query,Paginate paginate){
		List<BasicMap<String,Object>> list=new ArrayList<BasicMap<String,Object>>();
		String sql="select a.id,a.F_AID,a.BFSJ,a.BFDD,a.BFNR,a.ZHJZ,b.xm from JZ_BFXXCJB a inner join jz_jzryjbxx b on a.F_AID=b.id";
		SqlDbFilter filter=new SqlDbFilter();
		filter.like("b.xm",StringUtil.toEmptyString(query.get("xm")))
		      .eq("a.BSLX","1");
		SQLAdapter adapter=new SQLAdapter(sql);
		adapter.setFilter(filter);
		list=dbClient.find(adapter, paginate).getRows();
		return list;
	}
	
	/**
	 * 查询帮困扶助的详细信息
	 * @param id
	 * @return
	 */
	public BasicMap<String,Object> findOne(String id){
		BasicMap<String,Object> data=new BasicMap<>();
		String sql="select a.id,a.F_AID,a.BFSJ,a.BFDD,a.BFNR,a.ZHJZ,b.xm,b.csrq,b.xb,b.mz,a.qz from JZ_BFXXCJB a inner join jz_jzryjbxx b on a.F_AID=b.id where a.id='"+id+"'";
		SQLAdapter adapter=new SQLAdapter(sql);
		//adapter.getFilter().eq("a.id", id);
	    data=dbClient.findOne(adapter);
	    return data;
	}
	
	/**
	 * 查询所有帮困扶助的图片
	 * @param tablename
	 * @param id
	 * @return
	 */
	public List<BasicMap<String,Object>> findImgAll(String tablename,String id){
		List<BasicMap<String,Object>> list=new ArrayList<>();
		String sql="select IMGID from "+tablename+" where BFID='"+id+"'";
		SQLAdapter adapter=new SQLAdapter(sql);
		list=dbClient.find(adapter);
		return list;
	}

	/**
	 * 删除帮困扶助信息
	 * @param id
	 */
	public void delete(String id) {
		dbClient.remove(SupConst.Collections.JZ_BFXXCJB, new SqlDbFilter().eq("id", id));
	}
	
	/**
	 * 删除图片
	 * @param id
	 */
	public void deleteImg(String id) {
		dbClient.remove(SupConst.Collections.JZ_BFXXCJB_IMG, new SqlDbFilter().eq("IMGID", id));
	}

}
