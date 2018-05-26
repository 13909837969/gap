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
 * @Description 安置信息管理
 * @author 牛新宇
 * @date 2018年5月21日
 */
@Service("AzbjAzxxglService")
public class AzbjAzxxglService extends AbstractService{
	
	@Resource(name = "sqlDbClient")
	private SqlDbClient dbClient;
	
	@Resource(name="SSOService")
	private SSOService ssoService; 
	
	@Resource
	private UserinfoService userinfoService;
	/**
	 * 查询安置人员信息 
	 */
	public ResultList<BasicMap<String, Object>> find_ry(BasicMap<String, Object> query,Paginate paginate){
		User user = ssoService.getUser();
		ResultList<BasicMap<String, Object>> rtn = new ResultList<>();
		if(user!=null) {
			String sqlstr = "SELECT A.XM,B.* FROM JZ_JZRYJBXX A INNER JOIN ANZBJ_AZXXCJB B ON A.ID = B.AZBJRYID ";
			SqlDbFilter filter = toSqlFilter(query);
			SQLAdapter sql = new SQLAdapter(sqlstr);
			sql.setFilter(filter);
			filter.in("a.orgid", user.getOrgidSet());
			rtn = dbClient.find(sql, paginate);
		}
		return rtn;
	}
	/**
	 * 插入与修改安置人员信息 
	 */
	public void saveOne(BasicMap<String, Object> data){
		User user = ssoService.getUser();
		if(user!=null) {
			dbClient.save(SupConst.Collections.ANZBJ_AZXXCJB, data);
		}
	}
	/**
	 * 删除安置人员信息
	 */
	public void removeOne(String id){
		User user = ssoService.getUser();
		if(user!=null) {
			dbClient.remove(SupConst.Collections.ANZBJ_AZXXCJB, new SqlDbFilter().eq("id",id));
		}
	}
	/**
	 *模态框查询安置人员姓名
	 */
	public List<BasicMap<String, Object>> findAz(){
		User user = ssoService.getUser();
		String orgid = user.getOrgid();
		List<BasicMap<String, Object>> map = new ArrayList<>();
		if(user != null){
			String sql = "SELECT ID,XM,GRLXDH FROM  JZ_JZRYJBXX where orgid='"+orgid+"'";
			 SQLAdapter adapter = new SQLAdapter(sql);
			map = dbClient.find(adapter);
		}
		return map;
	}
}
