package com.ehtsoft.supervise.services;

import java.util.ArrayList;
import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;

import com.ehtsoft.common.services.SFCodeService;
import com.ehtsoft.common.services.SSOService;
import com.ehtsoft.fw.core.db.InsertOperation;
import com.ehtsoft.fw.core.db.RowDataListener;
import com.ehtsoft.fw.core.db.SQLAdapter;
import com.ehtsoft.fw.core.db.SqlDbClient;
import com.ehtsoft.fw.core.db.SqlDbFilter;
import com.ehtsoft.fw.core.dto.BasicMap;
import com.ehtsoft.fw.core.dto.Paginate;
import com.ehtsoft.fw.core.services.AbstractService;
import com.ehtsoft.fw.core.sso.User;
import com.ehtsoft.fw.utils.NumberUtil;
import com.ehtsoft.fw.utils.StringUtil;
import com.ehtsoft.fw.utils.Util;
import com.ehtsoft.supervise.api.SupConst;

/**
 * 安置帮教-人员衔接
 * @author maruimin
 */
@Service("AzbjRyxjService")
public class AzbjRyxjService extends AbstractService{
	@Resource(name="sqlDbClient")
	private SqlDbClient dbClient;
	@Resource(name="SSOService")
	private SSOService service;
	@Resource(name="SFCodeService")
	private SFCodeService sfService;
	
	
	/**
	 * 人员衔接列表信息
	 * @param data
	 * {
	 *   sfxj:  0 表示未衔接   1 表示衔接
	 * }
	 * @param paginate
	 * @return
	 */
	public List<BasicMap<String, Object>> findAll(BasicMap<String,Object> data,Paginate paginate){
		User user = service.getUser();
		List<BasicMap<String, Object>> list=new ArrayList<>();
		SqlDbFilter filter = toSqlFilter(data);
		String sql = "SELECT a.id,a.xm,a.sqjzrybh,a.sfzh,a.orgid,a.jcjz,b.gdjzdmx,b.hjszd,c.id as xjid,d.id as bjbsid FROM JZ_JZRYJBXX a "
				+ " left join JZ_JZRYJBXX_DZ b on a.id=b.id  "
				+ " left join ANZBJ_RYXJXXCJB C on C.ID = a.ID "
				+ " left join ANZBJ_BJBSXXJLB d on a.id=d.id";
		int sfxj = NumberUtil.toInt(data.get("sfxj"));
		filter.unEq("a.jcjz", "0");
		if(sfxj==0) {
			filter.isNull("C.ID");
		}else {
			filter.unEq("c.JCBJ", "1");
			filter.isNotNull("C.ID");
		}
		filter.eq("a.orgid", user.getOrgid());
		
		SQLAdapter sqlAdapter = new SQLAdapter(sql);
		sqlAdapter.setFilter(filter);	
		list = dbClient.find(sqlAdapter, paginate,new RowDataListener() {
			public void processData(BasicMap<String, Object> rowData) {
				if(Util.isEmpty(rowData.get("xjid"))) {
					rowData.put("sfxj", 0);
				}else{
					rowData.put("sfxj", 1);
				}
			}
		}).getRows();
		return list;
	}
	
	/**
	 * 查询所有已衔接人员
	 * @param query
	 * @param paginate
	 * @return
	 */
	public List<BasicMap<String,Object>> findList(BasicMap<String,Object> query,Paginate paginate){
		List<BasicMap<String,Object>> list=new ArrayList<BasicMap<String,Object>>();
	    User user=service.getUser();
	    String sql = "SELECT a.id,a.xm,a.sqjzrybh,a.sfzh,a.csrq,a.jcjz,a.orgid,b.gdjzdmx,b.hjszd,c.id as xjid FROM JZ_JZRYJBXX a "
				+ " left join JZ_JZRYJBXX_DZ b on a.id=b.id  "
				+ " left join ANZBJ_RYXJXXCJB C on C.ID = a.ID ";
		SqlDbFilter filter=new SqlDbFilter();
		filter.like("a.xm",StringUtil.toEmptyString(query.get("xm")))
		      .like("a.sfzh", StringUtil.toEmptyString(query.get("sfzh")));
		filter.isNotNull("c.id");
		filter.eq("a.orgid", user.getOrgid());
		filter.unEq("a.jcjz", "0");
		filter.unEq("c.JCBJ", "1");
		SQLAdapter adapter=new SQLAdapter(sql);
		adapter.setFilter(filter);
		list=dbClient.find(adapter, paginate).getRows();
		return list;
	}
	
