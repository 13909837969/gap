package com.ehtsoft.supervise.services;

import java.util.List;
import java.util.Set;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ehtsoft.common.dto.Approver;
import com.ehtsoft.common.dto.AuditApply;
import com.ehtsoft.common.dto.AuditBill;
import com.ehtsoft.common.dto.AuditHistory;
import com.ehtsoft.common.services.AuditService;
import com.ehtsoft.common.services.SSOService;
import com.ehtsoft.fw.core.context.AppException;
import com.ehtsoft.fw.core.db.RowDataListener;
import com.ehtsoft.fw.core.db.SQLAdapter;
import com.ehtsoft.fw.core.db.SqlDbClient;
import com.ehtsoft.fw.core.db.SqlDbFilter;
import com.ehtsoft.fw.core.dto.BasicMap;
import com.ehtsoft.fw.core.dto.Paginate;
import com.ehtsoft.fw.core.dto.ResultList;
import com.ehtsoft.fw.core.services.AbstractService;
import com.ehtsoft.fw.core.sso.User;
import com.ehtsoft.fw.utils.DateUtil;
import com.ehtsoft.fw.utils.NumberUtil;
import com.ehtsoft.fw.utils.StringUtil;
import com.ehtsoft.fw.utils.Util;
import com.ehtsoft.supervise.api.SupConst;

/**
 * 社区矫正-外出监管采集表
 * 
 * @author Administrator
 */
@Service("JzrywcjgService")
public class JzrywcjgService extends AbstractService {
	
	@Resource(name="AuditService")
	private AuditService auditService;
	
	@Resource(name="SSOService")
	private SSOService ssoService;
	
	@Resource(name = "sqlDbClient")
	private SqlDbClient dbClient;
	
	@PostConstruct
	public void init(){
		try {
			AuditBill bill = new AuditBill();
			bill.setId(SupConst.Collections.JZ_WCSQXXCJB);
			bill.setName("外出申请上报");
			auditService.regAuditBill(bill);
		}catch(Exception ex) {}
	}
	//jz_tqzaqfxicjb
	/**
	 * 获取治安处罚列表
	 * @param data
	 * @param paginate
	 * 			@return
	 * 	{ jzryid 矫正人员id jzrybh 矫正人员编号 tqli 提请理由 tqyj 提请依据
	 *            sfssqr 司法所申请人 sfssqsj 司法所申请时间 sfsshr 司法所审核人 sfsshsj 司法所审核时间
	 *            sfsshyj 司法所审核意见 xsfjspr 县司法局审批人 xsfjspsj 县司法局审批时间 xsfjspyj
	 *            县司法局审批意见 }
	 */
	public ResultList<BasicMap<String, Object>> find(BasicMap<String, Object> data, Paginate paginate) {
		SqlDbFilter filter = toSqlFilter(data);
		User user = ssoService.getUser();
		/*String sqlstr ="select distinct a.audit,b.f_id,c.*,"
				+ "d.sqjzrybh as jzrybh,d.xm "
				+ "from SYS_AUDIT_APPROVER a "
				+ "inner join SYS_AUDIT_APPLY b on a.f_applyid = b.f_id "
				+ "inner join JZ_WCSQXXCJB c on c.id = b.f_bsid "
				+ "inner join JZ_JZRYJBXX d on  d.id = c.f_aid ";  
				*/
		String sqlstr="select a.*,b.id,b.xm,b.sqjzrybh as jzrybh from JZ_WCSQXXCJB a inner join JZ_JZRYJBXX b on b.id = a.f_aid";
		SQLAdapter sql = new SQLAdapter(sqlstr);
			
		if(Util.isNotEmpty(data.get("audit"))){
			filter.eq("a.AUDIT", NumberUtil.toInt(data.get("audit")));
		}	
		if(user.getOrgType()==3){
			filter.gt("wcts", 7);
			filter.eq("a.audit", 1);
		}
		
		filter.eq("JCJZ", "0");
		filter.in("b.orgid", user.getOrgidSet());
		//判断当前登录是否为司法所，如果不是司法所按审批流程走
		//filter.eq("a.f_approver", user.getAid());
		
		filter.desc("a.audit");
		sql.setFilter(filter);
		
		ResultList<BasicMap<String, Object>> list = dbClient.find(sql, paginate,new RowDataListener() {
			public void processData(BasicMap<String, Object> rowData) {
				 rowData.put("sqsj", DateUtil.format(rowData.get("sqsj"), "yyyy-MM-dd"));
				 rowData.put("sfsshsj", DateUtil.format(rowData.get("sfsshsj"), "yyyy-MM-dd"));
				 rowData.put("xsfjspsj", DateUtil.format(rowData.get("xsfjspsj"), "yyyy-MM-dd "));
			
			if (Util.isNotEmpty(rowData.get("xsfjspyj"))) {
				rowData.put("spyj", rowData.get("xsfjspyj"));
			} else if (Util.isNotEmpty(rowData.get("sfsshyj"))) {
				rowData.put("spyj", rowData.get("sfsshyj"));
			} else {
				rowData.put("spyj", "待司法所审核");
			}
		  }
		});
		
		return list;
	}
	/**
	 *查询外出监管申请表
	 */
	public void save(BasicMap<String, Object> data) {
		User user = ssoService.getUser();
		dbClient.save(SupConst.Collections.JZ_WCSQXXCJB, data);
		/*String f_aid = StringUtil.toString(data.get("f_aid"));
		if(f_aid==null){
			throw new AppException("外出申请的服刑人员不能为空");
		}
		BasicMap<String, Object> one = dbClient.findOne("select xm from jz_jzryjbxx where id = ?",f_aid);
		String fxryxm = StringUtil.toString(one.get("xm"));
		AuditApply auditApply = new AuditApply();
		auditApply.setBillid(SupConst.Collections.JZ_WCSQXXCJB);
		auditApply.setBsid(StringUtil.toString(data.get("ID")));
		auditApply.setTitle(fxryxm + "的外出申请的审批上报");
		auditApply.setContent("变更理由："+StringUtil.toEmptyString(data.get("TQLY")) );
		auditApply.setName(user.getName());
		auditService.applyAudit(auditApply);*/
	}
	/**
	 * 获取服刑人员信息
	 */
	public List<BasicMap<String,Object>> findJzry(BasicMap<String, Object> query){
		User user = ssoService.getUser();
		Set<String> orgids = user.getOrgidSet();  //获取当前登录人的orgid
		//根据orgid查找数据
		String sqlstr = " SELECT id,xm,sqjzrybh,xb,sfzh,grlxdh FROM jz_jzryjbxx";
		SQLAdapter sql = new SQLAdapter(sqlstr);
		sql.setFilter(toSqlFilter(query).desc("cts"));
		sql.getFilter().in("orgid", orgids).eq("JCJZ","0");
		List<BasicMap<String,Object>> rtn = dbClient.find(sql);
		return rtn;
	}
	
