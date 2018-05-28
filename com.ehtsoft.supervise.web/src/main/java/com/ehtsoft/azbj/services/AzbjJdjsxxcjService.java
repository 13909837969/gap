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
import com.ehtsoft.im.services.UserinfoService;
import com.ehtsoft.supervise.api.SupConst;
/**
 * @Description 安置帮教基地信息采集信息
 * @author 李世伟
 * @date 2018年5月24日
 */
@Service("AzbjJdjsxxcjService")
public class AzbjJdjsxxcjService extends AbstractService {
	@Resource(name = "sqlDbClient")
	private SqlDbClient dbClient;
	@Resource(name = "SSOService")
	private SSOService ssoService;
	@Resource
	private UserinfoService userinfoService;
	/**
	 * 查询考核内容
	 * 
	 * @param query
	 * @param paginate
	 * @return
	 */
	public ResultList<BasicMap<String, Object>> findAll(BasicMap<String, Object> query, Paginate paginate) {
		User user = ssoService.getUser();
		ResultList<BasicMap<String, Object>> rtn = new ResultList<>();
		if (user != null) {
			String sqlstr = "select * from ANZBJ_AZBJJDJSXXCJB ";
			SqlDbFilter filter = toSqlFilter(query);
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
	public void saveOne(BasicMap<String, Object> data) {
		dbClient.save(SupConst.Collections.ANZBJ_AZBJJDJSXXCJB, data);
	}
	/**
	 * 删除考核内容
	 * 
	 * @param query
	 */
	public void removeOne(BasicMap<String, Object> data) {
		dbClient.remove(SupConst.Collections.ANZBJ_AZBJJDJSXXCJB, data);
	}
}


