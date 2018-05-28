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
 * 工作记录信息管理
 * @author 董育健
 * @date 2018年5月21日
 */

@Service("AzbjGzjlglService")
public class AzbjGzjlglService extends AbstractService {
	
	@Resource(name = "sqlDbClient")
	private SqlDbClient dbClient;
	
	@Resource(name = "SSOService")
	private SSOService ssoService;
	
	/**
	 * 查询工作记录
	 * @param query网页端通过name的形式对查询条件进行处理
	 * return 返回分页列表数据 
	 */
	public ResultList<BasicMap<String, Object>> findAll(BasicMap<String, Object> query, Paginate paginate) {
		User user = ssoService.getUser();
		ResultList<BasicMap<String, Object>> rtn = new ResultList<>();
		if (user != null) {
			String sqlstr = "SELECT A.ID aid,A.XM,B.* FROM JZ_JZRYJBXX A INNER JOIN ANZBJ_GZJLCJB B ON A.ID = B.AZBJRYID INNER JOIN ANZBJ_RYXJXXCJB C ON A.ID = C.ID";
			SqlDbFilter filter = toSqlFilter(query);
			filter.in("a.orgid", user.getOrgidSet());
			filter.eq("C.jcbj", "0");
			SQLAdapter sql = new SQLAdapter(sqlstr);
			sql.setFilter(filter);
			rtn = dbClient.find(sql, paginate);
		}
		return rtn;
	}
	
	/**
	 * 保存
	 * @param data 网页端提交的Form表单数据
	 */
	public void saveOne(BasicMap<String, Object> data) {
		dbClient.save(SupConst.Collections.ANZBJ_GZJLCJB, data);
	}
	
	/**
	 * 删除
	 * @param data 网页端提交保存的删除信息
	 */
	public void removeOne(BasicMap<String,Object> data) {
		dbClient.remove(SupConst.Collections.ANZBJ_GZJLCJB, data);
	}
	
}
