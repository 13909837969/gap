package com.ehtsoft.audit.services;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ehtsoft.common.dto.Approver;
import com.ehtsoft.common.dto.AuditApply;
import com.ehtsoft.common.services.AuditService;
import com.ehtsoft.common.services.SSOService;
import com.ehtsoft.fw.core.db.SQLAdapter;
import com.ehtsoft.fw.core.db.SqlDbClient;
import com.ehtsoft.fw.core.db.SqlDbFilter;
import com.ehtsoft.fw.core.dto.BasicMap;
import com.ehtsoft.fw.core.dto.Paginate;
import com.ehtsoft.fw.core.dto.ResultList;
import com.ehtsoft.fw.core.services.AbstractService;
import com.ehtsoft.fw.core.sso.User;
import com.ehtsoft.fw.utils.DateUtil;
import com.ehtsoft.fw.utils.StringUtil;
import com.ehtsoft.fw.utils.Util;
import com.ehtsoft.supervise.api.SupConst;
import com.ehtsoft.supervise.services.RegionService;
/**
 * 平板审批任务功能
 * @author GeiLaBa
 */
@Service("AuditApplyService")
public class AuditApplyService extends AbstractService {

	@Resource(name = "sqlDbClient")
	private SqlDbClient dbClient;

	@Resource(name = "SSOService")
	private SSOService service;

	@Resource(name="AuditService")
	private AuditService auditService;
	
	@Resource(name = "RegionService")
	private RegionService regionService;

	/**
	 * 
	 * @param status  0 待审状态   9 一审状态
	 * @param paginate
	 * @return
	 * android 平板使用
	 */
	public ResultList<AuditApply> findAuditApply(Integer status,Paginate paginate){
		BasicMap<String,Object> query = new BasicMap<>();
		query.put("audit", status);
		return auditService.findAuditApply(query, paginate);
	}
	/**
	 * @param paginate
	 * @return
	 * android 手机端使用
	 */
	public ResultList<AuditApply> findPhoneAuditApply(BasicMap<String,Object> query,Paginate paginate){
		return auditService.findPhoneAuditApply(query, paginate);
	}
	
	/**
	 * 
	 * @param applyid
	 * @param auditStatus
	 * @param remark
	 */
	public void auditing(String applyid,Integer auditStatus,String remark){
		auditService.auditing(applyid, auditStatus, remark);
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
		return auditService.findApprover(billid,applyId);
	}
	
