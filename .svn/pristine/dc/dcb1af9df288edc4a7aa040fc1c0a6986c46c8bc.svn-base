package com.ehtsoft.supervise.services;

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
import com.ehtsoft.supervise.api.SupConst;
@Service("SqjzryztService")
public class SqjzryztService extends AbstractService{
	
	@Resource(name="sqlDbClient")
	private SqlDbClient dbClient;
	
	@Resource(name="SSOService")
	private SSOService ssoService;
	/**
	 * 查询社区矫正人员状态信息
	 * @param query
	 * @param paginate
	 * @return{"":"","":"","":""}
	 */
	public ResultList<BasicMap<String, Object>> findAll(BasicMap<String, Object> query,Paginate paginate){
		User user = ssoService.getUser();
		ResultList<BasicMap<String, Object>> map = new ResultList<>();
		if(user != null){
			SqlDbFilter filter = toSqlFilter(query);
			String sql = "select a.xm,a.xb,a.sfzh,b.* from JZ_JZRYJBXX a inner join JZ_SQJZRYZTXXCJB b on a.id=b.f_aid";
			SQLAdapter adapter = new SQLAdapter(sql);
			filter.in("a.orgid", user.getOrgidSet());
			adapter.setFilter(filter);
			map = dbClient.find(adapter, paginate);
		}
		return map;
	}
	/**
	 * 新增或者修改社区矫正人员状态信息
	 * @param data
	 */
	public void saveOne(BasicMap<String, Object> data){
		dbClient.save(SupConst.Collections.JZ_SQJZRYZTXXCJB, data);
		BasicMap<String, Object> map = new BasicMap<>();
		map.put("jglx", data.get("gljb"));
		map.put("id", data.get("f_aid"));
		//更新服刑人员基本信息的矫管类型
		dbClient.save(SupConst.Collections.JZ_JZRYJBXX, map);
	}
	/**
	 * 删除一条社区矫正人员状态信息
	 * @param id
	 */
	public void removeOne(String id){
		dbClient.remove(SupConst.Collections.JZ_SQJZRYZTXXCJB, new SqlDbFilter().eq("id", id));
	}
	/**
	 * 查询矫正人员相关信息
	 * @return
	 */
	public List<BasicMap<String, Object>> findJz(){
		User user = ssoService.getUser();
		String orgid = user.getOrgid();
		List<BasicMap<String, Object>> map = new ArrayList<>();
		if(user != null){
			String sql = "select id,xm,jglx from JZ_JZRYJBXX where orgid='"+orgid+"'";
			 SQLAdapter adapter = new SQLAdapter(sql);
			map = dbClient.find(adapter);
		}
		return map;
	}
}
