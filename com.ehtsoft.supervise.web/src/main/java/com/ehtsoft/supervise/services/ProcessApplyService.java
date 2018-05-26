package com.ehtsoft.supervise.services;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ehtsoft.common.services.SSOService;
import com.ehtsoft.fw.core.db.SQLAdapter;
import com.ehtsoft.fw.core.db.SqlDbClient;
import com.ehtsoft.fw.core.db.SqlDbFilter;
import com.ehtsoft.fw.core.dto.BasicMap;
import com.ehtsoft.fw.core.dto.Paginate;
import com.ehtsoft.fw.core.services.AbstractService;
import com.ehtsoft.fw.core.sso.User;
import com.ehtsoft.fw.utils.NumberUtil;
import com.ehtsoft.fw.utils.StringUtil;

@Service("ProcessApplyService")
public class ProcessApplyService extends AbstractService{
	
	@Resource(name = "sqlDbClient")
	private SqlDbClient dbClient;

	@Resource(name="SSOService")
	private SSOService service;
	
	/**
	 * 查询申请
	 * @param query
	 * @param paginate
	 * @return
	 */
	public List<BasicMap<String,Object>> findApply(BasicMap<String, Object> query,Paginate paginate){
		List<BasicMap<String,Object>> list = new ArrayList<>();
		User user = service.getUser();
		if(user!=null){
			Set<String> orgids = user.getOrgidSet();
			String sqlstr = "select a.*,b.xm from "+StringUtil.toString(query.get("tablename"))+" a left join jz_jzryjbxx b "
					+ " on a.f_aid = b.id";
			SQLAdapter sqlAdapter = new SQLAdapter(sqlstr);
			SqlDbFilter sqlDbFilter = new SqlDbFilter();
			sqlDbFilter.eq("a.audit", NumberUtil.toInt(query.get("audit")))
			.like("b.xm", StringUtil.toEmptyString(query.get("xm")))
			.in("a.orgid", orgids);
			sqlDbFilter.desc("cts");
			sqlAdapter.setFilter(sqlDbFilter);
			list = dbClient.find(sqlAdapter, paginate).getRows();
		}
		return list;
	}
	/**
	 * 更新审核状态
	 * @param f_aid
	 * @param tablename
	 * @param audit
	 */
	public void updateAudit(String idname,String id,String tablename,Integer audit){
		dbClient.updateSql("update "+tablename+" set audit = "+audit+" where "+idname+" = ?", id);
	}
	
	/**
	 * 添加不同意原因
	 * @param tablename
	 * @param idname
	 * @param id
	 * @param content
	 */
	public void updateRemark(String tablename,String idname,String id,String content){
		dbClient.updateSql("update "+tablename+" set remark = '"+content+"' where "+idname+" = ?", id);
	}
	
	/**
	 * 查询不同意原因
	 * @param tablename
	 * @param idname
	 * @param id
	 * @return
	 */
	public BasicMap<String, Object> findReason(String tablename,String idname,String id){
		return dbClient.findOne("select remark from "+tablename+" where "+idname+" = ?", id);
	}
}
