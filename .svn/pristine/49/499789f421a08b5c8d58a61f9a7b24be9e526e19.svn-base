package com.ehtsoft.supervise.services;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;

import org.apache.xmlbeans.impl.common.NameUtil;
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

/**
 * 变更地申请
 * 
 * @author Administrator
 *
 */
@Service("BgdsqService")
public class BgdsqService extends AbstractService {

	@Resource(name = "sqlDbClient")
	SqlDbClient dbClient;

	@Resource
	private AuditService auditService;

	@Resource
	private RegionService regionService;

	@PostConstruct
	public void init() {
		try {
			AuditBill bill = new AuditBill();
			bill.setId(SupConst.Collections.JZ_JZDBGXXCJB);
			bill.setName("变更地申请");
			auditService.regAuditBill(bill);
		}catch(Exception ex) {}
	}

	/**
	 * 查询变更地申请
	 * 
	 * @param query
	 * @param paginate
	 * @return [ { JZDBGXXCJB01:主键 F_AID:社区矫正人员id SQJZRYBH:社区矫正人员编号 SQSJ:申请时间
	 *         QRDSZS:迁入地所在省（区、市） QRDSZD:迁入地所在地（市、州） QRDSZX:迁入地所在县（市、区）
	 *         QRDXZ:迁入地（乡镇、街道） QRDMX:迁入地明细 JZDBGSY:变更理由 SFSSHR:司法所审核人
	 *         SFSSHSJ:司法所审核时间 SFSSHYJ:司法所审核意见 XSFJSPR:县（市、区）司法局审批人
	 *         XSFJSPSJ:县（市、区）司法局审批时间 XSFJSPYJ:县（市、区）司法局审批意见 } ]
	 */
	public ResultList<BasicMap<String, Object>> findChangeAddressApply(BasicMap<String, Object> query,
			Paginate paginate) {
		ResultList<BasicMap<String, Object>> resultList = new ResultList<>();
		String sqlstr = "select a.*,b.REGION_NAME as province,c.REGION_NAME as city,d.REGION_NAME as area from JZ_JZDBGXXCJB a left join SYS_REGION b on a.QRDSZS = b.REGIONID "
				+ "left join SYS_REGION c on a.QRDSZD = c.REGIONID left join SYS_REGION d on a.QRDSZX = d.REGIONID";
		SqlDbFilter sqlDbFilter = toSqlFilter(query).desc("cdate");
		SQLAdapter sqlAdapter = new SQLAdapter(sqlstr);
		sqlAdapter.setFilter(sqlDbFilter);
		resultList = dbClient.find(sqlAdapter, paginate, new RowDataListener() {
			@Override
			public void processData(BasicMap<String, Object> rowData) {
				rowData.put("SQSJ", DateUtil.format(rowData.get("SQSJ"), "yyyy-MM-dd hh:mm:ss"));
				rowData.put("SFSSHSJ", DateUtil.format(rowData.get("SFSSHSJ"), "yyyy-MM-dd hh:mm:ss"));
			}
		});
		return resultList;
	}

	/**
	 * 新增变更地申请
	 * 
	 * @param data
	 */
	public void insertApply(BasicMap<String, Object> data) {
		
		dbClient.save(SupConst.Collections.JZ_JZDBGXXCJB, data);

		AuditApply auditApply = new AuditApply();
		auditApply.setBillid(SupConst.Collections.JZ_JZDBGXXCJB);
		auditApply.setBsid(StringUtil.toString(data.get("ID")));
		// TODO 【街道的问题？】
		// SYS_REGION 需要拼接 省 市 区 【进入xxxx区域的申请】
		String province = StringUtil.toString(data.get("QRDSZS"));
		String city = StringUtil.toString(data.get("QRDSZD"));
		String area = StringUtil.toString(data.get("QRDSZX"));

		String proName = regionService.getRegionName(province);
		String cityName = regionService.getRegionName(city);
		String areaName = regionService.getRegionName(area);

		String Title = "迁入" + proName + cityName + areaName + "区域的申请";

		// 申请人【id】
		auditApply.setAid(StringUtil.toString(data.get("F_AID")));
		// 申请人【name】
		BasicMap<String, Object> map = new BasicMap<>();
		String AID = StringUtil.toString(data.get("F_AID"));
		String sqlstr = "select * from JZ_JZRYJBXX where ID = ?";
		map = dbClient.findOne(sqlstr, AID);
		auditApply.setName(StringUtil.toString(map.get("XM")));

		auditApply.setTitle(Title);
		auditApply.setContent(StringUtil.toString(data.get("WCLY")));

		// 理由
		auditApply.setContent(StringUtil.toString(data.get("JZDBGSY")));
		// 审核时间
		auditApply.setTimearea(StringUtil.toString(data.get("SQSJ")));

		// 申请人【id】
		auditApply.setAid(StringUtil.toString(data.get("F_AID")));

		// 申请人【name】
		/*
		 * BasicMap<String, Object> map = new BasicMap<>(); String AID =
		 * StringUtil.toString(data.get("F_AID")); String sqlstr =
		 * "select * from JZ_JZRYJBXX where ID = ?"; map = dbClient.findOne(sqlstr,
		 * AID); auditApply.setName(StringUtil.toString(map.get("XM")));
		 */

		// 申请状态
		auditApply.setAudit(NumberUtil.toInt(data.get("audit")));

		auditService.applyAudit(auditApply);
	}
}
