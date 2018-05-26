package com.ehtsoft.supervise.services;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ehtsoft.fw.core.db.SQLAdapter;
import com.ehtsoft.fw.core.db.SqlDbClient;
import com.ehtsoft.fw.core.dto.BasicMap;
import com.ehtsoft.fw.core.dto.Paginate;
import com.ehtsoft.fw.core.dto.ResultList;
import com.ehtsoft.fw.core.services.AbstractService;
import com.ehtsoft.supervise.api.SupConst;

/**
 * 矫正人员信息管理
 * @author zhangsf
 */
@Service("YwglJzryxxService")
public class YwglJzryxxService extends AbstractService{
	
	@Resource(name="sqlDbClient")
	SqlDbClient dbClient;

	public ResultList<BasicMap<String,Object>> find_jg(BasicMap<String,Object> query,Paginate paginate){
		String sqlstr = "SELECT ID,JGMC,region_name FROM JC_SFXZJGJBXX a inner join SYS_REGION b ON a.regionid=b.regionid";
		SQLAdapter sql = new SQLAdapter(sqlstr);
		sql.setFilter(toSqlFilter(query).asc("a.regionid"));
		return dbClient.find(sql,paginate);
	}
	
	public ResultList<BasicMap<String,Object>> find_ry(BasicMap<String,Object> query,Paginate paginate){
		String sqlstr = "SELECT A.*,B.jgmc FROM JZ_JZRYJBXX A INNER JOIN JC_SFXZJGJBXX B ON A.ORGID = B.ID";
		SQLAdapter sql = new SQLAdapter(sqlstr);
		sql.setFilter(toSqlFilter(query));
		return dbClient.find(sql,paginate);
	}
	
	public void deleteOne(BasicMap<String, Object> query){
		dbClient.remove(SupConst.Collections.JZ_JZRYJBXX,query);
	}

}
