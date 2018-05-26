package com.ehtsoft.supervise.services;


import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.bouncycastle.i18n.filter.SQLFilter;
import org.springframework.stereotype.Service;

import com.ehtsoft.common.services.SSOService;
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
import com.ehtsoft.supervise.api.SupConst;
import com.ehtsoft.supervise.utils.ParameterUtil;

@Service("KhglService")
public class KhglService extends AbstractService{
	
	@Resource(name="sqlDbClient")
	SqlDbClient dbClient;
	
	@Resource(name="SSOService")
	private SSOService service;
	
	/**
	 * 查看考核管理
	 * @param query
	 * @param paginate
	 * @return
	 * [
	 * 	{
	 * 		id:矫正人员ID
	 * 		xm:矫正人员姓名
	 * 		sqjzrybh:编号
	 * 		sfzh:身份证号
	 * 		kf:扣分总数
	 * 		result:剩余分数
	 * 	}
	 * ]
	 */
	public ResultList<BasicMap<String, Object>> findAssessmentManage(BasicMap<String, Object> query,Paginate paginate){
		ResultList<BasicMap<String, Object>> resultList = new ResultList<>();
		User user = service.getUser();
		if(user!=null){
			String orgids = user.getOrgid();
			String sqlstr = "select a.id,a.xm,a.sqjzrybh,a.sfzh ,sum(b.kffs) as kf from jz_jzryjbxx a left join JZ_RCKHPF b on a.id = b.f_aid " 
						+ " where a.xm like '%"+StringUtil.toEmptyString(query.get("xm"))+"%' and a.orgid in ('" + orgids + "')"
								+ " and a.sfzh like '%"+StringUtil.toEmptyString(query.get("sfzh"))+"%' group by (a.id,a.xm,a.sqjzrybh,a.sfzh,a.cts) order by a.cts desc ";
			
			SQLAdapter sqlAdapter = new SQLAdapter(sqlstr);
			resultList = dbClient.find(sqlAdapter, paginate, new RowDataListener() {
				@Override
				public void processData(BasicMap<String, Object> rowData) {
					//默认考核分数 12 分
					int khfs = NumberUtil.toInt(ParameterUtil.getParameter(dbClient).get(SupConst.ParameterKey.KEY_SYSTEM_016).getValue());
					rowData.put("result", khfs - NumberUtil.toInt(rowData.get("kf")));
				}
			});
		}
		return resultList;
	}
	
	/**
	 * 查询矫正人员扣分详细情况
	 * @param query
	 * @param paginate
	 * @return
	 * [
	 * 	{
	 * 		ID:主键
	 * 		KHXM:考核项目
	 * 		KFFS:扣分分数
	 * 		KHMSQK:考核描述情况
	 * 		F_AID:矫正人员ID
	 * 		cts:创建时间戳
	 * 	}
	 * ]
	 */
	public ResultList<BasicMap<String, Object>> findDetails(BasicMap<String, Object> query,Paginate paginate){
		ResultList<BasicMap<String, Object>> resultList = new ResultList<>();
		String sqlstr = "select * from JZ_RCKHPF ";
		SQLAdapter sqlAdapter = new SQLAdapter(sqlstr);
		SqlDbFilter filter = new SqlDbFilter();
		filter.eq("f_aid", query.get("f_aid"));
		sqlAdapter.setFilter(filter);
		resultList = dbClient.find(sqlAdapter, paginate, new RowDataListener() {
			@Override
			public void processData(BasicMap<String, Object> rowData) {
				rowData.put("cts", DateUtil.format(rowData.get("cts"), "yyyy年MM月dd日"));
			}
		});
		return resultList;
	}
	
	/**
	 * 新增扣分情况
	 * @param data
	 */
	public List<BasicMap<String, Object>> insert(BasicMap<String, Object> data){
		List<BasicMap<String, Object>> list = new ArrayList<>();
		dbClient.save(SupConst.Collections.JZ_RCKHPF, data);
		list.add(data);
		return list;
	}
	/**
	 * 删除扣分情况
	 * @param data
	 */
	public void remove(BasicMap<String, Object> data){
		dbClient.remove(SupConst.Collections.JZ_RCKHPF, data);
	}
}
