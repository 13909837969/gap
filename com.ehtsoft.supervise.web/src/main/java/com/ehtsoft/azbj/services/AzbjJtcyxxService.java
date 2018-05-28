package com.ehtsoft.azbj.services;

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
import com.ehtsoft.fw.core.dto.ResultList;
import com.ehtsoft.fw.core.services.AbstractService;
import com.ehtsoft.fw.core.sso.User;
import com.ehtsoft.im.services.UserinfoService;
import com.ehtsoft.supervise.api.SupConst;
/**
 *  家庭成员信息
 * @author 吴涛
 * @date 2018年5月24日
 *
 */
@Service("AzbjJtcyxxService")
public class AzbjJtcyxxService extends AbstractService{

	@Resource(name = "sqlDbClient")
	private SqlDbClient dbClient;//也许是操作数据库的一个框架方法封装  class文件注释乱码 看不懂
	
	@Resource(name="SSOService")
	private SSOService ssoService; //处理session的类 通过sessionid获取登录用户的信息  不过两个都是 == null 获取不到也许和这个有关
	
	@Resource
	private UserinfoService userinfoService;//这个类没有用到 应该是多余的 未确定
	/**
	 * 展示用户列表
	 * @param query
	 * @param paginate
	 * @return
	 */
	public ResultList<BasicMap<String, Object>> findAll(BasicMap<String, Object> query,Paginate paginate){
		User user = ssoService.getUser();
		ResultList<BasicMap<String, Object>> rtn = new ResultList<>();
		if(user != null){
			String sqlstr = "SELECT d.xm as axm,d.id as aid,j.id,j.xm,j.gx,j.nl,j.gzdw,j.dh FROM ANZBJ_JTCYXXCJB j INNER JOIN JZ_JZRYJBXX d ON j.azbjryid=d.id INNER JOIN ANZBJ_RYXJXXCJB c ON c.id=d.id";
			SqlDbFilter filter = toSqlFilter(query);
			SQLAdapter sql = new SQLAdapter(sqlstr);
			sql.setFilter(filter);
			filter.in("d.orgid", user.getOrgidSet());
			rtn = dbClient.find(sql, paginate);
		}
		return rtn;
	}
	/**
	 *插入一条家庭成员信息到 表中 
	 * @param data
	 */
	public void saveOne(BasicMap<String, Object> data){
		dbClient.save(SupConst.Collections.ANZBJ_JTCYXXCJB, data);
	}
	/**
	 * 删除一条数据  
	 * @param id
	 */
	public void removeOne(String id){
		dbClient.remove(SupConst.Collections.ANZBJ_JTCYXXCJB, new SqlDbFilter().eq("id",id));
	}
	/**
	 * 下拉框操作
	 * @return
	 */
	public List<BasicMap<String, Object>> findJz(){
		//方法的返回值是一个集合类型存入的是安置帮教人员的信息
		User user = ssoService.getUser();
		//这里获取的user应该是通过session ID 获取的登录的用户的信息
		String orgid = user.getOrgid();
		// 根据用户信息获取到用户的orgid  我这里可能是账号问题 无法获取orgid 如果要测试需要给orgid物理赋值
		List<BasicMap<String, Object>> map = new ArrayList<>();
		if(user != null){
			System.out.println(orgid);
			String sql = "select A.id,A.xm from JZ_JZRYJBXX A INNER JOIN ANZBJ_RYXJXXCJB C ON A.ID=C.ID where A.orgid='"+orgid+"'"+"AND C.JCBJ='0'";
			SQLAdapter adapter = new SQLAdapter(sql);
			//执行sql语句的方法 把sql语句传入即可
			map = dbClient.find(adapter);
		}
		return map;
	}
}
