package com.ehtsoft.user.services;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.ehtsoft.fw.core.context.AppContext;
import com.ehtsoft.fw.core.context.AppException;
import com.ehtsoft.fw.core.db.RowDataListener;
import com.ehtsoft.fw.core.db.SQLAdapter;
import com.ehtsoft.fw.core.db.SqlDbFilter;
import com.ehtsoft.fw.core.dto.BasicMap;
import com.ehtsoft.fw.core.services.SqlBasicService;
import com.ehtsoft.fw.core.sso.SingleSignOnClient;
import com.ehtsoft.fw.core.sso.User;
import com.ehtsoft.fw.core.utils.EncryptUtil;
import com.ehtsoft.fw.utils.NumberUtil;
import com.ehtsoft.fw.utils.StringUtil;
import com.ehtsoft.fw.utils.Util;
import com.ehtsoft.im.api.ProxyApiFactory;
import com.ehtsoft.user.api.UserConst;

public class LoginService extends SqlBasicService{
	private Log logger = LogFactory.getLog(LoginService.class);
	@Resource
	private SingleSignOnClient ssoClient;
	
	@Resource
	private FirstPageService firstService;
	
	@Resource
	private UserSynchronizeService userSynchronizeService;
	/**
	 * BS 登录
	 */
	public String login(User user) throws AppException{
		String forward = "main.jsp";
		User ac = login(user.getAccountid(),user.getPassword());
		//登录成功后，获取用户对象
		String temp = user.getForward();
		if(Util.isNotEmpty(temp) && !"null".equals(temp)){
			if("true".equals(ssoClient.getShowToken())){
				temp = temp.replaceAll("\\&token\\=.*|\\?token\\=.*", "");
				 if(temp.contains("?")){
					 forward = temp + "&token="+ac.getToken();
				 }else{
					 forward = temp + "?token="+ac.getToken();
				 }
				return forward;
			}else{
				return temp;
			}
		}
		BasicMap<String,Object> smap = this.sqlDbClient.findFirstData(UserConst.Collections.CORE_SCENE, new SqlDbFilter().eq("DEFAULTFLAG", 1));
		if(smap!=null && Util.isNotEmpty(smap.get("mainurl"))){
			forward = StringUtil.toString(smap.get("mainurl"));
		}
		if(Util.isNotEmpty(ac.getOrgid())){
			String sql = "select sceneid from core_organization where sysid = '"+ ac.getOrgid() + "'";
			BasicMap<String, Object> org = this.sqlDbClient.findOne(new SQLAdapter(sql));
			if(org!=null && Util.isNotEmpty(org.get("sceneid"))){
				BasicMap<String, Object> scene = this.sqlDbClient.findOne(UserConst.Collections.CORE_SCENE,new SqlDbFilter().eq("SYSID", org.get("sceneid")));
				if(scene!=null && Util.isNotEmpty(scene.get("mainurl"))){
					forward = StringUtil.toString(scene.get("mainurl"));
				}
			}
		}
		if(Util.isNotEmpty(ac.getSceneid())){
			BasicMap<String, Object> scene = this.sqlDbClient.findOne(UserConst.Collections.CORE_SCENE,new SqlDbFilter().eq("SYSID", ac.getSceneid()));
			if(scene!=null && Util.isNotEmpty(scene.get("mainurl"))){
				forward = StringUtil.toString(scene.get("mainurl"));
			}
		}
		return forward;
	}
	
