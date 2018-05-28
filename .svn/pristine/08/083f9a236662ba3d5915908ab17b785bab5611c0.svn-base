package com.ehtsoft.azbj.services;

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
 * @Description 双管信息采集模块
 * @author 王维
 * @date 2018年5月21日
 */
@Service("AzbjSgjbxxService")
public class AzbjSgjbxxService extends AbstractService {
	@Resource(name="sqlDbClient")
	SqlDbClient dbClient;
	@Resource(name="SSOService")
	private SSOService ssoService; 
	/**
	 * 查询方法
	 * 方法的作用：进入页面查询人员信息;条件查询和查看信息
	 */
	public ResultList<BasicMap<String, Object>> findBjxzxx(BasicMap<String, Object> query,Paginate paginate){
		ResultList<BasicMap<String, Object>> list = new ResultList<>();
		User user = ssoService.getUser();
		if(user != null){
			SqlDbFilter filter = toSqlFilter(query);
			String sqlstr = "SELECT A.ID aid,A.XM,B.ID,B.SQYY,B.GFHTMC,B.ZFHTMC,B.GZHTMC,B.QTZMCL,B.SQSJ,B.SPZT,B.SPYJ,B.AZBJRYID FROM JZ_JZRYJBXX A INNER JOIN ANZBJ_SLGXXCJB B ON A.ID = B.AZBJRYID INNER JOIN ANZBJ_RYXJXXCJB C ON C.ID = A.ID";
			SQLAdapter sql = new SQLAdapter(sqlstr);
			/*filter.eq("b.del", 0);*/
			filter.eq("a.orgid", user.getOrgid());
			filter.eq("c.jcbj", "0");
			sql.setFilter(filter);
			list= dbClient.find(sql,paginate);
		}
			return list;
	}
	/**
	 * 新增方法
	 * 方法的作用：数据存在的时候更新，不存在的时候插入
	 */
	public void saveBjxzxx(BasicMap<String, Object> data){		
		dbClient.save(SupConst.Collections.ANZBJ_SLGXXCJB, data);
	}
	/**
	 * 删除方法
	 * 方法的作用：删除一条信息
	 */
	public void removeOne(BasicMap<String, Object> data){
		dbClient.remove(SupConst.Collections.ANZBJ_SLGXXCJB, data);
	}	
}
