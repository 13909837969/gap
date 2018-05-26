package com.ehtsoft.common.services;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ehtsoft.common.dto.Approver;
import com.ehtsoft.common.dto.AuditApply;
import com.ehtsoft.common.dto.AuditBill;
import com.ehtsoft.common.dto.AuditHistory;
import com.ehtsoft.fw.core.context.AppException;
import com.ehtsoft.fw.core.db.RowDataListener;
import com.ehtsoft.fw.core.db.SQLAdapter;
import com.ehtsoft.fw.core.db.SqlDbClient;
import com.ehtsoft.fw.core.db.SqlDbFilter;
import com.ehtsoft.fw.core.dto.BasicMap;
import com.ehtsoft.fw.core.dto.Paginate;
import com.ehtsoft.fw.core.dto.ResultList;
import com.ehtsoft.fw.core.sso.User;
import com.ehtsoft.fw.core.utils.ReflectUtil;
import com.ehtsoft.fw.utils.BooleanUtil;
import com.ehtsoft.fw.utils.NumberUtil;
import com.ehtsoft.fw.utils.StringUtil;
import com.ehtsoft.fw.utils.Util;
import com.ehtsoft.supervise.api.SupConst;

/**
 * 审批服务
 * @author wangbao
 */
@Service("AuditService")
public class AuditService {
	/**
	 * 审核状态
	 * <br>
	 * 通过状态
	 */
	public final static int AUDIT_STATUS_PASS = 1;
	/**
	 * 审核状态
	 * <br>
	 * 拒绝状态（不通过）
	 */
	public final static int AUDIT_STATUS_REFUSE = 2;
	
	@Resource(name="sqlDbClient")
	private SqlDbClient dbClient;
	
	@Resource(name="SSOService")
	private SSOService ssoService;

	private String fieldPrefix = "F_";
	
	/**
	 * 审批单据注册
	 * @param auditBill 单据对象（类型）
	 * @see <br>
	 * auditBill: {@link com.ehtsoft.common.dto.AuditBill}
	 */
	public void regAuditBill(AuditBill auditBill){
		String sql = "select F_ID from SYS_AUDIT_BILL where F_ID = ?";
		BasicMap<String,Object> map = dbClient.findOne(sql, auditBill.getId());
		if(map == null){
			dbClient.insert(SupConst.Collections.SYS_AUDIT_BILL, ReflectUtil.bean2Map(auditBill, fieldPrefix));
		}
	}
	
	/**
	 * 审批申请(如外出申请)
	 * @param auditApply 申请单据内容  
	 * @see <br>auditApply:{@link com.ehtsoft.common.dto.AuditApply}<br>
	 * @return 返回申请审核单据内容的主键
	 */
	public String applyAudit(AuditApply auditApply){
		BasicMap<String, Object> basicMap = dbClient.findOne("SELECT F_NAME FROM SYS_AUDIT_BILL WHERE F_ID = ?", auditApply.getBillid());
		if(basicMap==null){
			throw new AppException("单据类型["+auditApply.getBillid() + "]未注册");
		}
		BasicMap<String,Object> data = ReflectUtil.bean2Map(auditApply, fieldPrefix);

		dbClient.insert(SupConst.Collections.SYS_AUDIT_APPLY, data);
		final String pk = StringUtil.toString(data.get("F_ID"));
		
		List<Approver> approvers = findApprover(auditApply.getBillid());
		if(approvers.isEmpty()){
			String billname = StringUtil.toString(basicMap.get("F_NAME"));
			throw new AppException("单据 【"+billname+"】没有配置审批流程");
		}
		List<BasicMap<String, Object>> list = new ArrayList<>();
		Approver app = approvers.get(0);
		if(app.getTeams()==null){
			BasicMap<String,Object> item = new BasicMap<>();
			item.put("F_APPLYID", pk);
			item.put("F_APPROVER",app.getId());
			item.put("F_LVL", app.getLvl());
			item.put("ORGID", app.getOrgid());
			list.add(item);
		}else{
			for(Approver a : app.getTeams()){
				BasicMap<String,Object> item = new BasicMap<>();
				item.put("F_APPLYID", pk);
				item.put("F_APPROVER",a.getId());
				item.put("F_LVL", a.getLvl());
				item.put("ORGID", a.getOrgid());
				list.add(item);
			}
		}
		dbClient.insert(SupConst.Collections.SYS_AUDIT_APPROVER, list);
		return pk;
	}
	
