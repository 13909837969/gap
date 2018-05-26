package com.ehtsoft.sqjz.services;

import java.util.List;

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
 * 日常报告信息采集表
 * @author 李恒
 *
 */
@Service("SqjzRchbService")
public class SqjzRchbService extends AbstractService {
	@Resource(name="sqlDbClient")
	SqlDbClient dbClient;
	
	@Resource(name="SSOService")
	private SSOService Service;
	
	
	/**
	 * 日常报告信息采集表+查询
	 * @param query
	 * @param paginate
	 * @return list
	 */
	public ResultList<BasicMap<String, Object>> find (BasicMap<String,Object> query,Paginate paginate){
		User user = Service.getUser();//获取当前机构登陆ID
		ResultList<BasicMap<String,Object>> list = new ResultList<>();//返回值list
		if(user!=null) {
			String sql = "select " + 
					"a.id,a.xm,a.xb,a.sfzh,a.grlxdh, " + 
					"b.f_aid,b.sqjzrybh,b.bgsj,b.bgfs,b.bgnr,b.jlr,b.jlsj " + 
					"from jz_jzryjbxx a " + 
					"left join  jz_rcbgxxcjb b on b.f_aid=a.id";
			SqlDbFilter filter = toSqlFilter(query);//相当于查询
			filter.eq("a.orgid", user.getOrgid());
			SQLAdapter sqladpter = new SQLAdapter(sql);
			sqladpter.setFilter(filter);
			list=dbClient.find(sqladpter, paginate,new RowDataListener() {
				@Override
				public void processData(BasicMap<String, Object> rowData) {
					rowData.put("bgsj", DateUtil.format(rowData.get("bgsj"), "yyyy-MM-dd"));
					rowData.put("jlsj", DateUtil.format(rowData.get("jlsj"), "yyyy-MM-dd"));
				}
			});
		}
		return list;
	}
	
	/**
	 * 方法作用：存在更新，不存在插入
	 * @param data
	 */
	public void saveOne(BasicMap<String, Object> data) {
		dbClient.save(SupConst.Collections.JZ_RCBGXXCJB, data);
	}
	
	/**
	 * 获取社区矫正人员信息
	 */
	public List<BasicMap<String,Object>> findJzry(BasicMap<String,Object> data){
		User user = Service.getUser();
		SQLAdapter sql = new SQLAdapter("select id,xm,sfzh from JZ_JZRYJBXX");
		sql.getFilter().eq("orgid", user.getOrgid());
		sql.getFilter().eq("jcjz", "0");
		return dbClient.find(sql);
	}

}
