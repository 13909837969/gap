package com.ehtsoft.azbj.services;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import org.springframework.stereotype.Service;

import com.ehtsoft.common.services.SSOService;
import com.ehtsoft.fw.core.db.RowDataListener;
import com.ehtsoft.fw.core.db.SQLAdapter;
import com.ehtsoft.fw.core.db.SqlDbClient;
import com.ehtsoft.fw.core.db.SqlDbFilter;
import com.ehtsoft.fw.core.dto.BasicMap;
import com.ehtsoft.fw.core.dto.Paginate;
import com.ehtsoft.fw.core.dto.ResultList;
import com.ehtsoft.fw.core.services.AbstractService;
import com.ehtsoft.fw.core.sso.User;
import com.ehtsoft.fw.utils.DateUtil;
import com.ehtsoft.im.services.UserinfoService;
import com.ehtsoft.supervise.api.SupConst;

/**
 * @Description 安置帮教管理
 * @author 顾恒维
 * @date 2018年5月23日
 *
 *
 */
@Service("AzbjNdjdxxcjbService")
public class AzbjNdjdxxcjbService extends AbstractService {

	@Resource(name = "sqlDbClient")
	private SqlDbClient dbClient;

	@Resource(name = "SSOService")
	private SSOService ssoService;
	/**
	 * 查询年度鉴定信息内容
	 * 
	 * @param query
	 * @param paginate
	 * @return
	 */
	public ResultList<BasicMap<String, Object>> findNdjdxxcjb(BasicMap<String, Object> query, Paginate paginate) {
		User user = ssoService.getUser();
		ResultList<BasicMap<String, Object>> rtn = new ResultList<>();
		if(user != null){
			String sqlstr = "SELECT a.xm,b.* from  ANZBJ_NDJDXXCJB b inner join JZ_JZRYJBXX a on a.id=b.AZBJRYID inner join  ANZBJ_RYXJXXCJB c on a.id = c.id ";
			SqlDbFilter filter = toSqlFilter(query);
			filter.eq("a.orgid", user.getOrgid());
			filter.eq("c.jcbj", "0");
			SQLAdapter sql = new SQLAdapter(sqlstr);
			sql.setFilter(filter);
			rtn = dbClient.find(sql,paginate);
		}
			
		return rtn;
	}
	/**
	 * 插入与修改年度信息鉴定内容
	 * 
	 * @param query
	 */
	public void saveOne(BasicMap<String, Object> data) {
		dbClient.save(SupConst.Collections.ANZBJ_NDJDXXCJB, data);
	}
	/**
	 * 删除年度鉴定信息内容
	 * 
	 * @param query
	 *//*
	public void removeOne(String id) {
		dbClient.remove(SupConst.Collections.ANZBJ_NDJDXXCJB, new SqlDbFilter().eq("id", id));
	}*/
	/**
	 * 删除方法 方法的作用：删除一条信息
	 */
	public void removeOne(BasicMap<String, Object> data) {
		dbClient.remove(SupConst.Collections.ANZBJ_NDJDXXCJB, data);
	}
	/**
	 * 查询年度鉴定信息相关信息
	 * 
	 * @return
	 */
	public List<BasicMap<String, Object>> findJz() {
		User user = ssoService.getUser();
		String orgid = user.getOrgid();
		List<BasicMap<String, Object>> map = new ArrayList<>();
		if (user != null) {
			String sql = "SELECT a.id,a.xm,a.grlxdh FROM JZ_JZRYJBXX a INNER JOIN ANZBJ_RYXJXXCJB c ON c.id = a.id where a.orgid='"+orgid+"'"+"and c.jcbj = '0'";
			SQLAdapter adapter = new SQLAdapter(sql);
			map = dbClient.find(adapter);
		}
		return map;
	}
}