	/**
	 * 获取单据审批的流程
	 * @param orgid
	 * @return
	 */
	public List<Approver> findApprover(final String billid){
		User user = ssoService.getUser();
		String sqlstr = "SELECT AC.F_BILLID,AC.F_APPROVER,AC.F_LVL,AC.F_TEAMID,AC.ORGID,AC.REMARK," +
						" gzry.XM as NAME,JG.JGMC AS ORGNAME FROM SYS_AUDIT_CONFIG AC " +
						" LEFT JOIN jc_sfxzjggzryjbxx gzry ON AC.F_APPROVER = gzry.ID" +
						" LEFT JOIN jc_sfxzjgjbxx jg on AC.ORGID = jg.ID" +
						" WHERE F_BILLID = '" + billid + "' AND AC.ORGID = '"+user.getOrgid()+"'" +
						" ORDER BY F_LVL ASC";
		
		SQLAdapter sql = new SQLAdapter(sqlstr);
		final List<Approver> rtn = new ArrayList<>();
		dbClient.find(sql,new RowDataListener() {
			public void processData(BasicMap<String, Object> rowData) {
				Approver approver = new Approver();
				approver.setId(StringUtil.toString(rowData.get("F_APPROVER")));
				approver.setName(StringUtil.toString(rowData.get("NAME")));
				final int lvl = NumberUtil.toInt(rowData.get("F_LVL"));
				approver.setLvl(lvl);
				approver.setOrgid(StringUtil.toString(rowData.get("ORGID")));
				approver.setOrgname(StringUtil.toString(rowData.get("ORGNAME")));
				if(Util.isNotEmpty(rowData.get("F_TEAMID"))){
					//审批工作组 F_TEAMID 不为空的时候(存在审批工作组的时候)
					BasicMap<String, Object> team = dbClient.findOne(SupConst.Collections.SYS_AUDIT_TEAM, new SqlDbFilter().eq("F_TEAMID", rowData.get("F_TEAMID")));
					if(team!=null){
						//工作组的时候，Approver.name 值为工作组的 name,id = 工作组的ID;
						String teamid = StringUtil.toString(rowData.get("F_TEAMID"));
						approver.setId(teamid);
						approver.setName(StringUtil.toString(team.get("F_TEAMNAME")));
						//同组协调审批 0 (false) 表示同组（同一个机构的同一级别）有一个审核通过，就走下一个流程
						//          1 (true)  表示同组（同一个机构的同一级别）所有相同级别的人审核通过后，就走下个流程
						approver.setTeamFlag(NumberUtil.toInt(team.get("F_FLAG"))==1);
						final List<Approver> teams = new ArrayList<>();
						String str = "SELECT F_APPROVER,XM AS NAME,TA.ORGID,JG.JGMC AS ORGNAME FROM SYS_AUDIT_TEAM_APPROVER TA"
									  + " INNER JOIN JC_SFXZJGGZRYJBXX JZ ON TA.F_APPROVER = JZ.ID"
									  + " INNER JOIN JC_SFXZJGJBXX JG ON JG.ID = TA.ORGID"
									  + " WHERE F_TEAMID = '" + teamid + "'";
						
						dbClient.find(new SQLAdapter(str),new RowDataListener() {
							@Override
							public void processData(BasicMap<String, Object> d) {
								Approver app = new Approver(); 
								app.setId(StringUtil.toString(d.get("F_APPROVER")));
								app.setName(StringUtil.toString(d.get("NAME")));
								app.setLvl(lvl);
								app.setOrgid(StringUtil.toString(d.get("ORGID")));
								app.setOrgname(StringUtil.toString(d.get("ORGNAME")));
								teams.add(app);
							}
						});
						approver.setTeams(teams);
					}
				}
				rtn.add(approver);
			}
		});
		return rtn;
	}
	
