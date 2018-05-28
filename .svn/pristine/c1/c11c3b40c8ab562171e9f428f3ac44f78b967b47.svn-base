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
 * @Description 安置帮教_对话信息
 * @author 姜英卓
 * @date 2018年5月25日
 */

@Service("AzbjDhxxService")
public class AzbjDhxxService extends AbstractService {

	@Resource(name="sqlDbClient")
	SqlDbClient dbClient;
	
	@Resource(name="SSOService")
	private SSOService ssoService; 
	
	/**
	 * 安置帮教_分页列表对话信息的查询 
	 * @param query 网页端已通过name的形式对查询条件进行处理
	 * @return ResultList 返回分页列表数据
	 */
	public ResultList<BasicMap<String, Object>> findDhxx(BasicMap<String, Object> query,Paginate paginate){
		User user = ssoService.getUser();
		ResultList<BasicMap<String, Object>> list = new ResultList<>();
		if(user != null){
			String sqlstr = "select a.id aid,a.xm axm,b.id,b.orgid,b.dhbt,b.dhnr,b.hfdhdbh from jz_jzryjbxx a inner join anzbj_dhxxcjb b on a.id = b.azbjryid inner join anzbj_ryxjxxcjb c on c.id = a.id";
			SqlDbFilter filter = toSqlFilter(query);
			SQLAdapter sql = new SQLAdapter(sqlstr);
			filter.eq("b.orgid", user.getOrgid());
			filter.eq("c.jcbj", "0");
			sql.setFilter(filter);
			list= dbClient.find(sql,paginate);
		}
			return list;
	}
	
	/**
	 * 安置帮教_新增和修改对话信息 
	 * @param data 网页端提交Form表单的数据
	 */
	public void saveDhxx(BasicMap<String, Object> data){		
		dbClient.save(SupConst.Collections.ANZBJ_DHXXCJB, data);
	}
	
	/**
	 * 安置帮教_删除对话信息 
	 * @param data 网页端提交选中的删除信息
	 */
	public void removeDhxx(BasicMap<String, Object> data){
		dbClient.remove(SupConst.Collections.ANZBJ_DHXXCJB, data);
	}
}