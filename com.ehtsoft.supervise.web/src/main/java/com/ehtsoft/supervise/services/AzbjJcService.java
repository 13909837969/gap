package com.ehtsoft.supervise.services;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

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
import com.ehtsoft.supervise.api.SupConst;

/**
 * 
 * 解除安置帮教
 * @author Administrator
 * @date 2018年4月4日
 *
 */
@Service("AzbjJcService")
public class AzbjJcService extends AbstractService{

	@Resource(name="sqlDbClient")
	SqlDbClient dbClient;
	
	@Resource(name="SSOService")
	private SSOService ssoService;
	
	//解除帮教
	public void save(BasicMap<String, Object> data) {
		dbClient.save(SupConst.Collections.ANZBJ_JCAZBJXXCJB, data);
		
		//更改衔接安置帮教人员的解除状态
		BasicMap<String, Object> data1 = new BasicMap<>();
		data1.put("id", data.get("f_aid"));
		data1.put("jcbj", "1");
		dbClient.update(SupConst.Collections.ANZBJ_RYXJXXCJB, data1);
		
		//保存签字图片
		/*BasicMap<String, Object> img = new BasicMap<>();
		img.put("IMGID", data.get("f_aid"));
		img.put("data", data.get("qz"));
		dbClient.save(SupConst.Collections.ANZBJ_AZXX_IMG, img);*/
	}
	
	//查询所有解除帮教人员
	public List<BasicMap<String,Object>> findAll(BasicMap<String,Object> query,Paginate paginate){
		String sql=" SELECT a.xm,a.sqjzrybh,a.sfzh,a.csrq,a.xb,a.mz,b.gdjzdmx,b.hjszd,d.JCSJ,d.JCYY,d.ID,d.JCBJZJ,d.F_AID FROM JZ_JZRYJBXX a " + 
				   " left join JZ_JZRYJBXX_DZ b on a.id=b.id " + 
				   " left join ANZBJ_RYXJXXCJB c on c.ID = a.ID" +
				   " left join ANZBJ_JCAZBJXXCJB d on a.id=d.F_AID";
		User user=ssoService.getUser();
		SqlDbFilter filter=new SqlDbFilter();
		filter.like("a.xm",StringUtil.toEmptyString(query.get("xm")));
	    filter.isNotNull("c.id");
	    filter.eq("a.orgid",user.getOrgid());
	    filter.unEq("a.jcjz", "0");
	    filter.eq("c.JCBJ", "1");
		SQLAdapter adapter=new SQLAdapter(sql);
		adapter.setFilter(filter);
		List<BasicMap<String,Object>> list=dbClient.find(adapter, paginate).getRows();
		return list;
	}
	
	//解除帮教详细信息
	public BasicMap<String,Object> findOne(String id){
		String sql=" SELECT a.xm,a.sqjzrybh,a.sfzh,a.csrq,a.xb,a.mz,b.gdjzdmx,b.hjszd,d.JCSJ,d.JCYY,d.ID,d.JCBJZJ,d.F_AID FROM JZ_JZRYJBXX a " + 
				   " left join JZ_JZRYJBXX_DZ b on a.id=b.id " + 
				   " left join ANZBJ_RYXJXXCJB c on c.ID = a.ID" +
				   " left join ANZBJ_JCAZBJXXCJB d on a.id=d.F_AID";
		SQLAdapter adapter=new SQLAdapter(sql);
		adapter.getFilter().eq("d.id", id);
		BasicMap<String,Object> data=dbClient.findOne(adapter);
		return data;
	}
	
	/**
	 * 在册人数和解除人数
	 * @param data
	 * @return
	 */
	public List<BasicMap<String,Object>> findSize(BasicMap<String,Object> data) {
		List<BasicMap<String, Object>> list = new ArrayList<>();
		User user=ssoService.getUser();
		String sql1="SELECT count(a.id) as count FROM JZ_JZRYJBXX a  left join JZ_JZRYJBXX_DZ b on a.id=b.id " + 
				"left join ANZBJ_RYXJXXCJB C on C.ID = a.ID  " + 
				"left join ANZBJ_BJBSXXJLB d on a.id=d.id  where a.orgid='"+user.getOrgid()+"' and c.id is not null and a.jcjz<>'0' and c.jcbj<>'1'";
		
		String sql2="SELECT count(a.id) as counts FROM JZ_JZRYJBXX a  \r\n" + 
				"left join JZ_JZRYJBXX_DZ b on a.id=b.id  left join ANZBJ_RYXJXXCJB c on c.ID = a.ID " + 
				"left join ANZBJ_JCAZBJXXCJB d on a.id=d.F_AID " + 
				"WHERE c.id is not null AND a.orgid = '"+user.getOrgid()+"' AND a.jcjz <> '0' AND c.JCBJ = '1' ";
		
        BasicMap<String,Object> map1=new BasicMap<>();
        map1=dbClient.findOne(sql1);
        if(map1==null) {
    	         map1 = new BasicMap<>();
			 map1.put("count", "0");
         }
        list.add(map1);
        BasicMap<String,Object> map2=new BasicMap<>();
        map2=dbClient.findOne(sql2);
        if(map2==null) {
             map2 = new BasicMap<>();
			 map2.put("counts", "0");
        }
        list.add(map2);
		return list;
	}
	
	/**
	 * 查询在册人员
	 * @param query
	 * @param paginate
	 * @return
	 */
	public List<BasicMap<String,Object>> findAc(BasicMap<String,Object> query,Paginate paginate){
		User user=ssoService.getUser();
		String sql="SELECT a.id,a.xm,a.cts,b.gdjzdmx FROM JZ_JZRYJBXX a  left join JZ_JZRYJBXX_DZ b on a.id=b.id " + 
				"left join ANZBJ_RYXJXXCJB C on C.ID = a.ID " + 
				"left join ANZBJ_BJBSXXJLB d on a.id=d.id "; 
				
		SQLAdapter sqlAdapter = new SQLAdapter(sql);
		SqlDbFilter filter=new SqlDbFilter();
		filter.unEq("a.jcjz", "0");
		filter.unEq("c.JCBJ", "1");
		filter.isNotNull("C.ID");
		filter.eq("a.orgid", user.getOrgid());
		filter.like("a.xm", StringUtil.toEmptyString(query.get("xm")));
		sqlAdapter.setFilter(filter);
		List<BasicMap<String,Object>> list=dbClient.find(sqlAdapter, paginate).getRows();
		return list;
	}
	
}
