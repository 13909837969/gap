package com.ehtsoft.user.utils;
/**
 * 系统参数 （系统初始参数相关设置）
 * @author wangbao
 */
public class SysParamUtil {
	/**
	 * 获取 实体机构级别   医疗平台实体机构级别 lvl>=4 实体机构<br/>
	 * 
	 * 企业平台  实体机构 lvl>=2 为 实体企业
	 * 实体机构：指操作业务数据的机构（填报机构等）
	 * 医疗平台中：>=4 时，在进行机构设置的时候，提供默认 OSA 账户及权限功能
	 * 具体见 com.ehtsoft.user.services.PsaOrganizationService.save 方法
	 * @return
	 */
	public static int getEntityOrgLevel(){
		// 医疗机构实体机构 >=4   1省   2市   3区   4医院  5 ...
		// 企业   1 集团  2 公司（实体）  3 部门
		return 4;
	}
	/**
	 * 得到机构编码位数（定义机构编码位数）
	 * 医疗平台  机构编码位数为   行政区划+4 位流水号
	 * @return
	 */
	public static int getOrgCodeDigit(){
		// 4 为流水号
		return 4;
	}
}
