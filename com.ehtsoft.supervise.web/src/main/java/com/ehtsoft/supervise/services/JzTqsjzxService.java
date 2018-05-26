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
import com.ehtsoft.fw.utils.NumberUtil;
import com.ehtsoft.fw.utils.StringUtil;
import com.ehtsoft.fw.utils.Util;
import com.ehtsoft.supervise.api.SupConst;
/**
 * 提请收监执行信息Service
 */
@Service("JzTqsjzxService")
public class JzTqsjzxService extends AbstractService{
	
	@Resource(name="AuditService")
	private AuditService auditService;

	@Resource(name = "sqlDbClient")
	private SqlDbClient dbClient;
	
	@Resource(name="SSOService")
	private SSOService ssoService;
	
	@PostConstruct
	public void init(){
		try {
			AuditBill bill = new AuditBill();
			bill.setId(SupConst.Collections.JZ_TQSJZXXXCJB);
			bill.setName("收监执行上报");
			auditService.regAuditBill(bill);
		}catch(Exception ex) {}
	}
	
	/**
	 * 获取收监执行列表
	 *
	 * @return
	 */
	public ResultList<BasicMap<String, Object>> find(BasicMap<String, Object> data, Paginate paginate) {
		User user = ssoService.getUser();
		Set<String> orgld = user.getOrgidSet();
		SqlDbFilter filter = toSqlFilter(data);
		String sql = "select distinct b.id,b.aid,a.sqjzrybh,a.xm,a.xb,a.grlxdh,a.sfzh,a.orgid,a.cuid,c.f_id," + 
				"b.tqly,b.tqyj,b.sfssqr,b.sfssqsj,b.sfsshr,b.sfsshsj,b.sfsshyj,b.xsfjspr,b.xsfjspsj,b.xsfjshyj,b.jgyj," + 
				"d.audit from JZ_JZRYJBXX a " + 
				"inner join JZ_TQSJZXXXCJB b on a.ID = b.AID " +
				"INNER JOIN sys_audit_apply c on b.Id = c.f_bsid " + 
				"INNER JOIN sys_audit_approver d on d.f_applyid = c.f_id ";
		SQLAdapter sqlAdapter = new SQLAdapter(sql);
		if(Util.isNotEmpty(data.get("audit"))){
			filter.eq("b.audit",NumberUtil.toInt(data.get("audit")));
		}
		sqlAdapter.setFilter(filter);
		filter.eq("JCJZ","0");
		filter.in("a.orgid", user.getOrgidSet());
		//判断当前登录是否为司法所(不是则按当前登录用户的审批权限查询申请信息)
		if(!"4".equals(StringUtil.toEmptyString(user.getOrgType()))){
		}
		filter.eq("d.f_approver",user.getAid());
		filter.desc("d.audit");
		ResultList<BasicMap<String, Object>> list = dbClient.find(sqlAdapter, paginate);
		return list;
	}
	/**
	 * 保存收监执行信息
	 * @param data
	 *           
	 */
	public void save(BasicMap<String, Object> data) {
		User user = ssoService.getUser();
		dbClient.save(SupConst.Collections.JZ_TQSJZXXXCJB, data);
		String aid = StringUtil.toString(data.get("aid"));
		if(aid==null){
			throw new AppException("上报提请收监执行的服刑人员不能为空");
		}
		BasicMap<String, Object> one = dbClient.findOne("select xm from jz_jzryjbxx where id = ?",aid);
		String fxryxm = StringUtil.toString(one.get("xm"));
		AuditApply auditApply = new AuditApply();
		auditApply.setBillid(SupConst.Collections.JZ_TQSJZXXXCJB);
		auditApply.setBsid(StringUtil.toString(data.get("ID")));
		auditApply.setAid(user.getAid());
		auditApply.setTitle(fxryxm + "的收监执行上报");
	    auditApply.setContent("提请理由："+StringUtil.toEmptyString(data.get("TQLY")) + "\n 提请依据：" + StringUtil.toEmptyString(data.get("TQYJ")) );
	    //auditApply.setTimearea(StringUtils.toString(data.get("timearea")));
	    auditApply.setName(user.getName());
		auditService.applyAudit(auditApply);
		
	}
	/**
	 * 获取单据审批的流程
	 */
	public List<Approver> findApprover(String applyId){
		return auditService.findApprover(SupConst.Collections.JZ_TQSJZXXXCJB,applyId);
	}
	
	/**
	 * 获取单据的审批流程by  Billid
	 */
	public List<Approver> findApproverByBillid(String billid){
		return auditService.findApprover(billid);
	}


	/**
	 * 获取矫正人员信息
	 */
	public List<BasicMap<String,Object>> findJzry(BasicMap<String, Object> query){
		User user = ssoService.getUser();
		//获取当前登录人的orgid
		Set<String> orgids = user.getOrgidSet();  
		//根据orgid查找数据
		String sqlstr = " SELECT id,xm,xb,sfzh,grlxdh FROM jz_jzryjbxx";
		SQLAdapter sql = new SQLAdapter(sqlstr);
		sql.setFilter(toSqlFilter(query).desc("cts"));
		sql.getFilter().in("orgid", orgids).eq("JCJZ","0");
		List<BasicMap<String,Object>> rtn = dbClient.find(sql);
		return rtn;
	}
	
	//查询审批记录
	public List<AuditHistory> getAuditHistory(String f_id){
		/*BasicMap<String, Object> one = dbClient.findOne("SELECT f_id from sys_audit_apply where f_bsid = ? ",id);
		String applyid= StringUtil.toEmptyString(one.get("f_id"));
		return auditService.getAuditHistory(applyid);*/
		return auditService.getAuditHistory(f_id);
	}
	
	/**
	 * 单据审核
	 */
	
	public void auditSh(BasicMap<String, Object> data){
		BasicMap<String,Object> one = dbClient.findOne("SELECT F_ID from SYS_AUDIT_APPLY WHERE f_bsid = ?",StringUtil.toEmptyString(data.get("id")));
		String applyid = StringUtil.toEmptyString(one.get("F_ID"));
		Integer auditStatus = NumberUtil.toInteger(data.get("audit"));
		String remark= StringUtil.toEmptyString(one.get("xsfjshyj"));
		auditService.auditing(applyid, auditStatus, remark);
	}
}