	/**
	 * 根据单据类型ID 及 单据申请的ID 获取单据目前申请的审批情况
	 * @param billid  单据类型ID  SYS_AUDIT_BILL.F_ID
	 * @param applyId 申请审批单据的ID SYS_AUDIT_APPLY.F_ID
	 * @return 返回审批人的流程数据，状态见 auditStatus 属性
	 * @author wangbao
	 * @date   2018年3月18日
	 */
	public List<Approver> findApprover(final String billid,String applyId){
		List<Approver> apps = findApprover(billid);
		
		String sqlstr = "SELECT f_approver,f_lvl,audit FROM SYS_AUDIT_APPROVER where F_APPLYID = '"+SqlDbFilter.convertSqlParameter(applyId)+"'";
		final BasicMap<String,BasicMap<String,Object>> map = new BasicMap<>();
		dbClient.find(new SQLAdapter(sqlstr),new RowDataListener() {
			@Override
			public void processData(BasicMap<String, Object> rowData) {
				String key = StringUtil.toString(rowData.get("f_approver")) + StringUtil.toString(rowData.get("f_lvl"));
				BasicMap<String,Object> bm = new BasicMap<>();
				int aut = NumberUtil.toInt(rowData.get("audit"));
				bm.put("audit", aut);
				if(aut == 0) {
					bm.put("curAudit", true);
				}else {
					bm.put("curAudit", false);
				}
				map.put(key,bm);
			}
		});
		
		for(Approver app:apps){
			String key = app.getId() + app.getLvl();
			if(map.get(key)!=null){
				app.setAuditStatus(NumberUtil.toInt(map.get(key).get("audit")));
				app.setCurAudit(BooleanUtil.toBoolean(map.get(key).get("curAudit")));
			}
			if(app.getTeams()!=null){
				for(Approver a : app.getTeams()){
					String k = a.getId() + a.getLvl();
					if(map.get(k)!=null){
						a.setAuditStatus(NumberUtil.toInt(map.get(k).get("audit")));
						a.setCurAudit(BooleanUtil.toBoolean(map.get(k).get("curAudit")));
					}
				}
			}
		}
		return apps;
	}
	
	/**
	 * 单据审核（审核人员进行单据审核）
	 * <br>
	 * 审批人员进行审批的操作方法
	 * @param applyid 申请单据内容的ID (主键)
	 * @param auditStatus 审核的状态
	 * <br>
	 * @see <br>auditStatus 值为：<br>
	 * 		{@link AuditService#AUDIT_STATUS_PASS}<br>
	 * 		{@link AuditService#AUDIT_STATUS_REFUSE}
	 * @param remark 审核备注信息，如：通过不通过的原因等
	 */
	public void auditing(String applyid,Integer auditStatus,String remark){
		if(Util.isEmpty(applyid)){
			throw new AppException("审批单据ID不能为空");
		}
		if(auditStatus != AUDIT_STATUS_PASS && auditStatus != AUDIT_STATUS_REFUSE){
			throw new AppException("审核状态只能是 1 AUDIT_STATUS_PASS 或 2 AUDIT_STATUS_REFUSE");
		}
		BasicMap<String,Object> one = dbClient.findOne("SELECT F_BILLID,F_BSID FROM SYS_AUDIT_APPLY WHERE F_ID = ?",applyid);
		if(one == null){
			throw new AppException("["+applyid+"] 审批单据内容不存在");
		}
		User user = ssoService.getUser();
		String sqlstr = "SELECT * FROM SYS_AUDIT_APPROVER WHERE audit = 0 AND F_APPLYID = '"+applyid+"' AND F_APPROVER = '"+user.getAid()+"' ORDER BY F_LVL ASC";
		//根据为审批的状态 及 审批单据内容ID 和 审批人ID 获取审批人级别信息
		BasicMap<String, Object> firstApprover = dbClient.findFirstData(new SQLAdapter(sqlstr));
		if(firstApprover==null){
			throw new AppException("你没有该数据的审核权限");
		}
		BasicMap<String,Object> result = new BasicMap<>();
		//单据申请记录ID
		result.put("F_APPLYID", applyid);
		//审批人ID
		result.put("F_APPROVER", user.getAid());
		//审核标记
		result.put("audit", auditStatus);
		//审批备注（原因）
		result.put("remark", remark);
		//审核结果
		dbClient.insert(SupConst.Collections.SYS_AUDIT_RESULT, result);
		//更新审核人单据的状态（当前审核人的审核状态）
		BasicMap<String, Object> data1 = new BasicMap<>();
		data1.put("audit", auditStatus);
		data1.put("F_ID", firstApprover.get("F_ID"));
		dbClient.update(SupConst.Collections.SYS_AUDIT_APPROVER, data1);
		//dbClient.updateSql("UPDATE SYS_AUDIT_APPROVER SET audit = ? WHERE F_ID = ?", auditStatus,firstApprover.get("F_ID"));
		//如果审批通过后，审批流程转到下一个审批人，如果审批不通过，直接驳回到申请人的申请单据，不通过
		if(AUDIT_STATUS_PASS==auditStatus){
			String billid = StringUtil.toString(one.get("F_BILLID"));
			//审批通过的时候,获去下一个审批人，将下一个审批人保存到 SYS_AUDIT_APPROVER 中
			List<Approver> approvers = findApprover(billid);
			//当前审核人的级别
			int currentLvl = NumberUtil.toInt(firstApprover.get("F_LVL"));
			// 大于(>) 当前人的级别作为下一个审核人
			int index = -1;
			for(int i=0;i<approvers.size();i++){
				if(approvers.get(i).getLvl()>currentLvl){
					index = i;
					break;
				}
			}
			if(index==-1){
				//当前审批人是最后一个审批人的时候 (单据申请信息记录表)
				dbClient.updateSql("UPDATE SYS_AUDIT_APPLY SET audit = ? WHERE F_ID = ?", auditStatus,applyid);
			}else{
				//当前审批人不是最后一个审批人的时候
				//还有下一个审批人的时候，将下一个流程的审批人保存到  SYS_AUDIT_APPROVER （单据审批人流程信息记录表） 表中
				List<BasicMap<String, Object>> ls = new ArrayList<>();
				Approver app = approvers.get(index);
				//下一个审核人的标记
				boolean next = true;
				if(app.getTeams()==null){
					BasicMap<String,Object> item = new BasicMap<>();
					item.put("F_APPLYID", applyid);
					item.put("F_APPROVER",app.getId());
					item.put("F_LVL", app.getLvl());
					item.put("ORGID", app.getOrgid());
					ls.add(item);
				}else{
					/*
					 * 0 (false) 表示同组（同一个机构的同一级别）有一个审核通过，就走下一个流程
					 * 1 (true) 表示同组（同一个机构的同一级别）所有相同级别的人审核通过后，就走下个流程
					 */
					if(app.isTeamFlag()){
						//和当前审核人的级别人的级别一样的审核人员同时没有审核的情况，如果改级别没有审核完成，不走下一级别
						sqlstr = "SELECT F_ID FROM SYS_AUDIT_APPROVER WHERE audit = 0 AND F_LVL = "+currentLvl+" AND F_APPLYID = '"+applyid+"'";
						List<BasicMap<String, Object>> l = dbClient.find(new SQLAdapter(sqlstr));
						//l 不为空的时候表示当前级别已经审核完成
						if(!l.isEmpty()){
							//当前级别的人存在没有审核的时候 next = false
							next = false;
						}
					}
					for(Approver a : app.getTeams()){
						BasicMap<String,Object> item = new BasicMap<>();
						item.put("F_APPLYID", applyid);
						item.put("F_APPROVER",a.getId());
						item.put("F_LVL", a.getLvl());
						item.put("ORGID", a.getOrgid());
						ls.add(item);
					}
				}
				//走下一个审批人流程
				if(next){
					dbClient.insert(SupConst.Collections.SYS_AUDIT_APPROVER, ls);
				}
			}
		}else if(AUDIT_STATUS_REFUSE==auditStatus){
			//未审核通过
			//当前审批人是最后一个审批人的时候 (单据申请信息记录表)
			dbClient.updateSql("UPDATE SYS_AUDIT_APPLY SET audit = ? WHERE F_ID = ?", auditStatus,applyid);
		}
		
		//修改 JZ_WCSQXXCJB 的审批状态
		BasicMap<String, Object> jb_map = new BasicMap<>();
		jb_map.put("ID", one.get("F_BSID"));
		jb_map.put("audit", auditStatus);
		dbClient.update(SupConst.Collections.JZ_WCSQXXCJB, jb_map);
	}

