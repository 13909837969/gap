package com.ehtsoft.supervise.services;

import javax.annotation.Resource;
import javax.annotation.Resources;

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
import com.ehtsoft.fw.utils.Util;

@Service("LsswsxxService")
public class LsswsxxService extends AbstractService{
	@Resource(name="sqlDbClient")
	private SqlDbClient dbClient;
	
	@Resource(name="SSOService")
	private SSOService ssoService;
	
	/**
	 * 李恒 数据来源--->【LSZHGL_LSSWSJBQKSJYQ】
	 * 主键 ID
	 *  父ID PARENTID 
	 *  机构编码 JGBM 
	 *  机构名称 JGMC 
	 *  机构简称 JGJC 
	 *  英文名称 YWMC 
	 *  机构代码 JGDM 
	 *  负责人 FZR 
	 *  机构类别 JGLB 
	 *  机构行政级别 JGXZJB 
	 *  机构隶属层级 JGLSCJ 
	 *  上级司法行政主管机关 SJSFXZZGJG 
	 *  上级司法行政主管部门 SJSFXZZGBM 
	 *  行政区划ID REGIONID 
	 *  纬度 LAT 
	 *  经度 LNG 
	 *  联系电话 LXDH 
	 *  传真号码 CZHM 
	 *  电子邮箱 DZYX 
	 *  邮编 YB 
	 *  地址 DZ 
	 *  是否采集GIS HASGIS 
	 */
	public ResultList<BasicMap<String,Object>> findAllRy(BasicMap<String,Object> data,Paginate paginte){
		User user = ssoService.getUser();
		ResultList<BasicMap<String,Object>> list = new ResultList<>();
		SqlDbFilter filter = toSqlFilter(data);
		//filter.eq("orgid",user.getOrgid());//按照权限获取数据
		if(user!=null) {
			String sqlstr = new String("SELECT * FROM LSZHGL_LSSWSJBQKSJYQ ");
			filter.in("orgid", user.getOrgidSet());
			if(Util.isNotEmpty(data.get("lsswsmc"))) {
				filter.like("lsswsmc", data.get("lsswsmc").toString());
			}
			if(Util.isNotEmpty(data.get("ywmc"))) {
				filter.like("ywmc", data.get("ywmc").toString());
			}
			if(Util.isNotEmpty(data.get("fzrid"))) {
				filter.like("fzrid", data.get("fzrid").toString());
			}
			if(Util.isNotEmpty(data.get("hhrid"))) {
				filter.like("hhrid", data.get("hhrid").toString());
			}
			if(Util.isNotEmpty(data.get("zgjgid"))) {
				filter.like("zgjgid", data.get("zgjgid").toString());
			}
			if(Util.isNotEmpty(data.get("fzjg"))) {
				filter.like("fzjg", data.get("fzjg").toString());
			}
			if(Util.isNotEmpty(data.get("dzzmc"))) {
				filter.like("dzzmc", data.get("dzzmc").toString());
			}
			SQLAdapter sqlAdapter = new SQLAdapter(sqlstr.toString());
			sqlAdapter.setFilter(filter);
			list = dbClient.find(sqlAdapter, paginte);
		}
		return list;
	}
}


