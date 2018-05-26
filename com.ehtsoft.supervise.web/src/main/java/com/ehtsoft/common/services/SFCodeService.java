package com.ehtsoft.common.services;

import java.util.Date;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ehtsoft.fw.core.db.SQLAdapter;
import com.ehtsoft.fw.core.db.SqlDbClient;
import com.ehtsoft.fw.core.sso.User;
import com.ehtsoft.fw.utils.DateUtil;

/**
 * 司法业务编码生成服务
 * @author wangbao
 */
@Service("SFCodeService")
public class SFCodeService {

	@Resource(name = "sqlDbClient")
	private SqlDbClient dbClient;
	
	@Resource
	private SSOService sso;
	
	/**
	 * 生成 司法机构的便民
	 * 
	 * 6位行政区划编码【省(区、市)、市(地、州、盟)、县(市、区、旗)】,
	 * 见GB/T 2260和GB/T 10114,
	 * 所在司法行政机关的行政区划不足 6 位的在后面加“0”补齐。
	 * +2 位机构隶属层级编码 
	 * +4 位机构类别编码
	 * +2 位单位编码
	 * +4 位内设部门顺序码,
	 * 共 18 位,
	 * 所有编码只允许采用数字。
	 * 2 位单位编码从 01 开始,至 99 截止,单位编码不复用;
	 * 4 位内设部门顺序码从 0001 开始,至 9999 截止,内设部门顺序码不复用。
	 * @return
	 */
	public String getSfOrgcode(){
		
		
		
		return null;
	}
	/**
	 * 矫正人员的编码
	 * @return
	 */
	public String getCorrectCode(){
		String rtn = null;
		User user = sso.getUser();
		if(user!=null){
			String key = user.getRegioncode() + DateUtil.format(new Date(), "yyyyMM");
			long l = dbClient.getProxyPrimary(key, 1);
			rtn = String.format(key+"%04d", l);
		}
		return rtn;
	}

	/**
	 * 书面人民调解卷宗的编码
	 * @return
	 */
	public String getRmtjJzbmCode(){
		String rtn = null;
		User user = sso.getUser();
		if(user!=null){
			String key = user.getRegioncode() + DateUtil.format(new Date(), "yyyyMMdd");
			long l = dbClient.getProxyPrimary("RMTJ"+key, 1);
			rtn = String.format(key+"%04d", l);
		}
		return rtn;
	}
}
