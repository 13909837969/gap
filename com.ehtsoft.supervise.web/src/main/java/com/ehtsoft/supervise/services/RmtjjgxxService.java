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

@Service("RmtjjgxxService")
public class RmtjjgxxService extends AbstractService{
	@Resource(name="sqlDbClient")
	private SqlDbClient dbClient;
	
	@Resource(name="SSOService")
	private SSOService ssoService;
	/**
	 * 调委会编码	TWHBM
		调委会名称	TWHMC
		调委会照片	TWHZP
		调委会类型	TWHLX
		行专调委会类型	HZTWHLX
		专职调解员人数	ZZTJYRS
		兼职调解员人数	JZTJYRS
		联系电话	LXDH
		传真号码	CZHM
		联系地址	LXDZ
		邮政编码	YZBM
		电子邮箱	DZYX
		负责人	FZR
		成立日期	CLRQ
		信息采集日期	XXCJRQ
		所属区域	SUQY
		纬度	LAT
		经度	LNG
	 */
	
	public ResultList<BasicMap<String,Object>> findAllRy(BasicMap<String,Object> data,Paginate paginte){
		User user = ssoService.getUser();
		ResultList<BasicMap<String,Object>> list = new ResultList<>();
		SqlDbFilter filter = toSqlFilter(data);
//		filter.eq("orgid",user.getOrgid());//按照权限获取数据
		if(user!=null) {
			StringBuffer sqlstr = new StringBuffer("SELECT * FROM RMTJ_JWHJBXX ");
			filter.in("orgid", user.getOrgidSet());
			SQLAdapter sqlAdapter = new SQLAdapter(sqlstr.toString());
			sqlAdapter.setFilter(filter);
			list = dbClient.find(sqlAdapter, paginte);
		}
		return list;
	}
}
