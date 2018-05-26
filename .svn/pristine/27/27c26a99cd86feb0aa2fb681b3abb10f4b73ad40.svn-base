package com.ehtsoft.supervise.services;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

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
import com.ehtsoft.fw.utils.Util;
import com.ehtsoft.supervise.api.SupConst;

/**
 * 司法所工作人员基本信息
 * @author 李恒
 *
 */
@Service("JcSfxzJggzryjbxxService")
public class JcSfxzJggzryjbxxService extends AbstractService{
	@Resource(name="sqlDbClient")
	SqlDbClient dbClient;
	
	@Resource(name="SSOService")
	private SSOService service;
	/**
	 *表单数据来源-->JcSfxzJggzryjbxx
	 *主键 		ID
	 *人员编码	RYBM
	 *姓名		XM
	 *英文名		YWM
	 *性别		XB
	 *出生日期	CSRQ
	 *身份证号	SFZH
	 *民族		MZ
	 *政治面貌	ZZMM
	 *婚姻状况	HYZK
	 *毕业院校	BYYX
	 *学历		XL
	 *最高学位	ZGXW
	 *专业		ZY
	 *所属机构	SSJG
	 *职务		ZW
	 *人员编制	RYBZ
	 *手机号码	SJHM
	 *联系电话	LXDH
	 *电子邮箱	DZYX
	 *住址		ZZ
	 *参加工作时间	CJGZSJ
	 *
	 */
	public ResultList<BasicMap<String,Object>> findOrgid(BasicMap<String,Object>query,Paginate paginate){
		User user = service.getUser();
		ResultList<BasicMap<String,Object>> list = new ResultList<>();
		if(user!=null) {
			SqlDbFilter filter = toSqlFilter(query);
			String sqlstr ="select id, rybm,xm,ywm,xb,csrq,sfzh,mz,zzmm,hyzk,byyx,xl,zgxw,zy,ssjg,zw,rybz,sjhm,lxdh,dzyx,zz,cjgzsj  FROM Jc_SfxzJggzryjbxx"; 
			SQLAdapter sqlAdapter = new SQLAdapter(sqlstr);
			filter.eq("orgid",user.getOrgid());
			sqlAdapter.setFilter(filter);
			list = dbClient.find(sqlAdapter, paginate,new RowDataListener() {
			//转换时间格式
			@Override
			public void processData(BasicMap<String, Object> rowData) {
				// TODO Auto-generated method stub
				rowData.put("csrq",DateUtil.format(rowData.get("csrq"),"yyyy-MM-dd"));
				rowData.put("cjgzsj",DateUtil.format(rowData.get("cjgzsj"), "yyyy-MM-dd"));
				
			}
		});
		
		
		}
		return list;
		
	}
	
	/**
	 * 方法作用就是更新
	 * @param data
	 */
	public void update(BasicMap<String, Object> query) {
		//User user = service.getUser();
		dbClient.save(SupConst.Collections.JC_SFXZJGGZRYJBXX, query);
	}

}
