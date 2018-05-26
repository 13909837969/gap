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

@Service("AzbjAzglService")
public class AzbjAzglService extends AbstractService{
	
	@Resource(name="sqlDbClient")
	private SqlDbClient dbClient;
	@Resource(name="SSOService")
	private SSOService service;
	
	/**
	 * 保存安置管理信息
	 * @param data
	 */
	public void save(BasicMap<String,Object> data) {
		dbClient.save(SupConst.Collections.ANZBJ_AZXXCJB, data);
	}
	
	/**
	 * 查看所有的安置管理信息
	 * @param query
	 * @param paginate
	 * @return
	 */
	public List<BasicMap<String,Object>> findAll(BasicMap<String,Object> query,Paginate paginate){
		List<BasicMap<String,Object>> list=new ArrayList<BasicMap<String,Object>>();
		String sql="select a.id,a.f_aid,a.azfs,a.azsj,a.HDSHJZFS,a.SFXZBLSHBX,a.ZZCYSFLSJMSZC,a.CSGTJYSFLSJMSZC,a.QYHJJSFLSJMSZC,b.xm,c.gdjzdmx " + 
				" from ANZBJ_AZXXCJB a left join JZ_JZRYJBXX b on a.f_aid=b.id left join JZ_JZRYJBXX_DZ c on b.id=c.id ";
		SqlDbFilter filter=new SqlDbFilter();
		filter.like("b.xm",StringUtil.toEmptyString(query.get("xm")));
		SQLAdapter adapter=new SQLAdapter(sql);
		adapter.setFilter(filter);
		list=dbClient.find(adapter, paginate).getRows();
		return list;
	}
	
	/**
	 * 查询安置信息的详细信息
	 * @param id
	 * @return
	 */
	public BasicMap<String,Object> findOne(String id){
		BasicMap<String,Object> data=new BasicMap<>();
		String sql="select a.id,a.f_aid,a.azfs,a.azsj,a.HDSHJZFS,a.SFXZBLSHBX,a.ZZCYSFLSJMSZC,a.CSGTJYSFLSJMSZC,a.QYHJJSFLSJMSZC,a.remark,b.xm " + 
				" from ANZBJ_AZXXCJB a left join JZ_JZRYJBXX b on a.f_aid=b.id where a.id='"+id+"'";
		SQLAdapter adapter=new SQLAdapter(sql);
	    data=dbClient.findOne(adapter);
	    return data;
	}
	
	/**
	 * 查询所有安置信息的图片
	 * @param tablename
	 * @param id
	 * @return
	 */
	public List<BasicMap<String,Object>> findImgAll(String tablename,String id){
		List<BasicMap<String,Object>> list=new ArrayList<>();
		String sql="select IMGID from "+tablename+" where AZXXID='"+id+"'";
		SQLAdapter adapter=new SQLAdapter(sql);
		list=dbClient.find(adapter);
		return list;
	}
	
	/**
	 * 删除安置信息
	 * @param id
	 */
	public void delete(String id) {
		dbClient.remove(SupConst.Collections.ANZBJ_AZXXCJB, new SqlDbFilter().eq("id", id));
	}
	
	/**
	 * 删除图片
	 * @param id
	 */
	public void deleteImg(String id) {
		dbClient.remove(SupConst.Collections.ANZBJ_AZXX_IMG, new SqlDbFilter().eq("IMGID", id));
	}

}
