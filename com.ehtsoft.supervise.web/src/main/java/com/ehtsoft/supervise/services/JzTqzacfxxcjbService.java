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
 * 社区矫正-提请治安处罚信息采集表
 * 
 * @author Administrator
 */
@Service("JzTqzacfxxcjbService")
public class JzTqzacfxxcjbService extends AbstractService {
	
	@Resource(name="AuditService")
	private AuditService auditService;
	
	@Resource(name="SSOService")
	private SSOService ssoService;
	
	@Resource(name = "sqlDbClient")
	private SqlDbClient dbClient;
	
	/*@PostConstruct
	public void init(){
		try {
			AuditBill bill = new AuditBill();
			bill.setId(SupConst.Collections.JZ_TQZAQFXICJB);
			bill.setName("治安处罚上报");
			auditService.regAuditBill(bill);
		}catch(Exception ex) {}
	}*/
	//jz_tqzaqfxicjb
	/**
	 *查询矫正人员治安处罚的基本信息
	 */
	public ResultList<BasicMap<String, Object>> find(BasicMap<String, Object> data, Paginate paginate) {
		SqlDbFilter filter = toSqlFilter(data);
		User user = ssoService.getUser();
		/*String sqlstr ="select distinct a.audit,b.f_id, c.id,c.tqly,c.tqyj,c.sfssqr,c.aid,c.orgid,"
				+ "d.sqjzrybh,d.xm,d.xb,d.grlxdh,d.orgid "
				+ "from SYS_AUDIT_APPROVER a "
				+ "inner join SYS_AUDIT_APPLY b on a.f_applyid = b.f_id "
				+ "inner join JZ_TQZAQFXICJB c on c.id = b.f_bsid "
				+ "inner join JZ_JZRYJBXX d on  d.id = c.aid";
				*/
		String sqlstr="select a.*,b.id,b.xm,b.xb,b.grlxdh,b.mz,b.sfzh,b.sqjzrybh as jzrybh from JZ_TQZAQFXICJB a inner join JZ_JZRYJBXX b on b.id = a.aid";
		SQLAdapter sql = new SQLAdapter(sqlstr);
			
		if(Util.isNotEmpty(data.get("audit"))){
			filter.eq("a.AUDIT", NumberUtil.toInt(data.get("audit")));
		}
		filter.eq("JCJZ", "0");
		filter.in("b.orgid", user.getOrgidSet());
		//filter.eq("a.f_approver", user.getAid());
		filter.desc("a.audit");
		sql.setFilter(filter);
		ResultList<BasicMap<String,Object>> list = dbClient.find(sql,paginate,new RowDataListener() {
		
			public void processData(BasicMap<String, Object> rowData) {
				 rowData.put("sqsj", DateUtil.format(rowData.get("sqsj"), "yyyy-MM-dd "));
				 rowData.put("xsfjspsj", DateUtil.format(rowData.get("xsfjspsj"), "yyyy-MM-dd "));
			
				 if (Util.isNotEmpty(rowData.get("xsfjshyj"))) {
					rowData.put("spyj", rowData.get("xsfjshyj"));
				}else if (Util.isNotEmpty(rowData.get("dsfjshyj"))) {
					rowData.put("spyj", rowData.get("dsfjshyj"));
				}else {
					rowData.put("spyj", "待县司法局审核");
				}
			}
		});
		
		return list;
	}
	/**
	 * 保存警告信息
	 * 
	 * @param data
	 *            提请治安处罚信息采集数据 数据格式：见 JZ_TQZAQFXICJB 表
	 */
	public void save(BasicMap<String, Object> data) {
		User user = ssoService.getUser();
		dbClient.save(SupConst.Collections.JZ_TQZAQFXICJB, data);
		/*String aid = StringUtil.toString(data.get("aid"));
		if(aid==null){
			throw new AppException("上报治安处罚的服刑人员不能为空");
		}
		BasicMap<String, Object> one = dbClient.findOne("select xm from jz_jzryjbxx where id = ?",aid);
		String fxryxm = StringUtil.toString(one.get("xm"));
		AuditApply auditApply = new AuditApply();
		auditApply.setBillid(SupConst.Collections.JZ_TQZAQFXICJB);
		auditApply.setBsid(StringUtil.toString(data.get("ID")));
		auditApply.setTitle(fxryxm + "的治安处罚上报");
	    auditApply.setContent("提请理由："+StringUtil.toEmptyString(data.get("TQLY")) + "\n 提请依据：" + StringUtil.toEmptyString(data.get("TQYJ")) );
	    //auditApply.setTimearea(StringUtils.toString(data.get("timearea")));
	    auditApply.setName(user.getName());
		auditService.applyAudit(auditApply);*/
	}
	
	/**
	 * 获取单据审批的流程
	 */
	/*public List<Approver> findApprover(String applyId) {
		return auditService.findApprover(SupConst.Collections.JZ_TQZAQFXICJB, applyId);
	}
	public List<AuditHistory> getAuditHistory(String applyId){
		List<AuditHistory> list =auditService.getAuditHistory(applyId);
		return list;
	}	*/
	/**
	 * 获取服刑人员信息
	 */
	public List<BasicMap<String,Object>> findJzry(BasicMap<String, Object> query){
		User user = ssoService.getUser();
		Set<String> orgids = user.getOrgidSet();  //获取当前登录人的orgid
		//根据orgid查找数据
		String sqlstr = " SELECT id,xm,xb,sfzh,grlxdh FROM jz_jzryjbxx";
		SQLAdapter sql = new SQLAdapter(sqlstr);
		sql.setFilter(toSqlFilter(query).desc("cts"));
		sql.getFilter().in("orgid", orgids).eq("JCJZ","0");
		List<BasicMap<String,Object>> rtn = dbClient.find(sql);
		return rtn;
	}
	
	//保存审批
		public void saveSp(BasicMap<String, Object> data) {
			dbClient.save(SupConst.Collections.JZ_TQZAQFXICJB, data);
			/*String cid = StringUtil.toEmptyString(data.get("id"));
			BasicMap<String,Object> apply = dbClient.findOne("select f_id from SYS_AUDIT_APPLY where f_bsid =?",cid);
			String id = StringUtil.toEmptyString(apply.get("f_id"));
			Integer auditStatus = NumberUtil.toInteger(data.get("audit"));
			String remark = StringUtil.toEmptyString(data.get("xsfjshyj"));
			auditService.auditing(id, auditStatus,remark);*/
		}
		
		/**
		 * 获取审批的详情
		 */
		public BasicMap<String, Object> findOne(String id) {
			String sqlstr = "select b.xm,b.xb,b.sfzh,b.sqjzrybh,c.jzlb,c.sqjzqx,c.jzsssq,c.sqjzksrq,c.sqjzjsrq,c.jtzm,c.ypxq,a.*,"
					+ "d.hjszdmx,d.gdjzdmx " + "FROM JZ_TQZAQFXICJB a "
					+ "inner join JZ_JZRYJBXX b on b.id=a.aid "
					+ "inner join JZ_JZRYJBXX_JZ c on c.id=a.aid "
					+ "inner join JZ_JZRYJBXX_DZ d on d.id=a.aid and a.id='" + id + "'";// sql
			SQLAdapter sql = new SQLAdapter(sqlstr);
			// String sqlstr1 = "select * from JZ_JZRYJBXX_JZ where id=?";//sql
			BasicMap<String, Object> basicMap = dbClient.findOne(sql);// 根据ID获取个人基本信息
		return basicMap;
		}
	
}