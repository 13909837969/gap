package com.ehtsoft.supervise.services;
/**
 * 鉴定机构信息
 */
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
import com.ehtsoft.fw.utils.StringUtil;
import com.ehtsoft.fw.utils.Util;
@Service("JdjgService")
public class JdjgService extends AbstractService{
	@Resource(name="sqlDbClient")
	private SqlDbClient dbClient;
	
	@Resource(name="SSOService")
	private SSOService ssoService;
	
	/**
	 * 鉴定机构名称 	JGMC
		许可证号	XKZH
		统一社会信用代码	XYDM
		首次获准登记日期 	SCHZDJRQ
		机构有效开始时间	YXQKSSJ
		机构有效截止时间	YXQJSSJ
		业务范围 	YWFW
		颁证机关	BZJG
		颁证日期	BZRQ
		登记管理部门机构代码 	DJGLBMDM
		登记管理部门	DJGLBM
		机构注册住所	JGZCZS
		电子邮箱 	DZYX
		联系电话	LXDH
		传真	CZ
		机构性质 	JGXZ
		法人代表姓名	FRDBXM
		法人代表性别	FRDBXB
		机构负责人姓名 	FZRXM
		机构负责人性别	FZRXB
		联系人	LXR
		机构简介	JGJJ
		机构照片路径	ZPLJ
		经度	JD
		纬度	WD
		状态	ZT
	 */
	public ResultList<BasicMap<String,Object>> findAllRy(BasicMap<String,Object> data,Paginate paginte){
		User user = ssoService.getUser();
		ResultList<BasicMap<String,Object>> list = new ResultList<>();
		SqlDbFilter filter = toSqlFilter(data);
		if(user!=null) {
			StringBuffer sqlstr = new StringBuffer("SELECT * FROM GZZHGL_JDJGMC");
			filter.in("orgid", user.getOrgidSet());
			SQLAdapter sqlAdapter = new SQLAdapter(sqlstr.toString());
			sqlAdapter.setFilter(filter);
			list = dbClient.find(sqlAdapter, paginte);
		}
		return list;
		
		
		
	}

}
