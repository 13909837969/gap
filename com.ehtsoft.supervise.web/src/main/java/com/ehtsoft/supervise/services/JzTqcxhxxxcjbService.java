package com.ehtsoft.supervise.services;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ehtsoft.common.services.AuditService;
import com.ehtsoft.common.services.SSOService;
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
import com.ehtsoft.fw.utils.Util;
import com.ehtsoft.supervise.api.SupConst;

@Service("JzTqcxhxxxcjbService")
public class JzTqcxhxxxcjbService extends AbstractService{
	
	@Resource(name="AuditService")
	private AuditService auditService;
	
	@Resource(name="sqlDbClient")
	private SqlDbClient dbclient;

	@Resource(name="SSOService")
	private SSOService service;

/*	@PostConstruct
	public void init(){
		try {
			AuditBill bill = new AuditBill();
			bill.setId(SupConst.Collections.JZ_TQCXHXXXCJB);
			bill.setName("撤销缓刑上报");
			auditService.regAuditBill(bill);
		}catch(Exception ex) {}
	}*/
	//查询所有矫正人员撤销缓刑的基本信息
	public ResultList<BasicMap<String,Object>> findAll(BasicMap<String, Object> data,Paginate paginate){
		SqlDbFilter filter = toSqlFilter(data);
		User user = service.getUser();
		/*String sqlstr ="select distinct a.audit,b.f_id, c.id,c.tqly,c.tqyj,c.sfssqr,c.aid,c.orgid,"
				+ "d.sqjzrybh,d.xm,d.xb,d.grlxdh,d.orgid "
				+ "from SYS_AUDIT_APPROVER a "
				+ "inner join SYS_AUDIT_APPLY b on a.f_applyid = b.f_id "
				+ "inner join JZ_TQCXHXXXCJB c on c.id = b.f_bsid "
				+ "inner join JZ_JZRYJBXX d on  d.id = c.aid";*/
		String sqlstr="select a.*,b.id,b.xm,b.xb,b.grlxdh,b.mz,b.sfzh,b.sqjzrybh as jzrybh from JZ_TQCXHXXXCJB a inner join JZ_JZRYJBXX b on b.id = a.aid";
		SQLAdapter sql = new SQLAdapter(sqlstr);
			
		if(Util.isNotEmpty(data.get("audit"))){
			filter.eq("a.AUDIT", NumberUtil.toInt(data.get("audit")));
		}
		Set audits=new HashSet<>();
		audits.add(1);
		audits.add(2);
		audits.add(4);
		//地司法局审批信息筛选
		if(user.getOrgType()==2) {
			filter.in("a.audit", audits);
		}
		
		filter.eq("JCJZ", "0");
		filter.in("b.orgid", user.getOrgidSet());
		//filter.eq("a.f_approver", user.getAid());
		filter.desc("a.audit");
		sql.setFilter(filter);
		ResultList<BasicMap<String,Object>> list = dbclient.find(sql,paginate,new RowDataListener() {
		
			public void processData(BasicMap<String, Object> rowData) {
				 rowData.put("sqsj", DateUtil.format(rowData.get("sqsj"), "yyyy-MM-dd "));
				 rowData.put("xsfjspsj", DateUtil.format(rowData.get("xsfjspsj"), "yyyy-MM-dd "));
			}
		});
		
		return list;
	}
	
	//添加申请审核信息
	public void save(BasicMap<String, Object> data){
		User user = service.getUser();
		dbclient.save(SupConst.Collections.JZ_TQCXHXXXCJB, data);
		/*String aid = StringUtil.toString(data.get("aid"));
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
		auditService.applyAudit(auditApply);*/
	}
	
	//保存审批
	public void saveSp(BasicMap<String, Object> data) {
		dbclient.save(SupConst.Collections.JZ_TQCXHXXXCJB, data);
	/*	String cid = StringUtil.toEmptyString(data.get("id"));
		BasicMap<String,Object> apply = dbclient.findOne("select f_id from SYS_AUDIT_APPLY where f_bsid =?",cid);
		String id = StringUtil.toEmptyString(apply.get("f_id"));
		Integer auditStatus = NumberUtil.toInteger(data.get("audit"));
		String remark = StringUtil.toEmptyString(data.get("xsfjshyj"));
		auditService.auditing(id, auditStatus,remark);*/
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
	 * 获取审批的详情
	 */
	public BasicMap<String, Object> findOne(String id) {
		String sqlstr = "select b.xm,b.xb,b.sfzh,b.sqjzrybh,c.jzlb,c.sqjzqx,c.jzsssq,c.sqjzksrq,c.sqjzjsrq,c.jtzm,c.ypxq,a.*,"
				+ "d.hjszdmx,d.gdjzdmx " + "FROM JZ_TQCXHXXXCJB a "
				+ "left join JZ_JZRYJBXX b on b.id=a.aid "
				+ "left join JZ_JZRYJBXX_JZ c on c.id=a.aid "
				+ "left join JZ_JZRYJBXX_DZ d on d.id=a.aid "
				+ "where a.id='" + id + "'";// sql
		SQLAdapter sql = new SQLAdapter(sqlstr);
		// String sqlstr1 = "select * from JZ_JZRYJBXX_JZ where id=?";//sql
		BasicMap<String, Object> basicMap = dbclient.findOne(sql);// 根据ID获取个人基本信息
	return basicMap;
	}
	/**
	 * 获取单据审批的流程
	 */
	/*public List<Approver> findApprover(String applyId) {
		return auditService.findApprover(SupConst.Collections.JZ_TQCXHXXXCJB, applyId);
	}
	public List<AuditHistory> getAuditHistory(String applyId){
		List<AuditHistory> list =auditService.getAuditHistory(applyId);
		return list;
	}	*/
}
