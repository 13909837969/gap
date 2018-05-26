package com.ehtsoft.azbj.services;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ehtsoft.fw.core.db.SQLAdapter;
import com.ehtsoft.fw.core.db.SqlDbClient;
import com.ehtsoft.fw.core.dto.BasicMap;
import com.ehtsoft.fw.core.services.AbstractService;
/**
 * 安置帮教界面总览SQL
 * @author 李恒
 * @Data 2018-05-24
 */
@Service("AzbjJmzlService")
public class AzbjJmzlService  extends AbstractService{
	
	@Resource(name="sqlDbClient")
	SqlDbClient dbClient;
	/*安置帮教总览界面*/
	/**
	 * 1.全区人员衔接途径情况
	 * 未解除，解除社区矫正，监狱刑满释放，看守所刑满释放，公安机关落实管控
	 */
	public List<BasicMap<String,Object>> find_xjtjqk(BasicMap<String,Object>query){
		String sqlstr ="select * from  view_zl_azbj";
		SQLAdapter sql = new SQLAdapter(sqlstr);
		sql.setFilter(toSqlFilter(query));
		return dbClient.find(sql);
	}
	/**
	 * 2:全区人员衔接情况
	 * 好，一般，不好
	 */
	public List<BasicMap<String,Object>> find_qnazbjrybxqk(BasicMap<String,Object>query){
		String sqlstr ="select * from  view_zl_azbj";
		SQLAdapter sql = new SQLAdapter(sqlstr);
		sql.setFilter(toSqlFilter(query));
		return dbClient.find(sql);
	}
	/**
	 * 3：全区安置帮教类型曲线图
	 */
	public List<BasicMap<String,Object>> find_azbjlxqxt(BasicMap<String,Object>query){
		String sqlstr ="SELECT * FROM view_zl_azbj_azbjlxqxt";
		SQLAdapter sql = new SQLAdapter(sqlstr);
		sql.setFilter(toSqlFilter(query));
		return dbClient.find(sql);
	}
	
	
}
