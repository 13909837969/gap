package com.ehtsoft.supervise.services;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ehtsoft.fw.core.db.RowDataListener;
import com.ehtsoft.fw.core.db.SQLAdapter;
import com.ehtsoft.fw.core.db.SqlDbClient;
import com.ehtsoft.fw.core.db.SqlDbFilter;
import com.ehtsoft.fw.core.dto.BasicMap;
import com.ehtsoft.fw.core.services.AbstractService;
import com.ehtsoft.fw.utils.NumberUtil;
import com.ehtsoft.fw.utils.StringUtil;
import com.ehtsoft.fw.utils.Util;
import com.ehtsoft.supervise.api.SupConst;

/**
 * 行政区划字典信息表及服务
 * 记录 省，市，区（县） 的信息及编码
 * @author wangbao
 *
 */
@Service("RegionService")
public class RegionService extends AbstractService{
	
	@Resource(name = "sqlDbClient")
	private SqlDbClient dbClient;
	
	private BasicMap<String,String> cacheMap = new BasicMap<>();
	
	public List<BasicMap<String,Object>> find(BasicMap<String,Object> query){
		List<BasicMap<String,Object>> list = dbClient.find(SupConst.Collections.SYS_REGION,toSqlFilter(query));
		return Util.list2Tree(list, "PARENTID", "REGIONID");
	}
	
	public List<BasicMap<String, Object>> find(Integer lvl,String parentid){
		List<BasicMap<String, Object>> list = new ArrayList<>();
		String sqlstr = "select REGIONID,REGION_NAME,LVL from SYS_REGION";
		SQLAdapter sqlAdapter = new SQLAdapter(sqlstr);
		sqlAdapter.getFilter().eq("LVL", lvl).eq("PARENTID", parentid);
		list = dbClient.find(sqlAdapter);
		return list;
	}
	
	
	public String getRegionName(final String regionId) {
		String rtn = "";
		if(cacheMap.get(regionId)==null) {
			String sqlstr = "select REGIONID,REGION_NAME from SYS_REGION WHERE REGIONID = ?";
			BasicMap<String,Object> one = dbClient.findOne(sqlstr, regionId);
			if(one!=null) {
				cacheMap.put(regionId, StringUtil.toString(one.get("REGION_NAME")));
			}
		}
		rtn = cacheMap.get(regionId);
		if(rtn==null){
			rtn = "";
		}
		return rtn;
	}
	
	
	/**
	 * 根据条件查询区域矫正人员数量
	 */
	public List<BasicMap<String,Object>> findCount(String orgid){
		SqlDbFilter filter = new SqlDbFilter();
		String sql = "select id,xm,xb,sfzh,grlxdh,orgname from view_rep_qyjzrysmx";
		SQLAdapter adapter = new SQLAdapter(sql);
		filter.eq("orgid", orgid);
		filter.eq("jcjz", "0");
		adapter.setFilter(filter);
		List<BasicMap<String,Object>> list = new ArrayList<>();
		try {
			list = dbClient.find(adapter,new RowDataListener() {
				
				@Override
				public void processData(BasicMap<String, Object> rowData) {
					if(NumberUtil.toInt(rowData.get("xb"))==1){
						rowData.put("xb", "男");
					}else if(NumberUtil.toInt(rowData.get("xb"))==2){
						rowData.put("xb", "女");
					}
				}
			});
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}
	/**
	 * 根据条件查询服务所
	 */
	public List<BasicMap<String,Object>> findOrgfwjg(String district_code){
		String string = "select  orgname,orgid,jglx,count(id) as cnt from view_rep_qyjzrysmx " +
				" where jcjz = '0'  and district_code = '"+district_code+"'" +
				" group by  orgname,orgid,jglx ";
		final Map<String,Object> map = new BasicMap<String,Object>();
		dbClient.find(new SQLAdapter(string),new RowDataListener() {
			@Override
			public void processData(BasicMap<String, Object> rowData) {
				String orgid = StringUtil.toEmptyString(rowData.get("orgid"));
				String jglx = StringUtil.toEmptyString(rowData.get("jglx"));
				int cnt = NumberUtil.toInt(rowData.get("cnt"));
				map.put(orgid + jglx, cnt);
			}
		});
		
		String sql = "select orgname,orgid,count(id) as jzrysl from view_rep_qyjzrysmx WHERE district_code = '"+ district_code + "' and jcjz = '0' group by orgname,orgid";
		SQLAdapter adapter = new SQLAdapter(sql);
		List<BasicMap<String,Object>> list = dbClient.find(adapter,new RowDataListener() {
			@Override
			public void processData(BasicMap<String, Object> rowData) {
				String orgid = StringUtil.toEmptyString(rowData.get("orgid"));
				rowData.put("pgs",NumberUtil.toInt(map.get(orgid+"1")));//普管
				rowData.put("kgs",NumberUtil.toInt(map.get(orgid+"2")));//宽管
				rowData.put("ygs",NumberUtil.toInt(map.get(orgid+"3")));//严管
			}
		});
		return list;
	}
}
