package com.ehtsoft.supervise.services;

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
import com.ehtsoft.fw.utils.StringUtil;
import com.ehtsoft.fw.utils.Util;
import com.ehtsoft.supervise.api.SupConst;
/**
 * 解除矫正证明书(司法局)
 * @author 李恒
 *
 */
@Service("JcsqjzzmsService")
public class JcsqjzzmsService extends AbstractService {
	@Resource(name="sqlDbClient")
	SqlDbClient dbClient;
	
	@Resource(name="SSOService")
	private SSOService service;
	
	/**
	*主键		ID
	*居住地	JZD
	*户籍地	HJD
	*身份证号码	SFZH
	*具体罪名	ZM
	*判决日期	PJRQ
	*法院名称	RMFYMC
	*判处信息	PCXX
	*司法机构	SFJG
	*执行通知书文号	ZXTZSWH
	*社区矫正结束日期	SQJZJSRQ
	*
	 * @param query
	 * @param page
	 * @return  list
	 */
	/* "select A.id,A.XM,A.SFZH,A.XB,"
	//+ "B.JZD,B.HJD,B.ZM,B.PJRQ,B.RMFYMC,B.PCXX,B.SFJG,B.ZXTZSWH,B.SQJZJSRQ "
	+ "zms.ID AS zmsid "
	+ "FROM jz_jzryjbxx A "
	+ "JZ_"
	+ "LEFT JOIN JZ_JCSQJZZMS zms ON zms.ID=A.ID"
	 
	 */
	public ResultList<BasicMap<String, Object>> find (BasicMap<String,Object> query,Paginate paginate){
		User  user = service.getUser();//获取当前机构登陆ID
		ResultList<BasicMap<String,Object>> list = new ResultList<>();//返回值
		if(user!=null) {
			String sql = "select "
					+ "A.id,A.XM,A.XB,A.SFZH AS SFZH,"
					+ "B.GDJZDMX AS JZD,B.HJSZDMX AS HJD,"
					+ "C.JTZM AS ZM,C.SQJZJDJGMC AS RMFYMC,C.YPXF AS PCXX ,C.SQJZJDJG AS SFJG,C.SQJZKSRQ AS SQJZKSRQ,"
					+ "D.PJRQ AS PJRQ,D.ZXTZSWH AS ZXTZSWH,E.ID AS zmsid "
					+ "From JZ_JZRYJBXX  A "
					+ "LEFT JOIN jz_jzryjbxx_dz B ON B.ID=A.ID "
					+ "LEFT JOIN JZ_JZRYJBXX_JZ C ON C.ID=A.ID "
					+ "LEFT JOIN JZ_JZRYJBXX_WS D ON D.ID=A.ID "
					+ "LEFT JOIN JZ_JCSQJZZMS E ON E.ID=A.ID ";
			SqlDbFilter filter = toSqlFilter(query);//相当于查询,将前台传递的查询条件数据转换成 Query 对象
			filter.in("a.orgid", user.getOrgidSet());
			filter.eq("a.jcjz", "1");
			SQLAdapter sqladpter = new SQLAdapter(sql);
			sqladpter.setFilter(filter);
			list = dbClient.find(sqladpter, paginate,new RowDataListener() {
				@Override
				public void processData(BasicMap<String, Object> rowData) {
					rowData.put("sfff", Util.isNotEmpty(rowData.get("zmsid")));
				}
			});
		}
		return list;
	}
	
	
	/**
	 * 方法作用就是下发
	 * @param data
	 */
	public void save(BasicMap<String, Object> data) {
		dbClient.save(SupConst.Collections.JZ_JCSQJZZMS, data);
	}
	

}
