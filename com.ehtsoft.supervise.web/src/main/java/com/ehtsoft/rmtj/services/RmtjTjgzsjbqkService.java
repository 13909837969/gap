package com.ehtsoft.rmtj.services;
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
 * 人民调解工作室基本情况信息
 * 
 * @author 董育健
 * @date 2018年5月25日
 */
@Service("RmtjTjgzsjbqkService")
public class RmtjTjgzsjbqkService extends AbstractService {
	@Resource(name = "sqlDbClient")
	private SqlDbClient dbClient;
	@Resource(name = "SSOService")
	private SSOService ssoService;
	@Resource
	private UserinfoService userinfoService;
	/**
	 * 查询工作基本情况信息
	 */
	public ResultList<BasicMap<String, Object>> findAll(BasicMap<String, Object> query, Paginate paginate) {
//		User user = ssoService.getUser();
//		ResultList<BasicMap<String, Object>> rtn = new ResultList<>();
//		if (user != null) {
			String sqlstr = "SELECT * FROM RMTJ_TJGZSJBQK";
			SqlDbFilter filter = toSqlFilter(query);
//			filter.eq("C.jcbj", "0");
			SQLAdapter sql = new SQLAdapter(sqlstr);
			sql.setFilter(filter);
//			filter.in("a.orgid", user.getOrgidSet());
//			rtn = dbClient.find(sql, paginate);
//		}
		return dbClient.find(sql, paginate);
	}
	/**
	 * 保存
	 */
	public void saveOne(BasicMap<String, Object> data) {
//		User user = ssoService.getUser();
//		if (user != null) {
			dbClient.save(SupConst.Collections.RMTJ_TJGZSJBQK, data);
//		}
	}
	/**
	 * 删除
	 */
	public void removeOne(String id) {
//		User user = ssoService.getUser();
//		if (user != null) {
			dbClient.remove(SupConst.Collections.RMTJ_TJGZSJBQK, new SqlDbFilter().eq("id", id));
//		}
	}
	/**
	 * 查询所属调委会编码
	 */
	public List<BasicMap<String, Object>> findWyhbm() {
		User user = ssoService.getUser();
//		String orgid = user.getOrgid();
		List<BasicMap<String, Object>> map = new ArrayList<>();
		if (user != null) {
			String sql = "select A.ID,A.TWHBM FROM RMTJ_JWHJBXX A";
			SQLAdapter adapter = new SQLAdapter(sql);
			map = dbClient.find(adapter);
		}
		return map;
	}
	
}
