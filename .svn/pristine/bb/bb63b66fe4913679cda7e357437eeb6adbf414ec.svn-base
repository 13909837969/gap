package com.ehtsoft.supervise.services;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

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
@Service("FxpgService")
public class FxpgService extends AbstractService{
	
	@Resource(name = "sqlDbClient")
	private SqlDbClient dbClient;
	
	@Resource(name="SSOService")
	private SSOService service;
	
	@Resource(name="SFCodeService")
	private SFCodeService sfCodeService;
	/**
	 * 报到登记查询
	 * @param query
	 * @param paginate
	 * @return
	 * @author yanyubo
	 */
	public ResultList<BasicMap<String, Object>> findAll(BasicMap<String, Object> query, Paginate paginate){
		User user = service.getUser();
		ResultList<BasicMap<String, Object>> list = new ResultList<>();
		if(user!=null){
			SqlDbFilter filter = toSqlFilter(query);
			String sql = "SELECT a.xm,a.id,a.xb,b.ypxf,b.sqjzjsrq,b.sqjzksrq,b.sqjzjsrq from jz_jzryjbxx a "
					+ "left join jz_jzryjbxx_jz b"
					+ " on a.id=b.id";
			SQLAdapter sqlAdapter = new SQLAdapter(sql);
			filter.in("a.orgid", user.getOrgidSet());
			if(Util.isNotEmpty(query.get("sqjzksrq"))) {
				filter.gtEq("b.sqjzksrq",query.get("sqjzksrq") );
			}
			if(Util.isNotEmpty(query.get("sqjzjsrq"))) {
				filter.ltEq("b.sqjzjsrq", query.get("sqjzjsrq"));
			}
			sqlAdapter.setFilter(filter);
			list =  dbClient.find(sqlAdapter, paginate);
			
			
		}
		return list;
	}
	
	
	
	
	
	
	
}
