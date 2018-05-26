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

@Service("SfsXzysService")
public class SfsXzysService extends AbstractService{
	@Resource(name = "sqlDbClient")
	private SqlDbClient dbClient;
	@Resource(name="SSOService")
	private SSOService service;
	
	/**
	 * 保存司法所行政延伸信息
	 * @param data
	 */
	public void save(BasicMap<String,Object> data) {
		data.put("orgid", service.getUser().getOrgid());
		dbClient.save(SupConst.Collections.SFS_SFSXXGZXCSQYSQKXXB, data);
	}
	
	/**
	 * 查看司法所司法所行政延伸信息
	 * @param id 
	 * @return
	 */
    public BasicMap<String,Object> findOne(String id){
	   String sql="select * from SFS_SFSXXGZXCSQYSQKXXB where id ='"+id+"'";
	   SQLAdapter aapter=new SQLAdapter(sql);
	   BasicMap<String,Object> data = dbClient.findOne(aapter);
	   return data;
    }
    
    /**
	 * 查看司法所所有行政延伸信息
	 * @param id 
	 * @return
	 */
    public List<BasicMap<String,Object>> findAll(BasicMap<String,Object> query,Paginate paginate){
      	User user=service.getUser();
  	    String orgid=user.getOrgid();
      	String sql="select * from SFS_SFSXXGZXCSQYSQKXXB";
  	    SQLAdapter adapter=new SQLAdapter(sql);
        SqlDbFilter filter=new SqlDbFilter();
        filter.eq("orgid", orgid);
        adapter.setFilter(filter);
        List<BasicMap<String,Object>> list=dbClient.find(adapter, paginate).getRows();
        return list;
    }
    
    
}
