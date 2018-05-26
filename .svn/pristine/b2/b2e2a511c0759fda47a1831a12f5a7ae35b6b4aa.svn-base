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

@Service("GZJGXXBService")
public class GZJGXXBService  extends AbstractService{
	@Resource(name="sqlDbClient")
	private SqlDbClient dbClient;
	
	@Resource(name="SSOService")
	private SSOService ssoService;
	
	/**
	 * 表来源--->【GZZHGL_GZJGXXB】
	 *机构编码				JGBM
	 *机构名称				JGMC
	 *机构简称				JGJC
	 *英文名称				YWMC
	 *机构代码				JGDM
	 *执业证号				ZYZH
	 *办公用房面积			BGYFMJ
	 *是否承办涉外公证业务	SFCBSWGZYW
	 *党组织成立时间			DZZCLSJ
	 *机构设立时间			JGSLSJ
	 *执业区域				ZYQY
	 *负责人					FZR
	 *发证机关				FZJG
	 *发证时间				FZSJ
	 *公证机构体制			GZJGTZ
	 *所在地司法行政机关编码	SZDSFXZJGBM
	 *上级司法行政机关编码	SJSFXZJGBM
	 *所属公证协会编码		SSGZXHBM
	 *机构设置层级			JGSZCJ
	 *联系电话				LXDH
	 *传真号码				CZHM
	 *电子邮箱				DZYX
	 *邮编					YB
	 *地址					DZ
	 *官方网站（微博、微信公众号、网址）	GFWZ
	 */
	//设置权限查询数据库需要的字段
	public ResultList<BasicMap<String,Object>> findAllRy(BasicMap<String,Object> data,Paginate paginte){
		User user = ssoService.getUser();
		ResultList<BasicMap<String,Object>> list = new ResultList<>();
		SqlDbFilter filter = new SqlDbFilter();
		filter.eq("orgid",user.getOrgid());//按照权限获取数据
		if(user!=null) {
			StringBuffer sqlstr = new StringBuffer("SELECT * FROM GZZHGL_GZJGXXB ");
			
			if(Util.isNotEmpty(data.get("jgjc"))) {
				filter.like("jgjc", data.get("jgjc").toString());
			}
			if(Util.isNotEmpty(data.get("fzr"))) {
				filter.like("fzr", data.get("fzr").toString());
			}
			if(Util.isNotEmpty(data.get("jgdm"))) {
				filter.like("jgdm", data.get("jgdm").toString());
			}
			if(Util.isNotEmpty(data.get("zyzh"))) {
				filter.like("zyzh", data.get("zyzh").toString());
			}
			if(Util.isNotEmpty(data.get("zyqy"))) {
				filter.like("zyqy", data.get("zyqy").toString());
			}
			if(Util.isNotEmpty(data.get("fzjg"))) {
				filter.like("fzjg", data.get("fzjg").toString());
			}
			if(Util.isNotEmpty(data.get("lxdh"))) {
				filter.like("lxdh", data.get("lxdh").toString());
			}
			if(Util.isNotEmpty(data.get("dz"))) {
				filter.like("dz", data.get("dz").toString());
			}
			SQLAdapter sqlAdapter = new SQLAdapter(sqlstr.toString());
			sqlAdapter.setFilter(filter);
			list = dbClient.find(sqlAdapter, paginte);
		}
		return list;
	}
}
