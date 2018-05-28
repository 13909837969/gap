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
import com.ehtsoft.fw.core.services.AbstractService;
import com.ehtsoft.fw.core.sso.User;

/**
 * 安置帮教_封装安置模块下公用方法类
 * @author 苗辉  
 * @date 2018年5月27日
 */

@Service("AzbjCommonService")
public class AzbjCommonService extends AbstractService {
	
	@Resource(name = "sqlDbClient")
	private SqlDbClient dbClient;
	
	@Resource(name = "SSOService")
	private SSOService ssoService;
	
	/**
	 * 安置帮教_查询已安置帮教已衔接人员的信息
	 * @return List 返回所有已安置人员的信息
	 */
	public List<BasicMap<String, Object>> findYxjry() {
		User user = ssoService.getUser();
		List<BasicMap<String, Object>> rtnLt = new ArrayList<>();
		if (user != null) {
			//人员信息主表(orgid过滤当前机构数据)关联已衔接的人员(jcbj=0正常衔接人员)
			String sqlStr = "select a.id,a.xm,a.grlxdh from jz_jzryjbxx a inner join anzbj_ryxjxxcjb c on a.id=c.id ";
			SqlDbFilter sqlFilter = new SqlDbFilter();			
			sqlFilter.eq("c.jcbj", "0");
			sqlFilter.in("a.orgid", user.getOrgidSet());
			SQLAdapter sqlAdapter = new SQLAdapter(sqlStr);
			sqlAdapter.setFilter(sqlFilter);
			rtnLt = dbClient.find(sqlAdapter);
		}
		return rtnLt;
	}
}
