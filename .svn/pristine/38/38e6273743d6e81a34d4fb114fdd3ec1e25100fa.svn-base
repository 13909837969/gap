package com.ehtsoft.supervise.services;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ehtsoft.common.services.SFCodeService;
import com.ehtsoft.common.services.SSOService;
import com.ehtsoft.fw.core.db.InsertOperation;
import com.ehtsoft.fw.core.db.RowDataListener;
import com.ehtsoft.fw.core.db.SQLAdapter;
import com.ehtsoft.fw.core.db.SaveOperation;
import com.ehtsoft.fw.core.db.SqlDbClient;
import com.ehtsoft.fw.core.db.SqlDbFilter;
import com.ehtsoft.fw.core.dto.BasicMap;
import com.ehtsoft.fw.core.dto.Paginate;
import com.ehtsoft.fw.core.dto.ResultList;
import com.ehtsoft.fw.core.services.AbstractService;
import com.ehtsoft.fw.core.sso.User;
import com.ehtsoft.fw.utils.DateUtil;
import com.ehtsoft.fw.utils.NumberUtil;
import com.ehtsoft.fw.utils.StringUtil;
import com.ehtsoft.fw.utils.Util;
import com.ehtsoft.im.api.ImConst;
import com.ehtsoft.supervise.api.SupConst;
import com.ehtsoft.supervise.utils.ParameterUtil;
@Service("ZzczService")
public class ZzczService extends AbstractService{
	
	@Resource(name = "sqlDbClient")
	private SqlDbClient dbClient;
	
	@Resource(name="SSOService")
	private SSOService service;
	
	@Resource(name="SFCodeService")
	private SFCodeService sfCodeService;
	/**
	 * 档案管理页面展示的矫正人员的基本信息
	 * @param query
	 * @param paginate
	 * @return
	 */
	public ResultList<BasicMap<String, Object>> findZzcz(BasicMap<String, Object> query, Paginate paginate){
		User user = service.getUser();
		ResultList<BasicMap<String, Object>> list = new ResultList<>();
		if(user!=null){
			SqlDbFilter filter = toSqlFilter(query);
			String sql = "select a.id,a.xm,a.bdqk,a.caid,a.cdate,b.xm as name "
					+ "from JZ_JZRYJBXX a left join JC_SFXZJGGZRYJBXX b on b.id=a.caid ";
			SQLAdapter sqlAdapter = new SQLAdapter(sql);
			filter.in("a.orgid", user.getOrgidSet());
			filter.eq("a.bdqk","03");
			if(query.get("czjg").equals("2")) {
				filter.eq("a.bdqk", "03");
			}else if(query.get("czjg").equals("3")){
				filter.unEq("a.bdqk", "03");
			}
			sqlAdapter.setFilter(filter);
			list =  dbClient.find(sqlAdapter, paginate,new RowDataListener() {
				@Override
				public void processData(BasicMap<String, Object> rowData) {
					rowData.put("a.cdate", StringUtil.toString(rowData.get("a.cdate")));
					rowData.put("a.cdate", DateUtil.format(rowData.get("a.cdate"), "yyyy-MM-dd"));
					
				}
			});
				
		}
		return list;
	}
	
	
	
	
}
