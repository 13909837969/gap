package com.ehtsoft.azbj.services;

import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.ehtsoft.common.services.SFCodeService;
import com.ehtsoft.common.services.SSOService;
import com.ehtsoft.fw.core.db.InsertOperation;
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
 * 安置帮教_人员衔接
 * @author 宋占成
 * @data 2018年5月28日
 */
@Service("AzbjRyxjSrevice")
public class AzbjRyxjSrevice extends AbstractService {
	
	@Resource(name = "sqlDbClient")
	private SqlDbClient dbClient;
	
	@Resource(name = "SFCodeService")
	private SFCodeService sfService;
	
	@Resource(name = "SSOService")
	private SSOService service;
	/**
	 * 安置帮教_分页列表衔接人员和未衔接人员的信息查询 
	 * @param query 网页端已通过name的形式对查询条件进行处理
	 * @return ResultList 返回分页列表数据
	 */
	public ResultList<BasicMap<String, Object>> findAzbjRyxjAll(BasicMap<String, Object> query, Paginate paginate) {
		User user = service.getUser();
		ResultList<BasicMap<String, Object>> renyxx = new ResultList<>();
		if (user != null) {
			if (query.get("xjzt").equals("1")) {
				String sqlstr = "select a.*,b.id,b.xm,b.xb,b.jzjg,b.sfswry from anzbj_ryxjxxcjb a left join jz_jzryjbxx b on a.id = b.id";
				SqlDbFilter filter = toSqlFilter(query);
				filter.eq("a.orgid", user.getOrgid());
				filter.eq("a.jcbj", "0");
				SQLAdapter sql = new SQLAdapter(sqlstr);
				sql.setFilter(filter);
				renyxx = dbClient.find(sql, paginate);
			} else {
				String sqlstr = "select a.id xjid,a.xm,a.xb,a.jzjg,a.sfswry from jz_jzryjbxx a left join anzbj_ryxjxxcjb b on a.id = b.id";
				SqlDbFilter filter = toSqlFilter(query);
				SQLAdapter sql = new SQLAdapter(sqlstr);
				filter.addFieldRelation("b.id is null and a.jcjz='1'");
				filter.eq("a.orgid", user.getOrgid());
				sql.setFilter(filter);
				renyxx = dbClient.find(sql, paginate);
			}
		}
		return renyxx;
	}
	/**
	 * 安置帮教_新增修改
	 * @param data 通过网页端传来相关数据，对人员信息，衔接人员进行操作
	 */
	public void saveAzbj(BasicMap<String, Object> data) {
		String ryid = null;
		if (data.get("ID") == null) {
			if (data.get("xjid") == "" || data.get("xjid").equals("")) {
				dbClient.save(SupConst.Collections.JZ_JZRYJBXX, data, new InsertOperation() {
					@Override
					public void insertBefore(BasicMap<String, Object> data) {
						String code = sfService.getCorrectCode();
						data.put("SQJZRYBH", code);
					}
					@Override
					public void updateBefore(BasicMap<String, Object> data) {
						data.remove("SQJZRYBH");
					}
					@Override
					public void insertAfter(BasicMap<String, Object> data) {
					}
				});
				ryid = data.get("id").toString();
			} else {
				ryid = data.get("xjid").toString();
			}
			data.put("id", ryid);
			dbClient.save(SupConst.Collections.ANZBJ_RYXJXXCJB, data);
		} else {
			dbClient.save(SupConst.Collections.ANZBJ_RYXJXXCJB, data);
		}
	}
}
