package com.ehtsoft.common.services;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ehtsoft.fw.core.context.AppContext;
import com.ehtsoft.fw.core.sso.SingleSignOnClient;
import com.ehtsoft.fw.core.sso.User;
import com.ehtsoft.im.services.UserinfoService;

@Service("SSOService")
public class SSOService {
	public static final String SESSION_ACCOUNTID = "_session_accountid";
	
	@Resource
	private UserinfoService userinfoService;
	
	@Resource(name="SSO")
	private SingleSignOnClient sso;
	
	public User getUser(){
		User rtn = (User)AppContext.getSession().getAttribute(SingleSignOnClient.CURRENT_USER_SESSION);
		if(rtn==null){
			String accountid = (String)AppContext.getRequest().getParameter(SESSION_ACCOUNTID);
			rtn = userinfoService.findOne(accountid);
			AppContext.getSession().setAttribute(SingleSignOnClient.CURRENT_USER_SESSION,rtn);
		}
		if(rtn==null){
			rtn = sso.getUser();
		}
		return rtn;
	}
}
