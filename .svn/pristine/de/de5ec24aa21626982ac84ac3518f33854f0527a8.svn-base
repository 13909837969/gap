package com.ehtsoft.user.services;

import java.io.IOException;
import java.io.InputStream;
import java.util.List;
import java.util.UUID;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.ehtsoft.fw.core.config.helper.ModelConfigHelper;
import com.ehtsoft.fw.core.context.AppException;
import com.ehtsoft.fw.core.db.InsertOperation;
import com.ehtsoft.fw.core.db.SaveOperation;
import com.ehtsoft.fw.core.db.SqlDbClient;
import com.ehtsoft.fw.core.db.SqlDbFilter;
import com.ehtsoft.fw.core.dto.BasicMap;
import com.ehtsoft.fw.core.dto.UploadObject;
import com.ehtsoft.fw.core.services.AbstractService;
import com.ehtsoft.fw.core.services.DbMetaDataService;
import com.ehtsoft.fw.core.services.api.IUploadService;
import com.ehtsoft.fw.core.utils.AppUtil;
import com.ehtsoft.fw.core.utils.EncryptUtil;
import com.ehtsoft.fw.utils.StringUtil;
import com.ehtsoft.fw.utils.Util;
import com.ehtsoft.user.api.UserConst;
import com.ehtsoft.user.utils.InitUtil;

public class InitializeService extends AbstractService{
	
	private Log logger = LogFactory.getLog(InitializeService.class);
	
	@Resource(name="sqlDbClient")
	private SqlDbClient dbClient;
	
	@Resource(name="ApplicationService")
	private IUploadService appSvr;
	
	@Resource
	private DbMetaDataService dbMeta;
	
