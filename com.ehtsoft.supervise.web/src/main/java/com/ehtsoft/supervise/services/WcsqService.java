package com.ehtsoft.supervise.services;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

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

@Service("WcsqService")
public class WcsqService extends AbstractService{
	
	@Resource(name="sqlDbClient")
	SqlDbClient dbClient;
	
	@Resource
	private AuditService auditService;
	
	@Resource
	private RegionService regionService;
	
	@PostConstruct
	public void init(){
		try {
			AuditBill bill = new AuditBill();
			bill.setId(SupConst.Collections.JZ_WCSQXXCJB);
			bill.setName("外出申请");
			auditService.regAuditBill(bill);
		}catch(Exception ex) {}
	}
	/**
	 * 查询外出申请
	 * @param query
	 * @param paginate
	 * @return
	 * [
	 * 	{
	 * 		WCSQXXCJB01:主键
	 * 		F_AID:社区矫正人员id
	 * 		SQJZRYBH:社区矫正人员编号
	 * 		SQSJ:申请时间
	 * 		WCMDDSZS:外出目的地所在省（区、市）
	 * 		WCMDDSZD:外出目的地所在地（市、州）
	 * 		WCMDDSZX:外出目的地所在县（市、区）
	 * 		WCMDDXZ:外出目的地（乡镇、街道）
	 * 		WCMDDMX:外出目的地明细
	 * 		WCLY:外出理由
	 * 		WCTS:外出天数
	 * 		KSQR:外出开始时间
	 * 		JSRQ:外出结束时间
	 * 		SFSSHR:司法所审核人
	 * 		SFSSHSJ:司法所审核时间
	 * 		SFSSHYJ:司法所审核意见
	 * 		XSFJSPR:县（市、区）司法局审批人
	 * 		XSFJSPSJ:县（市、区）司法局审批时间
	 * 		XSFJSPYJ:县（市、区）司法局审批意见
	 * 		audit:	审核标记
	 * 	}
	 * ]
	 * 
	 */
	public ResultList<BasicMap<String, Object>> findGoOutApply(BasicMap<String, Object> query,Paginate paginate){
		ResultList<BasicMap<String, Object>> resultList = new ResultList<BasicMap<String, Object>>();
		String sqlstr = "select a.*,b.REGION_NAME as WCMDDSZS1 ,c.REGION_NAME as WCMDDSZD1 ,d.REGION_NAME as WCMDDSZX1 "
				+ "from JZ_WCSQXXCJB a left join SYS_REGION b on a.WCMDDSZS = b.REGIONID "
				+ " left join SYS_REGION c on a.WCMDDSZD = c.REGIONID left join SYS_REGION d on a.WCMDDSZX = d.REGIONID";
		SqlDbFilter sqlDbFilter = toSqlFilter(query).desc("cdate");
		SQLAdapter sqlAdapter = new SQLAdapter(sqlstr);
		sqlAdapter.setFilter(sqlDbFilter);
		resultList = dbClient.find(sqlAdapter, paginate, new RowDataListener() {
			@Override
			public void processData(BasicMap<String, Object> rowData) {
				rowData.put("SQSJ", DateUtil.format(rowData.get("sqsj"), "yyyy-MM-dd HH:mm:ss"));
				rowData.put("KSQR", DateUtil.format(rowData.get("KSQR"), "yyyy-MM-dd"));
				rowData.put("JSRQ", DateUtil.format(rowData.get("JSRQ"), "yyyy-MM-dd"));
				rowData.put("SFSSHSJ", DateUtil.format(rowData.get("SFSSHSJ"), "yyyy-MM-dd"));
			}
		});
		return resultList;
	}
	
