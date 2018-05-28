package com.ehtsoft.azbj.services;
import java.util.ArrayList;
import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.ehtsoft.common.services.SSOService;
import com.ehtsoft.fw.core.db.SQLAdapter;
import com.ehtsoft.fw.core.db.SqlDbClient;
import com.ehtsoft.fw.core.db.SqlDbFilter;
import com.ehtsoft.fw.core.dto.BasicMap;
import com.ehtsoft.fw.core.dto.Paginate;
import com.ehtsoft.fw.core.dto.ResultList;
import com.ehtsoft.fw.core.services.AbstractService;
import com.ehtsoft.fw.core.sso.User;
import com.ehtsoft.im.services.UserinfoService;
import com.ehtsoft.supervise.api.SupConst;
/**
 * 教育走访信息管理
 * @author 王世凯
 * Date 2018年5月21日
 */
@Service("AzbjJyzfxxService")
public class AzbjJyzfxxService extends AbstractService{	
	@Resource(name = "sqlDbClient")
	private SqlDbClient dbClient;	
	
	@Resource(name="SSOService")
	private SSOService ssoService; 	
	
	/**
	 * 查询内容
	 * @param query
	 * @param paginate
	 * @return
	 */
	public ResultList<BasicMap<String, Object>> findAll(BasicMap<String, Object> query,Paginate paginate){
		User user = ssoService.getUser();
		ResultList<BasicMap<String, Object>> rtn = new ResultList<>();
		if(user != null){
			String sqlstr = "SELECT a.id jid,a.xm,b.* FROM JZ_JZRYJBXX a INNER JOIN ANZBJ_JYZFXX b ON a.id = b.aid INNER JOIN ANZBJ_RYXJXXCJB c ON c.id = a.id";
			SqlDbFilter filter = toSqlFilter(query);
			filter.in("a.orgid", user.getOrgidSet());
			filter.eq("c.jcbj", "0");
			SQLAdapter sql = new SQLAdapter(sqlstr);
			sql.setFilter(filter);
			rtn = dbClient.find(sql, paginate);
		}
		return rtn;
	}	
	/**
	 * 插入与修改人教育走访内容
	 * @param query
	 */
	public void saveJyzf(BasicMap<String, Object> data){
		dbClient.save(SupConst.Collections.ANZBJ_JYZFXX, data);
	}
	/**
	 * 删除教育走访内容
	 * @param id 前台获取到选中行的id，通过对象调用removeJyzf删除
	 */
	public void removeJyzf(String id){
		dbClient.remove(SupConst.Collections.ANZBJ_JYZFXX, new SqlDbFilter().eq("id",id));
	}
}
