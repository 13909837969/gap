package com.ehtsoft.supervise.services;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ehtsoft.common.dto.AuditApply;
import com.ehtsoft.common.dto.AuditBill;
import com.ehtsoft.common.services.AuditService;
import com.ehtsoft.fw.core.db.RowDataListener;
import com.ehtsoft.fw.core.db.SQLAdapter;
import com.ehtsoft.fw.core.db.SqlDbClient;
import com.ehtsoft.fw.core.db.SqlDbFilter;
import com.ehtsoft.fw.core.dto.BasicMap;
import com.ehtsoft.fw.core.dto.Paginate;
import com.ehtsoft.fw.core.dto.ResultList;
import com.ehtsoft.fw.core.services.AbstractService;
import com.ehtsoft.fw.utils.DateUtil;
import com.ehtsoft.fw.utils.NumberUtil;
import com.ehtsoft.fw.utils.StringUtil;
import com.ehtsoft.supervise.api.SupConst;

@Service("TdqyService")
public class TdqyService extends AbstractService {

	@Resource(name = "sqlDbClient")
	SqlDbClient dbClient;

	@Resource
	private AuditService auditService;

	@PostConstruct
	public void init() {
		try {
			AuditBill bill = new AuditBill();
			bill.setId(SupConst.Collections.JZ_SQJZRYJRTDQYSPB);
			bill.setName("进入特定区域审请");
			auditService.regAuditBill(bill);
		}catch(Exception ex) {}
	}

	/**
	 * 进入特定区域（场所）信息查询
	 * 
	 * @param query
	 * @param paginate
	 * @return [ { F_ID:主键 F_AID:社区矫正人员id SQJZRYBH:社区矫正人员编号 SQJRCS:申请进入的场所 SQRQ:申请日期
	 *         SQJRRQ:申请进入时间 SQJSRQ:申请结束时间 SQLY:申请理由 SFSSHR:司法所审核人 SFSSHSJ:司法所审核时间
	 *         SFSSHYJ:司法所审核意见 XSFJSPR:县（市、区）司法局审批人 XSFJSPSJ:县（市、区）司法局审批时间
	 *         XSFJSPYJ:县（市、区）司法局审批意见 audit:审核标记(0、未审核状态 1、通过) del:删除标记(0、未删除 1、删除)
	 *         } ]
	 */
	public ResultList<BasicMap<String, Object>> findSpecificArea(BasicMap<String, Object> query, Paginate paginate) {
		ResultList<BasicMap<String, Object>> resultList = new ResultList<>();
		String sqlstr = "select * from JZ_SQJZRYJRTDQYSPB";
		SqlDbFilter sqlDbFilter = toSqlFilter(query).desc("cdate");
		SQLAdapter sqlAdapter = new SQLAdapter(sqlstr);
		sqlAdapter.setFilter(sqlDbFilter);
		resultList = dbClient.find(sqlAdapter, paginate, new RowDataListener() {
			@Override
			public void processData(BasicMap<String, Object> rowData) {
				rowData.put("SQRQ", DateUtil.format(rowData.get("SQRQ"), "yyyy-MM-dd hh:mm:ss"));
				rowData.put("SQJRRQ", DateUtil.format(rowData.get("SQJRRQ"), "yyyy-MM-dd"));
				rowData.put("SQJSRQ", DateUtil.format(rowData.get("SQJSRQ"), "yyyy-MM-dd"));
				rowData.put("SFSSHSJ", DateUtil.format(rowData.get("SFSSHSJ"), "yyyy-MM-dd"));
			}
		});
		return resultList;
	}

	/**
	 * 查询一条申请
	 * 
	 * @param id
	 * @return
	 */
	public BasicMap<String, Object> findOne(String id) {
		return dbClient.findOne("select * from JZ_SQJZRYJRTDQYSPB", id);
	}

	/**
	 * 新增或修改申请
	 * 
	 * @param data
	 */
	public String save(BasicMap<String, Object> data) {
		dbClient.save(SupConst.Collections.JZ_SQJZRYJRTDQYSPB, data);
		// 进入特定区域（场所）信息采集表 审批添加
		AuditApply auditApply = new AuditApply();
		auditApply.setBillid(SupConst.Collections.JZ_SQJZRYJRTDQYSPB);
		auditApply.setBsid(StringUtil.toString(data.get("F_ID")));
		// 添加字段信息
		// 矫正人员id
		auditApply.setAid(StringUtil.toString(data.get("F_AID")));
		// 矫正人员编号 SQJZRYBH
		// auditApply.set
		// 标题 +申请进入的场所
		String Title = StringUtil.toString(data.get("TDQYBT")) + "申请进入"
				+ StringUtil.toString(data.get("SQJRCS") + "进入时间：" + StringUtil.toString(data.get("SQJRRQ")) + "离开时间："
						+ StringUtil.toString(data.get("SQJSRQ")));
		auditApply.setTitle(Title);
		
		// 申请人【id】
		auditApply.setAid(StringUtil.toString(data.get("F_AID")));
		// 申请人【name】
		BasicMap<String, Object> map = new BasicMap<>();
		String AID = StringUtil.toString(data.get("F_AID"));
		String sqlstr = "select * from JZ_JZRYJBXX where ID = ?";
		map = dbClient.findOne(sqlstr, AID);
		auditApply.setName(StringUtil.toString(map.get("XM")));
		
		// 日期
		auditApply.setTimearea(StringUtil.toString(data.get("SQRQ")));
		// 理由
		auditApply.setContent(StringUtil.toString(data.get("SQLY")));
		// 申请标记
		auditApply.setAudit(NumberUtil.toInt(data.get("audit")));
		// 司法审核人
		// 审核时间
		// 审核意见
		// 县（市、区）司法局审批人
		// 县（市、区）司法局审批时间
		// 县（市、区）司法局审批建议
		auditService.applyAudit(auditApply);

		return StringUtil.toEmptyString(data.get("F_ID"));

	}

	/**
	 * 保存申请信息里的禁止区域
	 * 
	 * @param data
	 */
	public void saveAddress(BasicMap<String, Object> data) {
		String array[] = data.get("list").toString().split(";");
		for (int i = 0; i < array.length; i++) {
			BasicMap<String, Object> map = new BasicMap<>();
			map.put("JRTDQYID", data.get("JRTDQYID"));
			map.put("PROHIBITID", array[i]);
			dbClient.save(SupConst.Collections.JZ_JRTDQY_PROHIBIT, map);
		}
	}

	/**
	 * 删除申请(不做物理删除)
	 * 
	 * @param id
	 */
	public void delete(String id) {
		dbClient.updateSql("update JZ_SQJZRYJRTDQYSPB set del = 1 where F_ID = ?", id);
	}
}
