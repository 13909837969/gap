package com.ehtsoft.supervise.services;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.alibaba.druid.filter.Filter;
import com.ehtsoft.common.services.SSOService;
import com.ehtsoft.fw.core.db.RowDataListener;
import com.ehtsoft.fw.core.db.SQLAdapter;
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
import com.ehtsoft.supervise.api.SupConst;


/**
 * 1.司法行政机关（单位）基本信息采集表 JC_SFXZJGJBXX
 */
@Service("JcSfxzjgjbxxService")
public class JcSfxzjgjbxxService extends AbstractService {
	@Resource(name="sqlDbClient")
	SqlDbClient dbClient;
	
	@Resource(name="SSOService")
	private SSOService service;
	

	/**
	 * 2.表单数据来源 JC_SFXZJCJBXX，根据当前登录人员所在机构作为条件
	 *ID=user，getOrgid
	 *数据。更新到JC_SFXZJGJBXX
	 *
	 *机构编码:JGBM
	 *机构名称:JGMC
	 *机构简称:JGJC
	 *英文名称:YWMC
	 *机构代码:JGDM
	 *机构类别:JGLB SYS004
	 *负责人:FZR		
	 *联系电话:LXDH
	 *机构隶属层级:JGLSCJ	SYS005
	 *机构行政级别:JGXZJB	SYS006
	 *地址:DZ
	 *select jgbm,jgmc,jgjc,ywmc,jgdm,jglb,fzr,lxdh,jglscj,jgxzjb  FROM JC_SFXZJGJBXX;
	 */
	public ResultList<BasicMap<String,Object>> findOrgid(BasicMap<String,Object>query,Paginate paginate){
		User user = service.getUser();
		ResultList<BasicMap<String,Object>> list = new ResultList<>();
		if(user!=null) {
			SqlDbFilter filter = toSqlFilter(query);
			String sqlstr ="select jgbm,jgmc,jgjc,ywmc,jgdm,jglb,fzr,lxdh,jglscj,jgxzjb,dz,czhm  FROM JC_SFXZJGJBXX where id='"
					+ user.getOrgid()
					+ "'";
		SQLAdapter sqlAdapter = new SQLAdapter(sqlstr);
		sqlAdapter.setFilter(filter);
		list = dbClient.find(sqlAdapter, paginate);
		}
		return list;
	}
	
	/**
	 * 方法作用就是更新
	 * @param data
	 */
	public void update(BasicMap<String, Object> query) {
		User user = service.getUser();
		query.put("id", user.getOrgid());
		dbClient.update(SupConst.Collections.JC_SFXZJGJBXX, query);
	}
	
}
