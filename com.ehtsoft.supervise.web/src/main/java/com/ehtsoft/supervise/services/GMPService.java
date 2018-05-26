package com.ehtsoft.supervise.services;
import java.util.ArrayList;
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
import com.ehtsoft.im.services.UserinfoService;
import com.ehtsoft.supervise.api.SupConst;
/**
 * 考核管理
 * @author sunhailong
 *
 */
@Service("GMPService")
public class GMPService extends AbstractService{
	
	@Resource(name = "sqlDbClient")
	private SqlDbClient dbClient;
	
	@Resource(name="SSOService")
	private SSOService ssoService; 
	
	@Resource
	private UserinfoService userinfoService;
	
	/**
	 * 查询考核内容
	 * @param query
	 * @param paginate
	 * @return
	 */
	public ResultList<BasicMap<String, Object>> findAll(BasicMap<String, Object> query,Paginate paginate){
		User user = ssoService.getUser();
		ResultList<BasicMap<String, Object>> rtn = new ResultList<>();
		if(user != null){
			String sqlstr = "select a.xm,a.sqjzrybh,a.xb,b.* from JZ_JZRYJBXX a inner join JZ_KHXX b on a.id=b.aid";
			SqlDbFilter filter = toSqlFilter(query);
			SQLAdapter sql = new SQLAdapter(sqlstr);
			sql.setFilter(filter);
			filter.in("a.orgid", user.getOrgidSet());
			rtn = dbClient.find(sql , paginate, new RowDataListener() {
				@Override
				public void processData(BasicMap<String, Object> rowData) {
					rowData.put("khrq", DateUtil.format(rowData.get("khrq"),"yyyy-MM-dd"));
					rowData.put("khksrq",DateUtil.format(rowData.get("khksrq"),"yyyy-MM-dd"));
					rowData.put("khjsrq", DateUtil.format(rowData.get("khjsrq"), "yyyy-MM-dd"));
				}
			});
		}
		return rtn;
	}
	/**
	 * 插入与修改考核内容
	 * @param query
	 */
	public void saveOne(BasicMap<String, Object> data){
		dbClient.save(SupConst.Collections.JZ_KHXX, data);
	}
	/**
	 * 删除考核内容
	 * @param query
	 */
	public void removeOne(String id){
		dbClient.remove(SupConst.Collections.JZ_KHXX, new SqlDbFilter().eq("khid",id));
	}
	/**
	 * 查询矫正人员相关信息
	 * @return
	 */
	public List<BasicMap<String, Object>> findJz(){
		User user = ssoService.getUser();
		String orgid = user.getOrgid();
		List<BasicMap<String, Object>> map = new ArrayList<>();
		if(user != null){
			String sql = "select id,xm,grlxdh from JZ_JZRYJBXX where orgid='"+orgid+"'";
			 SQLAdapter adapter = new SQLAdapter(sql);
			map = dbClient.find(adapter);
		}
		return map;
	}
}