	/**
	 * 获取已衔接人员详细信息
	 * @param id
	 * @return
	 */
	public BasicMap<String,Object> findOneYxj(String id){
		User user=service.getUser();
		String sql = "SELECT a.id,a.xm,a.sqjzrybh,a.sfzh,a.csrq,a.orgid,a.jcjz,a.orgid,b.gdjzdmx,b.hjszd,c.id as xjid FROM JZ_JZRYJBXX a "
				+ " left join JZ_JZRYJBXX_DZ b on a.id=b.id  "
				+ " left join ANZBJ_RYXJXXCJB C on C.ID = a.ID ";
		SqlDbFilter filter=new SqlDbFilter();
		filter.isNotNull("c.id");
		filter.eq("a.orgid", user.getOrgid());
		filter.unEq("a.jcjz", "0");
		filter.eq("a.id", id);
		SQLAdapter adapter=new SQLAdapter(sql);
		adapter.setFilter(filter);
		BasicMap<String,Object> data =dbClient.findOne(adapter);
		return data;
	}
	
	/**
	 * 获取衔接人员基本信息
	 * @param id
	 * @return
	 */
	public BasicMap<String,Object> findOne(String id){
		BasicMap<String,Object> data=new BasicMap<>();
		String sql="SELECT A.ID,A.xm,c.f_name as xb,A .sfzh, A .sqjzrybh,b.gdjzdmx,b.HJSZD,d.SBQSF,d.BJLX,d.CH,d.XJSJ,d.XJTJ,d.YBBJDXXJFS,d.ZDBJDXXJFS,d.GAJGSFLSGKCS " + 
				"FROM JZ_JZRYJBXX A " + 
				"LEFT JOIN JZ_JZRYJBXX_DZ b ON A . ID = b. ID " + 
				"LEFT JOIN ANZBJ_RYXJXXCJB d ON d . ID = a. ID " + 
				"LEFT JOIN sys_dictionary c ON a.xb = c.f_code " + 
				"WHERE c.f_typecode = 'SYS000' " + 
				"AND a.id ='"+id+"'";
		SQLAdapter sqlAdapter = new SQLAdapter(sql);
		data=dbClient.findOne(sqlAdapter);
		return data;			
	}
	
	/**
	 * 必接必送人员信息
	 * @param data{
	 *      xm:姓名
	 *      xb:性别
	 *      sfzh：身份证号
	 *      grlxdh：联系电话
	 *      SCQSXM:随从亲属姓名
	 *      GZRYXM：工作人员姓名
	 *      ZRS:总人数
	 *      JSQKSM：情况说明
	 * }
	 * @return data
	 */
	public BasicMap<String,Object> findBjbsjsxx(String id){
		BasicMap<String,Object> data=new BasicMap<>();
		String sql="select b.id,a.SCQSXM,a.GZRYXM,a.ZRS,a.JSQKSM,b.xm,b.xb,b.sfzh,b.grlxdh from ANZBJ_BJBSXXJLB a right join JZ_JZRYJBXX b on a.id=b.id";
		SQLAdapter adapter=new SQLAdapter(sql);
		adapter.getFilter().eq("b.id", id);
		data=dbClient.findOne(adapter);
		return data;
	}
	
	/**
	 * 人员衔接退回上级
	 * @param data{
	 *     id:"矫正人员ID"
	 *     }
	 */
	public void update(BasicMap<String,Object> data) {
		User user=service.getUser();
		String orgid=user.getOrgid();
		String sql="select parentid from jc_sfxzjgjbxx where id = ?";
		BasicMap<String,Object> one=dbClient.findOne(sql, orgid);
		if(one!=null) {
			String pid = StringUtil.toString(one.get("parentid"));
			if(Util.isNotEmpty(pid)) {
			   data.put("orgid",pid);
		       dbClient.update(SupConst.Collections.JZ_JZRYJBXX, data);
		    }
			BasicMap<String,Object> ds = new BasicMap<String,Object>();
			ds.put("ID", data.get("ID"));
			ds.put("THSJID", pid);
			dbClient.insert(SupConst.Collections.ANZBJ_RYTHSJJLB, ds);
		}
	}
	
