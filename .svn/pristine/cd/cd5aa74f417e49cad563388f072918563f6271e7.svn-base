package com.ehtsoft.supervise.services;

import javax.annotation.Resource;

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
import com.ehtsoft.im.services.UserinfoService;
import com.ehtsoft.supervise.api.SupConst;


/**
 * 矫正随访
 * @author sunhailong
 *
 */
@Service("JzsfService")
public class JzsfService extends AbstractService{
	
	@Resource(name = "sqlDbClient")
	private SqlDbClient dbClient;
	
	@Resource
	private UserinfoService userinfoService;
	
	/**
	 * 插入与保存一条走访检查情况
	 * @param query
	 * @param paginate
	 * @return
	 */
	public void save(BasicMap<String, Object> data){
			dbClient.insert(SupConst.Collections.JZ_ZFJCQK, data);
	}
	/**
	 * 查询走访检查表和矫正人员信息表的内容
	 * @param query
	 * @param paginate
	 * @return
	 * {
	 * b.xm:矫正人员姓名
	 * b.xb:矫正人员性别
	 * b.mz:矫正人员民族
	 * b.sfzh:矫正人员身份证号
	 * b.sqjzksrq:社区矫正开始日期
	 * b.sqjzjsrq:社区矫正结束日期
	 * b.hjszdmx:矫正人员户籍所在地明细
	 * b.grlxdh:矫正人员个人联系电话
	 * b.whcd:矫正人员文化程度
	 * b.csrq:矫正人员出生日期
	 * b.fzlx:矫正人员犯罪类型
	 * a.f_dz:走访检查地址
	 * a.f_thr:走访检查谈话人
	 * a.f_jlr:走访检查记录人
	 * a.f_blnr:走访检查笔录内容
	 * a.cts:走访检查创建时间
	 * 
	 * }
	 */
	public ResultList<BasicMap<String, Object>> findAll(BasicMap<String, Object> query ,Paginate paginate){
		SqlDbFilter filter = toSqlFilter(query);
		String sqlstr = "select b.xm,b.xb,b.mz,b.sfzh,b.sqjzksrq,b.sqjzjsrq,b.hjszdmx,b.grlxdh,"
				+ "b.whcd,b.csrq,b.fzlx,a.f_dz,a.f_thr,a.f_jlr,a.f_blnr,a.cts from JZ_JZRYJBXX b left"
				+ " join JZ_ZFJCQK a on b.id=a.f_aid";
		SQLAdapter sqlAdapter = new SQLAdapter(sqlstr);
		sqlAdapter.setFilter(filter);
		return dbClient.find(sqlAdapter, paginate,new RowDataListener() {
			
			@Override
			public void processData(BasicMap<String, Object> rowData) {
				rowData.put("sqjzksrq", DateUtil.format(rowData.get("sqjzksrq"), "yyyy-MM-dd"));
				rowData.put("sqjzjsrq", DateUtil.format(rowData.get("sqjzjsrq"), "yyyy-MM-dd"));
				rowData.put("csrq", DateUtil.format(rowData.get("csrq"), "yyyy-MM-dd"));
			}
		});
	}
}
