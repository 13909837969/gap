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
import com.ehtsoft.fw.utils.StringUtil;
import com.ehtsoft.fw.utils.Util;

/**
 * 公正机构信息表
 * @author 李恒
 *
 */

@Service("GzryxxbService")
public class GzryxxbService  extends AbstractService{
	@Resource(name="sqlDbClient")
	private SqlDbClient dbClient;
	
	@Resource(name="SSOService")
	private SSOService ssoService;
	
	/**
	  表来源--->【GZZHGL_GZRYJBXX】
	*人员编码	GZYBM
	*姓名	XM
	*姓名汉语拼音	XMHYPY
	*性别	XB
	*出生日期	CSRQ
	*公民身份号码	GMSFHM
	*民族	MZ
	*政治面貌	ZZMM
	*照片	ZP
	*毕业院校	BYYX
	*毕业时间	BYSJ
	*学历	XL
	*学位	XW
	*专业	ZY
	*所属机构编码	SSJGBM
	*职务	ZW
	*协会职务	XHZW
	*人员编制	RYBZ
	*参加工作时间	CJGZSJ
	*专业职称	ZYZC
	*执业证书编码	ZYZSBM
	*执业证书颁发时间	ZYZSBFSJ
	*是否取得涉外公证资格	SFQDSWGZZG
	*涉外公证资格取得时间	SWGZZGQDSJ
	*资格证号	ZGZH
	*考核任职资格	KHRZZG
	*联系电话	LXDH
	*电子邮箱	DZYX
	*住址	ZZ
	 */
	//设置权限查询数据库需要的字段
	public ResultList<BasicMap<String,Object>> findAllRy(BasicMap<String,Object> data,Paginate paginte){
		User user = ssoService.getUser();
		ResultList<BasicMap<String,Object>> list = new ResultList<>();
		SqlDbFilter filter = new SqlDbFilter();
		if(user!=null) {
			StringBuffer sqlstr = new StringBuffer("SELECT * FROM GZZHGL_GZRYJBXX ");
			filter.eq("orgid",user.getOrgid());//按照权限获取数据
			if(Util.isNotEmpty(data.get("gzybm"))) {
				filter.like("gzybm", data.get("gzybm").toString());
			}
			if(Util.isNotEmpty(data.get("xm"))) {
				filter.like("xm", data.get("xm").toString());
			}
			if(Util.isNotEmpty(data.get("xb"))) {
				filter.like("xb", data.get("xb").toString());
			}
			if(Util.isNotEmpty(data.get("mz"))) {
				filter.like("mz", data.get("mz").toString());
			}
			if(Util.isNotEmpty(data.get("gmsfhm"))) {
				filter.like("gmsfhm", data.get("gmsfhm").toString());
			}
			if(Util.isNotEmpty(data.get("byyx"))) {
				filter.like("byyx", data.get("byyx").toString());
			}
			if(Util.isNotEmpty(data.get("xw"))) {
				filter.like("xw", data.get("xw").toString());
			}
			if(Util.isNotEmpty(data.get("ssjgbm"))) {
				filter.like("ssjgbm", data.get("ssjgbm").toString());
			}
			if(Util.isNotEmpty(data.get("zzmm"))) {
				filter.like("zzmm", data.get("zzmm").toString());
			}
			SQLAdapter sqlAdapter = new SQLAdapter(sqlstr.toString());
			sqlAdapter.setFilter(filter);
			list = dbClient.find(sqlAdapter, paginte);
		}
		return list;
	}
}
