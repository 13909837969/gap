package com.ehtsoft.azbj.services;
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
import com.ehtsoft.fw.core.dto.ResultList;
import com.ehtsoft.fw.core.services.AbstractService;
import com.ehtsoft.fw.core.sso.User;
import com.ehtsoft.im.services.UserinfoService;
import com.ehtsoft.supervise.api.SupConst;
/**
 * 人员迁居信息管理
 * @author 王世凯
 *
 */
@Service("AzbjRyqjxxService")
public class AzbjRyqjxxService extends AbstractService{
	
	@Resource(name = "sqlDbClient")
	private SqlDbClient dbClient;
	
	@Resource(name="SSOService")
	private SSOService ssoService; 
	
	@Resource
	private UserinfoService userinfoService;
	
	/**
	 * 查询考核内容
	 * @param query
	 * @param paginate
	 * @return
	 */
	public ResultList<BasicMap<String, Object>> findAll(BasicMap<String, Object> query,Paginate paginate){
		User user = ssoService.getUser();
		ResultList<BasicMap<String, Object>> rtn = new ResultList<>();
		if(user != null){
			String sqlstr = "SELECT a.xm,b.* FROM JZ_JZRYJBXX a INNER JOIN ANZBJ_RYQJXXCJB b ON a.id = b.azbjryid";
			SqlDbFilter filter = toSqlFilter(query);
			SQLAdapter sql = new SQLAdapter(sqlstr);
			sql.setFilter(filter);
			filter.in("a.orgid", user.getOrgidSet());
			rtn = dbClient.find(sql, paginate);
		}
		return rtn;
	}
	
	/**
	 * 插入与修改人员迁居内容
	 * @param query
	 */
	public void saveOne(BasicMap<String, Object> data){
		dbClient.save(SupConst.Collections.ANZBJ_RYQJXXCJB, data);
	}
	/**
	 * 删除人员迁居内容
	 * @param query
	 */
	public void removeOne(String id){
		dbClient.remove(SupConst.Collections.ANZBJ_RYQJXXCJB, new SqlDbFilter().eq("id",id));
	}
	/**
	 * 查询迁居人员相关信息
	 * @return
	 */
	public List<BasicMap<String, Object>> findJz(){
		User user = ssoService.getUser();
		String orgid = user.getOrgid();
		List<BasicMap<String, Object>> map = new ArrayList<>();
		if(user != null){
			String sql = "select id,xm,grlxdh from JZ_JZRYJBXX where orgid='"+orgid+"'";
			 SQLAdapter adapter = new SQLAdapter(sql);
			map = dbClient.find(adapter);
		}
		return map;
	}
}
