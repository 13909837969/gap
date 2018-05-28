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
import com.ehtsoft.fw.core.dto.ResultList;
import com.ehtsoft.fw.core.services.AbstractService;
import com.ehtsoft.fw.core.sso.User;
import com.ehtsoft.im.services.UserinfoService;
import com.ehtsoft.supervise.api.SupConst;
/**
 * 危险性评估管理
 * @author ranlf
 *
 */
@Service("AzbjJcqkService")
public class AzbjJcqkService extends AbstractService{
	
	@Resource(name = "sqlDbClient")
	private SqlDbClient dbClient;
	
	@Resource(name="SSOService")
	private SSOService ssoService; 
	
	@Resource
	private UserinfoService userinfoService;
	
	/**
	 * 查询奖惩情况内容
	 * @param query
	 * @param paginate
	 * @return
	 */
	public ResultList<BasicMap<String, Object>> findAll(BasicMap<String, Object> query,Paginate paginate){
		User user = ssoService.getUser();
		ResultList<BasicMap<String, Object>> rtn = new ResultList<>();
		if(user != null){
			String sqlstr = "SELECT a.id AS aid,a.xm,b.* FROM jz_jzryjbxx AS a INNER JOIN anzbj_jcqkcjb AS b ON a.id=b.azbjryid INNER JOIN anzbj_ryxjxxcjb AS c ON a.id=c.id";
			SqlDbFilter filter = toSqlFilter(query);
			filter.eq("c.jcbj","0");
			SQLAdapter sql = new SQLAdapter(sqlstr);
			sql.setFilter(filter);
			filter.in("a.orgid", user.getOrgidSet());
			rtn = dbClient.find(sql , paginate);
		}
		return rtn;
	}
	/**
	 * 插入与修改考核内容
	 * @param query
	 */
	public void saveOne(BasicMap<String, Object> data){
		dbClient.save(SupConst.Collections.ANZBJ_JCQKCJB, data);
	}
	/**
	 * 删除考核内容
	 * @param query
	 */
	public void removeOne(BasicMap<String, Object> data){
		dbClient.remove(SupConst.Collections.ANZBJ_JCQKCJB,data);
	}
	/**
	 * 查询矫正信息
	 * @return
	 */
	public List<BasicMap<String, Object>> findJz(){
		User user = ssoService.getUser();
		String orgid = user.getOrgid();
		List<BasicMap<String, Object>> map = new ArrayList<>();
		if(user != null){
			String sql = "SELECT a.id,a.xm,a.grlxdh FROM jz_jzryjbxx AS a INNER JOIN anzbj_ryxjxxcjb AS b ON a.id=b.id WHERE b.jcbj='0' AND a.orgid='"+orgid+"'";
			SQLAdapter adapter = new SQLAdapter(sql);
			map = dbClient.find(adapter);
		}
		return map;
	}
}

