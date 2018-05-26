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

@Service("AzbjJyzfService")
public class AzbjJyzfService extends AbstractService{
	
	@Resource(name="sqlDbClient")
	private SqlDbClient dbClient;
	@Resource(name="SSOService")
	private SSOService service;
	
	/**
	 * 保存教育走访信息
	 * @param data
	 */
	public void save(BasicMap<String,Object> data) {
		dbClient.save(SupConst.Collections.ANZBJ_JYZFXX, data);
	}
	
	/**
	 * 查看所有的教育走访信息
	 * @param query
	 * @param paginate
	 * @return
	 */
	public List<BasicMap<String,Object>> findAll(BasicMap<String,Object> query,Paginate paginate){
		List<BasicMap<String,Object>> list=new ArrayList<BasicMap<String,Object>>();
		String sql="select a.id,a.aid,a.ZFRQ,a.ZFDD,a.THNR,a.ZFXG,a.BFDXQZ,b.xm from anzbj_jyzfxx a inner join jz_jzryjbxx b on a.aid=b.id";
		SqlDbFilter filter=new SqlDbFilter();
		filter.like("b.xm",StringUtil.toEmptyString(query.get("xm")));
		SQLAdapter adapter=new SQLAdapter(sql);
		adapter.setFilter(filter);
		list=dbClient.find(adapter, paginate).getRows();
		return list;
	}
	
	/**
	 * 查询教育走访信息的详细信息
	 * @param id
	 * @return
	 */
	public BasicMap<String,Object> findOne(String id){
		BasicMap<String,Object> data=new BasicMap<>();
		String sql="select a.id,a.aid,a.ZFRQ,a.ZFDD,a.THNR,a.ZFXG,a.BFDXQZ,b.xm,b.csrq,b.xb,b.mz from anzbj_jyzfxx a inner join jz_jzryjbxx b on a.aid=b.id where a.id='"+id+"'";
		SQLAdapter adapter=new SQLAdapter(sql);
		//adapter.getFilter().eq("a.id", id);
	    data=dbClient.findOne(adapter);
	    return data;
	}
	
	/**
	 * 查询所有走访教育的图片
	 * @param tablename
	 * @param id
	 * @return
	 */
	public List<BasicMap<String,Object>> findImgAll(String tablename,String id){
		List<BasicMap<String,Object>> list=new ArrayList<>();
		String sql="select IMGID from "+tablename+" where JYZFID='"+id+"'";
		SQLAdapter adapter=new SQLAdapter(sql);
		list=dbClient.find(adapter);
		return list;
	}

	/**
	 * 删除走访教育信息
	 * @param id
	 */
	public void delete(String id) {
		dbClient.remove(SupConst.Collections.ANZBJ_JYZFXX, new SqlDbFilter().eq("id", id));
	}
	
	/**
	 * 删除图片
	 * @param imgid
	 */
	public void deleteImg(String imgid) {
		dbClient.remove(SupConst.Collections.ANZBJ_JYZFXX_IMG, new SqlDbFilter().eq("IMGID", imgid));
	}
	
	
}
