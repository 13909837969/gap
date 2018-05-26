package com.ehtsoft.im.services;

import java.util.UUID;

import javax.annotation.Resource;

import org.apache.cxf.jaxws.JaxWsProxyFactoryBean;
import org.springframework.stereotype.Service;

import com.ehtsoft.fw.core.context.AppContext;
import com.ehtsoft.fw.core.context.AppException;
import com.ehtsoft.fw.core.context.GlobalsName;
import com.ehtsoft.fw.core.db.MongoClient;
import com.ehtsoft.fw.core.db.SqlDbClient;
import com.ehtsoft.fw.core.dto.BasicMap;
import com.ehtsoft.fw.core.sso.SingleSignOnClient;
import com.ehtsoft.fw.core.sso.User;
import com.ehtsoft.fw.core.utils.ReflectUtil;
import com.ehtsoft.fw.json.JSONException;
import com.ehtsoft.fw.utils.StringUtil;
import com.ehtsoft.im.api.ProxyApiFactory;

@Service("LoginService")
public class LoginService{

	@Resource(name="sqlDbClient")
	private SqlDbClient dbClient;
	
	@Resource(name="mongoClient")
	private MongoClient mongoClient;
	
	@Resource
	private UserinfoService userinfoService;
	
	public User login(String accountId,String password) throws AppException{
		if(accountId!=null){
			accountId = accountId.trim();
		}
		User user = userinfoService.findOne(accountId);
		if(user!=null){
			if(!password.equals(user.getPassword())){
				throw new AppException("密码错误");
			}
		}else{
			throw new AppException("没有 " + accountId + " 账号");
		}
		String sqlstr = "select orgid from jz_jzryjbxx where id = '"+user.getAid()+"'";
		BasicMap<String,Object> one = dbClient.findOne(sqlstr);
		if(one!=null){
			user.setOrgid(StringUtil.toString(one.get("orgid")));
		}
		
		//临时的用户共享
		String token = UUID.randomUUID().toString().replaceAll("\\-", "");
		
		user.setToken(token);
		
		BasicMap<String,Object> bMap = ReflectUtil.bean2Map(user);
		bMap.put(GlobalsName.MONGO_PK_FIELD, token);
		mongoClient.insert(SingleSignOnClient.CURRENT_USER_SESSION, bMap);
		
		
		AppContext.getSession().setAttribute(SingleSignOnClient.CURRENT_USER_SESSION, user);
		
		
			
			
		//注册网易云
		try {
			String regtoken =  ProxyApiFactory.getInstance().register(user.getCode(),user.getName()); //返回 注册的token
			System.out.println("----------注册网易云token："+regtoken+"----------");
		} catch (Exception e) {
			e.printStackTrace();
		}
		//获得登陆的imToken
		try {
			String imtoken = ProxyApiFactory.getInstance().login(user.getCode());
			user.getExtra().put("imtoken", imtoken);
			System.out.println("----------登录网易云token："+imtoken+"-------------");
		} catch (Exception e) {
		}
		return user;
	}
}
