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
@Service("JbxxService")
public class JbxxService extends AbstractService{
	
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
	public BasicMap<String, Object> findJbxx(String id){
		User user = service.getUser();
		BasicMap<String, Object> map = new BasicMap<>();
		if(user!=null){
			SqlDbFilter filter = new SqlDbFilter();
			String sql = "select a.id,a.SQJZRYBH,a.xm,a.xb,a.mz,a.csrq,a.hyzk,a.whcd,b.jzlb,b.ypxq,b.sqjzksrq,b.sqjzjsrq "
					+ "from JZ_JZRYJBXX a left join JZ_JZRYJBXX_JZ b on a.id=b.id ";
			SQLAdapter sqlAdapter = new SQLAdapter(sql);
			filter.eq("a.id", id);
			sqlAdapter.setFilter(filter);
			map =dbClient.findOne(sqlAdapter);
		}
		return map;
	}
}
