/**
 * @Description TODO(用一句话描述该文件是做什么功能的，哪个地方使用的，android 还是 jsp 用)
 * @author wangbao
 * @date 2018年5月11日
 */
package com.ehtsoft.azbj.services;

import javax.annotation.Resource;
import javax.xml.crypto.Data;

import org.apache.lucene.queryparser.flexible.core.nodes.SlopQueryNode;
import org.omg.CosNaming.NamingContextExtPackage.StringNameHelper;
import org.springframework.stereotype.Service;

import com.ehtsoft.fw.core.db.RowDataListener;
import com.ehtsoft.fw.core.db.SQLAdapter;
import com.ehtsoft.fw.core.db.SqlDbClient;
import com.ehtsoft.fw.core.db.SqlDbFilter;
import com.ehtsoft.fw.core.dto.BasicMap;
import com.ehtsoft.fw.core.dto.Paginate;
import com.ehtsoft.fw.core.dto.ResultList;
import com.ehtsoft.fw.core.services.AbstractService;
import com.ehtsoft.fw.utils.DateUtil;
import com.ehtsoft.fw.utils.StringUtil;
import com.ehtsoft.supervise.api.SupConst;

/**
 * @Description TODO(用一句话描述该文件是做什么功能的，哪个地方使用的)
 * @author wangbao
 * @date 2018年5月11日
 */
@Service("AzbjDemoService")
public class AzbjDemoService extends AbstractService{
	
	
	@Resource(name="sqlDbClient")
	private SqlDbClient dbClient;
	
//	@Resource(name="mongoClient")
//	private MongoClient mongoClient;
	/**
	 * 简单分页方法
	 * @param query
	 * @param paginate
	 * @return<br>
	 * 返回值格式:<br>
	 *
	 * @author wangbao
	 * @date   2018年5月11日
	 * 方法的作用：TODO
	 */
	public ResultList<BasicMap<String, Object>> findSimple(BasicMap<String, Object> query,Paginate paginate){
		SqlDbFilter filter = toSqlFilter(query);//.eq("sfcj", 1);
//		SqlDbFilter filter = new SqlDbFilter();
//		filter.like("XM", StringUtil.toString(query.get("XM")));
		return dbClient.find(SupConst.Collections.JZ_JZRYJBXX,filter,paginate);
	}
	
	public ResultList<BasicMap<String, Object>> findDemo(BasicMap<String, Object> query,Paginate paginate){
		String sqlstr = "SELECT A.*,B.GDJZDMX FROM JZ_JZRYJBXX A LEFT JOIN JZ_JZRYJBXX_DZ ON A.ID = B.ID";
		SQLAdapter sql = new SQLAdapter(sqlstr);
	    sql.getFilter().like("XM", StringUtil.toString(query.get("XM"))).like("SFZH", StringUtil.toString(query.get("sfzh")));
	    //SELECT A.*,B.GDJZDMX FROM JZ_JZRYJBXX A LEFT JOIN JZ_JZRYJBXX_DZ ON A.ID = B.ID where sfzh like '%1%' and xm like '%%''
		return dbClient.find(sql,paginate,new RowDataListener() {
			@Override
			public void processData(BasicMap<String, Object> rowData) {
				//处理每条记录   将出生日期转换成 年龄
				rowData.put("nl", DateUtil.getAge(rowData.get("CSRQ")));
			}
		});
	}
	
	/**
	 * 查下一条数据
	 * @param id
	 * @return<br>
	 * 返回值格式:<br>
	 *
	 * @author wangbao
	 * @date   2018年5月12日
	 * 方法的作用：TODO
	 */
	public BasicMap<String, Object> findOne1(String id){
		return dbClient.findOne(SupConst.Collections.JZ_JZRYJBXX, new SqlDbFilter().eq("ID", id));
	}
	
	
	public void saveDemo(BasicMap<String, Object> data){
		//插入
//		dbClient.insert(SupConst.Collections.JZ_JZRYJBXX, data);
		//取主键
//		String id = StringUtil.toEmptyString(data.get("ID"));
		
		//更新
//		dbClient.update(SupConst.Collections.JZ_JZRYJBXX, data);
		
		//数据存在的时候更新，不存在的时候插入
		dbClient.save(SupConst.Collections.JZ_JZRYJBXX, data);
	}
	/**
	 * 删除
	 * TODO(方法的描述，哪那个地方使用的等)
	 * @param data<br>
	 * 返回值格式:<br>
	 *
	 * @author wangbao
	 * @date   2018年5月12日
	 * 方法的作用：TODO
	 */
	public void removeOne(BasicMap<String, Object> data){
		//ID:333
		dbClient.remove(SupConst.Collections.JZ_JZRYJBXX, data);
	}

}
