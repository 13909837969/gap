package com.ehtsoft.supervise.services;

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
import com.ehtsoft.fw.utils.DateUtil;
import com.ehtsoft.fw.utils.Util;
@Service("JdryxxService")
public class JdryxxService extends AbstractService{
	@Resource(name="sqlDbClient")
	private SqlDbClient dbClient;
	
	@Resource(name="SSOService")
	private SSOService ssoService;
	/**
	 * 鉴定人姓名 	XM
		身份证号 	SFZH
		执业证号 	ZYZH
		性别（GB） 	XB
		民族（GB） 	MZ
		学历（GB） 	XL
		职称 	ZC
		政治面貌 	ZZMM
		联系电话 	LXDH
		邮箱 	YX
		执业证有效开始日期	YXKSSJ
		执业证有效截止日期 	YXJSSJ
		毕业院校 	BYYX
		执业方式	ZYFS
		照片路径 	ZP
		简介 	JJ
		执业状态	ZYZT
		执业范围	ZYFW

	 */
	
	public ResultList<BasicMap<String,Object>> findAllRy(BasicMap<String,Object> data,Paginate paginte){
		User user = ssoService.getUser();
		ResultList<BasicMap<String,Object>> list = new ResultList<>();
		SqlDbFilter filter = toSqlFilter(data);
//		filter.eq("orgid",user.getOrgid());//按照权限获取数据
		if(user!=null) {
			
			StringBuffer sqlstr = new StringBuffer("SELECT * FROM GZZHGL_JDRXX ");
			filter.in("orgid", user.getOrgidSet());
			SQLAdapter sqlAdapter = new SQLAdapter(sqlstr.toString());
			sqlAdapter.setFilter(filter);
			list = dbClient.find(sqlAdapter, paginte);
		}
		return list;
	}
	
}
