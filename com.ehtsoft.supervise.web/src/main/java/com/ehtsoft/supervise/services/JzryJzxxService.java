package com.ehtsoft.supervise.services;

import java.util.List;

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
import com.ehtsoft.supervise.api.SupConst;
/**
 * 矫正人员矫正信息
 * @author sunhailong
 *
 */
@Service("JzryJzxxService")
public class JzryJzxxService extends AbstractService{
	
	@Resource(name="sqlDbClient")
	private SqlDbClient dbClient;
	
	/**
	 * 查询矫正人员判决信息
	 * xm 矫正人员姓名
	 * sfzh 矫正人员身份证号
	 * jzjg 矫正机构
	 * jzsssq 矫正所属社区
	 * bdqk 报到情况
	 * jfzxrq 交付执行日期
	 * wasbdqksm 未按时报到情况说明
	 * sqjzryjsfs 社区矫正人员接受方式
	 * sqjzryjsrq 社区矫正人员接受日期
	 * sfjljzxz 是否建立矫正小组
	 * sfcydzdwgl 是否采用电子定位管理
	 * dzdwfs 电子定位方式
	 * dwhm 定位号码
	 * dhhbfqh 电话汇报发起号码
	 * dhhbjsh 电话汇报接收号码
	 * 
	 */
	public ResultList<BasicMap<String,Object>> findAll(BasicMap<String,Object> query,Paginate paginate){
		SqlDbFilter filter = toSqlFilter(query);
		String sql = "select a.id,b.xm,b.xb,b.fzlx,b.jtzm,b.grlxdh,b.sfzh,a.jzjg,a.jzsssq,a.bdqk,a.jfzxrq,a.wasbdqksm,a.sqjzryjsfs,a.sqjzryjsrq,a.sfjljzxz,a.sfcydzdwgl,"
				+ "a.dzdwfs,a.dwhm,a.dhhbfqh,a.dhhbjsh from JZ_JZXX a left join JZ_JZRYJBXX b on a.id=b.id";
		SQLAdapter adapter = new SQLAdapter(sql);
		adapter.setFilter(filter);
		ResultList<BasicMap<String,Object>> list = dbClient.find(adapter, paginate,new RowDataListener() {

			@Override
			public void processData(BasicMap<String, Object> rowData) {
				rowData.put("jfzxrq", DateUtil.format(rowData.get("jfzxrq"),"yyyy-MM-dd"));
				rowData.put("sqjzryjsrq",DateUtil.format(rowData.get("sqjzryjsrq"),"yyyy-MM-dd"));
			}
			
		});
		return list;
	}
	/**
	 * 新增与修改判决信息
	 */
	public void insert(BasicMap<String,Object> map){
		dbClient.save(SupConst.Collections.JZ_JZXX, map);
	}
	/**
	 * 删除判决信息
	 */
	public void remove(List<BasicMap<String, Object>> list){
		for (int i = 0; i < list.size(); i++) {
			dbClient.remove(SupConst.Collections.JZ_JZXX, list.get(i));
		}
	}
	
	/**
	 * 新增矫正人员信息
	 * @param data
	 */
	public void save(BasicMap<String,Object> data) {
		data.put("sfjs", 1);
		dbClient.save(SupConst.Collections.JZ_JZRYJBXX, data);
	}
}
