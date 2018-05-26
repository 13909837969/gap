package com.ehtsoft.supervise.services;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ehtsoft.common.services.SFCodeService;
import com.ehtsoft.common.services.SSOService;
import com.ehtsoft.fw.core.db.RowDataListener;
import com.ehtsoft.fw.core.db.SQLAdapter;
import com.ehtsoft.fw.core.db.SqlDbClient;
import com.ehtsoft.fw.core.db.SqlDbFilter;
import com.ehtsoft.fw.core.dto.BasicMap;
import com.ehtsoft.fw.core.dto.Paginate;
import com.ehtsoft.fw.core.services.AbstractService;
import com.ehtsoft.fw.core.sso.User;
import com.ehtsoft.fw.utils.StringUtil;
import com.ehtsoft.fw.utils.api.IDictionary;
import com.ehtsoft.supervise.api.SupConst;
/**
 * 
 * 人民调解的调查取证
 * @author Administrator
 * @date 2018年4月3日
 *
 */
@Service("RmtjDcqzService")
public class RmtjDcqzService extends AbstractService{
	@Resource(name="sqlDbClient")
	SqlDbClient dbClient;
	
	@Resource(name="SSOService")
	private SSOService ssoService;
	
	@Resource(name="SFCodeService")
	private SFCodeService sfCodeService;
	
	@Resource(name="DictionaryService")
	private IDictionary dictionaryService;
	
	
	/**
	 * 
	 * 查询调查记录的图片
	 * 返回值格式:<br>
	 *
	 * @author Administrator
	 * @date   2018年4月28日
	 * 方法的作用：TODO
	 */
	public List<BasicMap<String,Object>> findDcImg(String tablename,String imgid,String listid){
		List<BasicMap<String,Object>> list=new ArrayList<>();
		String sql="select IMGID,qzlx,LISTID from " + tablename+ " where DCJLID='"+imgid+"' and LISTID = '"+ listid +"'";
		SQLAdapter adapter=new SQLAdapter(sql);
		list=dbClient.find(adapter);
		return list;
	}

	
	
	
	/**
	 * 
	 * 新增取证数据 、 取证数据保存到 RMTJ_QZXX   
	 *    关键字段：RMTJ_QZXX.DCJZID = 卷宗目录列表传过来的卷宗ID (RMTJ_DCJZ.ID)
	 * @param data<br>
	 * 返回值格式:<br>
	 *
	 * @author Administrator
	 * @date   2018年4月3日
	 * 方法的作用：TODO
	 */
	public String save(BasicMap<String, Object> data) {
		dbClient.save(SupConst.Collections.RMTJ_QZXX, data);
		
		//保存DCJZID,YWSZID
		dbClient.save(SupConst.Collections.RMTJ_DCJZ_YWSZ, data);
		
		return StringUtil.toString(data.get("id"));
	}
	

	/**
	 * 查询图片
	 * @param tablename
	 * @param qzxxid
	 * @return
	 */
	/*public List<BasicMap<String, Object>> findTp(String  qzxxid) {
		String  sql = "SELECT  b.imgid FROM RMTJ_DCJL a LEFT JOIN  RMTJ_QZXX_IMG  b ON a.id = b.QZXXID WHERE b.qzxxid = '"+ qzxxid +"'";
		SQLAdapter adapter = new SQLAdapter(sql);
		List<BasicMap<String, Object>> list = dbClient.find(adapter);
		BasicMap<String, Object> map = new BasicMap<>();
		List<String> list1 = new ArrayList<>();
		if (list.size() > 0) {
			for (int i = 0; i < list.size() ; i++) {
				String str = list.get(i).get("imgid").toString();
				list1.add(str);
			}
			
		}
		return list1;
	}*/
	
	
	/**
	 * 
	 * 获取记录的图片 取证图片保存到 RMTJ_QZXX_IMG    关键字段： RMTJ_QZXX_IMG.QZXXID = RMTJ_QZXX.ID
	 * @param tablename
	 * @param qzxxid
	 * @return<br>
	 * 返回值格式:<br>
	 *
	 * @author Administrator
	 * @date   2018年4月3日
	 * 方法的作用：TODO
	 */
	public  List<BasicMap<String, Object>> findImges(String tablename, String qzxxid) {
		String sql = "select IMGID from '"+ tablename +"' where  QZXXID = '" + qzxxid + "' ";
		SQLAdapter adapter = new SQLAdapter(sql);
		return dbClient.find(adapter);
		
	}
	