	/**
	 * 获取申请单据的内容
	 * @param query
	 * {
	 *   name:"申请人名称",
	 *   audit:审批状态, 0 待审批   1 通过    2 不通过   9 已审批 ( 不等于 1 的情况为一审核状态),
	 *   @see 
	 * 		{@link AuditService#AUDIT_STATUS_PASS}<br>
	 * 		{@link AuditService#AUDIT_STATUS_REFUSE}
	 *   billid:"单据类型",（sys_audit_bill.F_ID）
	 *   
	 * }
	 * @param paginate
	 * @return
	 */
	public ResultList<AuditApply> findAuditApply(BasicMap<String, Object> query,Paginate paginate){
		User user = ssoService.getUser();
		ResultList<AuditApply> rtn = new ResultList<>();
		String sqlstr = "select apply.*,app.audit as auditing,bill.f_name as f_billname from sys_audit_apply apply "
						+ " inner join sys_audit_bill  bill   on apply.f_billid = bill.f_id "
						+ " inner join sys_audit_approver app on apply.f_id = app.f_applyid ";
		
		SQLAdapter sql = new SQLAdapter(sqlstr);
		int audit = NumberUtil.toInt(query.get("audit"));
		sql.getFilter().like("apply.F_NAME", StringUtil.toString(query.get("name")));
		if(audit==9) {
			sql.getFilter().unEq("app.audit", 0);
		}else {
			sql.getFilter().eq("app.audit", audit);
		}
		sql.getFilter().eq("apply.f_billid", StringUtil.toString(query.get("billid")));
		//获取当前审批人需要审批的内容
		sql.getFilter().eq("app.F_APPROVER", user.getAid());
		sql.getFilter().desc("apply.cts");
		final List<AuditApply> rows = new ArrayList<>();
	    Paginate page = dbClient.find(sql,paginate,new RowDataListener() {
			public void processData(BasicMap<String, Object> rowData) {
				rows.add(ReflectUtil.map2Bean(rowData, AuditApply.class,fieldPrefix));
			}
		}).getPaginate();
	    
	    rtn.setRows(rows);
	    rtn.setPaginate(page);
	    
	    return rtn;
	}
	
