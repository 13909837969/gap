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
import com.ehtsoft.supervise.api.SupConst;

/**
 * @Description 对话信息
 * @author 姜英卓
 * @date 2018年5月25日
 */
@Service("AzbjDhxxService")
public class AzbjDhxxService extends AbstractService {

	@Resource(name="sqlDbClient")
	SqlDbClient dbClient;
	
	@Resource(name="SSOService")
	private SSOService ssoService; 
	
	/**
	 * 新增方法
	 * 方法的作用：数据存在的时候更新，不存在的时候插入
	 */
	public void saveDhxx(BasicMap<String, Object> data){		
		dbClient.save(SupConst.Collections.ANZBJ_DHXXCJB, data);
	}
	
	/**
	 * 删除方法
	 * 方法的作用：删除一条信息
	 */
	public void removeOne(BasicMap<String, Object> data){
		dbClient.remove(SupConst.Collections.ANZBJ_DHXXCJB, data);
	}
	
	/**
	 * 查询方法
	 * 方法的作用：进入页面查询人员信息;条件查询和查看信息
	 */
	public ResultList<BasicMap<String, Object>> findDhxx(BasicMap<String, Object> query,Paginate paginate){
		User user = ssoService.getUser();
		ResultList<BasicMap<String, Object>> list = new ResultList<>();
		if(user != null){
			String sqlstr = "SELECT A.ID AID,A.XM AXM,B.ID,B.ORGID,B.DHBT,B.DHNR,B.HFDHDBH FROM JZ_JZRYJBXX A INNER JOIN ANZBJ_DHXXCJB B ON A.ID = B.AZBJRYID INNER JOIN ANZBJ_RYXJXXCJB C ON C.ID = A.ID";
			SqlDbFilter filter = toSqlFilter(query).eq("b.del", 0);
			SQLAdapter sql = new SQLAdapter(sqlstr);
			filter.eq("b.del", 0);
			filter.eq("b.orgid", user.getOrgid());
			filter.eq("c.jcbj", "0");
			sql.setFilter(filter);
			list= dbClient.find(sql,paginate);
		}
			return list;
	}
	
	/**
	 * 查询方法
	 * 方法的作用：获取帮教人员
	 */
	public List<BasicMap<String, Object>> findJz(String lvl){
		User user = ssoService.getUser();
		String orgid = user.getOrgid();
		List<BasicMap<String, Object>> map = new ArrayList<>();
		if(user != null){
			String sql = "SELECT A.ID,A.XM,A.GRLXDH FROM JZ_JZRYJBXX A INNER JOIN ANZBJ_RYXJXXCJB C ON A.ID=C.ID  WHERE A.orgid='"+orgid+"'"+"AND C.JCBJ='0'";
			 SQLAdapter adapter = new SQLAdapter(sql);
			map = dbClient.find(adapter);
		}
		return map;
	}
}