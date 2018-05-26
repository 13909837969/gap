package com.ehtsoft.supervise.services;

import java.util.List;
import java.util.Set;

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



@Service("JzrywgxxService")
public class JzrywgxxService extends AbstractService{
	
	@Resource(name="sqlDbClient")
	private SqlDbClient dbclient;
	
	@Resource(name="SSOService")
	private SSOService service;
	
	public ResultList<BasicMap<String, Object>> find(BasicMap<String, Object> data,Paginate paginate){
		SqlDbFilter filter = toSqlFilter(data);
		String sqlstr ="select a.sqjzrybh,a.xm,a.xb,a.grlxdh,a.sfzh,a.mz,"
				+ "b.id,b.aid,b.wglx,b.wgsj,b.wgxq,b.kfz from JZ_JZRYJBXX a "
				+ "inner join JZ_SQJZRYWGXXCJB b on b.aid = a.id ";
		SQLAdapter sql = new SQLAdapter(sqlstr);
		sql.setFilter(filter);
		ResultList<BasicMap<String, Object>> list = dbclient.find(sql, paginate);
		return list;
	}
	
	//保存修改违规信息
	public void save(BasicMap<String, Object> data){
		dbclient.save(SupConst.Collections.JZ_SQJZRYWGXXCJB, data);
	}
	
	//删除违规信息
	public void deletewg(String id) {
		String sqlstr = "delete from JZ_SQJZRYWGXXCJB where id=?";
		dbclient.updateSql(sqlstr, id);
	}
	//获取服刑人员信息
	public List<BasicMap<String, Object>> findJzry(BasicMap<String,Object> query){
		User user = service.getUser();
		Set<String> orgids = user.getOrgidSet();
		//根据orgid查找数据
		String sqlstr="select id,xm,xb,grlxdh,sqjzrybh,sfzh from jz_jzryjbxx";
		SQLAdapter sql = new SQLAdapter(sqlstr);
		sql.setFilter(toSqlFilter(query).desc("cts"));
		sql.getFilter().in("orgid", orgids).eq("JCJZ", "0");
		List<BasicMap<String, Object>> list = dbclient.find(sql);
		return list;
	}
	
	
	

}
