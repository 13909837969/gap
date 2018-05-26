package com.ehtsoft.supervise.services;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ehtsoft.fw.core.db.InsertOperation;
import com.ehtsoft.fw.core.db.RowDataListener;
import com.ehtsoft.fw.core.db.SQLAdapter;
import com.ehtsoft.fw.core.db.SqlDbClient;
import com.ehtsoft.fw.core.db.SqlDbFilter;
import com.ehtsoft.fw.core.dto.BasicMap;
import com.ehtsoft.fw.core.dto.Paginate;
import com.ehtsoft.fw.core.dto.ResultList;
import com.ehtsoft.fw.core.services.AbstractService;
import com.ehtsoft.fw.utils.NumberUtil;
import com.ehtsoft.fw.utils.StringUtil;
import com.ehtsoft.fw.utils.Util;
import com.ehtsoft.supervise.api.SupConst;
/**
 * 试卷服务
 * 通过题库自动生成试卷
 * 对应的数据库表为：JZ_WJSTXXB （ 问卷试题信息记录表 ）
 * @author wangbao
 */
@Service("TestPaperService")
public class TestPaperService extends AbstractService{

	@Resource(name = "sqlDbClient")
	private SqlDbClient dbClient;
	
	/**
	 * 创建试卷
	 * @param param
	 * {
	 *  f_wjlx:"问卷类型  1 法律问卷 2 心里评测",
	 *  f_stsl: 试题数量（自动创建文件试题数量）,
	 *  f_sjbt：试卷标题（名称）,
	 *  f_sjzfz：试卷总分值
	 * }
	 */
	public void create(BasicMap<String,Object> param){
		//试题数量
		int f_stsl = NumberUtil.toInt(param.get("f_stsl"));
		
		BasicMap<String,Object> data = new BasicMap<String,Object>();
		data.put("F_SJBT", param.get("f_sjbt"));//试卷标题
		data.put("F_WJLX", param.get("f_wjlx"));//问卷类型  1 法律问卷  2 心理评测
		data.put("F_SJZFZ", param.get("f_sjzfz"));//试卷总分数
		dbClient.insert(SupConst.Collections.JZ_WJSTXXB, data);
		
		String stid = StringUtil.toString(data.get("F_STID"));
		dbClient.remove(SupConst.Collections.JZ_WJSTXX_MX, new SqlDbFilter().eq("F_STID", stid));
		List<BasicMap<String,Object>> list = new ArrayList<>();
		//F_TKID 问卷题库信息记录ID
		SQLAdapter sql = new SQLAdapter("SELECT F_TKID FROM JZ_WJTKXXB");
		sql.getFilter().eq("F_WJLX", param.get("f_wjlx"));
		List<BasicMap<String, Object>> ls = dbClient.find(sql);
		if(ls.size() < f_stsl){
			f_stsl = ls.size();
		}
		//根据 试题数量 随机从题库中抽取数据
		int[] buffer = NumberUtil.random(ls.size());
		int[] indexs = new int[f_stsl];
		System.arraycopy(buffer, 0, indexs, 0, f_stsl);
		
		for(int i=0;i<indexs.length;i++){
			list.add(ls.get(indexs[i]));
		}
		dbClient.insert(SupConst.Collections.JZ_WJSTXX_MX, list,new InsertOperation() {
			@Override
			public void insertBefore(BasicMap<String, Object> data) {
				data.put("F_STID", stid);//问卷题库信息记录ID
			}
			@Override
			public void insertAfter(BasicMap<String, Object> data) {
			}
		});
	}
	/**
	 * 获取试卷信息
	 * @return
	 */
	public ResultList<BasicMap<String, Object>> find(BasicMap<String,Object> query,Paginate paginate){
		//问卷试题信息记录表
		ResultList<BasicMap<String, Object>> rtn = dbClient.find(SupConst.Collections.JZ_WJSTXXB,toSqlFilter(query),paginate);
		return rtn;
	}
	
	public BasicMap<String,Object> findOne(String stid){
		//主键  试卷标题   问卷类型   试卷总分数
		BasicMap<String,Object> rtn = dbClient.findOne("SELECT F_STID,F_SJBT,F_WJLX,F_SJZFZ FROM JZ_WJSTXXB WHERE F_STID = ?",stid);
		if(rtn!=null){
			String sqlstr = "SELECT B.F_TKID,B.F_WTMS,B.F_WJLX,F_XTLX,F_WTDA,F_DAJX,C.F_DAXX,C.F_DAXXMS FROM JZ_WJSTXX_MX A" +
							" INNER JOIN JZ_WJTKXXB B ON A.F_TKID = B.F_TKID" +
							" INNER JOIN JZ_WJTKXX_DAXX C ON C.F_TKID = A.F_TKID";
			
			SQLAdapter sql = new SQLAdapter(sqlstr);
			sql.getFilter().eq("A.F_STID", stid);
			sql.getFilter().asc("A.F_STID").asc("F_DAXX");
			final List<BasicMap<String, Object>> list = new ArrayList<>();
			dbClient.find(sql,new RowDataListener() {
				Map<String,BasicMap<String,Object>> map = new BasicMap<>();
				public void processData(BasicMap<String, Object> rowData) {
					String f_tkid = StringUtil.toString(rowData.get("F_TKID"));
					// 为空的时候
					if(Util.isEmpty(map.get(f_tkid))){
						BasicMap<String,Object> data = new BasicMap<>();
						//F_TKID
						data.putAll(rowData);
						data.remove("F_DAXX");
						data.remove("F_DAXXMS");
						list.add(data);
						BasicMap<String,Object> item = new BasicMap<String,Object>();
						item.put("F_DAXX", rowData.get("F_DAXX")); //答案选项
						item.put("F_DAXXMS", rowData.get("F_DAXXMS"));//答案选项描述
						
						List<BasicMap<String, Object>> cs = new ArrayList<>();
						cs.add(item);
						data.put("children", cs);
						map.put(f_tkid, data);
					}else{
						//不为空的时候
						List<BasicMap<String,Object>> l = (List<BasicMap<String,Object>>)map.get(f_tkid).get("children");
						BasicMap<String,Object> item = new BasicMap<String,Object>();
						item.put("F_DAXX", rowData.get("F_DAXX")); //答案选项
						item.put("F_DAXXMS", rowData.get("F_DAXXMS"));//答案选项描述
						l.add(item);
					}
				}
			});
			rtn.put("children", list);
		}
		return rtn;
	}
}
