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
 * @Description 双管信息采集模块
 * @author 王维
 * @date 2018年5月21日
 */
@Service("AzbjSgjbxxService")
public class AzbjSgjbxxService extends AbstractService{
	
	@Resource(name="sqlDbClient")
	SqlDbClient dbClient;
	
	@Resource(name="SSOService")
	private SSOService ssoService;
	
	/**
	 * 查询方法
	 * @param query 网页端已通过name的形式对查询条件进行处理
	 * @return ResultList 返回分页列表数据
	 */
	public ResultList<BasicMap<String, Object>> findBjxzxx(BasicMap<String, Object> query,Paginate paginate){
		ResultList<BasicMap<String, Object>> list = new ResultList<>();
		User user = ssoService.getUser();
		if(user != null){
			SqlDbFilter filter = toSqlFilter(query);
			String sqlstr = "select a.id aid,a.xm,b.id,b.sqyy,b.gfhtmc,b.zfhtmc,b.gzhtmc,b.qtzmcl,b.sqsj,b.spzt,b.spyj,b.azbjryid from jz_jzryjbxx a inner join anzbj_slgxxcjb b on a.id = b.azbjryid inner join anzbj_ryxjxxcjb c on c.id = a.id";
			SQLAdapter sql = new SQLAdapter(sqlstr);
			filter.eq("a.orgid", user.getOrgid());
			filter.eq("c.jcbj", "0");
			sql.setFilter(filter);
			list= dbClient.find(sql,paginate);
		}
		return list;
	}

	/**
	 * 新增修改方法
	 * @param data 通过网页端传来相关数据，对信息进行操作
	 */
	public void saveBjxzxx(BasicMap<String, Object> data){		
		dbClient.save(SupConst.Collections.ANZBJ_SLGXXCJB, data);
	}
	
	/**
	 * 删除方法
	 * @param data 通过网页端传来相关数据，对信息进行删除
	 */
	public void removeOne(BasicMap<String, Object> data){
		dbClient.remove(SupConst.Collections.ANZBJ_SLGXXCJB, data);
	}	
}
