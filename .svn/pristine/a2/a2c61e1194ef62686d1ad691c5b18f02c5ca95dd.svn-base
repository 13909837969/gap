package com.ehtsoft.supervise.services;


import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ehtsoft.common.services.SFCodeService;
import com.ehtsoft.common.services.SSOService;
import com.ehtsoft.fw.core.db.InsertOperation;
import com.ehtsoft.fw.core.db.SQLAdapter;
import com.ehtsoft.fw.core.db.SqlDbClient;
import com.ehtsoft.fw.core.dto.BasicMap;
import com.ehtsoft.fw.core.services.AbstractService;
import com.ehtsoft.fw.core.sso.User;
import com.ehtsoft.fw.core.utils.AppUtil;
import com.ehtsoft.fw.utils.StringUtil;
import com.ehtsoft.fw.utils.Util;
import com.ehtsoft.supervise.api.SupConst;
/**
 * 矫正人员基本信息录入
 * （简化的数据录入方式）
 * 平板 新增矫正人员 和  修改矫正人员使用
 * @author wangbao
 */
@Service("FormSimpleServise")
public class FormSimpleServise extends AbstractService {
	@Resource(name = "sqlDbClient")
	private SqlDbClient dbClient;
	
	@Resource(name="SSOService")
	private SSOService service;
	
	@Resource(name="SFCodeService")
	private SFCodeService sfCodeService;
	
	public void save(BasicMap<String, Object> data){
		User user = service.getUser();
		String csrq = AppUtil.getBirthdate(StringUtil.toString(data.get("sfzh")));
		if(Util.isNotEmpty(csrq)){
			data.put("csrq", csrq);
		}
		if(user.getOrgType()<4) {
			data.put("SFJS", "0"); //司法所是否接受  0 未接收   1 接收
		}else {
			//司法所
			data.put("SFJS", "1"); //司法所是否接受  0 未接收   1 接收
		}
		dbClient.save(SupConst.Collections.JZ_JZRYJBXX, data,new InsertOperation() {
			@Override
			public void insertBefore(BasicMap<String, Object> data) {
				String code = sfCodeService.getCorrectCode();
				data.put("sqjzrybh", code);
			}
			@Override
			public void updateBefore(BasicMap<String, Object> data){
				data.remove("sqjzrybh");
			}
			@Override
			public void insertAfter(BasicMap<String, Object> data) {
			}
		});
//		String id=StringUtil.toEmptyString(data.get("id"));
//		data1.put("id", id);
		dbClient.save(SupConst.Collections.JZ_JZRYJBXX_DZ, data);
	}
	
	public BasicMap<String, Object> findOne(String id){
		return dbClient.findOne("select a.*,b.HJSZDMX,b.GDJZDMX,b.HJSZD,b.GDJZD from jz_jzryjbxx a left join jz_jzryjbxx_dz b on a.id=b.id where a.id = ?", id );
	}
}
