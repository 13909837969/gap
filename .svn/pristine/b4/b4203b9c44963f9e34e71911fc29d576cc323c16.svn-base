package com.ehtsoft.supervise.services;

import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ehtsoft.common.services.SSOService;
import com.ehtsoft.fw.core.db.RowDataListener;
import com.ehtsoft.fw.core.db.SQLAdapter;
import com.ehtsoft.fw.core.db.SqlDbClient;
import com.ehtsoft.fw.core.db.SqlDbFilter;
import com.ehtsoft.fw.core.dto.BasicMap;
import com.ehtsoft.fw.core.dto.Paginate;
import com.ehtsoft.fw.core.services.AbstractService;
import com.ehtsoft.fw.core.sso.User;
import com.ehtsoft.fw.utils.DateUtil;
import com.ehtsoft.fw.utils.StringUtil;

@Service("XlzxService")
public class XlzxService extends AbstractService{
	
	@Resource(name="sqlDbClient")
	SqlDbClient dbClient;
	
	@Resource(name="SSOService")
	private SSOService ssoService;
	/**
	 * 查询问卷列表信息
	 * @param query
	 * @return
	 * [
	 * 	{
	 * 		F_SJBT:试卷标题
	 * 		F_WJLX:问卷类型(1:法律问卷 2:心理测评)
	 * 		cts:创建时间
	 * 	}
	 * ]
	 */
	public List<BasicMap<String,Object>> findXlzx(BasicMap<String, Object> query,Paginate paginate){
		List<BasicMap<String, Object>> list = new ArrayList<>();
		String sqlstr = "select f_stid,f_sjbt,f_wjlx,cts from jz_wjstxxb";
		SqlDbFilter sqlDbFilter = new SqlDbFilter();
		sqlDbFilter.like("f_sjbt", StringUtil.toEmptyString(query.get("f_sjbt")));
		SQLAdapter sqlAdapter = new SQLAdapter(sqlstr);
		sqlAdapter.setFilter(sqlDbFilter);
		list = dbClient.find(sqlAdapter, paginate, new RowDataListener() {
			
			@Override
			public void processData(BasicMap<String, Object> rowData) {
				rowData.put("cts", DateUtil.format(rowData.get("cts"), "yyyy-MM-dd"));
				if("1".equals(rowData.get("f_wjlx"))){
					rowData.put("f_wjlx", "法律问卷");
				}else if("2".equals(rowData.get("f_wjlx"))){
					rowData.put("f_wjlx", "心理测评");
				}
			}
		}).getRows();
		return list;
	}
	
	/**
	 * 查询心里问卷得分情况
	 * @param query
	 * @param paginate
	 * @return
	 * [
	 * 	{
	 * 		f_aid:人员ID
	 * 		f_stid:试题ID
	 * 		cts:答题时间
	 * 		xm:姓名
	 * 		f_sjbt:试卷标题
	 * 		f_df:试卷得分
	 * 	}
	 * ]
	 */
	public List<BasicMap<String, Object>> findScore(BasicMap<String, Object> query,Paginate paginate){
		List<BasicMap<String, Object>> list = new ArrayList<>();
		User user = ssoService.getUser();
		if(user!=null){
			Set<String> set = user.getOrgidSet();
			String sqlstr = "select distinct a.f_aid,a.f_stid,a.cts,b.xm,c.f_sjbt,d.f_df from jz_wjdtqkxx a"+
			" left join jz_jzryjbxx b on a.f_aid = b.id left join jz_wjstxxb c on a.f_stid = c.f_stid"+
					" left join jz_wjdtfsb d on d.f_stid = a.f_stid";
			SqlDbFilter sqlDbFilter = new SqlDbFilter();
			if("1".equals(query.get("range"))){
				sqlDbFilter.like("xm", StringUtil.toEmptyString(query.get("searchText")));
			}else if("2".equals(query.get("range"))){
				sqlDbFilter.like("f_sjbt", StringUtil.toEmptyString(query.get("searchText")));
			}
			sqlDbFilter.in("a.orgid", set);
			SQLAdapter sqlAdapter = new SQLAdapter(sqlstr);
			sqlAdapter.setFilter(sqlDbFilter);
			list = dbClient.find(sqlAdapter, paginate, new RowDataListener() {
				
				@Override
				public void processData(BasicMap<String, Object> rowData) {
					rowData.put("cts", DateUtil.format(rowData.get("cts"),"yyyy-MM-dd hh:mm:ss"));
					rowData.put("f_df", new DecimalFormat("#.00").format(rowData.get("f_df")) );
				}
			}).getRows();
		}
		return list;
	}
}
