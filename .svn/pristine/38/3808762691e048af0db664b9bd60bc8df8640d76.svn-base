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
import com.ehtsoft.fw.core.dto.ResultList;
import com.ehtsoft.fw.core.services.AbstractService;
import com.ehtsoft.fw.core.sso.User;
import com.ehtsoft.im.services.UserinfoService;
import com.ehtsoft.supervise.api.SupConst;

@Service("YwyfService")
public class YwyfService extends AbstractService {

	@Resource(name = "sqlDbClient")
	private SqlDbClient dbClient;
	
	@Resource(name="SSOService")
	private SSOService service;
	
	@Resource
	private UserinfoService userinfoService;
	
	/**
	 * 插入与修改考核内容
	 * @param query
	 */
	public void saveInfo(BasicMap<String, Object> data) {
		dbClient.save(SupConst.Collections.SFS_SFSYWYFXXB, data);
	}
	
	/**
	 * 查询 find
	 */
	public ResultList<BasicMap<String, Object>> findAll(BasicMap<String, Object> query,Paginate paginate){
		User user = service.getUser();
		ResultList<BasicMap<String, Object>> map = new ResultList<>();
		if(user != null) {
			String sqlstr = "select * from sfs_ywyfxxb";
			SqlDbFilter filter = toSqlFilter(query);
			SQLAdapter sql = new SQLAdapter(sqlstr);
			filter.in("a.org", user.getOrgidSet());
			sql.setFilter(filter);
			map = dbClient.find(sql,paginate);
		}
		return map;
	}
	
}
