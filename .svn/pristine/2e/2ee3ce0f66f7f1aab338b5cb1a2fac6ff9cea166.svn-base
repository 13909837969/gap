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
 * @Description 安置帮教_帮教小组信息
 * @author 姜英卓
 * @date 2018年5月21日
 */
@Service("AzbjBjxzxxService")
public class AzbjBjxzxxService extends AbstractService {
	
	@Resource(name = "sqlDbClient")
	SqlDbClient dbClient;

	@Resource(name = "SSOService")
	private SSOService ssoService;

	/**
	 * 安置帮教_新增和修改帮教小组的信息 
	 * @param data 网页端提交Form表单的数据
	 */
	public void saveBjxzxx(BasicMap<String, Object> data) {
		dbClient.save(SupConst.Collections.ANZBJ_BJXZXXCJB, data);
	}

	/**
	 * 安置帮教_删除帮教小组的信息 
	 * @param data 网页端提交选中的删除信息
	 */
	public void removeBjxzxx(BasicMap<String, Object> data) {
		dbClient.remove(SupConst.Collections.ANZBJ_BJXZXXCJB, data);
	}

	/**
	 * 安置帮教_分页列表帮教小组信息查询 
	 * @param query 网页端已通过name的形式对查询条件进行处理
	 * @return ResultList 返回分页列表数据
	 */
	public ResultList<BasicMap<String, Object>> findBjxzxx(BasicMap<String, Object> query, Paginate paginate) {
		ResultList<BasicMap<String, Object>> list = new ResultList<>();
		User user = ssoService.getUser();
		if (user != null) {
			SqlDbFilter filter = toSqlFilter(query);
			String sqlstr = "SELECT A.ID AID,A.XM AXM,B.ID,B.ORGID,B.XM,B.XB,B.NL,B.GZDWJZW,B.DH FROM JZ_JZRYJBXX A INNER JOIN ANZBJ_BJXZXXCJB B ON A.ID = B.AZBJRYID INNER JOIN ANZBJ_RYXJXXCJB C ON C.ID = A.ID";
			SQLAdapter sql = new SQLAdapter(sqlstr);
			filter.eq("b.orgid", user.getOrgid());
			filter.eq("c.jcbj", "0");
			sql.setFilter(filter);
			list = dbClient.find(sql, paginate);
		}
		return list;
	}
}