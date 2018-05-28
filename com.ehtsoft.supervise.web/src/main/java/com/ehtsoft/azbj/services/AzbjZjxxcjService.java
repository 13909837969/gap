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
 * 安置帮教_转监信息采集
 * @author 牛新宇
 * @date 2018年5月24日
 */

@Service("AzbjZjxxcjService")
public class AzbjZjxxcjService extends AbstractService {
	
	@Resource(name = "sqlDbClient")
	private SqlDbClient dbClient;
	
	@Resource(name = "SSOService")
	private SSOService ssoService;
	
	/**
	 * 安置帮教_分页列表已转监人员的信息查询 
	 * @param query 网页端已通过name的形式对查询条件进行处理
	 * @return ResultList 返回分页列表数据
	 */
	public ResultList<BasicMap<String, Object>> findAll(BasicMap<String, Object> query, Paginate paginate) {
		User user = ssoService.getUser();
		ResultList<BasicMap<String, Object>> rtnLt = new ResultList<>();
		if (user != null) {
			//人员信息主表(orgid过滤当前机构数据)关联转监信息表关联已衔接的人员(jcbj=0正常衔接人员)
			String sqlstr = "select a.xm,a.id aid,b.* from jz_jzryjbxx a inner join anzbj_zjxxcjb b on a.id = b.azbjryid inner join anzbj_ryxjxxcjb c on a.id=c.id";
			SqlDbFilter filter = toSqlFilter(query);
			filter.eq("c.jcbj", "0");
			filter.in("a.orgid", user.getOrgidSet());
			SQLAdapter sql = new SQLAdapter(sqlstr);
			sql.setFilter(filter);
			rtnLt = dbClient.find(sql, paginate);
		}
		return rtnLt;
	}
	
	/**
	 * 安置帮教_新增和修改转监人员的信息 
	 * @param data 网页端提交Form表单的数据
	 */
	public void saveOne(BasicMap<String, Object> data) {
		dbClient.save(SupConst.Collections.ANZBJ_ZJXXCJB, data);
	}
	
	/**
	 * 安置帮教_删除转监人员的信息 
	 * @param data 网页端提交选中的删除信息
	 */
	public void removeOne(BasicMap<String, Object> data) {
		dbClient.remove(SupConst.Collections.ANZBJ_ZJXXCJB, data);
	}	
}
