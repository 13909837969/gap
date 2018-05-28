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
 * 人员脱管信息管理
 * @author 黄炜
 *
 */
@Service("AzbjRytgxxcjbService")
public class AzbjRytgxxcjbService extends AbstractService{

	@Resource(name = "sqlDbClient")
	private SqlDbClient dbClient;
	
	@Resource(name="SSOService")
	private SSOService ssoService; 
	
	@Resource
	private UserinfoService userinfoService;
	
	/**
	 * 查询脱管内容
	 * @param query
	 * @param paginate
	 * @return
	 */
	public ResultList<BasicMap<String, Object>> findAll(BasicMap<String, Object> query, Paginate paginate){
		User user = ssoService.getUser();
		ResultList<BasicMap<String, Object>> rtn = new ResultList<>();
		if(user != null){
			String sqlstr = "SELECT a.xm,b.* FROM JZ_JZRYJBXX a INNER JOIN ANZBJ_RYTGXXCJB b ON b.aid = a.id inner join ANZBJ_RYXJXXCJB c ON c.id = a.id";
			SQLAdapter sql = new SQLAdapter(sqlstr);
			SqlDbFilter filter = toSqlFilter(query);
			filter.eq("c.jcbj", "0");
			filter.eq("a.orgid", user.getOrgid());
			sql.setFilter(filter);
			return dbClient.find(sql, paginate);
		}
		return rtn;
	}
	
	/**
	 * 插入与修改人员脱管内容
	 * @param query
	 */
	public void saveOne(BasicMap<String, Object> data){
		dbClient.save(SupConst.Collections.ANZBJ_RYTGXXCJB, data);
	}
	/**
	 * 删除人员脱管内容
	 * @param query
	 */
	public void removeOne(String id){
		dbClient.remove(SupConst.Collections.ANZBJ_RYTGXXCJB, new SqlDbFilter().eq("id",id));
	}
	/**
	 * 查询脱管人员相关信息
	 * @return
	 */
	public List<BasicMap<String, Object>> findJz(){
		User user = ssoService.getUser();
		String orgid = user.getOrgid();
		List<BasicMap<String, Object>> map = new ArrayList<>();
		if(user != null){
			String sql = "select a.id,a.xm,a.grlxdh from JZ_JZRYJBXX a inner join ANZBJ_RYXJXXCJB c ON c.id = a.id where a.orgid='"+orgid+"' and c.jcbj = '0'";
			SQLAdapter adapter = new SQLAdapter(sql);
			map = dbClient.find(adapter);
		}
		return map;
	}
}


