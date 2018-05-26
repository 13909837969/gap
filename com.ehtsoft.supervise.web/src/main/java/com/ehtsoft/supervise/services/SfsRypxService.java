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

@Service("SfsRypxService")
public class SfsRypxService extends AbstractService{
	@Resource(name = "sqlDbClient")
	private SqlDbClient dbClient;
	@Resource(name="SSOService")
	private SSOService service;
	
	/**
	 * 保存司法所人员培训信息
	 * @param data
	 */
	public void save(BasicMap<String,Object> data) {
		data.put("orgid", service.getUser().getOrgid());
		dbClient.save(SupConst.Collections.SFS_SFSGZRYCJPXQKXXB, data);
	}
	
	/**
	 * 查看司法所人员培训详细信息
	 * @param id 
	 * @return
	 */
    public BasicMap<String,Object> findOne(String id){
	   String sql="select a.xm,b.* from JC_SFXZJGGZRYJBXX a right join SFS_SFSGZRYCJPXQKXXB b on a.id=b.RYID where b.id ='"+id+"'";
	   SQLAdapter aapter=new SQLAdapter(sql);
	   BasicMap<String,Object> data = dbClient.findOne(aapter);
	   return data;
    }
    
    /**
	 * 查看司法所所有人员培训信息
	 * @param id 
	 * @return
	 */
    public List<BasicMap<String,Object>> findAll(BasicMap<String,Object> query,Paginate paginate){
    	    User user=service.getUser();
  	    String orgid=user.getOrgid();
      	String sql="select a.xm,b.* from JC_SFXZJGGZRYJBXX a right join SFS_SFSGZRYCJPXQKXXB b on a.id=b.RYID";
     	SQLAdapter adapter=new SQLAdapter(sql);
        SqlDbFilter filter=new SqlDbFilter();
        filter.eq("b.orgid", orgid).like("a.xm", StringUtil.toEmptyString(query.get("xm")));
        adapter.setFilter(filter);
        List<BasicMap<String,Object>> list=dbClient.find(adapter, paginate).getRows();
        return list;
    }

}
