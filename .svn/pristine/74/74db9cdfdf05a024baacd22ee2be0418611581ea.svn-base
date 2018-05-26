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
import com.ehtsoft.fw.utils.NumberUtil;
import com.ehtsoft.fw.utils.StringUtil;
import com.ehtsoft.fw.utils.Util;
import com.ehtsoft.supervise.api.SupConst;

/**
 * 
 * @Description TODO(基层法律服务所管理)
 * @author Administrator
 * @date 2018年3月10日
 *
 */
@Service("SqJzJcflfwService")
public class SqJzJcflfwService  extends AbstractService {
	
	@Resource(name = "sqlDbClient")
	private SqlDbClient dbClient;
	
	@Resource(name = "SSOService")
	private SSOService ssoService;

	/**
	 * 
	 * TODO(保存及修改方法，当记录存在时，执行修改方法。新增，修改)
	 * @param data<br>
	 * 返回值格式: void
	 *
	 * @author Administrator
	 * @date   2018年3月10日
	 * 方法的作用：新增 或 修改
	 */
	public void save(BasicMap<String, Object> data) {
		dbClient.save(SupConst.Collections.FLFW_JCFLFWS, data);
	}
	
	
	/**
	 * 
	 * TODO(删除一条记录，删除)
	 * @param id<br>
	 * 返回值格式: void
	 *
	 * @author Administrator
	 * @date   2018年3月10日
	 * 方法的作用：删除一条记录 【id = orgid】
	 */
	public void deleteOne(String id) {
		dbClient.remove(SupConst.Collections.JZ_SQFWXX, new SqlDbFilter().eq("id", id));
	}
	
	
	
	/**
	 * 
	 * TODO(返回基层法律服务的全部列表，列表)
	 * @param query
	 * @param paginate
	 * @return<br>
	 * 返回值格式: List<BasicMap<String,Object>> 【可更换 ResultList<BasicMap<String,Object>>】
	 *
	 * @author Administrator
	 * @date   2018年3月10日
	 * 方法的作用：返回全部记录
	 * 
	 */
	public ResultList<BasicMap<String, Object>> findAll(BasicMap<String, Object> query,Paginate paginate) {
		String sqlstr = "SELECT a.ID,a.JGMC,a.JGZH,a.ZZXS,a.BZSJ,a.FZR,a.DH,a.DZ,a.JGJJ,b.region_name from FLFW_JCFLFWS a LEFT JOIN sys_region b ON a.regionid=b.regionid";
		SQLAdapter sql = new SQLAdapter(sqlstr);
		SqlDbFilter filter = new SqlDbFilter();
		if (null == query.get("a.regionid")) {
			filter = toSqlFilter(query);
		}else {
			filter.eq("a.regionid", query.get("a.regionid"));
		}
		sql.setFilter(filter);
		ResultList<BasicMap<String, Object>> list = dbClient.find(sql,paginate);
		return list;
	}
	
	
	/**
	 * 
	 * TODO(区域树，基层法律服务所管理)
	 * @return<br>
	 * 返回值格式:List<BasicMap<String, Object>>
	 *
	 * @author Administrator
	 * @date   2018年3月10日
	 * 方法的作用：区域树 【数据来源 sys_region表】
	 */
	public List<BasicMap<String, Object>> findTree() {
		List<BasicMap<String, Object>> rtn = new ArrayList<>();
		User user = ssoService.getUser();
		String sql = "SELECT regionid,parentid,region_code,region_name,lvl from sys_region";
		SQLAdapter adapter = new SQLAdapter(sql);
		adapter.getFilter().eq("parentid", user.getRegioncode());
		final BasicMap<String,Object> p = dbClient.findOne("SELECT regionid,parentid,region_code,region_name,lvl from sys_region where regionid = ?",user.getRegioncode());
		if(p!=null) {
			//检索市
			final List<BasicMap<String, Object>> list = new ArrayList<>();
			list.add(p);
			dbClient.find(adapter,new RowDataListener() {
				@Override
				public void processData(BasicMap<String, Object> rowData) {
					list.add(rowData);
				}
			}); 
			rtn = Util.list2Tree(list, "parentid", "regionid","nodes",new Util.List2Tree() {
				@Override
				public boolean isFirstNode(BasicMap<String, Object> obj) {
					boolean r = false;
					if(NumberUtil.toInt(obj.get("lvl")) == NumberUtil.toInt(p.get("lvl"))) {
						r = true;
					}
					return r;
				}
			});
		}
		return rtn;
	}
	
	/**
	 * 
	 * TODO(方法的描述，哪那个地方使用的等)
	 * @param query
	 * @return<br>
	 * 返回值格式:List<BasicMap<String, Object>>
	 *
	 * @author Administrator
	 * @date   2018年3月19日
	 * 方法的作用：返回行政区划
	 */
	public List<BasicMap<String, Object>> findRegion(BasicMap<String, Object> query) {
		String sqlstr="SELECT regionid,lvl,region_name,parentid FROM sys_region WHERE("
				+ "regionid="+ query.get("regionid")+ ""
				+ "or parentid="+ query.get("regionid")+ ") ORDER BY lvl ASC";
		SQLAdapter sql = new SQLAdapter(sqlstr);
		List<BasicMap<String, Object>> list = dbClient.find(sql);
		return list;
	}
	public List<BasicMap<String, Object>> findParentid(String regionname) {
		String sql = "SELECT regionid,parentid FROM sys_region WHERE region_name = '"+ regionname+ "'";
		SQLAdapter adapter = new SQLAdapter(sql);
		List<BasicMap<String, Object>> list = dbClient.find(adapter);
		return list;
		
	}
}
