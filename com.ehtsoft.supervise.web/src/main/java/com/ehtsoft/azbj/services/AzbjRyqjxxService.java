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
import com.ehtsoft.im.services.UserinfoService;
import com.ehtsoft.supervise.api.SupConst;

/**
 * 人员迁居信息管理
 * @author 王世凯
 * @date 2018年5月21日
 */
@Service("AzbjRyqjxxService")
public class AzbjRyqjxxService extends AbstractService{
	
	@Resource(name = "sqlDbClient")
	private SqlDbClient dbClient;
	
	@Resource(name="SSOService")
	private SSOService ssoService; 
	
	@Resource
	private UserinfoService userinfoService;
	/**
	 * 查询内容
	 * @param data
	 * @param paginate
	 * @return
	 */
	public ResultList<BasicMap<String, Object>> findAll(BasicMap<String, Object> query,Paginate paginate){
		User user = ssoService.getUser();
		ResultList<BasicMap<String, Object>> rtn = new ResultList<>();
		if(user != null){
			String sqlstr = "SELECT A.ID aid,a.xm,b.* FROM JZ_JZRYJBXX a INNER JOIN ANZBJ_RYQJXXCJB b ON a.id = b.azbjryid INNER JOIN ANZBJ_RYXJXXCJB c ON c.id = a.id";
			SqlDbFilter filter = toSqlFilter(query);
			SQLAdapter sql = new SQLAdapter(sqlstr);
			filter.in("a.orgid", user.getOrgidSet());
			filter.eq("c.jcbj", "0");
			sql.setFilter(filter);
			rtn = dbClient.find(sql, paginate);
		}
		return rtn;
	}
	/**
	 * 插入与修改人员迁居内容
	 * @param data
	 */
	public void saveRyqj(BasicMap<String, Object> data){
		dbClient.save(SupConst.Collections.ANZBJ_RYQJXXCJB, data);
	}
	/**
	 * 删除人员迁居内容
	 * @param id 前台获取到checkbox选中的数据id进行删除
	 */
	public void removeRyqj(String id){
		dbClient.remove(SupConst.Collections.ANZBJ_RYQJXXCJB, new SqlDbFilter().eq("id",id));
	}
}