	/**
	 * 网易云注册及刷新登录token
	 * @param accountid
	 * @param password
	 * @return
	 * @throws AppException
	 */
	public User login(String accountid,String password) throws AppException{
		User rtn = login(accountid, password,false);
			//注册网易云
			//com.ehtsoft.user.utils.VidaoImService.registered(rtn.getCode()); //无字段返回
		try {
			String regtoken = ProxyApiFactory.getInstance().register(rtn.getCode(),rtn.getName());
			System.out.println("----------注册网易云token："+regtoken+"----------");
		} catch (Exception e) {
				e.printStackTrace();
		}
		//获得登陆的imToken
		try {
			String imtoken = ProxyApiFactory.getInstance().login(rtn.getCode());
			rtn.getExtra().put("imtoken", imtoken);
			System.out.println("----------登录网易云token："+imtoken+"-------------");
		} catch (Exception e) {
		}
		return rtn;
	}
	
	
	/**
	 * cs 登录
	 * @param accountid
	 * @param password
	 * @paran passwordEncryptAfter true 加密后传递到后台  false 明码传递到后台，再加密
	 * @return
	 * {
	 * 	value:"Token 值",
	 *  name:"登录人的真实名字",
	 *  orgcode:"当前机构的编码",
	 *  orgname:"当前机构的名字"
	 * }
	 * @throws AppException
	 */
	public User login(String accountid,String password,Boolean passwordEncryptAfter) throws AppException{
		ssoClient.clear();
		if(Util.isEmpty(accountid)){
			throw new AppException("用户名不能为空！");
		}
		
		accountid = accountid.trim();
		
		if(Util.isEmpty(password)){
			throw new AppException("密码不能为空！");
		}
		if(passwordEncryptAfter==false){ //明码传来，再加密
			password = EncryptUtil.md5(password);
		}
		SqlDbFilter filter = new SqlDbFilter();
		filter.eq("ACCOUNTID", accountid);
		BasicMap<String,Object> ac = this.sqlDbClient.findOne(UserConst.Collections.CORE_ACCOUNT, filter);
		
		if(ac!=null){
			if(0 == NumberUtil.toInt(ac.get("flag"))){
				throw new AppException("账户 " + ac.get("accountid") + "已被禁用");
			}
			if(!accountid.equals(ac.get("accountid"))){
				throw new AppException("账户错误！");
			}
			if(!password.equals(ac.get("password"))){
				throw new AppException("密码错误！");
			}
			if(logger.isInfoEnabled()){
				logger.info("用户" + accountid + "从  IP [" + AppContext.getRemoteAddr() + "]登录系统");
			}
		}else{
			throw new AppException("没有账户为:" + accountid+"用户！");
		}
		User user = findUser(ac);
		// create token or cookie
		ssoClient.createTokenCookie(user);
		
	

		//将 token 放到 Context 中，用于 token 的获取
		//登录后更新在线标记 为已经在线状态
////		sqlDbClient.updateSql("UPDATE CORE_ACCOUNT SET STATUS='1' WHERE SYSID = ?", user.getAid());
		return user;
	}
	
	/**
	 * 退出
	 */
	public String logout() throws AppException{
		User user = ssoClient.getUser();
		if(user!=null){
			sqlDbClient.updateSql("UPDATE CORE_ACCOUNT SET STATUS='0' WHERE SYSID = ?", user.getAid());
		}
		ssoClient.clear();
		return ssoClient.getUrl();
	}
	
	/**
	 * 密码修改
	 * @throws AppException 
	 */
	public void modifyPsw(String oldPsw,String newPsw) throws AppException{
		User user = ssoClient.getUser();
		oldPsw = EncryptUtil.md5(oldPsw);
		newPsw = EncryptUtil.md5(newPsw);
		if(user==null){
			throw new AppException("由于长期没有操作系统，用户过期");
		}
		String sysid = user.getAid();
		
		SqlDbFilter filter = new SqlDbFilter();
		filter.eq("SYSID", sysid);
		
		BasicMap<String,Object> ac = this.sqlDbClient.findOne(UserConst.Collections.CORE_ACCOUNT, filter);
		if(ac==null){
			throw new AppException("当前用户已经丢失，请联系管理员");
		}else{
			String	password=(String) ac.get("PASSWORD");
			if(!oldPsw.equals(password)){
				throw new AppException("当前密码错误，请重新输入");
			}else{
				BasicMap<String,Object> data = new BasicMap<String,Object>();
				data.put("SYSID", sysid);
				data.put("PASSWORD", newPsw);
				this.sqlDbClient.update(UserConst.Collections.CORE_ACCOUNT,data);
			}
		}
		if(Util.isNotEmpty(ac.get("USERID"))){
			List<String> uids = new ArrayList<String>();
			uids.add(StringUtil.toString(ac.get("USERID")));
			userSynchronizeService.synchronize(uids);
		}
	}
		
