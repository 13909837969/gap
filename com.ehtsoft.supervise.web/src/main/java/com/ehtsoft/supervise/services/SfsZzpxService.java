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

@Service("SfsZzpxService")
public class SfsZzpxService extends AbstractService{
	@Resource(name = "sqlDbClient")
	private SqlDbClient dbClient;
	@Resource(name="SSOService")
	private SSOService service;
	
	/**
	 * 保存司法所组织培训信息
	 * @param data
	 */
	public void save(BasicMap<String,Object> data) {
		User user=service.getUser();
		String orgid=user.getOrgid();
		String orgidcode=user.getOrgcode();
		data.put("S_ID", orgid);
		data.put("SFSBM", orgidcode);
		dbClient.save(SupConst.Collections.SFS_SFSZZPXQKXXB, data);
	}
	
	/**
	 * 查看司法所组织培训信息
	 * @param id 
	 * @return
	 */
    public BasicMap<String,Object> findOne(String id){
	   String sql="select * from SFS_SFSZZPXQKXXB where id ='"+id+"'";
	   SQLAdapter aapter=new SQLAdapter(sql);
	   BasicMap<String,Object> data = dbClient.findOne(aapter);
	   return data;
    }
    
    public List<BasicMap<String,Object>> findAll(Paginate paginate){
    	    String orgid=service.getUser().getOrgid();
    	    String sql="select * from SFS_SFSZZPXQKXXB where S_ID='"+orgid+"'";
    	    SQLAdapter adapter=new SQLAdapter(sql);
    	    List<BasicMap<String,Object>> list=dbClient.find(adapter,paginate).getRows();
    	    return list;
    	
    }
    
    

}
