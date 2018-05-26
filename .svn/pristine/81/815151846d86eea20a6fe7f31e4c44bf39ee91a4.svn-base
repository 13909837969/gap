package com.ehtsoft.supervise.services;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ehtsoft.fw.core.db.SQLAdapter;
import com.ehtsoft.fw.core.db.SqlDbClient;
import com.ehtsoft.fw.core.db.SqlDbFilter;
import com.ehtsoft.fw.core.dto.BasicMap;
import com.ehtsoft.fw.core.services.AbstractService;
import com.ehtsoft.fw.utils.Util;
import com.ehtsoft.supervise.api.SupConst;

/**
 * 司法行政机构管理类
 * @author liuzhih
 *
 */
@Service("JzSfxzjgService")
public class JzSfxzjgService extends AbstractService{
	
	@Resource(name = "sqlDbClient")
	private SqlDbClient dbClient;
	
	public List<BasicMap<String,Object>> find(BasicMap<String,Object> query){
		List<BasicMap<String,Object>> list = dbClient.find(SupConst.Collections.JZ_SFXZJGJBXX,toSqlFilter(query));
		return Util.list2Tree(list, "PARENTID", "ID");
	}
	
	
	/**
	 *根据ID获取所有的下级机构
	 */
	public  List<BasicMap<String, Object>>  findByParentId(String parentid){
		List<BasicMap<String, Object>> list = new ArrayList<>();
		String sqlstr = "select id,jgbm,jgmc,dz,jgdm,jglb,regionid,lat,lng from JZ_SFXZJGJBXX";
		SQLAdapter sqlAdapter = new SQLAdapter(sqlstr);
		sqlAdapter.getFilter().eq("PARENTID", parentid);
		list = dbClient.find(sqlAdapter);
		return list;
	}
}
