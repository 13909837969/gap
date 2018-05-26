package com.ehtsoft.supervise.services;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ctc.wstx.util.DataUtil;
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
 * 
 * @author sunhailong
 * 矫正人员判决信息
 *
 */
@Service("JzryPjxxService")
public class JzryPjxxService extends AbstractService{
	
	@Resource(name="sqlDbClient")
	private SqlDbClient dbClient;
	
	/**
	 * 查询判决信息
	 * xm 矫正人员姓名
	 * sfzh 身份证号
	 * sqjzjdjg 社区矫正决定机关
	 * sqjzjdjgmc 社区矫正决定机关名称
	 * yjzfjg 移交罪犯机关
	 * yjzfjgmc 移交罪犯机关名称
	 * pjsbh 判决书编号
	 * pjrq 判决日期
	 * zxtzsrq 执行通知书日期
	 * zxtzswh 执行通知书文号
	 * wslx 文书类型
	 * wsbh 文书编号
	 * wssxrq 文书生效日期
	 * zyfzss 主要犯罪事实
	 * ypxf 原判刑罚
	 * ypxq 原判刑期
	 * ypxqksrq 原判刑期开始日期
	 * ypxqjsrq 原判刑期结束日期
	 * fjx 附加刑
	 * sfbxgjzl 是否被宣告禁止令
	 * sqjzqx 社区矫正期限
	 * yqtxqx 有期徒刑期限
	 */
	public ResultList<BasicMap<String, Object>> findAll(BasicMap<String, Object> query,Paginate page){
		SqlDbFilter filter = toSqlFilter(query);
		String sql = "select a.id,b.xm,b.sfzh,a.sqjzjdjg,a.sqjzjdjgmc,a.yjzfjg,a.yjzfjgmc,a.pjsbh,a.pjrq,a.zxtzsrq,"
				+ "a.zxtzswh,a.wslx,a.wsbh,a.wssxrq,a.zyfzss,a.ypxf,a.ypxq,a.ypxqksrq,a.ypxqjsrq,a.fjx,"
				+ "a.sfbxgjzl,a.sqjzqx,a.yqtxqx from jz_pjxx a left join JZ_JZRYJBXX b on a.id=b.id";
		SQLAdapter adapter = new SQLAdapter(sql);
		adapter.setFilter(filter);
		ResultList<BasicMap<String, Object>> list = dbClient.find(adapter, page,new RowDataListener() {

			@Override
			public void processData(BasicMap<String, Object> rowData) {
				rowData.put("pjrq", DateUtil.format(rowData.get("pjrq"),"yyyy-MM-dd"));
				rowData.put("zxtzsrq",DateUtil.format(rowData.get("zxtzsrq"),"yyyy-MM-dd"));
				rowData.put("wssxrq", DateUtil.format(rowData.get("wssxrq"), "yyyy-MM-dd"));
				rowData.put("ypxqksrq", DateUtil.format(rowData.get("ypxqksrq"), "yyyy-MM-dd"));
				rowData.put("ypxqjsrq", DateUtil.format(rowData.get("ypxqjsrq"), "yyyy-MM-dd"));
			}
			
		});
		return list;
	}
	
	/**
	 * 根据矫正人员id获取判决信息
	 * @param id
	 * @return 判决信息数据，参考 JZ_PJXX
	 * JZ_JZRYJBXX.ID = JZ_PJXX.ID
	 */
	public BasicMap<String,Object> findOne(String id){
		String sql="select * from jz_pjxx where id='"+id+"'";
		SQLAdapter adapter=new SQLAdapter(sql);
		BasicMap<String,Object> data=dbClient.findOne(adapter);
		return data;
		
	}
	/**
	 * 新增与修改判决信息
	 */
	public void save(BasicMap<String,Object> map){
		dbClient.save(SupConst.Collections.JZ_PJXX, map);
	}
	
	/**
	 * 删除判决信息
	 */
	public void remove(List<BasicMap<String, Object>> list){
		for (int i = 0; i < list.size(); i++) {
			dbClient.remove(SupConst.Collections.JZ_PJXX, list.get(i));
		}
	}
}
