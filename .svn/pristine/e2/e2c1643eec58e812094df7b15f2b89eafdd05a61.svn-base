package com.ehtsoft.user.api;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.ehtsoft.fw.core.context.AppException;
import com.ehtsoft.fw.core.dto.BasicMap;
import com.ehtsoft.fw.core.utils.helper.JSONHelper;
import com.ehtsoft.fw.core.webservice.ProxyWebService;

public class UserUtil {
	private static Log logger = LogFactory.getLog(UserUtil.class);
	/**
	 * 获取 医疗机构中的员工信息列表
	 * @param userService
	 * @param token
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public static List<BasicMap<String,Object>> getEmployees(ProxyWebService userService,String token){
		List<?> rtn = null;
		if(userService!=null){
			String reqcommand = "{service:'OsaOrganizationService'," +
					"method:'findEmployees'," +
					"arguments:[]" +
					"}";
			try {
				String json = userService.doJsonService(reqcommand, token);
				if(json!=null){
				
					rtn = JSONHelper.jsonArrayToList(json, BasicMap.class);
				}
			} catch (AppException e) {
				logger.error(e.getMessage());
			}
		}
		return (List<BasicMap<String,Object>>)rtn;
	}
	
	/**
	 * 获取组织机构名称信息列表
	 * @param userService
	 * @param token
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public static List<BasicMap<String,Object>> getOrganizations(ProxyWebService userService,String token){
		List<?> rtn = null;
		if(userService!=null){
			String reqcommand = "{service:'OrganizationService'," +
					"method:'findOrg'," +
					"arguments:[]" +
					"}";
			try {
				String json = userService.doJsonService(reqcommand, token);
				if(json!=null){
				
					rtn = JSONHelper.jsonArrayToList(json, BasicMap.class);
				}
			} catch (AppException e) {
				logger.error(e.getMessage());
			}
		}
		return (List<BasicMap<String,Object>>)rtn;
	}
}
