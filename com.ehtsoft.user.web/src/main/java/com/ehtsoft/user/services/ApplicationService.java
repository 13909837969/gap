package com.ehtsoft.user.services;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import com.ehtsoft.fw.core.context.AppException;
import com.ehtsoft.fw.core.db.RowDataListener;
import com.ehtsoft.fw.core.db.SQLAdapter;
import com.ehtsoft.fw.core.db.SaveOperation;
import com.ehtsoft.fw.core.db.SqlDbFilter;
import com.ehtsoft.fw.core.dto.BasicMap;
import com.ehtsoft.fw.core.dto.Paginate;
import com.ehtsoft.fw.core.dto.ResultList;
import com.ehtsoft.fw.core.dto.UploadObject;
import com.ehtsoft.fw.core.services.SqlBasicService;
import com.ehtsoft.fw.core.services.api.IUploadService;
import com.ehtsoft.fw.utils.NumberUtil;
import com.ehtsoft.fw.utils.StringUtil;
import com.ehtsoft.fw.utils.Util;
import com.ehtsoft.user.api.UserConst;
import com.ehtsoft.user.utils.MenuUtil;
import com.ehtsoft.user.utils.SYSID;
/**
 * 应用管理
 * @author wangbao
 */
public class ApplicationService extends SqlBasicService implements IUploadService{

