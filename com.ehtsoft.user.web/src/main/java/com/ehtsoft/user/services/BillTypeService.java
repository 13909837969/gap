package com.ehtsoft.user.services;

import java.util.ArrayList;
import java.util.List;

import com.ehtsoft.fw.core.context.AppException;
import com.ehtsoft.fw.core.db.RowDataListener;
import com.ehtsoft.fw.core.dto.BasicMap;
import com.ehtsoft.fw.core.services.SqlBasicService;
import com.ehtsoft.fw.utils.NumberUtil;
import com.ehtsoft.user.api.UserConst;

/**
 * 单据类型业务服务
 * 用于不同单据类型的审批权限
 * @author 王宝
 */
public class BillTypeService extends SqlBasicService{

	/**
	 * 获取单据类型列表数据
	 * @param query
	 * @return
	 * @throws AppException
	 */
	public List<BasicMap<String,Object>> find(BasicMap<String,Object> query) throws AppException{
		
		final List<BasicMap<String,Object>> auditOpts = this.sqlDbClient.find(UserConst.Collections.CORE_AUDIT_OPT,null);
		//AUDITID  CORE_AUDIT_OPT 的主键
		//BILLID   CORE_BILL_TYPE 的主键
		return this.sqlDbClient.find(UserConst.Collections.CORE_BILL_TYPE,toSqlFilter(query),new RowDataListener() {
			public void processData(BasicMap<String, Object> rowData) {
				/**
				 * 审批级别（暂时写死）
				 *
				List<BasicMap<String,Object>> l = new ArrayList<BasicMap<String,Object>>();
				**
				 * 当前审核通过状态      CPASS
				 * 当前审核不通过状态  NOTBY
				 * 前一审核通过状态      PPASS
				 * 表单类型ID     BILLID
				 * ==================
				 * 一级审核权限
				 * {CPASS:5,NOTBY:4,PPASS:0}
				 * 二级审核权限
				 * {CPASS:10,NOTBY:9,PPASS:5}
				 * 三级审核权限
				 * {CPASS:15,NOTBY:14,PPASS:10}
				 * 四级审核权限
				 * {CPASS:20,NOTBY:19,PPASS:15}
				 * 五级审核权限
				 * {CPASS:25,NOTBY:24,PPASS:20}
				 *
				l.add(new BasicMap<String, Object>("NAME","一级审核权限","CPASS",5,"NOTBY",4,"PPASS",0,"BILLID",rowData.get("SYSID"))); 
				l.add(new BasicMap<String, Object>("NAME","二级审核权限","CPASS",10,"NOTBY",9,"PPASS",5,"BILLID",rowData.get("SYSID"))); 
				l.add(new BasicMap<String, Object>("NAME","三级审核权限","CPASS",15,"NOTBY",14,"PPASS",10,"BILLID",rowData.get("SYSID"))); 
				l.add(new BasicMap<String, Object>("NAME","四级审核权限","CPASS",20,"NOTBY",19,"PPASS",15,"BILLID",rowData.get("SYSID"))); 
				//l.add(new BasicMap<String, Object>("NAME","五级审核权限","CPASS",25,"NOTBY",24,"PPASS",20)); 
				*/
				
				List<BasicMap<String,Object>> l = new ArrayList<BasicMap<String,Object>>();
				for(BasicMap<String,Object> b : auditOpts){
					b.put("AUDITID", b.get("SYSID"));
					if(NumberUtil.toLong(b.get("BILLID"))==NumberUtil.toLong(rowData.get("SYSID"))){
						l.add(b);
					}
				}
				rowData.put("children", l);
			}
		});
	}
}
