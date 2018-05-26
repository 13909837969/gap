package com.ehtsoft.sfs.services;

import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.ehtsoft.common.services.SSOService;
import com.ehtsoft.fw.core.db.RowDataListener;
import com.ehtsoft.fw.core.db.SQLAdapter;
import com.ehtsoft.fw.core.db.SqlDbClient;
import com.ehtsoft.fw.core.db.SqlDbFilter;
import com.ehtsoft.fw.core.dto.Basic;
import com.ehtsoft.fw.core.dto.BasicMap;
import com.ehtsoft.fw.core.dto.Paginate;
import com.ehtsoft.fw.core.dto.ResultList;
import com.ehtsoft.fw.core.services.AbstractService;
import com.ehtsoft.fw.core.sso.User;
import com.ehtsoft.fw.utils.DateUtil;
import com.ehtsoft.fw.utils.StringUtil;
import com.ehtsoft.supervise.api.SupConst;
/**
 * 司法所组织培训情况信息表
 * @author 李恒
 *
 */
@Service("SfsZzqkxxcjbService")
public class SfsZzqkxxcjb extends AbstractService {
	@Resource(name="sqlDbClient")
	SqlDbClient dbClient;
	
	@Resource(name="SSOService")
	private SSOService Service;
	
	/**
	 * 司法所受表彰情况采集表
	 * 表数据来源【SFSBZQKXXB】
	 * @author 李恒
	 * @param query
	 * @param paginate
	 * @return
	 */
	public ResultList<BasicMap<String, Object>> find (BasicMap<String,Object> query,Paginate paginate){
		User user = Service.getUser();//获取当前机构登陆ID
		ResultList<BasicMap<String,Object>> list = new ResultList<>();//返回值list
		if(user!=null) {
			String sql = "SELECT " + 
					"a.*, " + 
					"b.ID,b.JGBM,b.JGMC,b.fzr  " + 
					"from SFS_SFSZZPXQKXXB A  " + 
					"LEFT JOIN  JC_SFXZJGJBXX b ON b.id=s_id ";
			SqlDbFilter filter = toSqlFilter(query);//相当于查询
			filter.eq("a.orgid", user.getOrgid());
			SQLAdapter sqladpter = new SQLAdapter(sql);
			sqladpter.setFilter(filter);
			list=dbClient.find(sqladpter, paginate, new RowDataListener() {
				
				@Override
				public void processData(BasicMap<String, Object> rowData) {
					// TODO Auto-generated method stub
					rowData.put("pxkssj", DateUtil.format(rowData.get("pxkssj"), "yyyy-MM-dd"));
					rowData.put("pxjssj", DateUtil.format(rowData.get("pxjssj"), "yyyy-MM-dd"));
				}
			});
		}
		return list;
	}
	//查询
	public BasicMap<String, Object> findSfs(){
		User user=Service.getUser();
		BasicMap<String, Object> rtn = new BasicMap<>();
		if(user!=null) {
			SqlDbFilter filter = new SqlDbFilter();
			String sql = "select jgmc,id,jgbm from JC_SFXZJGJBXX";
			SQLAdapter adapter = new SQLAdapter(sql);
			filter.eq("id", user.getOrgid());
			adapter.setFilter(filter);
			rtn = dbClient.findOne(adapter);
		}
		return rtn;
	}
	/**
	 * 方法作用：存在更新，不存在插入
	 * @param data
	 */
	public void saveOne(BasicMap<String, Object> data) {
		dbClient.save(SupConst.Collections.SFS_SFSZZPXQKXXB, data);
	}
	/**
	 * 方法的作用:刪除一條信息
	 */
	public void deleteOne(BasicMap<String, Object> query) {
		dbClient.remove(SupConst.Collections.SFS_SFSZDJSQKXXB, new SqlDbFilter().eq("id", StringUtil.toEmptyString(query.get("id"))));
	}

	
	

}
