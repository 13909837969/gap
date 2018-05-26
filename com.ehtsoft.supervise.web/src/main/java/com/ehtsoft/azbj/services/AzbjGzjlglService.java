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
 * 工作记录信息管理
 */
@Service("AzbjGzjlglService")
public class AzbjGzjlglService extends AbstractService {

	@Resource(name="sqlDbClient")
	private SqlDbClient dbClient;
	
	@Resource(name="SSOService")
	private SSOService ssoService; 
	
	@Resource
	private UserinfoService userinfoService;
	
	/**
	 * 查询工作记录
	 */
	public ResultList<BasicMap<String, Object>> findAll(BasicMap<String, Object> query, Paginate paginate){
		User user = ssoService.getUser();
		ResultList<BasicMap<String, Object>> rtn = new ResultList<>();
		if(user != null){
			String sqlstr = "SELECT A.*,B.XM FROM ANZBJ_GZJLCJB A INNER JOIN JZ_JZRYJBXX B ON A.AZBJRYID = B.ID";
			SqlDbFilter filter = toSqlFilter(query);
			SQLAdapter sql = new SQLAdapter(sqlstr);
			sql.setFilter(filter);
			filter.in("a.orgid", user.getOrgidSet());
			rtn = dbClient.find(sql , paginate);
		}		
		return rtn;
	}
	
	/**
	 * 保存
	 */
	public void saveOne(BasicMap<String, Object> data){
		dbClient.save(SupConst.Collections.ANZBJ_GZJLCJB, data);
	}
	
	/**
	 * 删除
	 */
	public void removeOne(String id){
		dbClient.remove(SupConst.Collections.ANZBJ_GZJLCJB, new SqlDbFilter().eq("id",id));
	}
	
	/**
	 *查询矫正人员姓名 
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