	/**
	 * 
	 * 最后的保存   字段数据  YWSZID = SYS_RMTJ_YWSZ.ID， DCJZID = RMTJ_DCJZ.ID  （两个数据都是从卷宗目录传过去的）
	 * @param data<br>
	 * 返回值格式:<br>
	 *
	 * @author Administrator
	 * @date   2018年4月3日
	 * 方法的作用：TODO
	 */
	public void saveDjlv(BasicMap<String, Object> data) {
		dbClient.save(SupConst.Collections.RMTJ_DCJZ_YWSZ, data);
	}
	
	
	/**
	 * 
	 * 4.UI图下面列表数据取自  RMTJ_QZXX   表   图取之 RMTJ_QZXX_IMG   关联外键 RMTJ_DCJZ.ID
	 * @return<br>
	 * 返回值格式: List<BasicMap<String, Object>>
	 *
	 * @author Administrator
	 * @date   2018年4月3日
	 * 方法的作用：TODO
	 */
	public  List<BasicMap<String, Object>> findAll(BasicMap<String, Object> query,Paginate paginate) {
		String  sql = "select a.id,a.dcjzid,a.jfzyxx,a.qzxxms from RMTJ_QZXX a where  a.DCJZID = '"+ query.get("id") +"'";
		SQLAdapter adapter = new SQLAdapter(sql);
		List<BasicMap<String, Object>> list = dbClient.find(adapter,paginate,new RowDataListener() {
			
			@Override
			public void processData(BasicMap<String, Object> rowData) {
				String  sqlstr = "SELECT  b.imgid FROM RMTJ_DCJL a LEFT JOIN  RMTJ_QZXX_IMG  b ON a.id = b.QZXXID WHERE b.qzxxid = '"+ query.get("qzxxid") +"'";
				SQLAdapter adaptert = new SQLAdapter(sqlstr);
				List<BasicMap<String, Object>> lists = dbClient.find(adaptert);
				List<String> list1 = new ArrayList<>();
				if (lists.size() > 0) {
					for (int i = 0; i < lists.size() ; i++) {
						String str = lists.get(i).get("imgid").toString();
						list1.add(str);
					}
					rowData.put("imgid", list1);
				}
				
			}
		}).getRows();
		
		return list;
	}

	
	
