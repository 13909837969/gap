package com.ehtsoft.supervise.services;

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
import com.ehtsoft.fw.core.sso.User;
import com.ehtsoft.fw.utils.StringUtil;
import com.ehtsoft.supervise.api.SupConst;

@Service("SfsBzqkxxService")
public class SfsBzqkxxService extends AbstractService{
	
	@Resource(name = "sqlDbClient")
	private SqlDbClient dbClient;
	@Resource(name="SSOService")
	private SSOService service;
	
	/**
	 * 保存司法所表彰情况信息
	 * @param data
	 */
	public void save(BasicMap<String,Object> data) {
		User user=service.getUser();
		String orgid=user.getOrgid();
		String orgidcode=user.getOrgcode();
		data.put("SFSBM", orgidcode);
		data.put("S_ID", orgid);
		dbClient.save(SupConst.Collections.SFS_SFSBZQKXXB, data);
	}
	
	/**
	 * 查看司法所表彰情况信息
	 * @param id
	 * @return
	 */
    public BasicMap<String,Object> findOne(String id){
	  
	   String sql="select * from SFS_SFSBZQKXXB where id='"+id+"'";
	   SQLAdapter aapter=new SQLAdapter(sql);
	   BasicMap<String,Object> data = dbClient.findOne(aapter);
	   return data;
    }
    
    /**
     * 查询所有的表彰信息
     * @param query
     * @param paginate
     * @return
     */
    public List<BasicMap<String,Object>> findAll(BasicMap<String,Object> query,Paginate paginate){
      	User user=service.getUser();
  	    String orgid=user.getOrgid();
     	String sql="select * from SFS_SFSBZQKXXB";
      	SQLAdapter adapter=new SQLAdapter(sql);
        SqlDbFilter filter=new SqlDbFilter();
        filter.eq("orgid", orgid).desc("cts");
        adapter.setFilter(filter);
        List<BasicMap<String,Object>> list=dbClient.find(adapter, paginate).getRows();
        return list;
    }


}