	/**
	 * 手机端使用
	 * 获取申请单据的内容
	 * @param query
	 * {
	 *   name:"申请人名称",
	 *   audit:审批状态, 0 待审批   1 通过    2 不通过   9 已审批 ( 不等于 1 的情况为一审核状态),
	 *   @see 
	 * 		{@link AuditService#AUDIT_STATUS_PASS}<br>
	 * 		{@link AuditService#AUDIT_STATUS_REFUSE}
	 *   billid:"单据类型",（sys_audit_bill.F_ID）
	 *   
	 * }
	 * @param paginate
	 * @return
	 */
	public ResultList<AuditApply> findPhoneAuditApply(BasicMap<String, Object> query,Paginate paginate){
		User user = ssoService.getUser();
		ResultList<AuditApply> rtn = new ResultList<>();
		String sqlstr = "select apply.*,app.audit as auditing,bill.f_name as f_billname from sys_audit_apply apply "
						+ " inner join sys_audit_bill  bill   on apply.f_billid = bill.f_id "
						+ " inner join sys_audit_approver app on apply.f_id = app.f_applyid ";
		
		SQLAdapter sql = new SQLAdapter(sqlstr);
		sql.getFilter().like("apply.F_NAME", StringUtil.toString(query.get("name")));
		sql.getFilter().eq("apply.f_billid", StringUtil.toString(query.get("billid")));
		sql.getFilter().eq("apply.f_aid", StringUtil.toString(query.get("f_aid")));
		//获取当前审批人需要审批的内容
		sql.getFilter().eq("app.F_APPROVER", user.getAid());
		sql.getFilter().desc("apply.cts");
		final List<AuditApply> rows = new ArrayList<>();
	    Paginate page = dbClient.find(sql,paginate,new RowDataListener() {
			public void processData(BasicMap<String, Object> rowData) {
				rows.add(ReflectUtil.map2Bean(rowData, AuditApply.class,fieldPrefix));
			}
		}).getPaginate();
	    
	    rtn.setRows(rows);
	    rtn.setPaginate(page);
	    
	    return rtn;
	}

	/**
	 * 获取当前工作人员 未审核的数量
	 * @return
	 */
	public int getUnauditedCount(){
		User user = ssoService.getUser();
		String sqlstr = "SELECT count(1) as cnt FROM SYS_AUDIT_APPROVER WHERE F_APPROVER = ? AND AUDIT = 0";
		
		int r =  NumberUtil.toInt(dbClient.countSql(sqlstr, user.getAid()));
		
		return r;
	}
	/**
	 * 获取已审核的数量
	 * @return
	 */
	public int getAuditedCount(){
		return 0;
	}
	
	/**
	 * 根据审批单据ID 获取审核记录的历史信息
	 * @param applyid
	 * @return
	 */
	public List<AuditHistory> getAuditHistory(String applyid){
		String sqlstr = "select ar.f_applyid,ar.f_approver,ar.audit,ar.cts,ar.remark,jc.xm as name from SYS_AUDIT_RESULT ar "
						+ " inner join jc_sfxzjggzryjbxx jc on ar.f_approver=jc.id "
						+ " where f_applyid = '"+SqlDbFilter.convertSqlParameter(applyid)+"'";
		SQLAdapter sql = new SQLAdapter(sqlstr);
		
		final List<AuditHistory> rtn = new ArrayList<>();
		dbClient.find(sql,new RowDataListener() {
			@Override
			public void processData(BasicMap<String, Object> rowData) {
				AuditHistory ah = ReflectUtil.map2Bean(rowData, AuditHistory.class, fieldPrefix);
				rtn.add(ah);
			}
		});
		return rtn;
	}	
	/**
	 * 保存审批流程配置信息
	 */
	public void saveConfig(){
		
	}
}