	public void initialize(){
		dbClient.getInterceptor().setSkipSso(true);
		try {
			logger.debug("生成初始化脚本:");
			String sqlstr = dbMeta.getCompareResult();
			logger.debug(sqlstr);
			logger.debug("执行初始化脚本");
			if(Util.isNotEmpty(sqlstr)){
				dbMeta.executeSql(sqlstr);
			}
			logger.debug("执行初始化脚本完成");
		}catch(AppException e){
			logger.error("生成初始化脚本失败");
		}
		logger.debug("正在初始化 model/*/*-model.xml 文件");
		ModelConfigHelper.init("classpath:META-INF/model/*/*-model.xml");
		long cnt = dbClient.count(UserConst.Collections.CORE_APPLICATION, null);
		if(cnt==0){
			try {
				UploadObject uo = new UploadObject();
				/***
				 * 导入user菜单数据
				 */
				logger.info("系统正在导入 user-menu.xml 菜单数据");
				InputStream is = this.getClass().getClassLoader().getResourceAsStream("META-INF/init/user-menu.xml");
				uo.setInputStream(is);
				appSvr.upload(uo, "");
				is.close();
				logger.info("系统导入 user-menu.xml 菜单数据成功");
				
				logger.info("系统正在导入 user-role.xml 角色数据");
				is = this.getClass().getClassLoader().getResourceAsStream("META-INF/init/user-role.xml");
				List<BasicMap<String,Object>> roles = InitUtil.getRoleList(is);
				/**
				 * 角色初始化
				 */
		    	for(BasicMap<String,Object> bm : roles){
					BasicMap<String,Object> one = dbClient.findOne(UserConst.Collections.CORE_ROLE,new SqlDbFilter().eq("ROLECODE", bm.get("ROLECODE")));
					if(one!=null){
						bm.put("SYSID",one.get("SYSID"));
					}
		    	}
		    	dbClient.save(UserConst.Collections.CORE_ROLE, roles,new SaveOperation() {
					public void saveBefore(BasicMap<String, Object> data) {
					}
					public void saveAfter(final BasicMap<String, Object> data) {
						if(Util.isNotEmpty(data.get("children"))){
							try {
								dbClient.remove(UserConst.Collections.CORE_ROLE_MENU, new SqlDbFilter().eq("ROLEID", data.get("SYSID")));
								List<BasicMap<String,Object>> children = (List<BasicMap<String,Object>>)data.get("children");
								for(BasicMap<String,Object> o : children){
									BasicMap<String,Object> menu = dbClient.findOne(UserConst.Collections.CORE_MENU,new SqlDbFilter().eq("MENUCODE", o.get("MENUCODE")));
									if(menu!=null){
										o.put("MENUID",menu.get("SYSID"));
										o.put("ROLEID", data.get("SYSID"));
									}
								}
								dbClient.save(UserConst.Collections.CORE_ROLE_MENU, children);
							} catch (AppException e) {
								throw new RuntimeException(e.getMessage());
							}
						}
					}
				});
		    	is.close();
		    	logger.info("系统导入 user-role.xml 角色成功");
		    	/**
		    	 * 账户初始化
		    	 */
		    	logger.info("正在初始化用户账户...");
		    	is = this.getClass().getClassLoader().getResourceAsStream("META-INF/init/user-initacc.xml");
		    	
		    	List<BasicMap<String,Object>> accounts = InitUtil.getAccountList(is);
		    	for(BasicMap<String,Object> account:accounts){
		    		BasicMap<String,Object> one = dbClient.findOne(UserConst.Collections.CORE_ACCOUNT,new SqlDbFilter().eq("ACCOUNTID", account.get("accountid")));
		    		if(one!=null){
		    			account.put("SYSID", one.get("SYSID"));
		    		}else{
		    			account.put("SYSID", UUID.randomUUID().toString());
		    		}
		    		String psw = EncryptUtil.md5(StringUtil.toString(account.get("password")));
		    		account.put("password", psw);
		    		dbClient.save(UserConst.Collections.CORE_ACCOUNT, account);
		    		dbClient.remove(UserConst.Collections.CORE_ACCOUNT_ROLE, new SqlDbFilter().eq("ACCOUNTID", account.get("SYSID")));
		    		if(Util.isNotEmpty(account.get("children"))){
		    			List<BasicMap<String,Object>> rs = (List<BasicMap<String,Object>>)account.get("children");
		    			for(BasicMap<String,Object> r:rs){
		    				BasicMap<String,Object> rr = dbClient.findOne(UserConst.Collections.CORE_ROLE,new SqlDbFilter().eq("rolecode", r.get("rolecode")));
		    				r.put("ROLEID", rr.get("SYSID"));
		    				r.put("ACCOUNTID", account.get("SYSID"));
		    			}
		    			dbClient.insert(UserConst.Collections.CORE_ACCOUNT_ROLE, rs);
		    		}
		    	}
		    	is.close();
		    	logger.info("初始化账号完成.");
		    	/**
		    	 * 账户初始化完成
		    	 */
			} catch (AppException e) {
				logger.error(e.getMessage());
			} catch (IOException e) {
				logger.error(e.getMessage());
			}
		}
		/**
		 * 存之前，检查下  CORE_SCENE 表中是否有数据，如果有数据，就不要存了
		 */
		long sceneCount = dbClient.count(UserConst.Collections.CORE_SCENE, null);
		if(sceneCount == 0){
			try {
				logger.info("系统正在导入 user-scene.xml 场景数据");
				InputStream is = this.getClass().getClassLoader().getResourceAsStream("META-INF/init/user-scene.xml");
				List<BasicMap<String,Object>> scenes = InitUtil.getSceneList(is);
				dbClient.insert(UserConst.Collections.CORE_SCENE, scenes,new InsertOperation(){
					public void insertBefore(BasicMap<String, Object> data) {
						InputStream is = InitializeService.class.getClassLoader().getResourceAsStream(StringUtil.toString(data.get("imgscene")));
						try {
							data.put("imgscene", AppUtil.toByteArray(is));
						} catch (AppException e) {
						}
					}
					public void insertAfter(BasicMap<String, Object> data) {
					}});
			} catch (AppException e) {
				e.printStackTrace();
			}
		}
		dbClient.getInterceptor().setSkipSso(false);
	}
}
