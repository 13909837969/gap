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
 * @Description TODO(未成年子女信息采集表)
 * @author 马妍
 * @date 2018年5月21日
 */
@Service("AzbjWcnznxxcjbService")
public class AzbjWcnznxxcjbService extends AbstractService {
    	
	@Resource(name = "sqlDbClient")
	private SqlDbClient dbClient;
	
	@Resource(name = "SSOService")
	private SSOService ssoService;	

	/**
	 * 查询未成年子女内容
	 * 
	 * @param query
	 * @param paginate
	 * @return
	 */
	public ResultList<BasicMap<String, Object>> findAll(BasicMap<String, Object> query, Paginate paginate) {
		User user = ssoService.getUser();
		ResultList<BasicMap<String, Object>> rtn = new ResultList<>();
		if (user != null) {
			// 人员信息主表(orgid过滤当前机构数据)关联安置信息表关联已衔接的人员(jcbj=0正常衔接人员)
			String sqlstr = "select a.xm,a.xb,a.id aid,b.* from JZ_JZRYJBXX a inner join ANZBJ_WCNZNXXCJB b on a.id=b.azbjryid inner join ANZBJ_RYXJXXCJB c on a.id = c.id";
			SqlDbFilter filter = toSqlFilter(query);
			filter.eq("c.jcbj", "0");
			filter.in("a.orgid", user.getOrgidSet());
			SQLAdapter sql = new SQLAdapter(sqlstr);
			sql.setFilter(filter);
			rtn = dbClient.find(sql, paginate);
		}
		return rtn;
	}

	/**
	 * 插入与修改考核内容
	 * 
	 * @param query
	 */
	public void saveWcnxx(BasicMap<String, Object> data) {
		dbClient.save(SupConst.Collections.ANZBJ_WCNZNXXCJB, data);
	}

	/**
	 * 删除考核内容
	 * 
	 * @param id 前台获取到选中信息的id，通过对象调用removeWcnxx方法传输到后台
	 */
	public void removeWcnxx(String id) {
		dbClient.remove(SupConst.Collections.ANZBJ_WCNZNXXCJB, new SqlDbFilter().eq("id",id));
	}
}