	/**
	 * 
	 * 调查记录【无条件查询】
	 * @return<br>
	 * 返回值格式: List<BasicMap<String, Object>>
	 * 	id:id
	 * 	dcjl: 调查记录
	 *
	 * @author Administrator
	 * @date   2018年4月4日
	 * 方法的作用：TODO
	 */
	public List<BasicMap<String, Object>> findDcjl(BasicMap<String, Object> query, Paginate paginate) {
		User user = ssoService.getUser();
		String sql = " SELECT a.ID,a.dcjzid,a.dcsj,a.dcr,a.dcdd,a.dcjl,a.ndjb,a.ajyc,a.orgid,a.listid,b.xm as  cjr " + 
				"FROM RMTJ_DCJL a " + 
				"LEFT JOIN RMTJ_TJAJSQR b ON  b.TJAJXXID = a.ID where a.orgid = '" + user.getOrgid() + "' ";
		SQLAdapter adapter = new SQLAdapter(sql);
		return dbClient.find(adapter,paginate).getRows();
	}
	
	
	/**
	 * 
	 * 调查记录【条件查询】
	 * @return<br>
	 * 返回值格式: List<BasicMap<String, Object>>
	 * 	id:id
	 * 	dcjl: 调查记录
	 *
	 * @author Administrator
	 * @date   2018年4月4日
	 * 方法的作用：TODO
	 */
	public List<BasicMap<String, Object>> findDcjl_TJ(BasicMap<String, Object> query,Paginate paginate) {
		User user = ssoService.getUser();
		StringBuffer sqlstr = new StringBuffer("SELECT A . ID, A .dcjzid, A .dcsj, A .dcr, A .dcdd, A .dcjl, A .ndjb, A .ajyc, A .orgid ,A.listid" + 
				" FROM RMTJ_DCJL A  LEFT JOIN  RMTJ_TJAJSQR b " + 
				" ON  a.ID = b.TJAJXXID ");
		sqlstr.append(" where a.orgid = '"+ user.getOrgid() +"'");
		if (!"".equals(StringUtil.toEmptyString(query.get("dcr")))) {
			sqlstr.append(" and a.dcr like '"+ StringUtil.toEmptyString(query.get("dcr")) +"%'");
		}
		if (!"".equals(StringUtil.toEmptyString(query.get("cjr")))) {
			sqlstr.append(" and b.xm like '"+ StringUtil.toEmptyString(query.get("cjr")) +"%' and b.lx = '4' ");
		}
		if (!"".equals(StringUtil.toEmptyString(query.get("dckssj"))) || !"".equals(StringUtil.toEmptyString(query.get("dcjssj")))) {
			sqlstr.append(" and a.dcsj between '"+ StringUtil.toEmptyString(query.get("dckssj"))+"' and '"+ StringUtil.toEmptyString(query.get("dckssj"))+"'");
		}
		SQLAdapter adapter = new SQLAdapter(sqlstr.toString());
		List<BasicMap<String, Object>> list = dbClient.find(adapter,paginate).getRows();
		return list;
	}
	
	
	/**
	 * 
	 * 调查记录【条件查询】
	 * @return<br>
	 * 返回值格式: List<BasicMap<String, Object>>
	 * 	id:id
	 * 	dcjl: 调查记录
	 *
	 * @author Administrator
	 * @date   2018年4月4日
	 * 方法的作用：TODO
	 */
	public List<BasicMap<String, Object>> findDcjlTJ(BasicMap<String, Object> query ) {
		User user = ssoService.getUser();
		StringBuffer sqlstr = new StringBuffer("SELECT A . ID, A.dcjzid, A .dcsj, A .dcr, A .dcdd, A .dcjl, A .ndjb, A .ajyc, A .orgid,A.listid" + 
				" FROM RMTJ_DCJL A " );
		sqlstr.append(" where a.orgid = '"+ user.getOrgid() +"' and a.dcjzid = '"+query.get("dcjzid") +"' ");
		if (!"".equals(StringUtil.toEmptyString(query.get("dcr")))) {
			sqlstr.append(" and a.dcr like '"+ StringUtil.toEmptyString(query.get("dcr")) +"%'");
		}
		SQLAdapter adapter = new SQLAdapter(sqlstr.toString());
		List<BasicMap<String, Object>> list = dbClient.find(adapter,new RowDataListener() {
			
			@Override
			public void processData(BasicMap<String, Object> rowData) {
				//检索参与人 与 被调查人
				String sqls = "SELECT xm,lx from RMTJ_TJAJSQR where TJAJXXID = '"+rowData.get("id") +"' and xm like '"+ StringUtil.toEmptyString(query.get("cjr")) +"%'";
				 List<BasicMap<String, Object>> li = dbClient.find(new SQLAdapter(sqls));
				 for (int i = 0; i < li.size(); i++) {
					 if ("4".equals(li.get(i).get("lx").toString())) {
							rowData.put("cjr", li.get(i).get("xm"));
					}
					 if ("3".equals(li.get(i).get("lx").toString())) {
							rowData.put("bdcr", li.get(i).get("xm"));
					}
				}
			}
		});
		
		return list;
	}
	/**
	 * 根据调查记录id查询调查记录信息信息
	 * @param id
	 * @return
	 */
	public BasicMap<String, Object> findOne(String id){
		User user = ssoService.getUser();
		BasicMap<String, Object> map = new BasicMap<>();
		if(user != null) {
			String sql ="select * from RMTJ_DCJL";
			SQLAdapter adapter = new SQLAdapter(sql);
			SqlDbFilter filter = new SqlDbFilter();
			filter.in("orgid", user.getOrgidSet());
			filter.eq("id", id);
			adapter.setFilter(filter);
			map = dbClient.findOne(adapter);
		}
		return map;
	}
	/**
	 * 根据调查记录id查询参加人和调查人信息   3被调查人  4参加人
	 * @param tjajxxid
	 * @return
	 */
	public List<BasicMap<String,Object>> findList(String dcjlid){
		User user = ssoService.getUser();
		List<BasicMap<String,Object>> list = new ArrayList<>();
		if(user != null) {
			String sql ="select * from RMTJ_TJAJSQR";
			SQLAdapter adapter = new SQLAdapter(sql);
			SqlDbFilter filter = new SqlDbFilter();
			filter.in("orgid", user.getOrgidSet());
			filter.eq("tjajxxid", dcjlid);
			adapter.setFilter(filter);
			list = dbClient.find(adapter);
		}
		return list;
	}
}
