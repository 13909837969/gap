package com.ehtsoft.common.dto;

import com.ehtsoft.fw.core.dto.Basic;

/**
 * 审核结果历史记录对象信息
 */
public class AuditHistory extends Basic{
	/**
	 * 申请审批单据ID (AuditApply.id)
	 */
	private String applyid;
	
	/**
	 * 审批人ID (Approver.id)
	 */
	private String approver;
	
	/**
	 * 审核人姓名
	 */
	private String name;
	
	/**
	 * 申请审批单据ID (AuditApply.id)
	 */
	public String getApplyid() {
		return applyid;
	}
	
	/**
	 * 申请审批单据ID (AuditApply.id)
	 */
	public void setApplyid(String applyid) {
		this.applyid = applyid;
	}
	
	/**
	 * 审批人ID (Approver.id)
	 */
	public String getApprover() {
		return approver;
	}
	
	/**
	 * 审批人ID (Approver.id)
	 */
	public void setApprover(String approver) {
		this.approver = approver;
	}
	
	/**
	 * 审核人姓名
	 */
	public String getName() {
		return name;
	}
	
	/**
	 * 审核人姓名
	 */
	public void setName(String name) {
		this.name = name;
	}
}
