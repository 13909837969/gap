package com.ehtsoft.supervise.services;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ehtsoft.common.services.SSOService;
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
 * 基层法律服务 
 * @author maruimin
 * 
 *
 */
@Service("FlfwJcflfwService")
public class FlfwJcflfwService extends AbstractService{
	@Resource (name = "sqlDbClient")
	private SqlDbClient dbClient;
	@Resource (name = "SSOService")
	private SSOService service;
	
	/**
	 * 查询所有基层法律服务工作登记信息
	 * 平板用
	 * @param paginate
	 * @return
	 */
	public List<BasicMap<String, Object>> findList(BasicMap<String,Object> query,Paginate paginate) {
		User user =service.getUser();
		List<BasicMap<String, Object>> data = new ArrayList<>();
		String sqlStr = "select a.id,a.fwsj,a.fwdd,a.fwdx,a.gzlx,a.gznrms,b.xm from FLFW_JCFLFWDJB a left join FLFW_JCFLFWGZZ b on a.aid=b.id";
		SQLAdapter adapter = new SQLAdapter(sqlStr);
		SqlDbFilter filter=new SqlDbFilter();
		filter.like("fwdx", StringUtil.toEmptyString(query.get("dx")))
		     .eq("a.orgid", user.getOrgid());
		adapter.setFilter(filter);
		data = dbClient.find(adapter,paginate).getRows();
		return data;
	}
	
	/**
	 * 查询一条基层法律服务工作登记信息
	 * 平板用
	 * @param paginate
	 * @return
	 */
	public BasicMap<String, Object> findOne(String id){
		BasicMap<String, Object> data = new BasicMap<>();
		String sqlStr = "select a.id,a.fwsj,a.fwdd,a.fwdx,a.gzlx,a.gznrms,b.xm from FLFW_JCFLFWDJB a left join FLFW_JCFLFWGZZ b on a.aid=b.id";
		SQLAdapter adapter = new SQLAdapter(sqlStr);
		adapter.getFilter().eq("a.id", id);
		data = dbClient.findOne(adapter);
		return data;
	}
	
	/**
	 * 保存或者修改一条基层法律服务工作登记信息
	 * 平板用
	 * @param paginate
	 * @return
	 */
	public void saveOne(BasicMap<String, Object> data) {
		dbClient.save(SupConst.Collections.FLFW_JCFLFWDJB, data);
	}
	
	/**
	 * 删除一条基层法律服务工作登记信息
	 * 平板用
	 * @param paginate
	 * @return
	 */
	public void delete(String id) {
		dbClient.remove(SupConst.Collections.FLFW_JCFLFWDJB, new SqlDbFilter().eq("id", id));
	}
	
	/**
	 * 获取所有法律服务工作人员
	 * 平板用
	 * @param query
	 * @param paginate
	 * @return
	 */
	public List<BasicMap<String,Object>> findGz(BasicMap<String,Object> query,Paginate paginate){
		User user=service.getUser();
		//SqlDbFilter filter = toSqlFilter(query);
		List<BasicMap<String,Object>> list=new ArrayList<>();
		String sql="select * from FLFW_JCFLFWGZZ";
		SqlDbFilter sqlFilter = new SqlDbFilter();
		sqlFilter.like("xm", StringUtil.toEmptyString(query.get("name")))
		         .like("orgid", user.getOrgid());
        SQLAdapter adapter=new SQLAdapter(sql);
        adapter.setFilter(sqlFilter);
        list=dbClient.find(adapter, paginate).getRows();
        return list;	
	}
	
	/**
	 * 查询法律服务工作者的基本信息
	 * @param id
	 * @return
	 */
	public BasicMap<String,Object> findGzOne(String id){
		//SqlDbFilter filter = toSqlFilter(query);
		BasicMap<String,Object> data=new BasicMap<>();
		String sql="select a.*,b.f_name as ywzcmc from FLFW_JCFLFWGZZ a LEFT JOIN sys_dictionary b on a.ywzc = b.f_code ";
        SQLAdapter adapter=new SQLAdapter(sql);
        adapter.getFilter().eq("a.id", id).eq("b.f_typecode", "SYS201");
        data=dbClient.findOne(adapter);
        return data;	
	}
	
}
