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
import com.ehtsoft.fw.core.services.AbstractService;
import com.ehtsoft.supervise.api.SupConst;

/**
 * 人民调解-调查卷宗
 * @author maruimin
 *
 */
@Service("RmtjDcjzService")
public class RmtjDcjzService extends AbstractService{
	@Resource(name="sqlDbClient")
	private SqlDbClient dbClient;
	@Resource(name="SSOService")
	private SSOService service;
	
	
	/**
	 * 添加申请登记中申请人信息和被申请人信息
	 * @param list
	 */
	public void saveSqr(List<BasicMap<String,Object>> list){
		dbClient.save(SupConst.Collections.RMTJ_TJAJSQR,list);
	}
	
	/**
	 * 添加申请登记中纠纷概要信息
	 * @param data
	 */
	public void saveJfgy(BasicMap<String,Object> data) {
		//dbClient.save(SupConst.Collections.RMTJ_JFZYQK, data);
	}
	 
	/**
	 * 添加申请登记中当事人申请事项
	 * @param list
	 */
	public void saveDsrsq(List<BasicMap<String,Object>> list) {
		//dbClient.save(SupConst.Collections.RMTJ_SQDJXX_SXXX,list);
	}
	
	/**
	 * 添加申请登记中图片
	 * @param list
	 */
	public void saveSqdjTp(List<BasicMap<String,Object>> list) {
		//dbClient.save(SupConst.Collections.RMTJ_SQDJXX_IMG,list);
	}
	
	/**
	 * 添加调查记录中基本信息
	 * @param data
	 */
	public void saveDcjljbxx(BasicMap<String,Object> data) {
		//dbClient.save(SupConst.Collections.RMTJ_PCJFAJ,data);
	}
	
	/**
	 * 添加调查记录中被调查人和参加人
	 * @param data
	 */
	public void saveDcjlDcr(BasicMap<String,Object> data) {
		//dbClient.save(SupConst.Collections.RMTJ_BDCRJL,data);
	}
	
	/**
	 * 添加调查记录中图片
	 * @param data
	 */
	public void saveDcjlTp(List<BasicMap<String,Object>> list) {
		//dbClient.save(SupConst.Collections.RMTJ_PCJFAJ_IMG,data);
	}
	
	/**
	 * 获取所有的调查记录
	 * @param query
	 * @param paginate
	 * @return{
	 * 
	 *    }
	 */
	public List<BasicMap<String,Object>> findDcjl(BasicMap<String,Object> query,Paginate paginate){
		List<BasicMap<String,Object>> list=new ArrayList<>();
		String sql="";
		SQLAdapter adapter=new SQLAdapter(sql);
		SqlDbFilter filter=new SqlDbFilter();
		//filter.like(column, value)
		adapter.setFilter(filter);
		list=dbClient.find(adapter,paginate).getRows();
		return list;
	}
	
	/**
	 * 添加调查取证基本信息
	 * @param data
	 */
	public void saveDcqzJbxx(BasicMap<String,Object> data) {
		//dbClient.save(SupConst.Collections.RMTJ_QZXX, data);
	}
	
	/**
	 * 添加调查取证图片
	 * @param data
	 */
	public void saveDcqzTp(List<BasicMap<String,Object>> list) {
		//dbClient.save(SupConst.Collections.RMTJ_QZXX_IMG, data);
	}
	
	/**
	 * 添加调解记录基本信息
	 * @param data
	 */
	public void saveTjjlJbxx(BasicMap<String,Object> data) {
		//dbClient.save(SupConst.Collections.RMTJ_TJJL, data);
	}
	
	/**
	 * 添加调解记录中当事人
	 * @param data
	 */
	public void saveTjjlDsr(List<BasicMap<String,Object>> list) {
		//dbClient.save(SupConst.Collections.RMTJ_DSRYS,list);
	}
	
	/**
	 * 添加调解记录中参加人
	 * @param data
	 */
	public void saveTjjlCjr(List<BasicMap<String,Object>> list) {
		//dbClient.save(SupConst.Collections.,list);
	}
	
	/**
	 * 添加调解记录图片
	 * @param data
	 */
	public void saveTjjlTp(List<BasicMap<String,Object>> list) {
		//dbClient.save(SupConst.Collections.RMTJ_TJJL_IMG, list);
	}
	
	/**
	 * 添加人民调解协议书中当事人
	 * @param list
	 */
	public void saveRmtjxys(List<BasicMap<String,Object>> list) {
		//dbClient.save(SupConst.Collections.RMTJ_DSRYS, list);
	}
	
	/**
	 * 添加人民调解协议书图片
	 * @param data
	 */
	public void saveRmtjxysTp(List<BasicMap<String,Object>> list) {
		//dbClient.save(SupConst.Collections.RMTJ_XYS_IMG, data);
	}
	
	

}
