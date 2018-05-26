package com.ehtsoft.supervise.services;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.collections.map.HashedMap;
import org.springframework.stereotype.Service;

import com.ehtsoft.common.services.SSOService;
import com.ehtsoft.fw.core.db.RowDataListener;
import com.ehtsoft.fw.core.db.SQLAdapter;
import com.ehtsoft.fw.core.db.SqlDbClient;
import com.ehtsoft.fw.core.db.SqlDbFilter;
import com.ehtsoft.fw.core.dto.BasicMap;
import com.ehtsoft.fw.core.dto.Paginate;
import com.ehtsoft.fw.core.dto.ResultList;
import com.ehtsoft.fw.core.services.AbstractService;
import com.ehtsoft.fw.core.sso.User;
import com.ehtsoft.fw.utils.DateUtil;
import com.ehtsoft.fw.utils.StringUtil;
import com.ehtsoft.supervise.api.SupConst;
/**
 * 教育培训
 * @author wangbao
 */
@Service("JypxService")
public class JypxService extends AbstractService{

	@Resource(name="sqlDbClient")
	private SqlDbClient dbClient;
	
	@Resource(name="SSOService")
	private SSOService service;
	
	/**
	 * 查询全部集中教育情况
	 * @param query
	 * @param paginate
	 * @return
	 * [
	 * 	{
	 * 		pxqkid:主键
	 * 		pxztmc:培训主题名称
	 * 		ycjrs:应参加人数
	 * 		sjcjrs:实际参加人数
	 * 		pxlsmc:培训老师名称
	 * 		pxksj:培训开始时间
	 * 		pxjssj:培训结束时间
	 * 		pxdz:培训地址
	 * 		pxnrms:培训内容描述
	 * 		ksqkfx:考试情况分析
	 * 		pxjgpj:培训结果评价
	 * 		del:删除标记
	 * 		cts:创建时间
	 * 		cuid:当前创建人员
	 * 	}
	 * ]
	 */
	public ResultList<BasicMap<String, Object>> findFocusEducation(BasicMap<String, Object> query,Paginate paginate){
		User user = service.getUser();
		String orgid = user.getOrgid();
		String sqlstr = "select pxqkid,pxztmc,ycjrs,sjcjrs,pxlsmc,pxksj,pxjssj,pxdz,pxnrms,ksqkfx,pxjgpj,del,cts,cuid from jz_pxqkdjb "
				+ " where del=0 and orgid = '"+orgid+"'"
				+ " and pxztmc like '%"+StringUtil.toEmptyString(query.get("pxztmc"))+"%'";
		SQLAdapter sqlAdapter = new SQLAdapter(sqlstr);
		final List<String> ids = new ArrayList<>();
		ResultList<BasicMap<String, Object>> list = dbClient.find(sqlAdapter, paginate, new RowDataListener() {
			public void processData(BasicMap<String, Object> rowdata) {
				rowdata.put("cts", DateUtil.format(rowdata.get("cts"), "yyyy-MM-dd hh:mm:ss"));
				ids.add(StringUtil.toString(rowdata.get("pxqkid")));
			}
		});
		SQLAdapter sql = new SQLAdapter("SELECT IMGID,PXQKID FROM JZ_PXQKDJB_IMG");
		sql.getFilter().in("PXQKID", ids);
		
		BasicMap<String,List<String>> map = new BasicMap<>();
		dbClient.find(sql,new RowDataListener() {
			public void processData(BasicMap<String, Object> rowData) {
			   String pkqxid = StringUtil.toString(rowData.get("PXQKID"));
			   if(map.get(pkqxid)==null){
				   List<String> l = new ArrayList<String>();
				   l.add(StringUtil.toString(rowData.get("IMGID")));
				   map.put(pkqxid, l);
			   }else{
				   map.get(pkqxid).add(StringUtil.toString(rowData.get("IMGID")));
			   }
			}
		});
		list.getRows().forEach((o)->{
			String pkqxid = StringUtil.toString(o.get("PXQKID"));
			o.put("images", map.get(pkqxid));
		});
		return list;
	}
	
