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

@Service("RmtjyjbxxService")
public class RmtjyjbxxService  extends AbstractService{
	@Resource(name="sqlDbClient")
	private SqlDbClient dbClient;
	
	@Resource(name="SSOService")
	private SSOService ssoService;
	
	/**
	  表来源--->【RMTJ_JWHJBXX】
	*调委会编码	TWHBM
	*调委会名称	TWHMC
	*调委会照片	TWHZP
	*调委会类型	TWHLX
	*行专调委会类型	HZTWHLX
	*专职调解员人数	ZZTJYRS
	*兼职调解员人数	JZTJYRS
	*联系电话	LXDH
	*传真号码	CZHM
	*联系地址	LXDZ
	*邮政编码	YZBM
	*电子邮箱	DZYX
	*负责人	FZR
	*成立日期	CLRQ
	*信息采集日期	XXCJRQ
	*所属区域	SUQY
	*纬度	LAT
	*经度	LNG

	 */
	//设置权限查询数据库需要的字段
	public ResultList<BasicMap<String,Object>> findAllRy(BasicMap<String,Object> data,Paginate paginte){
		User user = ssoService.getUser();
		ResultList<BasicMap<String,Object>> list = new ResultList<>();
		SqlDbFilter filter = new SqlDbFilter();
//		filter.eq("orgid",user.getOrgid());//按照权限获取数据
		if(user!=null) {
			StringBuffer sqlstr = new StringBuffer("SELECT a.TJYBM,a.TWHID,a.TWHBM,a.TJGZSBM,a.xm,a.XB,a.SFZHM,a.CSNY,a.MZ,a.XL,a.SXZY,a.SSDW,a.JBQTSF,a.TWHZW,a.CSRMTJGZSNX,a.ZJZ,a.SFZFGMFW,a.XGGZZSCB,a.YGSWQK,a.LXDH,a.SJ,a.DZYX,a.CSFS,a.ZZMM,a.HYZK,a.SFZY,a.ZGZC,a.LXDZ,a.GRJJ,b.id "
					+ "FROM RMTJ_TJYJBXX a "
					+ "LEFT JOIN  RMTJ_JWHJBXX b ON b.id= a.TWHID");
			
			if(Util.isNotEmpty(data.get("a.TWHBM"))) {
				filter.like("a.TWHBM", data.get("a.TWHBM").toString());
			}
			if(Util.isNotEmpty(data.get("a.TJGZSBM,"))) {
				filter.like("a.TJGZSBM,", data.get("a.TJGZSBM,").toString());
			}
			if(Util.isNotEmpty(data.get("a.xm"))) {
				filter.like("a.xm", data.get("a.xm").toString());
			}
			if(Util.isNotEmpty(data.get("a.sfzhm"))) {
				filter.like("a.sfzhm", data.get("a.sfzhm").toString());
			}
			if(Util.isNotEmpty(data.get("a.twhzw"))) {
				filter.like("a.twhzw", data.get("a.twhzw").toString());
			}
			if(Util.isNotEmpty(data.get("a.lxdh"))) {
				filter.like("a.lxdh", data.get("a.lxdh").toString());
			}
			if(Util.isNotEmpty(data.get("a.xw"))) {
				filter.like("a.xw", data.get("a.xw").toString());
			}
			if(Util.isNotEmpty(data.get("a.sfzy"))) {
				filter.like("a.sfzy", data.get("a.sfzy").toString());
			}
			if(Util.isNotEmpty(data.get("a.zgzc"))) {
				filter.like("a.zgzc", data.get("a.zgzc").toString());
			}
			SQLAdapter sqlAdapter = new SQLAdapter(sqlstr.toString());
			sqlAdapter.setFilter(filter);
			list = dbClient.find(sqlAdapter, paginte);
		}
		return list;
	}
}
