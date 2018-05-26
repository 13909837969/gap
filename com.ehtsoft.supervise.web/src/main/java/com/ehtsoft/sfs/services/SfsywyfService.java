package com.ehtsoft.sfs.services;

import java.util.List;
import java.util.Set;

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
import com.ehtsoft.supervise.api.SupConst;

@Service("SfsywyfService")
public class SfsywyfService extends AbstractService {
	
	@Resource(name="sqlDbClient")
	private SqlDbClient dbClient;
	
	@Resource(name="SSOService")
	private SSOService service;
	
	
	//查询所有用房信息
	public ResultList<BasicMap<String, Object>> find(BasicMap<String, Object> query,Paginate paginate){
		User user = new User();
		SqlDbFilter filter = toSqlFilter(query);
		//String sqlstr = "select * from SFS_SFSYWYFXXB";
		String sqlstr="select a.*,b.id as jgid,b.jgbm,b.jgmc from sfs_sfsywyfxxb a inner join JC_SFXZJGJBXX b on a.s_id = b.id";
		SQLAdapter sql = new SQLAdapter(sqlstr);
		sql.setFilter(filter);
		ResultList<BasicMap<String, Object>> list = dbClient.find(sql,paginate, new RowDataListener() {
			@Override
			public void processData(BasicMap<String, Object> rowData) {
				rowData.put("jcsj", DateUtil.format(rowData.get("jcsj"), "yyyy-MM-dd"));
				
			}
		});

		return list;
	}
	
	//保存业务用房信息
	public void save(BasicMap<String, Object> data) {
		
		dbClient.save(SupConst.Collections.SFS_SFSYWYFXXB, data);
	}
	
	//删除一条数据
	public void deleteOne(String id) {
		String sqlstr="delete from SFS_SFSYWYFXXB where id=?";
		dbClient.updateSql(sqlstr, id);
	}
	
	//查询司法所编码
	public List<BasicMap<String, Object>> findSfs(BasicMap<String, Object> query){
		User user = service.getUser();
		SqlDbFilter filter =toSqlFilter(query);
		
		//根据orgid查找数据
		String sqlstr = "select id,jgmc,jgbm from JC_SFXZJGJBXX";
		filter.in("id", user.getOrgidSet());
		SQLAdapter sql = new SQLAdapter(sqlstr);
		sql.setFilter(filter);
		List<BasicMap<String, Object>> list = dbClient.find(sql);
		return list;
	}

}
