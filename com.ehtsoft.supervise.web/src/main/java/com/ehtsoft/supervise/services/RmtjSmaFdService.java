package com.ehtsoft.supervise.services;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ehtsoft.common.services.SSOService;
import com.ehtsoft.fw.core.db.SQLAdapter;
import com.ehtsoft.fw.core.db.SqlDbClient;
import com.ehtsoft.fw.core.dto.BasicMap;
import com.ehtsoft.fw.core.services.AbstractService;
import com.ehtsoft.supervise.api.SupConst;

@Service("RmtjSmaFdService")
public class RmtjSmaFdService extends  AbstractService{ 
	
	
	@Resource(name="sqlDbClient")
	private SqlDbClient dbClient;
	
	@Resource(name="SSOService")
	private SSOService service;
	
	/**
	 * 封底日期保存
	 * @param data 【立卷日期，卷宗说明，dcjzid ， ywszid】
	 */
	public void save(BasicMap<String, Object> data) {
		dbClient.save(SupConst.Collections.RMTJ_DCJZ, data);
		
		//保存关联ID
		//data.put("DCJZID", data.get("dcjzid"));
		
		dbClient.save(SupConst.Collections.RMTJ_DCJZ_YWSZ, data);

	}
	
	/**
	 * 查看
	 * @param data 【立卷日期，卷宗说明，dcjzid ， ywszid】
	 */
	public BasicMap<String,Object> findOne(String dcjzid) {
		String sql="select * from RMTJ_DCJZ where id = '"+dcjzid+"'";
		SQLAdapter adapter=new SQLAdapter(sql);
		BasicMap<String,Object> map=dbClient.findOne(adapter);
		return map;
	}

	
	/**
	 * 查询 人民调解调查封底相关照片
	 * @param dcjzid
	 * @return
	 */
	public List<BasicMap<String, Object>> findAllImg(String dcjzid) {
			String sql = " select * from RMTJ_DCJZ_IMG where  DCJZID = '"+ dcjzid+"'";
			SQLAdapter adapter = new SQLAdapter(sql);
			return dbClient.find(adapter);
	}

}
