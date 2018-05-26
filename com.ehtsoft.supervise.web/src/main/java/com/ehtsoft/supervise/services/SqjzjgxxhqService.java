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

/**
	* 社区矫正机构信息获取表 【JC_SFXZJGJBXX-->司法行政机关（单位）基本信息采集表】
	* @author 李恒
	*主键	ID
	*父ID	PARENTID
	*机构编码	JGBM
	*机构名称	JGMC
	*机构简称	JGJC
	*英文名称	YWMC
	*机构代码	JGDM
	*负责人	FZR
	*机构类别	JGLB
	*机构行政级别	JGXZJB
	*机构隶属层级	JGLSCJ
	*上级司法行政主管机关	SJSFXZZGJG
	*上级司法行政主管部门	SJSFXZZGBM
	*行政区划ID	REGIONID
	*纬度	LAT
	*经度	LNG
	*联系电话	LXDH
	*传真号码	CZHM
	*电子邮箱	DZYX
	*邮编	YB
	*地址	DZ
	*是否采集GIS	HASGIS
	*删除标记	del
 */
@Service("SqjzjgxxhqService")
public class SqjzjgxxhqService extends AbstractService {
	@Resource(name="sqlDbClient")
	SqlDbClient dbClient;
	
	@Resource(name="SSOService")
	private SSOService service;
	
	public ResultList<BasicMap<String,Object>> findOrgid(BasicMap<String,Object>query,Paginate paginate){
		User user = service.getUser();
		ResultList<BasicMap<String,Object>> list = new ResultList<>();
		if(user!=null) {
			SqlDbFilter filter = toSqlFilter(query);
			String sqlstr ="select *  FROM JC_SFXZJGJBXX where id='"
					+ user.getOrgid()
					+ "'";
		SQLAdapter sqlAdapter = new SQLAdapter(sqlstr);
		sqlAdapter.setFilter(filter);
		list = dbClient.find(sqlAdapter, paginate);
		}
		return list;
	}

}
