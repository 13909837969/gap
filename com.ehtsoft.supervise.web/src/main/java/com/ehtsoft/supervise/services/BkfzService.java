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
import com.ehtsoft.fw.utils.Util;
import com.ehtsoft.supervise.api.SupConst;

/**
 * 
 * @author DENNYPC 帮困扶助
 */
@Service("BkfzService")
public class BkfzService extends AbstractService {

	@Resource(name = "sqlDbClient")
	SqlDbClient dbClient;

	@Resource(name = "SSOService")
	private SSOService service;

	/**
	 * 查询帮困扶助信息
	 * 
	 * @param query
	 * @param paginate
	 * @return [ { BFXXCJB01:主键 F_AID:社区矫正人员id BFSJ:帮扶时间 BFDD:帮扶地点 BFNR:帮扶内容 JLR:记录人
	 *         XM:矫正人员姓名 } ]
	 */
	public ResultList<BasicMap<String, Object>> findHelpPerson(BasicMap<String, Object> query, Paginate paginate) {
		ResultList<BasicMap<String, Object>> resultList = new ResultList<>();
		User user = service.getUser();
		if (user != null) {
			String sqlstr = "select a.*,b.xm,b.id from JZ_BFXXCJB a left join jz_jzryjbxx b on a.f_aid = b.id";
			SqlDbFilter sqlDbFilter = toSqlFilter(query).eq("a.del", 0).desc("a.BFSJ").in("a.orgid", user.getOrgidSet()).eq("a.BSLX", "0");
			SQLAdapter sqlAdapter = new SQLAdapter(sqlstr);
			sqlAdapter.setFilter(sqlDbFilter);
			resultList = dbClient.find(sqlAdapter, paginate, new RowDataListener() {
				@Override
				public void processData(BasicMap<String, Object> rowData) {
				}
			});
		}
		return resultList;
	}

	/**
	 * 新增或修改帮困信息
	 * 
	 * @param data
	 */
	public void save(BasicMap<String, Object> data) {
		dbClient.save(SupConst.Collections.JZ_BFXXCJB, data);
	}

	/**
	 * 删除一条帮扶信息 删除(不做物理删除)
	 * 
	 * @param id
	 */
	public void delete(String id) {
		dbClient.updateSql("update JZ_BFXXCJB set del = 1 where F_AID = ?", id);
	}
	
	/**
	 * 查看帮扶信息附加图片
	 * @param id
	 * @return
	 */
	public List<BasicMap<String, Object>> getImageList(String id){
		List<BasicMap<String, Object>> data  = new ArrayList<>();
	    String sqlStr = "select imgid from JZ_BFXXCJB_IMG";
	    SQLAdapter adapter = new SQLAdapter(sqlStr);
	    adapter.getFilter().eq("bfid", id);
	    data = dbClient.find(adapter);
		return data;
	}
}
