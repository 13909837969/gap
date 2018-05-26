package com.ehtsoft.supervise.services;

import java.util.List;

import javax.annotation.Resource;

import org.apache.regexp.recompile;
import org.springframework.stereotype.Service;

import com.ehtsoft.common.services.SSOService;
import com.ehtsoft.fw.core.db.RowDataListener;
import com.ehtsoft.fw.core.db.SQLAdapter;
import com.ehtsoft.fw.core.db.SqlDbClient;
import com.ehtsoft.fw.core.dto.BasicMap;
import com.ehtsoft.fw.core.services.AbstractService;
import com.ehtsoft.fw.utils.StringUtil;
import com.ehtsoft.fw.utils.Util;
import com.ehtsoft.supervise.api.SupConst;

/**
 * 
 * 人民调节协议书（书面）
 * @author Administrator
 * @date 2018年4月7日
 *
 */
@Service("RmtjKtXysService")
public class RmtjKtXysService extends AbstractService{
	
	@Resource(name="sqlDbClient")
	private SqlDbClient dbClient;
	
	@Resource(name="SSOService")
	private SSOService service;
	
	
	/**
	 * 【注：人民调解协议书-当事人签字信息 保存到数据表  RMTJ_XYS_IMG 关联外键 XYSID  RMTJ_XYS.ID   签字类型 LX   1 当事人签字   2  调解员签字  3 记录人签字】
	 * 
	 * 添加人民调节协议书（书面）
	 * @param data<br>
	 * 返回值格式:<br>
	 *
	 * @author Administrator
	 * @date   2018年4月7日
	 * 方法的作用：TODO
	 */
	public void save(BasicMap<String, Object> data) {
		data.put("ID", data.get("DCJZID"));
		dbClient.save(SupConst.Collections.RMTJ_XYS, data);
		
		
		//当事人
		if (Util.isNotEmpty(StringUtil.toString(data.get("type1")))) {
			BasicMap<String, Object > data1 = new BasicMap<>();
			data1.put("XYSID", data.get("DCJZID"));
			data1.put("lx","1");
			data1.put("data", data.get("type1"));
			dbClient.save(SupConst.Collections.RMTJ_XYS_IMG, data1);
		}
		//调解员
		if (Util.isNotEmpty(StringUtil.toString(data.get("type2")))) {
			BasicMap<String, Object > data2 = new BasicMap<>();
			data2.put("XYSID", data.get("DCJZID"));
			data2.put("lx","2");
			data2.put("data", data.get("type2"));
			dbClient.save(SupConst.Collections.RMTJ_XYS_IMG, data2);
		}
		//记录人
		if (Util.isNotEmpty(StringUtil.toString(data.get("type3")))) {
			BasicMap<String, Object > data3 = new BasicMap<>();
			data3.put("XYSID", data.get("DCJZID"));
			data3.put("lx","3");
			data3.put("data", data.get("type3"));
			dbClient.save(SupConst.Collections.RMTJ_XYS_IMG, data3);
		}
		
		
		//保存DCJZID,YWSZID
		dbClient.save(SupConst.Collections.RMTJ_DCJZ_YWSZ, data);
	}
	
	
	/**
	 * 
	 * 查询签字图片
	 * @param id -- 卷宗ID
	 * @return<br>
	 * 返回值格式: List<BasicMap<String, Object>>
	 *
	 * @author Administrator
	 * @date   2018年5月1日
	 * 方法的作用：TODO
	 */
	public BasicMap<String, Object>  findIMG(String id) {
		BasicMap<String, Object> map = new BasicMap<>();
		String sql = "SELECT imgid,lx FROM RMTJ_XYS_IMG where  XYSID = '"+ id +"'";
		SQLAdapter adapter = new SQLAdapter(sql);
		List<BasicMap<String, Object>> list = dbClient.find(adapter,new RowDataListener() {
			
			@Override
			public void processData(BasicMap<String, Object> rowData) {
				map.put(StringUtil.toEmptyString(rowData.get("lx")), rowData.get("imgid"));
			}
		});
		return map;
	}
	
	
	
	public BasicMap<String, Object> findTJY(String dcjzid) {
		String sql = "select * from RMTJ_XYS where id ='"+ dcjzid +"'";
		SQLAdapter adapter = new  SQLAdapter(sql);
		return dbClient.findOne(adapter);
	}
}
