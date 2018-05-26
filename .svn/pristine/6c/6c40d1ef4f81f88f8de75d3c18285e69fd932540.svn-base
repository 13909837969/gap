package com.ehtsoft.supervise.services;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;

import org.apache.lucene.queryparser.flexible.core.util.StringUtils;
import org.springframework.stereotype.Service;

import com.ehtsoft.common.dto.Approver;
import com.ehtsoft.common.dto.AuditApply;
import com.ehtsoft.common.dto.AuditBill;
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
 * 社区矫正-警告信息采集表
 * 
 * @author Administrator
 */
@Service("JgxxcjbService")
public class JgxxcjbService extends AbstractService {
	
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
			bill.setId(SupConst.Collections.JZ_JGXXCJB);
			bill.setName("警告上报");
			auditService.regAuditBill(bill);
		}catch(Exception ex) {}
	}

	/**
	 * 获取警告信息列表
	 * 
	 * @param data
	 * @param paginate
	 * 			@return
	 * 	{ jzryid 矫正人员id jzrybh 矫正人员编号 jgli 警告理由 jgyj 警告依据
	 *            sfssqr 司法所申请人 sfssqsj 司法所申请时间 sfsshr 司法所审核人 sfsshsj 司法所审核时间
	 *            sfsshyj 司法所审核意见 xsfjspr 县司法局审批人 xsfjspsj 县司法局审批时间 xsfjspyj
	 *            县司法局审批意见 }
	 */
	public ResultList<BasicMap<String, Object>> find(BasicMap<String, Object> data, Paginate paginate) {
		User user = ssoService.getUser();
		SqlDbFilter filter = toSqlFilter(data);
		String sql = "select b.id,a.sqjzrybh,a.xm,a.xb,a.grlxdh,a.orgid,a.sfzh,b.jgly,b.jgyj,b.sfssqr,b.sfssqsj,b.audit from JZ_JZRYJBXX  a inner join JZ_JGXXCJB  b on a.ID = b.F_AID";
		SQLAdapter sqlAdapter = new SQLAdapter(sql);
		if(Util.isNotEmpty(data.get("audit"))){
			filter.eq("b.AUDIT",NumberUtil.toInt(data.get("audit")));
		}
		sqlAdapter.setFilter(filter);
		filter.in("a.orgid",user.getOrgidSet());
		ResultList<BasicMap<String, Object>> list = dbClient.find(sqlAdapter, paginate);
		return list;

	}
	
	
	
	/**
	 * 获取司法所警告信息列表
	 * 
	 * @param data
	 * @param paginate
	 * 			@return
	 * 	{ jzryid 矫正人员id jzrybh 矫正人员编号 jgli 警告理由 jgyj 警告依据
	 *            sfssqr 司法所申请人 sfssqsj 司法所申请时间 sfsshr 司法所审核人 sfsshsj 司法所审核时间
	 *            sfsshyj 司法所审核意见 xsfjspr 县司法局审批人 xsfjspsj 县司法局审批时间 xsfjspyj
	 *            县司法局审批意见 }
	 */
	public ResultList<BasicMap<String, Object>> findSfs(BasicMap<String, Object> data, Paginate paginate) {
		User user = ssoService.getUser();
		SqlDbFilter filter = toSqlFilter(data);
		String sql = "select a.audit,b.f_id,e.sqjzrybh,e.xm,e.xb,e.grlxdh,e.sfzh,c.id,c.jgly,c.jgyj,c.sfssqr,c.sfssqsj,c.sfsspr,"
				+ "c.sfsspsj,c.sfsspyj,c.xsfjspr,xsfjspsj,c.xsfjspyj "
				+ "from SYS_AUDIT_APPROVER  a "
				+ " inner join SYS_AUDIT_APPLY b on a.f_applyid=b.f_id "
				+ " inner join JZ_JGXXCJB  c on c.id=b.f_bsid  "
				
				+ " inner join JZ_JZRYJBXX e on e.id=c.f_aid ";
		SQLAdapter sqlAdapter = new SQLAdapter(sql);
		if(Util.isNotEmpty(data.get("audit"))){
			filter.eq("a.AUDIT",NumberUtil.toInt(data.get("audit")));
		}
		sqlAdapter.setFilter(filter);
		filter.eq("c.orgid",user.getOrgid());
		ResultList<BasicMap<String, Object>> list = dbClient.find(sqlAdapter, paginate,new RowDataListener() {
			
			@Override
			public void processData(BasicMap<String, Object> rowData) {
				rowData.put("sfssqsj", DateUtil.format(rowData.get("sfssqsj"),"yyyy-MM-dd"));
			}
		});
		return list;

	}
	
	/**
	 * 获取司法局警告信息列表
	 * 
	 * @param data
	 * @param paginate
	 * 			@return
	 * 	{ jzryid 矫正人员id jzrybh 矫正人员编号 jgli 警告理由 jgyj 警告依据
	 *            sfssqr 司法所申请人 sfssqsj 司法所申请时间 sfsshr 司法所审核人 sfsshsj 司法所审核时间
	 *            sfsshyj 司法所审核意见 xsfjspr 县司法局审批人 xsfjspsj 县司法局审批时间 xsfjspyj
	 *            县司法局审批意见 }
	 */
	public ResultList<BasicMap<String, Object>> findSfj(BasicMap<String, Object> data, Paginate paginate) {
		User user = ssoService.getUser();
		SqlDbFilter filter = toSqlFilter(data);
		String sql = "select a.audit,b.f_id,e.sqjzrybh,e.xm,e.xb,e.grlxdh,e.sfzh,c.id,c.jgly,c.jgyj,c.sfssqr,c.sfssqsj,c.sfsspr,"
				+ "c.sfsspsj,c.sfsspyj,c.xsfjspr,xsfjspsj,c.xsfjspyj,d.jgmc,d.id "
				+ "from SYS_AUDIT_APPROVER  a "
				+ " inner join SYS_AUDIT_APPLY b on a.f_applyid=b.f_id "
				+ " inner join JZ_JGXXCJB  c on c.id=b.f_bsid  "
				+ " left join jc_sfxzjgjbxx d on d.id=c.orgid"
				+ " inner join JZ_JZRYJBXX e on e.id=c.f_aid ";
		SQLAdapter sqlAdapter = new SQLAdapter(sql);
		filter.in("c.orgid", user.getOrgidSet());
		filter.eq("a.f_approver", user.getAid());
		if(Util.isNotEmpty(data.get("audit"))){
			filter.eq("b.AUDIT",NumberUtil.toInt(data.get("audit")));
		}
		sqlAdapter.setFilter(filter);
		
		ResultList<BasicMap<String, Object>> list = dbClient.find(sqlAdapter, paginate,new RowDataListener() {
			
			@Override
			public void processData(BasicMap<String, Object> rowData) {
				rowData.put("sfssqsj", DateUtil.format(rowData.get("sfssqsj"),"yyyy-MM-dd"));
			}
		});
		return list;

	}
	
	
	

	/**
	 * 保存警告信息
	 * 
	 * @param data
	 *            警告信息采集数据 数据格式：见 JZ_JGXXCJB 表
	 * 
	 */
	public void save(BasicMap<String, Object> data) {
		User user = ssoService.getUser();
		dbClient.save(SupConst.Collections.JZ_JGXXCJB, data);
		String aid = StringUtil.toString(data.get("f_aid"));
		if(aid==null){
			throw new AppException("上报警告的服刑人员不能为空");
		}
		BasicMap<String, Object> one = dbClient.findOne("select xm from jz_jzryjbxx where id = ?",aid);
		String fxryxm = StringUtil.toString(one.get("xm"));
		AuditApply auditApply = new AuditApply();
		auditApply.setBillid(SupConst.Collections.JZ_JGXXCJB);
		auditApply.setBsid(StringUtil.toString(data.get("ID")));
		auditApply.setTitle(fxryxm + "的警告上报");
	    auditApply.setContent("警告理由："+StringUtil.toEmptyString(data.get("JGLY")) + "\n 警告依据：" + StringUtil.toEmptyString(data.get("JGYJ")) );
	    //auditApply.setTimearea(StringUtils.toString(data.get("timearea")));
	    auditApply.setName(user.getName());
		auditService.applyAudit(auditApply);
	}
	
	/**
	 * 机构查询
	 * @param query
	 * @param paginate
	 * @return
	 */
	public List<BasicMap<String,Object>> findOrgid(BasicMap<String,Object> query){
		User user = ssoService.getUser();
		List<BasicMap<String,Object>> list=new ArrayList<>();
		if(user!=null) {
			SqlDbFilter filter = toSqlFilter(query);
			String sql = "SELECT" + 
					"   a.id," + 
					"	a.jgmc," + 
					"	b.region_name," + 
					"	a.fzr," +  
					"	a.lxdh" +  
					"   FROM" + 
					"   jc_sfxzjgjbxx a"+
					"   LEFT JOIN sys_region b ON a.regionid=b.regionid";;
			SQLAdapter adapter = new SQLAdapter(sql);
			filter.eq("a.parentid", user.getOrgid());
			filter.like("a.jgmc", "司法所");
			adapter.setFilter(filter);
			list = dbClient.find(adapter);
		  }
		return list;
	}
	
	
	
	/**
	 * 获取单据审批的流程
	 */
	public List<Approver> findApprover(){
		return auditService.findApprover(SupConst.Collections.JZ_JGXXCJB);
	}
	/**
	 * 保存审批
	 * @param data
	 */
	public void saveSp(BasicMap<String, Object> data) {
		dbClient.save(SupConst.Collections.JZ_JGXXCJB, data);
		String cid = StringUtil.toEmptyString(data.get("id"));
		BasicMap<String,Object> apply = dbClient.findOne("select f_id from SYS_AUDIT_APPLY where f_bsid =?",cid);
		String id = StringUtil.toEmptyString(apply.get("f_id"));
		Integer auditStatus = NumberUtil.toInteger(data.get("audit"));
		String remark = StringUtil.toEmptyString(data.get("sfsspyj"));
		auditService.auditing(id, auditStatus,remark);
	}
	 
	/**
	 * 获取服刑人员信息
	 */
	public List<BasicMap<String,Object>> findJzry(BasicMap<String,Object> data){
		User user = ssoService.getUser();
		SQLAdapter sql = new SQLAdapter("select id,xm,grlxdh from JZ_JZRYJBXX");
		sql.getFilter().eq("orgid", user.getOrgid());
		sql.getFilter().eq("jcjz", "0");
		return dbClient.find(sql);
	}
}
