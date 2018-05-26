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

/**
 	* 社区矫正工作人员信息获取 【JC_SFXZJGGZRYJBXX----->司法行政机关（单位）工作人员基本信息采集表】
 	* @author 李恒
 	*人员编码	RYBM
	*姓名	XM
	*英文名	YWM
	*性别	XB
	*出生日期	CSRQ
	*身份证号	SFZH
	*民族	MZ
	*政治面貌	ZZMM
	*婚姻状况	HYZK
	*毕业院校	BYYX
	*学历	XL
	*最高学位	ZGXW
	*专业	ZY
	*所属机构	SSJG
	*职务	ZW
	*人员编制(人员类型)	RYBZ
	*参加工作时间	CJGZSJ
	*手机号码	SJHM
	*联系电话	LXDH
	*电子邮箱	DZYX
	*住址	ZZ
	*/
@Service("SqjzgzryxxbService")
public class SqjzgzryxxbService extends AbstractService {
	@Resource(name="sqlDbClient")
	SqlDbClient dbClient;
	
	@Resource(name="SSOService")
	private SSOService service;
	
	public ResultList<BasicMap<String,Object>> findOrgid(BasicMap<String,Object>query,Paginate paginate){
		User user = service.getUser();
		ResultList<BasicMap<String,Object>> list = new ResultList<>();
		if(user!=null) {
			SqlDbFilter filter = toSqlFilter(query);
			String sqlstr ="select * FROM Jc_SfxzJggzryjbxx";
			filter.in("orgid", user.getOrgidSet());
		SQLAdapter sqlAdapter = new SQLAdapter(sqlstr);
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

}
