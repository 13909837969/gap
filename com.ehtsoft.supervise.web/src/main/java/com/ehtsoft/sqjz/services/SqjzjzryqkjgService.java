package com.ehtsoft.sqjz.services;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ehtsoft.common.services.SSOService;
import com.ehtsoft.fw.core.db.SQLAdapter;
import com.ehtsoft.fw.core.db.SqlDbClient;
import com.ehtsoft.fw.core.db.SqlDbFilter;
import com.ehtsoft.fw.core.dto.BasicMap;
import com.ehtsoft.fw.core.dto.Paginate;
import com.ehtsoft.fw.core.dto.ResultList;
import com.ehtsoft.fw.core.services.AbstractService;
import com.ehtsoft.fw.core.sso.User;
/**
 * 
 * @author 李恒
 *
 */
@Service("SqjzjzryqkjgService")
public class SqjzjzryqkjgService extends AbstractService{

	@Resource(name="sqlDbClient")
	SqlDbClient dbClient;
	
	@Resource(name="SSOService")
	private SSOService Service;
	
	public ResultList<BasicMap<String, Object>> find (BasicMap<String,Object> query,Paginate paginate){
		User user = Service.getUser();//获取当前机构登陆ID
		ResultList<BasicMap<String,Object>> list = new ResultList<>();//返回值list
		if(user!=null) {
			String sql = "SELECT " + 
					"A.*, " + 
					"b.xm as sqjzryxm, " + 
					"b.xb as sqjzryxb, " + 
					"b.grlxdh as sqjzrylxdh " + 
					"FROM JZ_JZXZCY a " + 
					"LEFT JOIN JZ_JZRYJBXX b ON b.id=f_aid";
			SqlDbFilter filter = toSqlFilter(query);//相当于查询
			filter.eq("a.orgid", user.getOrgid());
			SQLAdapter sqladpter = new SQLAdapter(sql);
			sqladpter.setFilter(filter);
			list=dbClient.find(sqladpter, paginate);
		}
		return list;
	}
	
	
}