	/**
	 * 
	 * @param bsid
	 * @param tablename
	 * @return
	 */
	public BasicMap<String, Object> findOne(String bsid, String tablename) {
		BasicMap<String, Object> map = new BasicMap<>();
		User user = service.getUser();
		String id = "";
		//这样写的原因是因为JZ_TQZAQFXICJB表里的矫正人员字段是aid 其他表的字段是f_aid 以后JZ_TQZAQFXICJB表里的aid改成f_aid的话下面的判断语句取消掉
		if(tablename.equals("JZ_TQZAQFXICJB")) {
			id = "b.aid";
		}else {
			id = "b.f_aid";
		}
		if (user != null) {
			String sqlStr = "select a.SQJZRYBH,a.XM,a.XB,a.GRLXDH,a.CSRQ,b.* from JZ_JZRYJBXX a "
					+ " inner join " + tablename + " b on " + id + " = a.id";
			SQLAdapter adapter = new SQLAdapter(sqlStr);
			SqlDbFilter filter = new SqlDbFilter();
			if("JZ_SQJZRYJRTDQYSPB".equals(tablename)) {
				filter.eq("b.f_id", bsid);
			} else {
				filter.eq("b.id", bsid);
			}
			adapter.setFilter(filter);
			map = dbClient.findOne(adapter);
			// cts时间类型转换为String
			if (Util.isNotEmpty(map.get("cts"))) {
				String ctsString = DateUtil.format(map.get("cts"), "yyyy-MM-dd HH:mm:ss");
				map.put("cts", ctsString);
			}
			// 添加矫正人员年龄 通过出生日计算
			if (Util.isNotEmpty(map.get("csrq"))) {
				map.put("nl", DateUtil.getAge(map.get("csrq")));
			}
			// 添加外出申请 外出目的地完整信息 省，市，县城，街道
			if("JZ_WCSQXXCJB".equals(tablename)) {
				StringBuffer buffer = new StringBuffer();
				buffer.append(regionService.getRegionName(StringUtil.toEmptyString(map.get("WCMDDSZS"))))
					  .append(regionService.getRegionName(StringUtil.toEmptyString(map.get("WCMDDSZD"))))
				      .append(regionService.getRegionName(StringUtil.toEmptyString(map.get("WCMDDSZX"))))
				      .append(StringUtil.toEmptyString(map.get("WCMDDXZ")))
					  .append(StringUtil.toEmptyString(map.get("WCMDDMX")));
				map.put("gooutAddress", buffer.toString());
				String sqsjStr = DateUtil.format(map.get("sqsj"), "yyyy-MM-dd");
				map.put("sqsj", sqsjStr);
				
				//申请期限
				if(Util.isNotEmpty(map.get("KSQR")) && Util.isNotEmpty(map.get("JSRQ"))) {
					int day = DateUtil.subtractOfDay((Date)map.get("JSRQ"), (Date)map.get("KSQR"));
					String dayStr = DateUtil.format(map.get("KSQR"), "yyyy-MM-dd") + "  到  " 
							      + DateUtil.format(map.get("JSRQ"), "yyyy-MM-dd")
							      + "   共" + StringUtil.toEmptyString(day) + "天";
					map.put("wcsqsjqx", dayStr);
				}
			}
									
			// 进入特殊区域申请 
			if ("JZ_SQJZRYJRTDQYSPB".equals(tablename)) {
				//添加禁止类类型
				sqlStr = "select JZLLX from JZ_JZLXXCJB";
				SQLAdapter sqlAdapter = new SQLAdapter(sqlStr);
				sqlAdapter.getFilter().eq("f_aid", map.get("f_aid"));
				map.put("JZLLX", dbClient.findOne(sqlAdapter));
				
				//申请期限
				if(Util.isNotEmpty(map.get("SQJRRQ")) && Util.isNotEmpty(map.get("SQJSRQ"))) {
					int day = DateUtil.subtractOfDay((Date)map.get("SQJSRQ"), (Date)map.get("SQJRRQ"));
					String dayStr = DateUtil.format(map.get("SQJRRQ"), "yyyy-MM-dd HH-mm-ss") + "  到  " 
							      + DateUtil.format(map.get("SQJSRQ"), "yyyy-MM-dd HH-mm-ss")
							      + "   共" + StringUtil.toEmptyString(day) + "天";
					map.put("jrtsqysqsjqx", dayStr);
				}
			}	
			
			//居住地变更
			if ("JZ_JZDBGXXCJB".equals(tablename)) {		
				StringBuffer buffer = new StringBuffer();
				buffer.append(regionService.getRegionName(StringUtil.toEmptyString(map.get("QRDSZS"))))
					  .append(regionService.getRegionName(StringUtil.toEmptyString(map.get("QRDSZD"))))
				      .append(regionService.getRegionName(StringUtil.toEmptyString(map.get("QRDSZX"))))
				      .append(StringUtil.toEmptyString(map.get("QRDXZ")))
					  .append(StringUtil.toEmptyString(map.get("QRDMX")));
				map.put("changeAddrAddress", buffer.toString());
				// 添加居住地申请 添加现住地信息
				sqlStr = "select GDJZDMX from JZ_JZRYJBXX_DZ";
				SQLAdapter sqlAdapter = new SQLAdapter(sqlStr);
				sqlAdapter.getFilter().eq("id", map.get("f_aid"));
				map.put("gdjzdmx", dbClient.findOne(sqlAdapter));
				
			}
		}

		return map;
	}
	
	public BasicMap<String, Object> findDisagreeContent(String f_applyid) {
		BasicMap<String, Object> data = dbClient.findOne(SupConst.Collections.SYS_AUDIT_RESULT, 
				new SqlDbFilter().eq("f_applyid", f_applyid));
		return data;
	}

}