	/**
	 * save 
	 * @param data
	 * @throws AppException
	 */
	public void save(BasicMap<String,Object> data) throws AppException{
		super.save(UserConst.Collections.CORE_APPLICATION, data);
	}
	/**
	 * delete 
	 * @param data
	 * @throws AppException
	 */
	public void remove(List<BasicMap<String,Object>> data)  throws AppException{
		super.remove(UserConst.Collections.CORE_APPLICATION, data);
		
	}
	
	
	/**
	 * 查询数据
	 * @param tablename
	 * @param data
	 * @param paginate
	 * @return
	 */
	public ResultList<BasicMap<String,Object>> find(BasicMap<String,Object> filter,Paginate paginate) throws AppException{
		filter.put("SYSID[asc]", 1);
		return super.find(UserConst.Collections.CORE_APPLICATION, filter, paginate);
	}
	
	
	public List<BasicMap<String,Object>> find(BasicMap<String,Object> filter) throws AppException{
		filter.put("SYSID[asc]", 1);
		return super.find(UserConst.Collections.CORE_APPLICATION, filter);
	}
	/**
	 * 导入 menu.xml 文件
	 */
	@Override
	public String upload(UploadObject uploadObject, String dir)
			throws AppException {
		boolean rtn = false;
		BasicMap<String,List<BasicMap<String,Object>>> approle = MenuUtil.getApplicationMenu(uploadObject.getInputStream());
		// application 数据
		final List<BasicMap<String, Object>> apps = approle.get("appmenus");
		
		List<String> appcodes = new ArrayList<String>();
		for(BasicMap<String,Object> app:apps){
			String sysid = UUID.randomUUID().toString();
			app.put("SYSID", sysid);
			appcodes.add(StringUtil.toString(app.get("appcode")));
		}
		final List<String> appids = new ArrayList<String>();
		//根据 APPCODE 查找 core_application 数据，如果数据库中的数据  appcode 和 导入数据的 APPCODE 相等，则将 数据库主键 sysid 赋给 导入的数据中，后面用户数据的更新操作
		List list = this.sqlDbClient.find(UserConst.Collections.CORE_APPLICATION, new SqlDbFilter().in("APPCODE", appcodes), new RowDataListener() {
			public void processData(BasicMap<String, Object> rowData) {
				//将主键 放到  appids 中，用于到 menu 库查询数据
				appids.add(StringUtil.toString(rowData.get("SYSID")));
				for(BasicMap<String,Object> app:apps){
					//appcode 相等时 将 rowData.sysid 赋值给  app 数据，之后用于更新当前数据 
					if(rowData.get("appcode").equals(app.get("appcode"))){
						app.put("SYSID", rowData.get("SYSID"));
						continue;
					}
				}
			}
		});
		//根据 appid 更新  del = 1,删除状态
		if(!list.isEmpty()){
			this.sqlDbClient.update(UserConst.Collections.CORE_MENU, new BasicMap<String, Object>("DEL",1,"ACTIONURI",""),new SqlDbFilter().in("APPID", appids),null);
		}
		//保存   app 数据
		for(final BasicMap<String,Object> app:apps){
			//更加 app sysid 查找当前应用的所有 menu ,让后和 app中的menu数据通过menucode 比较，如果存在，将数据库中的 sysid 赋给 app 中的menu ，之后，通过sysid 进行数据更新和插入
			if(Util.isNotEmpty(app.get("SYSID"))){
				this.sqlDbClient.find(UserConst.Collections.CORE_MENU,new SqlDbFilter().eq("APPID", app.get("SYSID")),new RowDataListener() {
					@Override
					public void processData(BasicMap<String, Object> rowData) {
						//menu 菜单数据
						if(Util.isNotEmpty(app.get("children"))){
							List<BasicMap<String,Object>> children = (List<BasicMap<String,Object>>)app.get("children");
							for(BasicMap<String,Object> c : children){
								if(c.get("MENUCODE").equals(rowData.get("MENUCODE"))){
									((SYSID)c.get("SYSID")).setValue(StringUtil.toString(rowData.get("SYSID")));
									continue;
								}
							}
						}
					}
				});
			}
			//保存  app 数据
			this.sqlDbClient.save(UserConst.Collections.CORE_APPLICATION,app);
			if(Util.isNotEmpty(app.get("children"))){
				//保存 menu 数据
				this.sqlDbClient.save(UserConst.Collections.CORE_MENU, (List<BasicMap<String,Object>>)app.get("children"),new SaveOperation() {
					@Override
					public void saveBefore(BasicMap<String, Object> data) {
						data.put("APPID", app.get("SYSID"));
						if(SYSID.INIT_VALUE.equals(((SYSID)data.get("SYSID")).getValue())){
							((SYSID)data.get("SYSID")).setValue(UUID.randomUUID().toString());
						}
						data.put("PARENTID", StringUtil.toString(data.get("PARENTID")));
						data.put("SYSID", StringUtil.toString(data.get("SYSID")));
						data.put("DEL", 0);
					}
					@Override
					public void saveAfter(BasicMap<String, Object> data) {
					}
				});
			}
		}
		//导入功能角色
		List<BasicMap<String,Object>> roles = approle.get("rolemenus");
		if(roles.size()>0){
			for(final BasicMap<String,Object> role:roles){
				String rolecode = StringUtil.toString(role.get("rolecode"));
				if(rolecode!=null){
					BasicMap<String, Object> r = this.sqlDbClient.findOne(UserConst.Collections.CORE_ROLE,new SqlDbFilter().eq("ROLECODE", rolecode));
					if(r!=null){
						String rsysid = StringUtil.toString(r.get("sysid"));
						role.put("sysid", rsysid);
						this.sqlDbClient.remove(UserConst.Collections.CORE_ROLE_MENU, new SqlDbFilter().eq("ROLEID", rsysid));
					}
					//保存角色
					this.sqlDbClient.save(UserConst.Collections.CORE_ROLE, role);
					
					final List<BasicMap<String,Object>> menus = new ArrayList<BasicMap<String,Object>>();
					if(Util.isNotEmpty(role.get("appcodes")) || Util.isNotEmpty(role.get("menucodes"))){
						String codes = StringUtil.toString(role.get("appcodes"));
						String mcodes = StringUtil.toString(role.get("menucodes"));
						String exclude = StringUtil.toString(role.get("exclude"));
						String sqlstr = "SELECT SYSID,MENUCODE,MENUNAME FROM CORE_MENU WHERE DEL = 0 ";
						if(codes!=null){
							sqlstr += " AND APPID IN (SELECT SYSID FROM CORE_APPLICATION WHERE APPCODE IN ("+codes+"))";
						}
						if(mcodes!=null){
							sqlstr += " AND MENUCODE IN ("+mcodes+")";
						}
						if(exclude!=null){
							sqlstr += " AND MENUCODE NOT IN ("+exclude+")";
						}
						this.sqlDbClient.find(new SQLAdapter(sqlstr),new RowDataListener() {
							public void processData(BasicMap<String, Object> rowData) {
								menus.add(new BasicMap<String,Object>("ROLEID",role.get("sysid"),"MENUID",rowData.get("SYSID")));
							}
						});
						this.sqlDbClient.insert(UserConst.Collections.CORE_ROLE_MENU, menus);
					}
				}
			}
		}
		return "应用数据导入成功";
	}

}
