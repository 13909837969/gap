package com.ehtsoft.azbj.services;

import javax.annotation.Resource;
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
import com.ehtsoft.supervise.api.SupConst;

/**
 * @Description 安置帮教档案管理
 * @author 王维
 * @date 2018年5月21日
 */
@Service("AzbjDaglService")
public class AzbjDaglService extends AbstractService {
	
	@Resource(name = "sqlDbClient")
	private SqlDbClient dbClient;
	
	@Resource(name="SSOService")
	private SSOService ssoService;
	
	/**
	 * 查询服刑人员信息(关联列表anzbj_fxryfxxx） 
	 * 2018年5月21日 方法的作用：表的外联查询
	 */
	public ResultList<BasicMap<String, Object>> findFxry(BasicMap<String, Object> query, Paginate paginate) {
		
		User user = ssoService.getUser();
		ResultList<BasicMap<String, Object>> list = new ResultList<>();
		if(user != null){
		SqlDbFilter filter = toSqlFilter(query);	
		StringBuffer sbf = new StringBuffer();
		sbf.append("select a.id azbjryid,a.sqjzrybh,a.xm xm,a.xb xb,a.mz mz,a.orgid,a.sfzh sfzh,a.jglx,a.csrq csrq,a.sfcn,a.wcn,a.xzzmm,a.yzzmm,a.jyjxqk,a.pqzy,a.hyzk,a.grlxdh,a.whcd,a.ygzdw,a.xgzdw,a.dwlxdh,a.qtlxfs,");
		sbf.append("b.tiqian ,b.id id,b.critype critype, b.tq_reason,b.drughis,b.pritime,b.precri,b.addition,b.peixun,b.jineng,b.xinli,b.lianxi,b.sanwu,b.pinggu,b.gaizao,b.renzui,b.remark,b.jiuyi,b.siwang,b.sw_reason,b.sw_shuoming,b.tongzhishu ");
		sbf.append("from jz_jzryjbxx a left join anzbj_fxryfxxx b on b.azbjryid=a.id inner join anzbj_ryxjxxcjb c on a.id = c.id");
		SQLAdapter adapter = new SQLAdapter(sbf.toString());
		filter.eq("a.orgid", user.getOrgid());
		filter.eq("c.jcbj", "0");		
		adapter.setFilter(filter);
		list = dbClient.find(adapter, paginate,new RowDataListener() {
			@Override
			public void processData(BasicMap<String, Object> rowData) {
				rowData.put("csrq", DateUtil.format(rowData.get("csrq"),"yyyy-MM-dd"));
			}});
		}
		return list;
	}
	
	/**
	 * 添加修改服刑信息
	 */
	public void saveFxxx(BasicMap<String, Object> data) {			
		dbClient.save(SupConst.Collections.ANZBJ_FXRYFXXX, data);				
	}

}