	/**
	 * 获取退回人员信息
	 * @param query
	 * @param paginate
	 * @return
	 */
	public List<BasicMap<String,Object>> findBack(BasicMap<String,Object> query,Paginate paginate){
		List<BasicMap<String,Object>> list=new ArrayList<>();
		String sql=" SELECT b. ID, b.xm, C .jgmc, A .cts, d.gdjzdmx, b.sfzh " + 
				"FROM  ANZBJ_RYTHSJJLB A   " + 
				"INNER JOIN JZ_JZRYJBXX b ON A . ID = b. ID " + 
				"INNER JOIN jc_sfxzjgjbxx C ON A .THSJID = C . ID " + 
				"LEFT JOIN JZ_JZRYJBXX_DZ d ON b.ID = d.ID";
		SQLAdapter adapter=new SQLAdapter(sql);
		SqlDbFilter filter=new SqlDbFilter();
	    filter.like("b.xm",StringUtil.toEmptyString(query.get("xm")))
	          .like("b.sfzh", StringUtil.toEmptyString(query.get("sfzh")))
	          .eq("b.orgid", service.getUser().getOrgid());
		adapter.setFilter(filter);
		list=dbClient.find(adapter, paginate).getRows();
		return list;
		
	}
	
	/**
	 * 必接必送人员信息保存
	 * @param data{
	 *    id:"服刑人员ID"
	 * }
	 */
	public void saveBjbs(BasicMap<String,Object> data) {
		dbClient.save(SupConst.Collections.ANZBJ_BJBSXXJLB, data);
		
	}
	
	/**
	 * 保存人员衔接信息
	 * @param data{
	 *    id:"服刑人员ID"
	 * }
	 */
	public void saveRyxj(BasicMap<String,Object> data) {
		dbClient.save(SupConst.Collections.ANZBJ_RYXJXXCJB, data);
	}
	
	/**
	 * 新建衔接人员
	 * @param data1{
	 *     矫正人员信息
	 *  }
	 * @param data2{
	 *    衔接人员信息
	 *  }
	 */
	public void insertRyxj(BasicMap<String,Object> data1,BasicMap<String,Object> data2,BasicMap<String,Object> data3) {
		dbClient.save(SupConst.Collections.JZ_JZRYJBXX, data1,new InsertOperation() {
			@Override
			public void insertBefore(BasicMap<String, Object> data) {
		         String code=sfService.getCorrectCode();
		         data1.put("SQJZRYBH", code);
			}
			
			@Override
			public void updateBefore(BasicMap<String, Object> data) {
		         data1.remove("SQJZRYBH");
			}
			
			@Override
			public void insertAfter(BasicMap<String, Object> data) {
				
			}
		});
		String jzid=StringUtil.toEmptyString(data1.get("id"));
		data2.put("id", jzid);
		dbClient.save(SupConst.Collections.ANZBJ_RYXJXXCJB,data2);
		data3.put("id", jzid);
		dbClient.save(SupConst.Collections.JZ_JZRYJBXX_DZ, data3);
	}
	
	/**
	 * 查询帮教人员详细信息
	 * @param id
	 * @return
	 */
	public BasicMap<String,Object> findAzbjDetail(String id){
		String sql="select a.id,a.xm,a.XB,a.CYM,a.MZ,a.SFZH,a.CSRQ," + 
				"a.WHCD,a.HYZK,a.GRLXDH,a.XZZMM,a.XGZDW,a.DWLXDH," + 
				"a.QTLXFS,a.SFSWRY,a.JYJXQK,a.PQZY,b.GJ,b.HJSZD,b.HJSZDMX,b.GDJZD,b.gdjzdmx,c.SBQSF," + 
				"c.XJTJ,c.BJLX,c.XJSJ from JZ_JZRYJBXX a left join " + 
				"JZ_JZRYJBXX_DZ b on a.id=b.id left join ANZBJ_RYXJXXCJB c " + 
				"on a.id=c.id";
		SQLAdapter adapter=new SQLAdapter(sql);
		SqlDbFilter filter=new SqlDbFilter();
		filter.eq("a.id", id);
		adapter.setFilter(filter);
		BasicMap<String,Object> data=dbClient.findOne(adapter);
		return data;
	}
	
	
	
} 
