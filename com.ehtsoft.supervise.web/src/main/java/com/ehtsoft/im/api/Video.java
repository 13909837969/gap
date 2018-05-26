/**
 * @Description TODO(用一句话描述该文件是做什么功能的，哪个地方使用的，android 还是 jsp 用)
 * @author wangbao
 * @date 2018年4月22日
 */
package com.ehtsoft.im.api;

import javax.jws.WebMethod;
import javax.jws.WebService;
import javax.security.auth.login.LoginContext;

/**
 * @Description TODO(用一句话描述该文件是做什么功能的，哪个地方使用的)
 * @author wangbao
 * @date 2018年4月22日
 *
 */
@WebService
public interface Video {

	@WebMethod
	String register(String accountid,String name);
	
	@WebMethod
	String login(String accountid);
	
}
