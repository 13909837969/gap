package com.ehtsoft.azbj.services;

import java.util.ArrayList;
import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.ehtsoft.common.services.SFCodeService;
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

@Service("AzbjBjjcService")
public class AzbjBjjcService extends AbstractService {
	@Resource(name = "sqlDbClient")
	private SqlDbClient dbClient;
	@Resource(name = "SFCodeService")
	private SFCodeService sfService;
	@Resource(name = "SSOService")
	private SSOService service;

	/**
	 * 分页查询
	 * 
	 * @param query
	 * @param paginate
	 * @return
	 */
	public ResultList<BasicMap<String, Object>> findAll(BasicMap<String, Object> query, Paginate paginate) {
		SqlDbFilter filter = toSqlFilter(query);
		return dbClient.find(SupConst.Collections.ANZBJ_JCAZBJXXCJB, filter, paginate);
	}
	/**
	 * 查询所有
	 * 
	 * @param query
	 * @param paginate
	 * @return
	 */
	public ResultList<BasicMap<String, Object>> findAzbjBjjcAll(BasicMap<String, Object> query, Paginate paginate) {
		User user = service.getUser();
		if (user != null) {
			String sqlstr = "SELECT a.*,b.xm,b.id FROM anzbj_jcazbjxxcjb a LEFT JOIN jz_jzryjbxx b ON a.f_aid = b.id INNER JOIN ANZBJ_RYXJXXCJB c ON b.id = c.id";
			SqlDbFilter filter = toSqlFilter(query);
			filter.eq("b.orgid", user.getOrgid());
			filter.eq("c.jcbj", "1");
			SQLAdapter sql = new SQLAdapter(sqlstr);
			sql.setFilter(filter);
			return dbClient.find(sql, paginate);
		}
		return null;
	}
	/**
	 * 查询衔接人员相关信息
	 * @return
	 */
	public List<BasicMap<String, Object>> findJz(){
		User user = service.getUser();
		String orgid = user.getOrgid();
		List<BasicMap<String, Object>> map = new ArrayList<>();
			StringBuffer sql = new StringBuffer();
			sql.append("select a.id,a.xm,a.grlxdh from jz_jzryjbxx a INNER JOIN anzbj_ryxjxxcjb b ON a.id = b.id ");
			sql.append("LEFT JOIN ANZBJ_JCAZBJXXCJB c on c.f_aid = a.id ");
			sql.append("where b.jcbj = '0' and c.f_aid is null and a.orgid='"+orgid+"'");
			SQLAdapter adapter = new SQLAdapter(sql.toString());
			map = dbClient.find(adapter);
		return map;
	}
	/**
	 * 解除衔接人员
	 * @param data
	 */
	public void saveOne(BasicMap<String, Object> data) {
		dbClient.save(SupConst.Collections.ANZBJ_JCAZBJXXCJB, data);
		data.put("id", data.get("f_aid"));
		data.put("jcbj", "1");
		dbClient.save(SupConst.Collections.ANZBJ_RYXJXXCJB, data);
	}
	/**
	 * 删除
	 * @param data
	 */
	public void removeOne(BasicMap<String, Object> data) {
		dbClient.remove(SupConst.Collections.ANZBJ_JCAZBJXXCJB, data);
		data.put("id", data.get("f_aid"));
		data.put("jcbj", "0");
		dbClient.save(SupConst.Collections.ANZBJ_RYXJXXCJB, data);
	}
}
