package com.ehtsoft.azbj.services;
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
import com.ehtsoft.supervise.api.SupConst;
/**
 * 年度鉴定信息采集表
 * @author 武文涛  
 * @date 2018年5月21日
 */
@Service("AzbjNdjdXxcjbXzService")
public class AzbjNdjdXxcjbXzService extends AbstractService{
	
	@Resource(name = "sqlDbClient")
	private SqlDbClient dbClient;
	
	@Resource(name = "SSOService")
	private SSOService ssoService;
	/**
	 * 安置帮教_分页列表已年度鉴定(乡镇)信息查询 
	 * @param query 网页端已通过name的形式对查询条件进行处理
	 * @return ResultList 返回分页列表数据
	 */
	public ResultList<BasicMap<String, Object>> findAll(BasicMap<String, Object> query, Paginate paginate) {
		   User user = ssoService.getUser();
		    ResultList<BasicMap<String, Object>> rtn = new ResultList<>();
			if(user!=null) {
		    String sqlstr = "SELECT AZ.*,JZ.XM,JZ.ID aid FROM anzbj_ndjdxxcjbxz AZ INNER JOIN jz_jzryjbxx JZ ON az.azbjryid=JZ.ID inner join ANZBJ_RYXJXXCJB c on jz.id = c.id ";
			SqlDbFilter filter = toSqlFilter(query);
			filter.in("JZ.orgid", user.getOrgidSet());
			filter.eq("c.jcbj", "0");
			SQLAdapter sql = new SQLAdapter(sqlstr);
			sql.setFilter(filter);
			rtn = dbClient.find(sql, paginate);
			}
		return rtn;
	}
	/**
	         安置帮教_新增和修改年度鉴定(乡镇)的信息 
	 * @param data 网页端提交Form表单的数据
	 * @param query
	 */
	public void saveOne(BasicMap<String, Object> data){
		dbClient.save(SupConst.Collections.ANZBJ_NDJDXXCJBXZ, data);
	}
	/**
	 * 安置帮教_删除年度鉴定(乡镇)的信息 
	 * @param data 网页端提交选中的删除信息
	 */
	public void removeOne(BasicMap<String, Object> data) {
		dbClient.remove(SupConst.Collections.ANZBJ_NDJDXXCJBXZ, data);
	}
	
}
