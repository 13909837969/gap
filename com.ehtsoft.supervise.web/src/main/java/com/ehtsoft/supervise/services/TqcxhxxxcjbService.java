package com.ehtsoft.supervise.services;

import java.util.List;
import java.util.Set;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;

import org.bouncycastle.i18n.filter.SQLFilter;
import org.springframework.stereotype.Service;

import com.ehtsoft.common.dto.Approver;
import com.ehtsoft.common.dto.AuditApply;
import com.ehtsoft.common.dto.AuditBill;
import com.ehtsoft.common.dto.AuditHistory;
import com.ehtsoft.common.services.AuditService;
import com.ehtsoft.common.services.SSOService;
import com.ehtsoft.fw.core.context.AppException;
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

@Service("TqcxhxxxcjbService")
public class TqcxhxxxcjbService extends AbstractService{
	
	@Resource(name="AuditService")
	private AuditService auditService;
	
	@Resource(name="sqlDbClient")
	private SqlDbClient dbclient;

	@Resource(name="SSOService")
	private SSOService service;

	@PostConstruct
	public void init(){
		try {
			AuditBill bill = new AuditBill();
			bill.setId(SupConst.Collections.JZ_TQCXHXXXCJB);
			bill.setName("撤销缓刑上报");
			auditService.regAuditBill(bill);
		}catch(Exception ex) {}
	}
	//查询所有矫正人员基本信息
	public ResultList<BasicMap<String,Object>> findAll(BasicMap<String, Object> data,Paginate paginate){
		SqlDbFilter filter = toSqlFilter(data);
		User user = service.getUser();
		String sqlstr ="select distinct a.audit,b.f_id, c.id,c.tqly,c.tqyj,c.sfssqr,c.aid,c.orgid,"
				+ "d.sqjzrybh,d.xm,d.xb,d.grlxdh,d.orgid "
				+ "from SYS_AUDIT_APPROVER a "
				+ "inner join SYS_AUDIT_APPLY b on a.f_applyid = b.f_id "
				+ "inner join JZ_TQCXHXXXCJB c on c.id = b.f_bsid "
				+ "inner join JZ_JZRYJBXX d on  d.id = c.aid";
				
		SQLAdapter sql = new SQLAdapter(sqlstr);
			
		if(Util.isNotEmpty(data.get("audit"))){
			filter.eq("c.AUDIT", NumberUtil.toInt(data.get("audit")));
		}
		
		sql.setFilter(filter);
		filter.eq("JCJZ", "0");
		filter.in("d.orgid", user.getOrgidSet());
		//判断当前登录是否为司法所，如果不是司法所按审批流程走
		filter.eq("a.f_approver", user.getAid());
		
		filter.desc("a.audit");
		ResultList<BasicMap<String,Object>> list = dbclient.find(sql,paginate);
		
		return list;
	}
	
	//添加申请审核信息
	public void save(BasicMap<String, Object> data){
		User user = service.getUser();
		dbclient.save(SupConst.Collections.JZ_TQCXHXXXCJB, data);
		String aid = StringUtil.toString(data.get("aid"));
		if(aid==null) {
			throw new AppException("上报撤销缓刑的服刑人员不能为空");
		}
		BasicMap<String, Object> one = dbclient.findOne("select xm from jz_jzryjbxx where id=?",aid);
		String fxrmxm = StringUtil.toString(one.get("xm"));
		AuditApply auditApply = new AuditApply();
		auditApply.setBillid(SupConst.Collections.JZ_TQCXHXXXCJB);
		auditApply.setBsid(StringUtil.toString(data.get("id")));
		auditApply.setTitle(fxrmxm+"的撤销缓刑上报");
		auditApply.setContent("提请理由"+StringUtil.toEmptyString(data.get("tqly"))+"\n提请依据:"+StringUtil.toEmptyString(data.get("tqyj")));
		auditApply.setName(user.getName());
		auditService.applyAudit(auditApply);
	}
	
	//保存审批
	public void saveSp(BasicMap<String, Object> data) {
		String cid = StringUtil.toEmptyString(data.get("id"));
		BasicMap<String,Object> apply = dbclient.findOne("select f_id from SYS_AUDIT_APPLY where f_bsid =?",cid);
		String id = StringUtil.toEmptyString(apply.get("f_id"));
		Integer auditStatus = NumberUtil.toInteger(data.get("audit"));
		String remark = StringUtil.toEmptyString(data.get("xsfjshyj"));
		auditService.auditing(id, auditStatus,remark);
	}
	
	//获取服刑人员信息
	public List<BasicMap<String, Object>> findJzry(BasicMap<String,Object> query){
		User user = service.getUser();
		SqlDbFilter filter =toSqlFilter(query);
		Set<String> orgids = user.getOrgidSet();//获取当前登录人的ordid
		//根据orgid查找数据
		String sqlstr = "select id,xm,xb,sfzh,grlxdh from jz_jzryjbxx";
		SQLAdapter sql = new SQLAdapter(sqlstr);
		sql.setFilter(filter.desc("cts"));
		sql.getFilter().in("orgid", orgids).eq("JCJZ", "0");
		List<BasicMap<String, Object>> rtn = dbclient.find(sql);
		return rtn;
		
	}
	/**
	 * 获取单据审批的流程
	 */
	public List<Approver> findApprover(String applyId) {
		return auditService.findApprover(SupConst.Collections.JZ_TQCXHXXXCJB, applyId);
	}
	public List<AuditHistory> getAuditHistory(String applyId){
		List<AuditHistory> list =auditService.getAuditHistory(applyId);
		return list;
	}	
}
