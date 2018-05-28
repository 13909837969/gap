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
		String sqlstr ="select * from  view_zl_azbj_jzryjbxxb";
		SQLAdapter sql = new SQLAdapter(sqlstr);
		sql.setFilter(toSqlFilter(query));
		return dbClient.find(sql);
	}
	/**
	 * 2:全区人员衔接情况
	 * 三种类型：好，一般，不好(按月份计数)
	 */
	public List<BasicMap<String,Object>> find_qnazbjrybxqk(BasicMap<String,Object>query){
		String sqlstr ="SELECT count(a.aid),a.xsbx,b.f_name,substring(to_char(a.cdate,'99999999'),1,7) mon "+ 
						"from ANZBJ_GZJLCJB a LEFT JOIN sys_dictionary b ON b.f_code=a.xsbx WHERE b.f_typecode='SYS149'  "+ 
						"GROUP BY a.xsbx,b.f_name,mon";
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
	/**
	 * 4：全区安置帮教方式占比情况
	 * cnt 落实责任田,cnt2 公益性岗位安置,cnt3 自主创业,cnt4 从事个体经营,cnt5 企业户和经济实体吸钠就业,cnt6 其他安置方式
	 */
	public List<BasicMap<String,Object>> find_bjqk(BasicMap<String,Object>query){
		String sqlstr ="select cnt,cnt2,cnt3,cnt4,cnt5,cnt6 from view_zl_azbj_bjqk";
		SQLAdapter sql = new SQLAdapter(sqlstr);
		sql.setFilter(toSqlFilter(query));
		return dbClient.find(sql);
	}
	/**
	 * 5.全区安置帮教获得社会救助统计情况
	 * 01:落实最低生活保障,02:落实特困人员供养,03:落实医疗救助,04:落实教育救助,05:落实住房救助,06:其他
	 */
	
	
	
	
}
