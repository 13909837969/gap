package com.ehtsoft.supervise.services;

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
import com.ehtsoft.fw.utils.StringUtil;
import com.ehtsoft.supervise.api.SupConst;

@Service("YzzzService")
public class YzzzService extends AbstractService {

	@Resource(name = "sqlDbClient")
	private SqlDbClient dbClient;

	@Resource(name = "SSOService")
	private SSOService service;
	
	/**
	 * 查找人员信息
	 * @param data
	 * @param paginate
	 * @return
	 */
	public ResultList<BasicMap<String, Object>> findAllRy(BasicMap<String, Object> data,Paginate paginate){
		User user=service.getUser();
		SqlDbFilter filter = toSqlFilter(data);
		String sql="SELECT a.id, a.xm,a.sfzh,a.grlxdh,a.jglx,a.orgid,b.pjrq,c.zm FROM JZ_JZRYJBXX a "
				+ " LEFT JOIN JZ_PJXX b ON a.id=b.id "
				+ " LEFT JOIN JZ_YZHZZYGQKXXCJB c on b.id=c.aid";
		SQLAdapter sqlAdapter=new SQLAdapter(sql);	
		filter.eq("a.orgid", user.getOrgid());
		sqlAdapter.setFilter(filter);
		ResultList<BasicMap<String, Object>> list=dbClient.find(sqlAdapter, paginate);
		return list;
	}
	/**
	 * 根据UID，保存用户刑期变动情况
	 * @param aid
	 * @param data
	 */
	public void saveYz(BasicMap<String,Object> data) {
		dbClient.save(SupConst.Collections.JZ_YZHZZYGQKXXCJB,data);
	}
	
	/**
	 * 根据AID获取余罪信息
	 * @param aid
	 * @return 
	 */
	public List<BasicMap<String,Object>> findxx(String aid){
		List<BasicMap<String,Object>> list=new ArrayList<>();
		String sql="SELECT a.*,dic.F_NAME as zmms FROM jz_yzhzzygqkxxcjb a"
				+ " LEFT JOIN SYS_DICTIONARY DIC ON DIC.F_TYPECODE='SYS120' AND DIC.F_CODE = a.ZM";
		SqlDbFilter sqlDbFilter=new SqlDbFilter();
		sqlDbFilter.eq("aid",aid);
		SQLAdapter sqlAdapter=new SQLAdapter(sql);
		sqlAdapter.setFilter(sqlDbFilter);
		list=dbClient.find(sqlAdapter);
		return list;
	}
	
	/**
	 * 删除
	 */
	public void deleteOne(BasicMap<String, Object> data){
		dbClient.remove(SupConst.Collections.JZ_YZHZZYGQKXXCJB,new SqlDbFilter().eq("id", StringUtil.toEmptyString(data.get("id"))));
	}
}
