package com.ehtsoft.supervise.services;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ehtsoft.fw.utils.StringUtil;
import com.ehtsoft.common.services.SSOService;
import com.ehtsoft.fw.core.db.RowDataListener;
import com.ehtsoft.fw.core.db.SQLAdapter;
import com.ehtsoft.fw.core.db.SqlDbClient;
import com.ehtsoft.fw.core.db.SqlDbFilter;
import com.ehtsoft.fw.core.dto.BasicMap;
import com.ehtsoft.fw.core.dto.Paginate;
import com.ehtsoft.fw.core.services.AbstractService;

/**
 * 人民调解-书面调解
 * @author maruimin
 *
 */
@Service("RmtjSmtjService")
public class RmtjSmtjService extends AbstractService{
	@Resource(name="sqlDbClient")
	private SqlDbClient dbClient;
	@Resource(name="SSOService")
	private SSOService service;
	
	
	/**
	 * 获取所有书面调解案件信息
	 * @param query
	 * @param paginate
	 * @return {
	 *       SLRQ：受理日期
	 *       JFLB：纠纷类别
	 *       TJRQ：调节日期
	 *    }
	 */
	public List<BasicMap<String,Object>> findList(BasicMap<String,Object> query,Paginate paginate){
		List<BasicMap<String,Object>> list=new ArrayList<>();
		String sql="select * from RMTJ_TJAJXX where TJLX='2'";
		SQLAdapter adapter=new SQLAdapter(sql);
		SqlDbFilter filter=new SqlDbFilter();
		filter.like("JFLB",StringUtil.toEmptyString(query.get("jflb")))
		      .eq("SLRQ", StringUtil.toEmptyString(query.get("slrq")));
		adapter.setFilter(filter);
		list=dbClient.find(adapter,paginate,new RowDataListener() {
			@Override
			public void processData(BasicMap<String, Object> rowData) {
				String sql="select count(JFLB) as count,jflb from RMTJ_TJAJXX where TJLX='2' group by jflb";
				SQLAdapter adapter=new SQLAdapter(sql);
				List<BasicMap<String,Object>> result=dbClient.find(adapter);
				//rowData.put("count", result.get("count"));
			}
		}).getRows();
		return list;
	}
	
	
	
	
	

}