	//保存审批
		public void saveSp(BasicMap<String, Object> data) {
			dbClient.save(SupConst.Collections.JZ_WCSQXXCJB, data);
			/*String cid = StringUtil.toEmptyString(data.get("id"));
			BasicMap<String,Object> apply = dbClient.findOne("select f_id from SYS_AUDIT_APPLY where f_bsid =?",cid);
			String id = StringUtil.toEmptyString(apply.get("f_id"));
			Integer auditStatus = NumberUtil.toInteger(data.get("audit"));
			String remark = StringUtil.toEmptyString(data.get("xsfjshyj"));
			auditService.auditing(id, auditStatus,remark);*/
		}
		
		/**
		 * 获取审批详情
		 */
		public BasicMap<String, Object> findOne(String id) {
			String sqlstr = "select b.xm,b.xb,b.sfzh,b.sqjzrybh,c.jzlb,c.sqjzqx,c.jzsssq,c.sqjzksrq,c.sqjzjsrq,c.jtzm,c.ypxq,a.id,a.wcmddmx,a.wcly,"
					+ "a.sfsshyj,a.remark,a.xsfjspyj,"
					+ "d.hjszdmx,d.gdjzdmx " + "FROM JZ_WCSQXXCJB a "
					+ "inner join JZ_JZRYJBXX b on b.id=a.f_aid "
					+ "inner join JZ_JZRYJBXX_JZ c on c.id=a.f_aid "
					+ "inner join JZ_JZRYJBXX_DZ d on d.id=a.f_aid and a.id='" + id + "'";// sql
			SQLAdapter sql = new SQLAdapter(sqlstr);
			// String sqlstr1 = "select * from JZ_JZRYJBXX_JZ where id=?";//sql
			BasicMap<String, Object> basicMap = dbClient.findOne(sql);// 根据ID获取个人基本信息
		return basicMap;
		}
	
}