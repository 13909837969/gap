package com.ehtsoft.common.dto;

import com.ehtsoft.fw.core.dto.Basic;

/**
 * 审批单据（类型）
 * @author 王宝
 */
public class AuditBill extends Basic{
	/**
	 * 审批单据ID（表名作为ID注册）
	 */
	private String id;
	/**
	 * 审批单据的名称
	 */
	private String name;
	
	/**
	 * 审批单据ID（表名作为ID注册）
	 */
	public String getId() {
		return id;
	}
	/**
	 * 审批单据ID（表名作为ID注册）
	 */
	public void setId(String id) {
		this.id = id;
	}
	/**
	 * 审批单据的名称
	 */
	public String getName() {
		return name;
	}
	/**
	 * 审批单据的名称
	 */
	public void setName(String name) {
		this.name = name;
	}
}