	/**
	 * 查询一条集中教育情况
	 * @param pxqkid
	 * @return
	 * {
	 *  	pxqkid:主键
	 * 		pxztmc:培训主题名称
	 * 		ycjrs:应参加人数
	 * 		sjcjrs:实际参加人数
	 * 		pxlsmc:培训老师名称
	 * 		pxksj:培训开始时间
	 * 		pxjssj:培训结束时间
	 * 		pxdz:培训地址
	 * 		pxnrms:培训内容描述
	 * 		ksqkfx:考试情况分析
	 * 		pxjgpj:培训结果评价
	 * 		del:删除标记
	 * 		cts:创建时间
	 * 		cuid:当前创建人员
	 * }
	 */
	public BasicMap<String, Object> findOneFocusEducation(String pxqkid){
		BasicMap<String, Object> data = new BasicMap<>();
		List<String> list = new ArrayList<>();
		data = dbClient.findOne("select pxqkid,pxztmc,ycjrs,sjcjrs,pxlsmc,pxksj,pxjssj,pxdz,pxnrms,ksqkfx,pxjgpj,del,cts,cuid from jz_pxqkdjb where pxqkid = ?", pxqkid);
		SQLAdapter sql = new SQLAdapter("SELECT IMGID,PXQKID FROM JZ_PXQKDJB_IMG");
		sql.getFilter().eq("PXQKID", pxqkid);
		dbClient.find(sql, new RowDataListener() {
			@Override
			public void processData(BasicMap<String, Object> rowData) {
				list.add(StringUtil.toString(rowData.get("IMGID")));
			}
		});
		if(data!=null){
			data.put("images", list);
		}
		return data;
	}
	/**
	 * 新增或更新集中教育情况
	 * @param data
	 */
	public void saveOrUpdateFocusEducation(BasicMap<String, Object> data){
		dbClient.save(SupConst.Collections.JZ_PXQKDJB, data);
	}
	/**
	 * 删除集中教育情况
	 * @param data
	 */
	public void removeFocusEducation(String id) {
		dbClient.updateSql("update jz_pxqkdjb set del=1 where pxqkid=?", id);
	}
	/**
	 * 查询个别教育情况
	 * @param query
	 * @param paginate
	 * @return
	 * [
	 * 	{
	 * 		pxqkid:主键
	 * 		pxztmc:培训主题名称
	 * 		pxsj:培训时间
	 * 		pxdd:培训地点
	 * 		pxnr:培训内容
	 * 		pxjgpj:培训结果平价 
	 * 		f_aid:矫正人员ID
	 * 		cts:创建时间
	 * 		xm:矫正人员姓名
	 * 		xb:矫正人员性别
	 * 	} 
	 * ] 
	 * {pxztmc[like]=}
	 */
	public ResultList<BasicMap<String, Object>> findPersonalEducation(BasicMap<String, Object> query,Paginate paginate){
		ResultList<BasicMap<String, Object>> list = new ResultList<>();
		User user = service.getUser();
		if(user!=null) {
			String strsql = "select a.pxqkid,a.pxztmc,a.pxsj,a.pxdd,a.pxnr,a.pxjgpj,a.f_aid,a.cts,b.xm,b.xb from jz_gbjyqk a "
					+ "left join jz_jzryjbxx b on a.f_aid=b.id ";
			SQLAdapter sqlAdapter = new SQLAdapter(strsql);
	        SqlDbFilter sqlDbFilter =  toSqlFilter(query);
	        sqlDbFilter.desc("a.cts");
	        sqlAdapter.setFilter(sqlDbFilter);
	        list = dbClient.find(sqlAdapter, paginate, new RowDataListener() {
				@Override
				public void processData(BasicMap<String, Object> rowData) {
					rowData.put("cts", DateUtil.format(rowData.get("cts"), "yyyy-MM-dd hh:mm:ss"));
				}
			});
		}
        return list;
	}
	
	
	/**
	 * 查询一条个人教育情况
	 * @param pxqkid
	 * @return
	 */
	public BasicMap<String, Object> findOnePersonalEducation(String pxqkid){
		BasicMap<String, Object> data = new BasicMap<>();
		data = dbClient.findOne("select pxqkid,pxztmc,pxsj,pxdd,pxnr,pxjgpj,f_aid,cts from jz_gbjyqk where pxqkid = ?", pxqkid);
		return data;
	}
	
	/**
	 * 新增或修改个人教育情况
	 * @param data
	 * {
	 * 	jypxqz:byte[]
	 * }
	 * @return
	 * String pxqkid
	 */
	public String insertOrUpdate(BasicMap<String, Object> data){
		dbClient.save(SupConst.Collections.JZ_GBJYQK, data);
		BasicMap<String, Object> img = new BasicMap<>();
		img.put("IMGID", data.get("PXQKID"));
		img.put("data", data.get("jypxqz"));
		dbClient.save(SupConst.Collections.JZ_GBJYQK_IMG, img);
		return StringUtil.toEmptyString(data.get("pxqkid"));
	}
	
	/**
	 * 新增或修改个人教育情况
	 * PC端 李恒
	 */
	public String saveOne(BasicMap<String, Object> data){
		//在矫正人员基本信息表里，验证 个别教育人员是不是，已经存的矫正人员，存在继续存储，不存在在页面，提示，“该人员不是该机构的矫正人员，请确认后在进行个别教育添加”
		User user = service.getUser();
		String orgid = user.getOrgid();
		
		String sql = "select xm from jz_jzryjbxx";
		SQLAdapter adapter  = new SQLAdapter(sql);
		SqlDbFilter filter = new SqlDbFilter();
		filter.eq("orgid", orgid);
		filter.eq("xm", data.get("xm"));
		adapter.setFilter(filter);
		List<BasicMap<String, Object>> list = dbClient.find(adapter);
		
		if(list.size() > 0 ) {
			dbClient.save(SupConst.Collections.JZ_GBJYQK, data);
			BasicMap<String, Object> img = new BasicMap<>();
			img.put("IMGID", data.get("PXQKID"));
			img.put("data", data.get("jypxqz"));
			dbClient.save(SupConst.Collections.JZ_GBJYQK_IMG, img);
			return StringUtil.toEmptyString(data.get("pxqkid"));
		}else{
			BasicMap<String, Object> map=new BasicMap<>();
			map.put("error", "01");
			return StringUtil.toString(map.get("error"));
		}
	}
	
	
	/**
	 * 删除一条数据
	 * @param pxqkid
	 */
	public void deleteOnePersonalEducation(String pxqkid){
		dbClient.remove(SupConst.Collections.JZ_GBJYQK, new SqlDbFilter().eq("pxqkid", pxqkid));
	}
	
	public void delete(String id) {
		dbClient.remove(SupConst.Collections.JZ_PXQKDJB, new SqlDbFilter().eq("PXQKID", id));
	}
	
}
