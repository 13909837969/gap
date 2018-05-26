package com.ehtsoft.supervise.services;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ehtsoft.common.services.SSOService;
import com.ehtsoft.fw.core.db.SQLAdapter;
import com.ehtsoft.fw.core.db.SqlDbClient;
import com.ehtsoft.fw.core.db.SqlDbFilter;
import com.ehtsoft.fw.core.dto.BasicMap;
import com.ehtsoft.fw.core.dto.Paginate;
import com.ehtsoft.fw.core.services.AbstractService;
import com.ehtsoft.fw.utils.StringUtil;
import com.ehtsoft.supervise.api.SupConst;

/**
 * 
 * 人民调节回访记录
 * @author Administrator
 * @date 2018年4月7日
 *
 */
@Service("RmtjHfjlService")
public class RmtjHfjlService extends AbstractService{
	
	@Resource(name="sqlDbClient")
	private SqlDbClient dbClient;
	
	@Resource(name="SSOService")
	private SSOService service;
	
	
	/**
	 * 
	 * 【回访图片的保存  RMTJ_HFJL_IMG  外键关联  IMGID 矫正人员ID】
	 * 
	 * 新增回访记录   
	 * 返回值格式: void
	 *
	 * @author Administrator
	 * @date   2018年4月7日
	 * 方法的作用：TODO
	 */
	public void save(BasicMap<String, Object> data) {
		dbClient.save(SupConst.Collections.RMTJ_HFJL, data);
		//保存DCJZID,YWSZID
		dbClient.save(SupConst.Collections.RMTJ_DCJZ_YWSZ, data);
	}

	
	/**
	 * 
	 * 回访记录列表
	 * @param query
	 * @param paginate
	 * @return<br>
	 * 返回值格式: List<BasicMap<String, Object>>
	 *
	 * @author Administrator
	 * @date   2018年4月7日
	 * 方法的作用： 检索条件  根据 回访的时间范围进行检索    hfkssj：回访开始时间     hfjssj 回访结束时间
	 */ 
	public List<BasicMap<String, Object>> findAll(BasicMap<String, Object> query,Paginate paginate) {
		String sqlstr = "SELECT id,DCJZID,DSRID,XYSID,TJXYBM,HFSJ,FSSY,HFDD,HFQK,LXQK,SFMY,HFRQZ FROM RMTJ_HFJL ";
		SQLAdapter adapter = new SQLAdapter(sqlstr);
		SqlDbFilter filter = new SqlDbFilter();
		filter.between("HFSJ", query.get("hfkssj"), query.get("hfjssj"));
		filter.eq("DCJZID",StringUtil.toEmptyString(query.get("jzId")));
		adapter.setFilter(filter);
		List<BasicMap<String, Object>> list = dbClient.find(adapter, paginate).getRows();
		return list;
	}
	/**
	 * 
	 * 回访记录列查询一条
	 * @param query
	 * @param paginate
	 * @return<br>
	 * 返回值格式: BasicMap<String, Object>
	 * @author Administrator
	 */ 
	public BasicMap<String, Object> findOne(BasicMap<String, Object> query) {
		String sqlstr = "SELECT a.*,b.XM FROM RMTJ_HFJL a inner join RMTJ_TJAJSQR b  On a.dcjzid=b.TJAJXXID "
				+ "where b.LX='1' and a.DSRID='"+ query.get("DSRID") +"' and a.dcjzid='"+ query.get("jzId") +"'and a.id='"+query.get("id")+"'";
		SQLAdapter adapter = new  SQLAdapter(sqlstr);
		return dbClient.findOne(adapter);
	}
	
	
	
}

