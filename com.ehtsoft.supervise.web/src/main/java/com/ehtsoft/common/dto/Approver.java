package com.ehtsoft.common.dto;

import java.util.List;

/**
 * 审批人
 * @author 王宝
 */
public class Approver {
	/**
	 * 审批人的ID
	 */
	private String id;
	/**
	 * 审批人姓名
	 */
	private String name;
	/**
	 * 审批人级别
	 * <br>
	 * 审批级别，从1 开始，数值越大，审批级别越高，同一个机构中的审批级别相等的时候，有一个审批通过，该级别就设置为通过
	 */
	private int lvl;
	/**
	 * 审核工作组，如果没有工作组的时候，值为null
	 */
	private List<Approver> teams;
	/**
	 * 审批的team，审批组的标记（存在team的时候，该值才获取数据）
	 * <br>
	 * 同组协调审批<br>
	 * 0 (false) 表示同组（同一个机构的同一级别）有一个审核通过，就走下一个流程<br>
	 * 1 (true)  表示同组（同一个机构的同一级别）所有相同级别的人审核通过后，就走下个流程<br>
	 */
	private boolean teamFlag;
	/**
	 * 审批人所在机构的名称
	 */
	private String orgname;
	/**
	 * 审批人所在机构的ID
	 */
	private String orgid;
	/**
	 * 当前审批人标记（审批完成后的下一个审批人）
	 * true 表示当前审批人
	 * false 表示审核完成或未审核的人
	 */
	private boolean curAudit = false;
	/**
	 * 审核状态
	 * 画流程图的时候用
	 * 0 待审状态（未审核状态）
	 * 1 通过状态
	 * 2 拒绝状态（不通过）
	 */
	private int auditStatus = 0;
	/**
	 * 审批人的ID
	 */
	public String getId() {
		return id;
	}
	/**
	 * 审批人的ID
	 */
	public void setId(String id) {
		this.id = id;
	}
	
	/**
	 * 审批人姓名
	 */
	public String getName() {
		return name;
	}
	/**
	 * 审批人姓名
	 */
	public void setName(String name) {
		this.name = name;
	}
	
	/**
	 * 审批人级别
	 * <br>
	 * 审批级别，从1 开始，数值越大，审批级别越高，同一个机构中的审批级别相等的时候，有一个审批通过，该级别就设置为通过
	 */
	public int getLvl() {
		return lvl;
	}
	
	/**
	 * 审批人级别
	 * <br>
	 * 审批级别，从1 开始，数值越大，审批级别越高，同一个机构中的审批级别相等的时候，有一个审批通过，该级别就设置为通过
	 */
	public void setLvl(int lvl) {
		this.lvl = lvl;
	}
	
	public List<Approver> getTeams() {
		return teams;
	}
	public void setTeams(List<Approver> teams) {
		this.teams = teams;
	}
	/**
	 * 审批的team
	 * <br>
	 * 同组协调审批<br>
	 * 0 (false) 表示同组（同一个机构的同一级别）有一个审核通过，就走下一个流程<br>
	 * 1 (true)  表示同组（同一个机构的同一级别）所有相同级别的人审核通过后，就走下个流程<br>
	 */
	public boolean isTeamFlag() {
		return teamFlag;
	}
	/**
	 * 审批的team
	 * <br>
	 * 同组协调审批<br>
	 * 0 (false) 表示同组（同一个机构的同一级别）有一个审核通过，就走下一个流程<br>
	 * 1 (true)  表示同组（同一个机构的同一级别）所有相同级别的人审核通过后，就走下个流程<br>
	 */
	public void setTeamFlag(boolean teamFlag) {
		this.teamFlag = teamFlag;
	}
	/**
	 * 审批人所在机构的名称
	 */
	public String getOrgname() {
		return orgname;
	}
	/**
	 * 审批人所在机构的名称
	 */
	public void setOrgname(String orgname) {
		this.orgname = orgname;
	}
	/**
	 * 审批人所在机构的ID
	 */
	public String getOrgid() {
		return orgid;
	}
	/**
	 * 审批人所在机构的ID
	 */
	public void setOrgid(String orgid) {
		this.orgid = orgid;
	}
	
	/**
	 * 审核状态
	 * 画流程图的时候用
	 * 0 待审状态（未审核状态）
	 * 1 通过状态
	 * 2 拒绝状态（不通过）
	 */
	public int getAuditStatus() {
		return auditStatus;
	}
	
	/**
	 * 审核状态
	 * 画流程图的时候用
	 * 0 待审状态（未审核状态）
	 * 1 通过状态
	 * 2 拒绝状态（不通过）
	 */
	public void setAuditStatus(int auditStatus) {
		this.auditStatus = auditStatus;
	}
	/**
	 * 当前审批人标记（审批完成后的下一个审批人）
	 * true 表示当前审批人
	 * false 表示审核完成或未审核的人
	 */
	public boolean isCurAudit() {
		return curAudit;
	}
	/**
	 * 当前审批人标记（审批完成后的下一个审批人）
	 * true 表示当前审批人
	 * false 表示审核完成或未审核的人
	 */
	public void setCurAudit(boolean curAudit) {
		this.curAudit = curAudit;
	}
	
	
}