	/**
	 * 查询一条外出申请
	 * @param WCSQXXCJB01
	 * @return
	 * 	{
		 * 	WCSQXXCJB01:主键
		 * 	F_AID:社区矫正人员id
		 *	SQJZRYBH:社区矫正人员编号
		 * 	SQSJ:申请时间
		 * 	WCMDDSZS:外出目的地所在省（区、市）
		 * 	WCMDDSZD:外出目的地所在地（市、州）
		 * 	WCMDDSZX:外出目的地所在县（市、区）
		 * 	WCMDDXZ:外出目的地（乡镇、街道）
		 * 	WCMDDMX:外出目的地明细
		 * 	WCLY:外出理由
		 * 	WCTS:外出天数
		 * 	KSQR:外出开始时间
		 * 	JSRQ:外出结束时间
		 * 	SFSSHR:司法所审核人
		 * 	SFSSHSJ:司法所审核时间
		 * 	SFSSHYJ:司法所审核意见
		 * 	XSFJSPR:县（市、区）司法局审批人
		 * 	XSFJSPSJ:县（市、区）司法局审批时间
		 * 	XSFJSPYJ:县（市、区）司法局审批意见
		 * 	audit:	审核标记
	 * 	}
	 */
	public BasicMap<String, Object> findOneGoOutApply(String WCSQXXCJB01){
		BasicMap<String, Object> map = new BasicMap<>();
		String sqlstr = "select * from JZ_WCSQXXCJB where WCSQXXCJB01 = ?";
		map = dbClient.findOne(sqlstr, WCSQXXCJB01);
		return map;
	}
	
	/**
	 * 新增或修改外出申请
	 * 
	 * @param data
	 */
	public void saveGoOutApply(BasicMap<String,Object> data){
		long date = 0;
		Date KSQR;
		Date JSRQ;
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
		try {
			JSRQ = simpleDateFormat.parse((String) data.get("JSRQ"));
			KSQR = simpleDateFormat.parse((String) data.get("KSQR"));
			date = (JSRQ.getTime()-KSQR.getTime())/(1000*60*60*24);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		data.put("WCTS", date);
		dbClient.save(SupConst.Collections.JZ_WCSQXXCJB, data);
		
		AuditApply auditApply = new AuditApply();
		auditApply.setBillid(SupConst.Collections.JZ_WCSQXXCJB);
		auditApply.setBsid(StringUtil.toString(data.get("ID")));
		//TODO SYS_REGION 需要拼接 省 市 区 【到xxxx地的外出申请,迁入xxxx（呼和浩特市新城区xx街道）的变更申请,进入xxxx区域的申请】
		String province = StringUtil.toString(data.get("WCMDDSZS"));
		String city = StringUtil.toString(data.get("WCMDDSZD"));
		String area = StringUtil.toString(data.get("WCMDDSZX"));
		
		String proName =  regionService.getRegionName(province);
		String cityName =  regionService.getRegionName(city);
		String areaName =  regionService.getRegionName(area);
		
		String Title = "到"+proName + cityName + areaName + "的外出申请";
		auditApply.setTitle(Title);
		auditApply.setContent(StringUtil.toString(data.get("WCLY")));
		//日期及时间范围
		String WCTS = StringUtil.toString(data.get("KSQR"))+"至"+ StringUtil.toString(data.get("JSRQ"))+"共"+ StringUtil.toString(data.get("WCTS"))+"天";
		auditApply.setTimearea(WCTS);
		
		//申请人【id】
		auditApply.setAid(StringUtil.toString(data.get("F_AID")));
		//申请人【name】
		BasicMap<String, Object> map = new BasicMap<>();
		String AID = StringUtil.toString(data.get("F_AID"));
		String sqlstr = "select * from JZ_JZRYJBXX where ID = '"+ AID +"'";
		map = dbClient.findOne(sqlstr);
		auditApply.setName(StringUtil.toString(map.get("XM")));
		//申请地址【当前机构所在矫正的机构】
		auditApply.setAddr(StringUtil.toString(data.get("orgid")));
		//地址的经纬度 LAT LON
		auditApply.setLat(NumberUtil.toDouble(data.get("LAT")));
		auditApply.setLng(NumberUtil.toDouble(data.get("LNG")));
		//审批人ID F_APPROVER【编号】
		//项目ID F_PROJECT
		//auditApply.setLng();
		auditService.applyAudit(auditApply);
	}
	/**
	 * 删除外出申请
	 * @param WCSQXXCJB01
	 */
	public void deleteGoOutApply(String WCSQXXCJB01){
		dbClient.remove(SupConst.Collections.JZ_WCSQXXCJB, new SqlDbFilter().eq("WCSQXXCJB01", WCSQXXCJB01));
	}
}
