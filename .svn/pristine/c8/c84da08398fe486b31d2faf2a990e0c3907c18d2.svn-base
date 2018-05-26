package com.ehtsoft.supervise.services;


import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.ehtsoft.fw.core.db.SQLAdapter;
import com.ehtsoft.fw.core.db.SqlDbClient;
import com.ehtsoft.fw.core.db.SqlDbFilter;
import com.ehtsoft.fw.core.dto.BasicMap;
import com.ehtsoft.fw.core.dto.Paginate;
import com.ehtsoft.fw.core.dto.ResultList;
import com.ehtsoft.fw.core.services.AbstractService;
import com.ehtsoft.im.services.UserinfoService;
import com.ehtsoft.supervise.api.SupConst;

/**
 * 保存心理测评记录
 * @author Administrator
 *
 */
@Service("JzXljzService")
public class JzXljzService extends AbstractService {
	
	@Resource(name="sqlDbClient")
	private SqlDbClient dbClient;
	
	@Resource(name="UserinfoService")
	private UserinfoService uService;
	/**
	 * 保存心理测评记录
	 */
	public void save(BasicMap<String, Object> data) {
		dbClient.save(SupConst.Collections.JZ_XLJZB, data);
	}
	
	/**
	 * 查询一条记录
	 * @param id
	 * @return
	 */
	public BasicMap<String , Object> findOne(String id) {
		return dbClient.findOne("select A.*,B.XM from JZ_XLJZB A inner join JZ_JZRYJBXX B ON A.AID = B.ID WHERE A.ID = ?", id);
	}

	
	/**
	 * 个人的全部信息
	 * @param query
	 * @param paginate
	 * @return
	 */
	public ResultList<BasicMap<String, Object>> findAll(BasicMap<String, Object> query,Paginate paginate) {
		String sqlstr = "select A.ID,A.AID,A.CPNR,A.CPRQ,A.CPJG,A.XLZTPJ,A.CPRXM,B.xm,B.grlxdh from JZ_XLJZB  A inner join JZ_JZRYJBXX  B ON A.AID = B.ID ";
		SqlDbFilter filter = toSqlFilter(query);
		SQLAdapter sql = new SQLAdapter(sqlstr);
		sql.setFilter(filter);
		return  dbClient.find(sql, paginate);
	}
	
	/**
	 * 删除一条记录
	 */
	public void deleteOne(String id) {
		dbClient.remove(SupConst.Collections.JZ_XLJZB, new SqlDbFilter().eq("ID", id));
	}
}