	/**
	 * 根据 账号信息得到 权限中  User 对象
	 * @param account
	 * @return
	 */
	private User findUser(BasicMap<String,Object> account) throws AppException{
		User user = new User();
		/**
		 * 设置账户ID
		 */
		user.setAccountid(StringUtil.toString(account.get("ACCOUNTID")));
		user.setAid(StringUtil.toString(account.get("sysid")));
		user.setUid(StringUtil.toString(account.get("userid")));
		user.setIpAddr(AppContext.getRemoteAddr());
		user.setRule(StringUtil.toString(account.get("FRULE")));
		user.setPassword(StringUtil.toString(account.get("password")));
		user.setSceneid(StringUtil.toString(account.get("sceneid")));
		
		if(Util.isNotEmpty(user.getUid())){
			SqlDbFilter pf = new SqlDbFilter();
			pf.eq("sysid", user.getUid());
			BasicMap<String,Object> person = sqlDbClient.findOne(UserConst.Collections.CORE_PERSONNEL, pf);
			if(person!=null){
				user.setName(StringUtil.toString(person.get("name")));
				user.setEmail(StringUtil.toString(person.get("EMAIL")));
				user.setMobile(StringUtil.toString(person.get("TELEPHONE")));
				user.setCode(StringUtil.toString(person.get("CODING")));
			}
		}else{
			//没有关联用户情况(admin 等 psa 用户)
			user.setName(StringUtil.toEmptyString(account.get("nickname")));
			user.setCode(user.getAccountid());
		}
			
		if(user.isPsa()){
			return user;
		}
		//根据用户获取默认的组织机构信息
		String sqlstr = "SELECT ORGID,ORGCODE,ORGNAME,O.REGIONCODE,O.FLAG,O.LVL,DEFAULTORG FROM CORE_ACCOUNT_ORGANIZATION A "+
						"INNER JOIN CORE_ORGANIZATION O ON A.ORGID = O.SYSID "+
						"WHERE A.ACCOUNTID = '"+user.getAid()+"'";
		final BasicMap<String,Object> m = new BasicMap<String,Object>();
		sqlDbClient.find(new SQLAdapter(sqlstr),new RowDataListener() {
			@Override
			public void processData(BasicMap<String, Object> rowData) {
				if(NumberUtil.toInt(rowData.get("DEFAULTORG"))==1){//用户默认的当前机构
					user.setOrgid(String.valueOf(rowData.get("ORGID")));
					user.setOrgname(String.valueOf(rowData.get("ORGNAME")));
					user.setOrgcode(String.valueOf(rowData.get("ORGCODE")));
					user.setOrgType(NumberUtil.toInteger(rowData.get("LVL")));
					//行政区划编码
					user.setRegioncode(StringUtil.toString(rowData.get("REGIONCODE")));
					m.put("flag", rowData.get("flag"));
				}
				user.getOrgidSet().add(StringUtil.toString(rowData.get("ORGID")));
			}
		});
		if(Util.isNotEmpty(user.getOrgid())){
			//1、司法厅   2、市司法局  3、区司法局  4、司法所（司法行政机关）   5、法律服务机构"
			if(NumberUtil.toInt(user.getOrgType()) > 1){
				BasicMap<String, Object> one = sqlDbClient.findOne("select sysid,lft,rgt from core_organization where sysid = ?", user.getOrgid());
				if(one!=null){
					int lft = NumberUtil.toInt(one.get("lft"));
					int rgt = NumberUtil.toInt(one.get("rgt"));
					String sql = "select sysid from core_organization where  lft >= "+lft+" and rgt <= "+rgt;
					sqlDbClient.find(new SQLAdapter(sql),new RowDataListener() {
						@Override
						public void processData(BasicMap<String, Object> rowData) {
							user.getOrgidSet().add(StringUtil.toString(rowData.get("sysid")));
						}
					});
				}
			}
		}
		/**
		 * 具体用户的信息
		 */
		if(m!=null){
			/**
			 * 医疗机构被禁用
			 * 目前：提示为 系统升级中...
			 */
			if(0 == NumberUtil.toInt(m.get("flag"))){
				//throw new AppException(user.getOrgname() + "被禁用!");
				throw new AppException("智慧社区平台升级中...");
			}
		}
		return user;
	}
}
