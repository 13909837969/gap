package com.ehtsoft.user.utils;

import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import com.ehtsoft.fw.core.config.helper.ModelConfigHelper;
import com.ehtsoft.fw.core.config.model.ColumnConfig;
import com.ehtsoft.fw.core.config.model.TableConfig;
import com.ehtsoft.fw.core.db.Interceptor;
import com.ehtsoft.fw.core.sso.SingleSignOnClient;
import com.ehtsoft.fw.core.sso.User;
import com.ehtsoft.fw.utils.DateUtil;
import com.ehtsoft.fw.utils.NumberUtil;
import com.ehtsoft.fw.utils.StringUtil;
import com.ehtsoft.fw.utils.Util;

public class SqlDbInterceptorImpl implements Interceptor {

	private boolean skipSso = false;
	@Resource
	private SingleSignOnClient sso;
	/**
	 * 设置跳过 sso 功能
	 * @param skip  true 跳过   false 不跳过
	 */
	public void setSkipSso(boolean skip){
		this.skipSso = skip;
	}
	@Override
	public void insertBefore(String collectionName,Map<String, Object> data) {
		TableConfig tc = ModelConfigHelper.getTableConfig(collectionName);
		if(tc != null){
			List<ColumnConfig> ccs = tc.getColumns();
			for(ColumnConfig cc:ccs){
				String prop = cc.getProperty();
				String value = StringUtil.toEmptyString(data.get(prop));
				if("string".equals(cc.getType())){
					if(value.length()>cc.getLength()){
						throw new  RuntimeException(cc.getLabel() +" ["+cc.getField()+" ] 超长，值为：" + value);
					}
				}
			}
		}
		if(!skipSso){
			User user = sso.getUser();
			if(user!=null){
				if(Util.isEmpty(data.get("orgid"))){
					data.put("orgid", user.getOrgid());
				}
				if(Util.isEmpty(data.get("cuid"))){
					data.put("cuid", user.getUid());
				}
				if(Util.isEmpty(data.get("uuid"))){
					data.put("uuid", user.getUid());
				}
				if(Util.isEmpty(data.get("caid"))){
					data.put("caid", user.getAid());
				}
				if(Util.isEmpty(data.get("uaid"))){
					data.put("uaid", user.getAid());
				}
			}else{
				throw new RuntimeException("用户没用登录系统，当前用户对象为空");
			}
		}
		/**
		 * 添加默认字段数据
		 */
		//integer 数据是否被使用  1、已经被使用  0、没有被使用     默认为 0
		if(Util.isEmpty(data.get("used"))){
			data.put("used", 0);
		}
		//integer 删除标记    1 删除   0 没有删除  默认为  0
		if(Util.isEmpty(data.get("del"))){
			data.put("del", 0);
		}
		
		//创建日期(不含时分秒) 数据格式 yyyyMMdd 数字类型，如：20150202
		data.put("cdate", NumberUtil.toInteger(DateUtil.format(new Date(), "yyyyMMdd")));
		//修改日期(不含时分秒) 数据格式 yyyyMMdd 数字类型，如：20150202
		data.put("udate", NumberUtil.toInteger(DateUtil.format(new Date(), "yyyyMMdd")));
	}
	@Override
	public void updateBefore(String collectionName,Map<String, Object> data) {
		if(Util.isNotEmpty(data.get("cuid"))){
			data.remove("cuid");
		}
		if(Util.isNotEmpty(data.get("caid"))){
			data.remove("caid");
		}
		if(Util.isNotEmpty(data.get("cdate"))){
			//创建日期(不含时分秒) 数据格式 yyyyMMdd 数字类型，如：20150202
			data.remove("cdate");
		}
		if(!skipSso){
			User user = sso.getUser();
			if(user!=null){
				data.put("uuid",user.getUid());
				data.put("uaid",user.getAid());
			}else{
				throw new RuntimeException("用户没用登录系统，当前用户对象为空");
			}
		}
		//修改日期(不含时分秒) 数据格式 yyyyMMdd 数字类型，如：20150202
		data.put("udate", NumberUtil.toInteger(DateUtil.format(new Date(), "yyyyMMdd")));
	}
	
	@Override
	public void removeBefore(String collectionName, Map<String, Object> query) {
	}
	/**
	 * 查看每一条数据，对数据通用字段进行格式化处理
	 */
	@Override
	public void watchData(Map<String,Object> rowData){
		//将默认的 cts uts date 类型格式化 yyyy-MM-dd HH:mm:ss
		//默认的带有 毫秒数
		/*Object cts = rowData.get("cts");
		if(cts!=null && cts instanceof Date){
			rowData.put("cts", DateUtil.format((Date)cts, "yyyy-MM-dd HH:mm:ss"));
		}
		Object uts = rowData.get("uts");
		if(uts!=null && uts instanceof Date){
			rowData.put("uts", DateUtil.format((Date)uts, "yyyy-MM-dd HH:mm:ss"));
		}*/
	}
}
