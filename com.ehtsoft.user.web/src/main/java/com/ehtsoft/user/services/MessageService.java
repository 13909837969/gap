package com.ehtsoft.user.services;

import java.util.List;

import javax.annotation.Resource;

import com.ehtsoft.fw.core.context.AppException;
import com.ehtsoft.fw.core.db.InsertOperation;
import com.ehtsoft.fw.core.db.SQLAdapter;
import com.ehtsoft.fw.core.db.SqlDbFilter;
import com.ehtsoft.fw.core.dto.AuditOpt;
import com.ehtsoft.fw.core.dto.BasicMap;
import com.ehtsoft.fw.core.sso.User;
import com.ehtsoft.fw.core.services.SqlBasicService;
import com.ehtsoft.fw.core.sso.SingleSignOnClient;
import com.ehtsoft.user.api.UserConst;
/**
 * 消息提醒记录服务
 * @author 王宝
 */
public class MessageService extends SqlBasicService{

	@Resource
	private SingleSignOnClient sso;
	/**
	 * 插入消息记录信息
	 * 数据格式：
	 * [{
	 * 	FROM_USER:发送的用户ID,
	 *  FROM_USERNAME:"发送的用户名字",
	 *  TO_USER:接受的用户ID,
	 *  TO_USERNAME:"接受的用户名",
	 *  TITLE:"消息标题",
	 *  CONTENT:"消息内容",
	 *  URL:"消息打开的URL"
	 * }]
	 * @throws AppException 
	 */
	public void insert(List<BasicMap<String,Object>> data) throws AppException{
		this.sqlDbClient.insert(UserConst.Collections.CORE_MESSAGE, data,new InsertOperation() {
			@Override
			public void insertBefore(BasicMap<String, Object> data) {
				data.put("FLAG", "0");//新进入的消息为未读状态
			}
			@Override
			public void insertAfter(BasicMap<String, Object> data) {
			}
		});
	}
	/**
	 * 更新读取标记
	 * @param data
	 * @throws AppException
	 */
	public void update(BasicMap<String,Object> data) throws AppException{
		this.sqlDbClient.update(UserConst.Collections.CORE_MESSAGE, new BasicMap<String,Object>("SYSID",data.get("SYSID"),"FLAG","1"));
	}
	/**
	 * 获取未读的数据列表
	 * @return
	 */
	public List<BasicMap<String,Object>> find(String flag){
//		User user = sso.getUser();
//		List<AuditOpt> opts = user.getAuditOpts();
//		StringBuffer flags = new StringBuffer();
//		StringBuffer level = new StringBuffer();
//		for(AuditOpt a : opts){
//			//flag
//			flags.append("'");
//			flags.append(a.getFlag());
//			flags.append("'");
//			flags.append(",");
//			//level
//			level.append("'");
//			level.append(a.getLevel());
//			level.append("'");
//			level.append(",");
//		}
//		if(level.length()>0){
//			level.deleteCharAt(level.length()-1);
//		}
//		if(flags.length()>0){
//			flags.deleteCharAt(flags.length()-1);
//		}
//		String sqlstr ="SELECT * FROM CORE_MESSAGE WHERE "
//				+ " TO_USER = "+user.getUserid()+" AND FLAG = '"+flag+"' "
//				+ (flags.length()>0?" OR (FLAG = '"+flag+"'"
//				+ " AND BILL_TYPE IN ("+flags+")"
//				+ " AND AUDIT_LEVEL IN ("+level+"))":"");
//		return this.sqlDbClient.find(new SQLAdapter(sqlstr));
		return null;
	}
}
