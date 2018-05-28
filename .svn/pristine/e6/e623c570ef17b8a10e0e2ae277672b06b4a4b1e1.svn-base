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
import com.mongodb.DB;

/**
 * 
 * @Description 书面人民调解-调解记录
 * @author Administrator
 * @date 2018年4月4日
 *
 */
@Service("RmtjTjjlService")
public class RmtjTjjlService extends AbstractService {
	
	@Resource(name = "sqlDbClient")
	private SqlDbClient dbClient;
	
	
	@Resource(name="SSOService")
	private SSOService service;
	
	/**
	 * 
	 * 调解记录数据保存： RMTJ_TJJL (人民调解调解记录表）
	 * 调解记录的图片保存到 RMTJ_TJJL_IMG 表中  关键字段：RMTJ_TJJL_IMG.TJJLID = RMTJ_TJJL.ID
	 * 返回值格式:<br>
	 *
	 * @author Administrator
	 * @date   2018年4月4日
	 * 方法的作用：TODO
	 */
	public void saveTjjl(BasicMap<String, Object> data) {
		data.put("ID", data.get("dcjzid"));
		data.put("TJYXM", data.get("tjyxm"));
		data.put("TJYID", data.get("tjyid"));
		dbClient.save(SupConst.Collections.RMTJ_TJJL, data);
		
		//保存书面调解-人民调解调查卷宗和人民调解业务设置关联表  的关联字段
		BasicMap<String, Object> data1 = new BasicMap<>();
		data1.put("YWSZID", data.get("YWSZID")); //4
		data1.put("DCJZID", data.get("DCJZID"));//1
		dbClient.save(SupConst.Collections.RMTJ_DCJZ_YWSZ, data1);
		
		
		//保存 人民调解协议书  RMTJ_XYS : ID [jzID]   调委会   TWH  及 调解员  JLR   
		
		BasicMap<String, Object>  xys = new BasicMap<>();
		xys.put("ID", data.get("dcjzid"));
		xys.put("TWH", data.get("twhmc")); //调委会名称
		xys.put("JLR", data.get("tjyxm")); //调解员姓名
		dbClient.save(SupConst.Collections.RMTJ_XYS, xys);
		
		BasicMap<String, Object>  dcjzData = new BasicMap<>();
		dcjzData.put("ID", data.get("dcjzid"));
		dcjzData.put("TJY", data.get("tjyxm"));
		dbClient.save(SupConst.Collections.RMTJ_DCJZ, dcjzData);

		
		
		//保存参加人
		//参加人保存到 RMTJ_TJAJSQR 表中  调查记录ID (RMTJ_DCJL.ID)(RMTJ_TJJL.ID)  保存到  RMTJ_TJAJSQR.TJAJXXID ，类型（LX） 为 4  ，具体见数据模型文档
		BasicMap<String, Object> data2 = new BasicMap<>();
		data2.put("IMGID", data.get("ID"));
		data2.put("LX", "4");
		dbClient.save(SupConst.Collections.RMTJ_TJAJSQR, data2);
		
	}

	/**
	 * 
	 * 返回当事人列表
	 * @return<br>
	 * 返回值格式:<br>
	 * 当时人信息来自人民调解申请中的 申请人和被申请人（RMTJ_TJAJSQR  [外键 RMTJ_TJSQS.id] ）
	 * @author Administrator
	 * @date   2018年4月4日
	 * 方法的作用：TODO
	 */
	public List<BasicMap<String, Object>> findDsr(String id) {
		String sql = "SELECT  A . ID,A .xm,A .SFZH,A .lx,A .DHHM,A .JTZZ, c.TJYXM, c.DCJLNR " + 
				"FROM RMTJ_TJAJSQR A " + 
				"LEFT JOIN RMTJ_TJSQS b ON b. ID = A .TJAJXXID "+ 
				"LEFT JOIN rmtj_tjjl c ON c.id =  A .TJAJXXID " + 
				"WHERE A .lx IN ('1', '2','4') " + 
				"AND b. ID = '"+ id +"' " + 
				"GROUP BY  A . ID, A .xm, A .SFZH, A .lx, A .DHHM, A .JTZZ , c.TJYXM, c.DCJLNR";
		SQLAdapter adapter = new SQLAdapter(sql);
		List<BasicMap<String, Object>> list = dbClient.find(adapter);
		return list;
	}
	
	
	
	/**
	 * 
	 * @param query
	 * @return<br>
	 * 返回值格式: List<BasicMap<String, Object>>
	 *
	 * @author Administrator
	 * @date   2018年4月12日
	 * 方法的作用：查询 调解记录的参加人
	 */
	public List<BasicMap<String, Object>> findCjr(BasicMap<String, Object> query) {
		String sql = "SELECT A .xm,b.f_name AS xb " + 
				"FROM RMTJ_TJAJSQR A " + 
				"LEFT JOIN sys_dictionary b ON A .xb = b.f_code " + 
				"WHERE A .lx ='4'" + 
				"AND b.f_typecode = 'SYS000' " + 
				"and a.TJAJXXID = '"+ query.get("dcjzid")+"'";
		SQLAdapter adapter = new SQLAdapter(sql);
		return dbClient.find(adapter);
				

	}
	
	/**
	 * 
	 * @param query
	 * @return<br>
	 * 返回值格式:<br>
	 *
	 * @author Administrator
	 * @date   2018年4月12日
	 * 方法的作用：方法的作用：查询  调解记录
	 */
	public BasicMap<String, Object> findTjjl(BasicMap<String, Object> query) {
		String sql = "SELECT b.f_name,a.dcjg,a .tjyxm,a .TJYID,a .DCJLNR,c.twhid,d.TWHMC " + 
				"FROM RMTJ_TJJL a " + 
				"LEFT JOIN sys_dictionary b ON a .dcjg = b.f_code " + 
				"LEFT JOIN   RMTJ_TJYJBXX c ON a.TJYID = c.id " + 
				"LEFT JOIN RMTJ_JWHJBXX d ON c.twhid = d.id " + 
				"WHERE b.f_typecode = 'SYS110' and a.ID = '"+ query.get("dcjzid")+"'";
		SQLAdapter adapter = new SQLAdapter(sql);
		BasicMap<String,Object> map=dbClient.findOne(adapter);
		return map;
	}
	
}
