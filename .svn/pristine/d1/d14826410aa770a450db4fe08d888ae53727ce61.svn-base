package com.ehtsoft.supervise.services;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ehtsoft.fw.core.db.RowDataListener;
import com.ehtsoft.fw.core.db.SQLAdapter;
import com.ehtsoft.fw.core.db.SqlDbClient;
import com.ehtsoft.fw.core.dto.BasicMap;
import com.ehtsoft.fw.core.dto.Paginate;
import com.ehtsoft.fw.core.dto.ResultList;
import com.ehtsoft.fw.core.services.AbstractService;

@Service("JzryService")
public class JzryService extends AbstractService{
	
	@Resource(name="sqlDbClient")
	SqlDbClient dbClient;
	
	/**
	 * 查询矫正人员信息-----发送通知
	 * @param query
	 * @param paginate
	 * @return
	 */
	public ResultList<BasicMap<String,Object>> findPerson(BasicMap<String, Object> query,Paginate paginate){
		ResultList<BasicMap<String,Object>> list = new ResultList<>();
		String sqlstr = "select id,xm,grlxdh,bdqk from jz_jzryjbxx";
		SQLAdapter sqlAdapter = new SQLAdapter(sqlstr);
		sqlAdapter.setFilter(toSqlFilter(query));
		list = dbClient.find(sqlAdapter, paginate, new RowDataListener() {
			@Override
			public void processData(BasicMap<String, Object> rowData) {
				
			}
		});
		return list;
	}
}
