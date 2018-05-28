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
/**
 * 安置帮教_帮教解除
 * @author 宋占成
 * @data 2018年5月28日
 */
@Service("AzbjBjjcService")
public class AzbjBjjcService extends AbstractService {
	
	@Resource(name = "sqlDbClient")
	private SqlDbClient dbClient;
	
	@Resource(name = "SFCodeService")
	private SFCodeService sfService;
	
	@Resource(name = "SSOService")
	private SSOService service;

	/**
	 * 安置帮教_分页列表衔接人员的信息查询 
	 * @param query 网页端已通过name的形式对查询条件进行处理
	 * @return ResultList 返回分页列表数据
	 */
	public ResultList<BasicMap<String, Object>> findAzbjBjjcAll(BasicMap<String, Object> query, Paginate paginate) {
		User user = service.getUser();
		ResultList<BasicMap<String, Object>> ryxx = new ResultList<>();
		if (user != null) {
			String sqlstr = "select a.*,b.xm,b.id from anzbj_jcazbjxxcjb a left join jz_jzryjbxx b on a.f_aid = b.id inner join anzbj_ryxjxxcjb c on b.id = c.id";
			SqlDbFilter filter = toSqlFilter(query);
			filter.eq("b.orgid", user.getOrgid());
			filter.eq("c.jcbj", "1");
			SQLAdapter sql = new SQLAdapter(sqlstr);
			sql.setFilter(filter);
			ryxx = dbClient.find(sql, paginate);
		}
		return ryxx;
	}
	/**
	 * 安置帮教_查询衔接人员相关信息
	 * @return List<BasicMap<String, Object>>返回衔接人员信息
	 */
	public List<BasicMap<String, Object>> findJz(){
		User user = service.getUser();
		String orgid = user.getOrgid();
		List<BasicMap<String, Object>> map = new ArrayList<>();
			StringBuffer sql = new StringBuffer();
			sql.append("select a.id,a.xm,a.grlxdh from jz_jzryjbxx a inner join anzbj_ryxjxxcjb b on a.id = b.id ");
			sql.append("left join anzbj_jcazbjxxcjb c on c.f_aid = a.id ");
			sql.append("where b.jcbj = '0' and c.f_aid is null and a.orgid='"+orgid+"'");
			SQLAdapter adapter = new SQLAdapter(sql.toString());
			map = dbClient.find(adapter);
		return map;
	}
	/**
	 * 解除衔接人员
	 * @param data 网页端通过name形式传过来人员ID解除信息，同时修改衔接信息
	 */
	public void saveOne(BasicMap<String, Object> data) {
		dbClient.save(SupConst.Collections.ANZBJ_JCAZBJXXCJB, data);
		data.put("id", data.get("f_aid"));
		data.put("jcbj", "1");
		dbClient.save(SupConst.Collections.ANZBJ_RYXJXXCJB, data);
	}
	/**
	 * 删除解除衔接人员
	 * @param data 通过网页端返回数据进行删除解除帮教，同时修改衔接信息
	 */
	public void removeOne(BasicMap<String, Object> data) {
		dbClient.remove(SupConst.Collections.ANZBJ_JCAZBJXXCJB, data);
		data.put("id", data.get("f_aid"));
		data.put("jcbj", "0");
		dbClient.save(SupConst.Collections.ANZBJ_RYXJXXCJB, data);
	}
}
