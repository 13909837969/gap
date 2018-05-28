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
 * 回执信息采集
 * @author 陈崇
 *
 */
@Service("AzbjHzxxcjbService")
public class AzbjHzxxcjbService extends AbstractService{
	@Resource(name="sqlDbClient")
	private SqlDbClient dbClient;
	
	@Resource(name="SSOService")
	private SSOService ssoService; 
	
	@Resource
	private UserinfoService userinfoService;
	public ResultList<BasicMap<String, Object>> findAll(BasicMap<String, Object> query, Paginate paginate){
		User user = ssoService.getUser();
		ResultList<BasicMap<String, Object>> rtn = new ResultList<>();
		if(user != null){
			String sqlstr = "SELECT a.id aid,a.xm,b.* FROM JZ_JZRYJBXX a INNER JOIN ANZBJ_HZXXCJB b ON a.id = b.azbjryid INNER JOIN ANZBJ_RYXJXXCJB c ON a.id = c.id";
			SqlDbFilter filter = toSqlFilter(query);
			SQLAdapter sql = new SQLAdapter(sqlstr);
			filter.in("a.orgid", user.getOrgidSet());
			filter.eq("c.jcbj", "0");
			sql.setFilter(filter);
			rtn = dbClient.find(sql , paginate);
		}		
		return rtn;
	}

	/**
	 * 插入与修改未成年子女帮扶内容
	 * @param query
	 */
	public void saveOne(BasicMap<String, Object> data){
		dbClient.save(SupConst.Collections.ANZBJ_HZXXCJB, data);
	}
	/**
	 * 删除未成年子女帮扶内容
	 * @param query
	 */
	public void removeOne(BasicMap<String, Object> data){
		dbClient.remove(SupConst.Collections.ANZBJ_HZXXCJB, data);
	}
	/**
	 * 查询迁居人员相关信息
	 * @return
	 */
	public List<BasicMap<String, Object>> findJz(){
		User user = ssoService.getUser();
		String orgid = user.getOrgid();
		List<BasicMap<String, Object>> map = new ArrayList<>();
			String sql = "select a.id,a.xm,a.grlxdh from JZ_JZRYJBXX a INNER JOIN ANZBJ_RYXJXXCJB b ON a.id = b.id where b.jcbj = '0' and a.orgid='"+orgid+"'";
			SQLAdapter adapter = new SQLAdapter(sql);
			map = dbClient.find(adapter);
		return map;
	}
}
