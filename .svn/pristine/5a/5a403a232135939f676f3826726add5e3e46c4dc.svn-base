package com.ehtsoft.supervise.services;

/**
 *解除矫正信息
 */
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Set;

import javax.annotation.Resource;

import org.bouncycastle.i18n.filter.SQLFilter;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.stereotype.Service;

import com.ehtsoft.common.services.SFCodeService;
import com.ehtsoft.common.services.SSOService;
import com.ehtsoft.fw.core.db.InsertOperation;
import com.ehtsoft.fw.core.db.MongoClient;
import com.ehtsoft.fw.core.db.RowDataListener;
import com.ehtsoft.fw.core.db.SQLAdapter;
import com.ehtsoft.fw.core.db.SqlDbClient;
import com.ehtsoft.fw.core.db.SqlDbFilter;
import com.ehtsoft.fw.core.dto.BasicMap;
import com.ehtsoft.fw.core.dto.Paginate;
import com.ehtsoft.fw.core.dto.ResultList;
import com.ehtsoft.fw.core.services.AbstractService;
import com.ehtsoft.fw.core.sso.User;
import com.ehtsoft.fw.core.utils.AppUtil;
import com.ehtsoft.fw.utils.DateUtil;
import com.ehtsoft.fw.utils.NumberUtil;
import com.ehtsoft.fw.utils.StringUtil;
import com.ehtsoft.fw.utils.Util;
import com.ehtsoft.im.api.ImConst;
import com.ehtsoft.im.protocol.CommandType;
import com.ehtsoft.supervise.api.SupConst;
import com.ibm.icu.text.SimpleDateFormat;

import oracle.security.o5logon.a;

/**
 * 矫正人员基本信息表
 * @创建人  ：liuzhih
 * @创建时间：2017年10月11日 下午10:49:25
 * @修改人  ：liuzhih
 * @修改时间：2017年10月11日 下午10:49:25
 * @修改备注：
 *
 * @version 1.0
 */
@Service("JzJzryjbxxService")
public class JzJzryjbxxService  extends AbstractService  {
	
	@Resource(name = "sqlDbClient")
	private SqlDbClient dbClient;
	
	
	@Resource(name="mongoClient")
	private MongoClient mongoClient;
	
	@Resource(name="SSOService")
	private SSOService service;
	
	
	@Resource(name="SFCodeService")
	private SFCodeService sfCodeService;
	
	/**
	 * 
	 * 解除矫正个人详情
	 * 返回值格式:<br>
	 * @author Administrator
	 * @date   2018年3月31日
	 * 方法的作用：TODO
	 */
	public BasicMap<String, Object> findRemCorrectDetils(String id) {
		BasicMap<String, Object> rtn = new BasicMap<>();
		String sqlstr = "SELECT a.*,b,xm from JZ_JZJCXXCJB a LEFT JOIN jc_sfxzjggzryjbxx b ON a.SFSJCR = b.id where  a.id = '"+ id +"'";
		SQLAdapter sqlAdapter = new SQLAdapter(sqlstr);
		rtn = dbClient.findOne(sqlAdapter);
		return rtn;
	}
	
	/**
	 * 获取已解除矫正人员
	 * @return<br>
	 * 返回值格式: List<BasicMap<String, Object>>
	 *
	 * @author Administrator
	 * @date   2018年3月31日
	 * 方法的作用：TODO
	 */
	public List<BasicMap<String, Object>> findRemCorrects(BasicMap<String, Object> query,Paginate paginate) {
		User user = service.getUser();
		List<BasicMap<String, Object>> list = new ArrayList<>();
		if(user!=null){
			//b.gdjzdmx,b.fzlx,
			String sqlstr = "select a.qs,b.xm,b.id,b.sqjzrybh,b.sfzh,b.grlxdh from JZ_SQJZRYGRJL  a right JOIN  JZ_JZRYJBXX b ON b.ID = a.f_aid ";
			SqlDbFilter sqlFilter = new SqlDbFilter();
			sqlFilter.eq("b.jcjz", "1");
			sqlFilter.like("b.xm", StringUtil.toEmptyString(query.get("name")))
			.like("b.sfzh", StringUtil.toEmptyString(query.get("identify")))
			.eq("b.sfjs", "1");//判断是否接受  0 未接受  1 接受 
			Set<String> set =  user.getOrgidSet();
			if(set.size()>0){
				sqlFilter.in("b.orgid", set);
			}
			SQLAdapter sqlAdapter = new SQLAdapter(sqlstr);
			sqlAdapter.setFilter(sqlFilter);
			list = dbClient.find(sqlAdapter,paginate,new RowDataListener() {
				
				@Override
				public void processData(BasicMap<String, Object> rowData) {
					rowData.put("qs", DateUtil.format(rowData.get("rq"), "yyyy-MM-dd"));
					
				}
			}).getRows();
		}
		return list;
	}
	
	
	/**
	 * 解除矫正
	 * 返回值格式:<br>
	 * @author Administrator
	 * @date   2018年3月30日
	 * 方法的作用：TODO <新增>
	 */
	public void save(BasicMap<String, Object> data) {
		dbClient.save(SupConst.Collections.JZ_JZJCXXCJB, data);
		BasicMap<String, Object> datas = new BasicMap<>();
		datas.put("id", data.get("id"));
		datas.put("jcjz", 1);
		dbClient.save(SupConst.Collections.JZ_JZRYJBXX, datas);
	}
	
	/**
	 * 获取当前司法所的工作人员列表
	 * @return<br>
	 * 返回值格式: List<BasicMap<String, Object>>
	 * @author Administrator
	 * @date   2018年3月30日
	 * 方法的作用：TODO <新增>
	 */
	public List<BasicMap<String, Object>> findRemCorrect() {
		BasicMap<String, Object> map = new BasicMap<>();
 		User user = service.getUser();
		String orgid= user.getOrgid();
		String id = user.getUid();
		StringBuffer sqlstr = new StringBuffer("SELECT xm,id FROM jc_sfxzjggzryjbxx ");
		if (orgid != null) {
			sqlstr.append("where orgid = '"+ orgid +"'");
		}
		SQLAdapter adapter = new SQLAdapter(sqlstr.toString());
		List<BasicMap<String, Object>> list = dbClient.find(adapter);
		if(list.size() > 1) {
			for (int i = 0; i < list.size(); i++) {
				if (id.equals( StringUtil.toString(list.get(i).get("id")))) {
					map.put("xm", list.get(i).get("xm"));
					map.put("id", id);
					list.remove(i);
				}
			}
			list.add(0, map);
		}
		return list;

	}
	/**
	 * 电脑端查询矫正人员列表
	 * @param query
	 * @param paginate
	 * @return
	 */
	public ResultList<BasicMap<String,Object>> findRseultList(BasicMap<String,Object> query,Paginate paginate){
		User user = service.getUser();
		ResultList<BasicMap<String,Object>>  result = new ResultList<>();
		if(user != null){
			SqlDbFilter filter = toSqlFilter(query);
			String sqlstr = "SELECT "
					+ "A.ID,A.xm,A.xb,A.sfzh,A.jglx,A.grlxdh,A.jcjz,"
					+ "B.JJLX,B.JJRQ,B.SJZXYY,B.SJZXLX,B.SJZXRQ,B.SWSJ,B.SWYY,B.JTSY,B.JZDBGRQ,B.XJZDDZ,"
					+ "B.JZQJBX,B.RZTD,B.SFCJZYJNPX,B.SFHDZYJNZS,B.JSTCJDJ,B.WXXPG,B.JTLXQK,B.TSQKBZJBJJY,B.SFSJCR"
					+ " from jz_jzryjbxx A "
					+ "LEFT JOIN JZ_JZJCXXCJB b ON b.id=a.id";
			SQLAdapter sql = new SQLAdapter(sqlstr);
			filter.in("a.orgid", user.getOrgidSet());
			sql.setFilter(filter);
			result = dbClient.find(sql, paginate);
		}
		return result;
	}
	
	
	/**
	 * 获取已发放解除证明的矫正人员方法
	 * @param query
	 * @param paginate
	 * @return
	 * 电脑端使用
	 * @author 李恒
	 */
	public ResultList<BasicMap<String,Object>> findYffjczmList(BasicMap<String,Object> query,Paginate paginate){
		User user = service.getUser();
		ResultList<BasicMap<String,Object>>  result = new ResultList<>();
		if(user != null){
			SqlDbFilter filter = toSqlFilter(query);
			String sqlstr = "SELECT a.id,a.xm,a.xb,a.sfzh,a.jglx,a.grlxdh,a.jcjz,b.jjlx,b.jjrq,zms.id as zmsid "
					+ "from jz_jzryjbxx a "
					+ "LEFT JOIN JZ_JZJCXXCJB b ON b.id=a.id "
					+ "left join JZ_JCSQJZZMS ZMS ON ZMS.ID = A.ID" ;
					
					/*"SELECT "
					+ "A.ID,A.xm,A.xb,A.sfzh,A.jglx,A.grlxdh,A.jcjz,"
					+ "B.JJLX,B.JJRQ,B.SJZXYY,B.SJZXLX,B.SJZXRQ,B.SWSJ,B.SWYY,B.JTSY,B.JZDBGRQ,B.XJZDDZ,"
					+ "B.JZQJBX,B.RZTD,B.SFCJZYJNPX,B.SFHDZYJNZS,B.JSTCJDJ,B.WXXPG,B.JTLXQK,B.TSQKBZJBJJY,B.SFSJCR"
					+ " from jz_jzryjbxx A "
					+ " LEFT JOIN JZ_JZJCXXCJB b ON b.id=a.id";*/
			SQLAdapter sql = new SQLAdapter(sqlstr);
			filter.eq("a.orgid", user.getOrgid());
			sql.setFilter(filter);
			result = dbClient.find(sql, paginate);
		}
		return result;
	}
	
	
	/**
	 * 根据条件获取矫正人员列表
	 * @param query
	 * @param paginate
	 * @return
	 * 平板端接口
	 */
	public List<BasicMap<String,Object>> findList(BasicMap<String,Object> query,Paginate paginate){
		User user = service.getUser();
		String orgid = user.getOrgid();
		SqlDbFilter filter = toSqlFilter(query);
		String sqlstr = "select a.id,a.xm,a.xb,a.mz,a.sfzh,a.csrq,a.xgzdw,a.jglx,a.grlxdh,d.gdjzdmx,d.gdjzdszs,d.gdjzdszds,d.gdjzdszxq,d.gdjzd "
				+ "from  jz_jzryjbxx a  LEFT JOIN JZ_JZRYJBXX_DZ d ON a. ID = d. ID  where  a.orgid = '"+ orgid +"'";
		SQLAdapter sql = new SQLAdapter(sqlstr);
		sql.setFilter(filter);
		List<BasicMap<String,Object>>  result = dbClient.find(sql,paginate,new RowDataListener(){
			@Override
			public void processData(BasicMap<String, Object> rowData) {
				//TODO;设置当前坐标和是否在线
			}}).getRows();
		return result;
	}
	
	/**
	 *根据id获取个人基本信息详细信息
	 * @param id
	 * @return
	 * BasicMap<String,Object>
	 * @创建人  ：Administrator
	 * @创建时间：2017年10月8日下午2:43:16
	 * @修改人  ：Administrator
	 * @修改时间：2017年10月8日下午2:43:16
	 * @修改备注：
	 * @version 1.0
	 * 
	 *	平板端接口
	 */
	public BasicMap<String,Object> findDetail(String id){
		BasicMap<String, Object> rtn = new BasicMap<>();
		String sqlstr = "select a.*,d.GDJZDMX,c.region_name,c.regionid,"
				+ " e.fzlx from jz_jzryjbxx a "
				+ "LEFT JOIN JZ_JZRYJBXX_DZ d ON a.id = d.id " + 
				"LEFT JOIN JZ_JZRYJBXX_JZ e on a.id = e.id "+
				"LEFT JOIN sys_region C ON d.gdjzdszxq = C .regionid";
		SqlDbFilter sqlDbFilter = new SqlDbFilter();
		sqlDbFilter.eq("a.id", id);
		SQLAdapter sqlAdapter = new SQLAdapter(sqlstr);
		sqlAdapter.setFilter(sqlDbFilter);
		rtn = dbClient.findOne(sqlAdapter);
		
		//检索禁止令 类型
		List<BasicMap<String, Object>> list = dbClient.find(new SQLAdapter( "SELECT  a.jzllx,b.f_name from JZ_JZLXXCJB a LEFT JOIN sys_dictionary b ON a.jzllx = b.f_code " + 
				"where f_aid = '"+ id +"' and b.F_TYPECODE = 'SYS101' GROUP BY a.jzllx,b.f_name"));
		
		List<String> li = new ArrayList<>();
		for (int i = 0; i < list.size(); i++) {
			li.add(StringUtil.toString(list.get(i).get("f_name")));
		}
		rtn.put("jzlnr",li);
		rtn.put("csrq", DateUtil.format(rtn.get("csrq"), "yyyy-MM-dd"));
		rtn.put("cts", DateUtil.format(rtn.get("cts"), "yyyy-MM-dd"));
		rtn.put("jzqxksrq", DateUtil.format(rtn.get("jzqxksrq"), "yyyy-MM-dd"));
		rtn.put("jzqxjsrq", DateUtil.format(rtn.get("jzqxjsrq"), "yyyy-MM-dd"));
		rtn.put("sqjzryjsrq", DateUtil.format(rtn.get("sqjzryjsrq"), "yyyy-MM-dd"));
		rtn.put("sqjzksrq", DateUtil.format(rtn.get("sqjzksrq"), "yyyy-MM-dd"));
		rtn.put("sqjzjsrq", DateUtil.format(rtn.get("sqjzjsrq"), "yyyy-MM-dd"));
		return rtn;
	}
	
	
	/**
	 *pad-根据id获取个人基本信息详细信息（简单）
	 * @param id
	 * @return
	 * BasicMap<String,Object>
	 * @创建人  ：Administrator
	 * @创建时间：2017年10月8日下午2:43:16
	 * @修改人  ：Administrator
	 * @修改时间：2017年10月8日下午2:43:16
	 * @修改备注：
	 * @version 1.0
	 * 
	 *	平板端接口
	 */
	public BasicMap<String,Object> findSimpleDetail(String id){
		String sql="select id,xm,xb,csrq,grlxdh,dwlxdh  from  jz_jzryjbxx where id='"+id+"'";
		BasicMap<String,Object> rtn = dbClient.findOne(sql);
		if(rtn!=null){
			if(Util.isNotEmpty(rtn.get("csrq"))){
				Date birthdate = (Date)rtn.get("csrq");
				int age = DateUtil.getAge(birthdate);
				rtn.put("nl", age);
			}
		}
		return rtn;
	
	}
	
	
	/**
	 * @query
	 * {
	 *    mulitquey:姓名或个人联系电话或身份证号 查下条件 （ 平板 矫正人联系人用 ）
	 * }
	 * pad-按条件获取当前登录机构管理的矫正人员列表
	 * @return
	 * 
	 * 平板端接口
	 */
	public List<BasicMap<String,Object>> getPeopleList(BasicMap<String,Object> query,Paginate paginate){
		SqlDbFilter dbFilter=new SqlDbFilter();
		User user = service.getUser();
		List<BasicMap<String,Object>>  result = new ArrayList<>();
		if(user!=null){
			dbFilter.like("a.xm", StringUtil.toString(query.get("xm")))
			.like("a.grlxdh", StringUtil.toString(query.get("grlxdh")))
			.eq("a.online",StringUtil.toString(query.get("online")))
			.eq("a.jglx",StringUtil.toString(query.get("jglx")) );
			
			
			if(Util.isNotEmpty(query.get("mulitquey"))){
				String qustr = SqlDbFilter.convertSqlParameter(StringUtil.toString(query.get("mulitquey")));
				dbFilter.like("( a.xm",qustr )
				.or().like("a.grlxdh", qustr)
				.or().addFieldRelation("a.sfzh like '%"+ qustr + "%') ");
			}
			
			String sqlstr = "select a.id,a.sqjzrybh as code,a.xm,a.xb,a.grlxdh,a.csrq,a.sfzh,jz.fzlx,a.online,a.jglx,b.f_finger,b.f_face,b.f_voice from  "
					+ "jz_jzryjbxx a "
					+ " left join jz_jzryjbxx_jz jz on jz.id = a.id "
					+ " left join jz_collect_user b on a.id = b.f_id  ";
			SQLAdapter sql = new SQLAdapter(sqlstr);
			dbFilter.eq("a.jcjz", "0");
			if(Util.isNotEmpty(query.get("SFCJ"))){
				dbFilter.eq("a.SFCJ",NumberUtil.toInt((query.get("SFCJ"))));
			}else{
				dbFilter.eq("a.SFCJ", 1);
			}
			Set<String> set =  user.getOrgidSet();
			if(set.size()>0){
				dbFilter.in("a.orgid", set);
			}
			if(user.getOrgType() >= 4){
				dbFilter.eq("a.SFJS", "1");/// 是否接收为已接收状态（1）
			}
			sql.setFilter(dbFilter);
			result = dbClient.find(sql,paginate,new RowDataListener(){
				@Override
				public void processData(BasicMap<String, Object> rowData) {
					rowData.put("code", StringUtil.toLowerCase(StringUtil.toEmptyString(rowData.get("code"))));
					Date birthdate = (Date)rowData.get("csrq");
					int age = DateUtil.getAge(birthdate);
					rowData.put("nl", age);
					Query q = Query.query(Criteria.where("_id").is(String.valueOf(rowData.get("id")).trim()));
					BasicMap<String,Object> currentLocation= mongoClient.findOne(ImConst.Collections.IM_CURRENT_LOCATION, q);
					if(currentLocation!=null&&currentLocation.size()>0){
						rowData.put("address", currentLocation.get("address"));
						rowData.put("describe", currentLocation.get("describe"));
						rowData.put("online",currentLocation.get("online"));
						rowData.put("lat", currentLocation.get("lat"));
						rowData.put("lng", currentLocation.get("lng"));
					}
				}}).getRows();
		}
		return result;
	}
	
	/**
	 * 报到补录新增
	 * 保存未采集矫正人员
	 * @param data
	 */
	public void saveCJ(BasicMap<String,Object> data) {
		User user = service.getUser();
		String csrq = AppUtil.getBirthdate(StringUtil.toString(data.get("sfzh")));
		if(Util.isNotEmpty(csrq)){
			data.put("csrq", csrq);
		}
		if(user.getOrgType()<4) {
			data.put("SFJS", "0"); //司法所是否接受  0 未接收   1 接收
		}else {
			//司法所
			data.put("SFJS", "1"); //司法所是否接受  0 未接收   1 接收
		}
		dbClient.save(SupConst.Collections.JZ_JZRYJBXX, data,new InsertOperation() {
			@Override
			public void insertBefore(BasicMap<String, Object> data) {
				String code = sfCodeService.getCorrectCode();
				data.put("sqjzrybh", code);
			}
			@Override
			public void updateBefore(BasicMap<String, Object> data){
				data.remove("sqjzrybh");
			}
			@Override
			public void insertAfter(BasicMap<String, Object> data) {
			}
		});	
	}
	
	/**
	 * 查询矫正人员基本信息列表
	 * @param query
	 * @param paginate
	 * @return
	 * {
	 *  rows[{images:[]}]
	 * }
	 * 电脑端接口
	 * 矫正人员禁止区域使用(listJzryjrjqsz.jsp)
	 */
	public ResultList<BasicMap<String,Object>> find(BasicMap<String,Object> query,Paginate paginate){
		User user = service.getUser();
		Set<String> orgids = user.getOrgidSet();  //获取当前登录人的orgid
		ResultList<BasicMap<String,Object>> rtn = new ResultList<>();
		SqlDbFilter filter = toSqlFilter(query);
		//根据orgid查找数据
		if(user != null){
			String sqlstr = " SELECT a.id,a.xm,a.xb,a.sqjzrybh,a.grlxdh,b.fzlx,b.jtzm FROM jz_jzryjbxx a left join JZ_JZRYJBXX_JZ b on a.id=b.id";
			SQLAdapter sql = new SQLAdapter(sqlstr);
			sql.setFilter(filter);
			filter.in("a.orgid", orgids).desc("a.cts");
			rtn = dbClient.find(sql,paginate);
		}
		return rtn;
	}
	
	
	/**
	 * 决策分析首页统计数据
	 * @param query
	 * @return
	 */
	public List<BasicMap<String,Object>> findCount(BasicMap<String,Object> query){
		SQLAdapter sql = new SQLAdapter("select count(1)  bdrs  from  JZ_JZRYJBXX  where BDQK='01' ");
		return dbClient.find(sql);
	}
	
	/**
	 * 更新在线或离线的状态
	 * @param aid
	 * @param online  0:不在线  1:在线
	 */
	public void updateOnlineStatus(String aid,String online){
		dbClient.getInterceptor().setSkipSso(true);
		dbClient.update(SupConst.Collections.JZ_JZRYJBXX, new BasicMap<String,Object>("ID",aid,"ONLINE",online));
		dbClient.getInterceptor().setSkipSso(false);
	}
	
	/**
	 * 矫正人员档案管理
	 * @param paginate
	 * @param query:{name:矫正人员姓名,identify:矫正人员身份证号}
	 * @return
	 * [
	 * 	{
	 * 		id:主键
	 * 		number:矫正人员编号
	 * 		name:矫正人员姓名
	 * 		identify:矫正人员身份证号
	 * 		address:矫正人员家庭住址
	 * 	}
	 * ]
	 */	
	public List<BasicMap<String, Object>> findArchives(BasicMap<String, Object> query,Paginate paginate){
		User user = service.getUser();
		List<BasicMap<String, Object>> list = new ArrayList<>();
		if(user!=null){
			String sqlstr = "select a.id,a.sqjzrybh,a.xm,a.sfzh,b.gdjzdmx,jz.fzlx,a.grlxdh from JZ_JZRYJBXX a "
							+ " left join JZ_JZRYJBXX_DZ b on a.id=b.id "
							+ " left join JZ_JZRYJBXX_JZ jz ON jz.id = a.id";
			SqlDbFilter sqlFilter = new SqlDbFilter();
			sqlFilter.eq("a.jcjz", "0");
			sqlFilter.like("a.XM", StringUtil.toEmptyString(query.get("name")))
			.like("a.SFZH", StringUtil.toEmptyString(query.get("identify")))
			.eq("a.sfjs", "1");
			Set<String> set =  user.getOrgidSet();
			if(set.size()>0){
				sqlFilter.in("a.orgid", set);
			}
			SQLAdapter sqlAdapter = new SQLAdapter(sqlstr);
			sqlAdapter.setFilter(sqlFilter);
			list = dbClient.find(sqlAdapter,paginate).getRows();
		}
		return list;
	}
	
	
	/**
	 * 
	 * 查询矫正人员
	 * @param query
	 * @param paginate
	 * @return<br>
	 * 返回值格式:List<BasicMap<String, Object>>
	 *
	 * @author Administrator
	 * @date   2018年3月30日
	 * 方法的作用：TODO
	 */
	public List<BasicMap<String, Object>> findjzry(BasicMap<String, Object> query,Paginate paginate){
		User user = service.getUser();
		List<BasicMap<String, Object>> list = new ArrayList<>();
		if(user!=null){
			//不存在 字段
			String sqlstr = "select a.xm,a.id,a.sqjzrybh,a.sfzh,a.grlxdh,d.gdjzdmx from jz_jzryjbxx a "
					+ "left join jz_jzryjbxx_dz d on a.id=d.id";
			SqlDbFilter sqlFilter = new SqlDbFilter();
			sqlFilter.eq("a.jcjz", "0");
			sqlFilter.like("a.XM", StringUtil.toEmptyString(query.get("name")))
			.like("a.SFZH", StringUtil.toEmptyString(query.get("identify")))
			.eq("a.sfjs", "1");//判断是否接受  0 未接受  1 接受 
			Set<String> set =  user.getOrgidSet();
			if(set.size()>0){
				sqlFilter.in("a.orgid", set);
			}
			//sqlstr += "";
			SQLAdapter sqlAdapter = new SQLAdapter(sqlstr);
			sqlAdapter.setFilter(sqlFilter);
			list = dbClient.find(sqlAdapter,paginate).getRows();
		}
		return list;
	}
	
	/**
	 * 矫正人员报警管理
	 * @param paginate
	 * @param query:{}
	 * @return
	 * [
	 *  {
	 *  	id:主键
	 *  	f_level:报警级别
	 *  	f_type:报警类型
	 *  	f_content:报警内容
	 *  	f_address:报警位置
	 *  	f_lat:纬度
	 *  	f_lng:经度
	 *  	f_score:相似度分数
	 *  	f_aid:登录用户主键
	 *  }
	 * ]
	 */
	public ResultList<BasicMap<String, Object>> findAlarm(BasicMap<String, Object> query,Paginate paginate){
		ResultList<BasicMap<String, Object>> rtn = new ResultList<BasicMap<String, Object>>();
		User user = service.getUser();
		if(user!=null){
			//
			String orgids = user.getOrgidsByWhereIn();
	    	String	sqlstr = "SELECT A .f_aid,A.f_type,A.f_content,A .cts AS mincts,A .cts AS maxcts, " + 
	    			"A .F_ADDRESS AS LOCATION,A.F_LAT,A.F_LNG,b.xm,b.grlxdh,d.gdjzdmx,b.sqjzrybh AS code  " + 
	    			"FROM REP_ALARM A   " + 
	    			"INNER JOIN jz_jzryjbxx b ON A.f_aid = b.ID " + 
	    			"LEFT JOIN JZ_JZRYJBXX_DZ d ON b.ID = d.ID" + 
					" where f_solve = " + NumberUtil.toInt(query.get("status"))  + 
					" and  a.orgid in ("+orgids+")" + 
					" order by a.cts desc";
			SQLAdapter sqlAdapter = new SQLAdapter(sqlstr);
			final BasicMap<String,BasicMap<String,Object>> locationMap = new BasicMap<>();
			final BasicMap<String,BasicMap<String, Object>> tempMap = new BasicMap<>();
			rtn = dbClient.find(sqlAdapter,paginate,new RowDataListener() {
				@Override
				public void processData(BasicMap<String, Object> rowData) {
					String faid = StringUtil.toString(rowData.get("f_aid"));
					if(AlarmService.hasContainType(StringUtil.toEmptyString(rowData.get("f_type")),CommandType.COMMAND_IN_TDQY+"")){
						//当前人员是否曾经进入禁止区域
						rowData.put("forbidArea", 1);
						if(tempMap.get(faid)!=null){
							tempMap.get(faid).put("forbidArea", 1);
						}
					}
					//查询报警时间间隔
					rowData.put("maxcts", DateUtil.format(rowData.get("maxcts"), "yyyy-MM-dd HH:mm:ss"));
					rowData.put("mincts", DateUtil.format(rowData.get("mincts"), "yyyy-MM-dd HH:mm:ss"));
				}
			});
		}
		return rtn;
	}
	/**
	 * 查询报警条数
	 * @param query
	 * @return
	 * [
	 * 	{
	 * 		count:报警条数
	 * 	}
	 * ]
	 */
	public List<BasicMap<String, Object>> findAlarmCount(BasicMap<String, Object> query){
		List<BasicMap<String, Object>> list = new ArrayList<>();
		User user = service.getUser();
		if(user!=null){
			String orgids = user.getOrgidsByWhereIn();
			String alarmSolveCount = "select count(a.f_aid) as alarmSolveCount from jz_alarm_solve a left join jz_jzryjbxx b on a.f_aid = b.id left join jz_alarm c on a.alarmid = c.f_id where b.orgid in ("+orgids+") group by c.f_solve having c.f_solve = 1";			
			String alarmUnsolvedCount = "select count(a.f_aid) as alarmUnsolvedCount from jz_alarm_solve a left join jz_jzryjbxx b on a.f_aid = b.id left join jz_alarm c on a.alarmid = c.f_id where b.orgid in ("+orgids+") group by c.f_solve having c.f_solve = 0";
			BasicMap<String,Object> map0 = new BasicMap<>();
			map0 = dbClient.findOne(alarmSolveCount);
			if(map0 ==null) {
				map0 = new BasicMap<>();
				map0.put("alarmSolveCount", "0");
			}
			list.add(map0);
			BasicMap<String,Object> map = new BasicMap<>();
			
			map = dbClient.findOne(alarmUnsolvedCount);
			if(map ==null) {
				map = new BasicMap<>();
				map.put("alarmUnsolvedCount", "0");
			}
			
			list.add(map);
			
		
		}
		return list;
	}
	
	/**
	 * 矫正人员个人基本信息表
	 * 根据	
	 * 		个人基本信息表内的ID=个人简历内的F_AID	获取个人简历
	 * 		个人基本信息表内的ID=家庭成员及主要社会关系内的F_AID	获取家庭成员及主要社会关系
	 * @param id
	 * @return
	 */
	public BasicMap<String, Object> findOne(String id){
		String sqlstr = "select * from JZ_JZRYJBXX where id=?";//sql
		BasicMap<String, Object> basicMap = dbClient.findOne(sqlstr, id);//根据ID获取个人基本信息
		/**
		 * 根据	个人基本信息表内的ID=个人简历内的F_AID	获取个人简历
		 */
		List<BasicMap<String,Object>> grjl = dbClient.find(SupConst.Collections.JZ_SQJZRYGRJL, new SqlDbFilter().eq("f_aid", id),new RowDataListener(){
			public void processData(BasicMap<String, Object> rowData) {
				/**
				 * 处理表内相关字段的时间格式
				 */
				rowData.put("qs",  DateUtil.format(rowData.get("qs"),"yyyy-MM"));
				rowData.put("zr",  DateUtil.format(rowData.get("zr"),"yyyy-MM"));
			}
			
		});
		basicMap.put("grjl", grjl);
		/**
		 * 根据	个人基本信息表内的ID=家庭成员及主要社会关系内的F_AID	获取家庭成员及主要社会关系
		 */
		List<BasicMap<String,Object>> shgx = dbClient.find(SupConst.Collections.JZ_JTCYJZYSHGX, new SqlDbFilter().eq("f_aid", id));
		if(shgx!=null&&shgx.size()>0){
			basicMap.put("shgx", shgx);
		}
		/**
		 * 根据	个人基本信息表内的ID=禁止令信息采集表内的F_AID	获取禁止令信息
		 */
		List<BasicMap<String,Object>> jzl = dbClient.find(SupConst.Collections.JZ_JZLXXCJB, new SqlDbFilter().eq("f_aid", id),new RowDataListener(){
			public void processData(BasicMap<String, Object> rowData) {
				/**
				 * 处理禁止令信息采集表内的时间格式
				 */
				rowData.put("jzqxksrq",  DateUtil.format(rowData.get("jzqxksrq"),"yyyy-MM-dd"));
				rowData.put("jzqxjsrq",  DateUtil.format(rowData.get("jzqxjsrq"),"yyyy-MM-dd"));
			}
			
		});
		basicMap.put("jzl", jzl);
		if(basicMap!=null){//限定时间格式为：“yyyy-MM-dd”；
			//个人基本信息表
			//basicMap.put("csrq",  DateUtil.format(basicMap.get("csrq"),"yyyy-MM-dd"));
			//basicMap.put("zxtzsrq",  DateUtil.format(basicMap.get("zxtzsrq"),"yyyy-MM-dd"));
			//basicMap.put("jfzxrq",  DateUtil.format(basicMap.get("jfzxrq"),"yyyy-MM-dd"));
			//basicMap.put("sqjzksrq",  DateUtil.format(basicMap.get("sqjzksrq"),"yyyy-MM-dd"));
			//basicMap.put("sqjajsrq",  DateUtil.format(basicMap.get("sqjajsrq"),"yyyy-MM-dd"));
			basicMap.put("ypxqksrq",  DateUtil.format(basicMap.get("ypxqksrq"),"yyyy-MM-dd"));
			basicMap.put("ypxqjsrq",  DateUtil.format(basicMap.get("ypxqjsrq"),"yyyy-MM-dd"));
			basicMap.put("sqjzryjsrq",  DateUtil.format(basicMap.get("sqjzryjsrq"),"yyyy-MM-dd"));
			basicMap.put("sqjzjsrq",  DateUtil.format(basicMap.get("sqjzjsrq"),"yyyy-MM-dd"));
			basicMap.put("flwssdsj",  DateUtil.format(basicMap.get("flwssdsj"),"yyyy-MM-dd"));
			//basicMap.put("sqjzryjsrq",  DateUtil.format(basicMap.get("sqjzryjsrq"),"yyyy-MM-dd"));
			
		}
		return basicMap;
	}
	/**
	 * 全部矫正人员个人基本信息
	 * @param id
	 * @return
	 */
	public ResultList<BasicMap<String, Object>> findAll(BasicMap<String, Object> query, Paginate paginate){
		User user = service.getUser();
		ResultList<BasicMap<String, Object>> list = new ResultList<>();
		if(user!=null){
			SqlDbFilter filter = toSqlFilter(query);
			String sql = "select * from JZ_JZRYJBXX";
			filter.in("orgid", user.getOrgidSet());
			SQLAdapter sqlAdapter = new SQLAdapter(sql);
			sqlAdapter.setFilter(filter);
			list =  dbClient.find(sqlAdapter, paginate,new RowDataListener() {
				public void processData(BasicMap<String, Object> rowData) {
					rowData.put("csrq", DateUtil.format(rowData.get("csrq"),"yyyy-MM-dd"));
					rowData.put("zxtzsrq",  DateUtil.format(rowData.get("zxtzsrq"),"yyyy-MM-dd"));
					rowData.put("jfzxrq",  DateUtil.format(rowData.get("jfzxrq"),"yyyy-MM-dd"));
					rowData.put("sqjzksrq",  DateUtil.format(rowData.get("sqjzksrq"),"yyyy-MM-dd"));
					rowData.put("sqjzjsrq",  DateUtil.format(rowData.get("sqjzjsrq"),"yyyy-MM-dd"));
					rowData.put("sqjajsrq",  DateUtil.format(rowData.get("sqjajsrq"),"yyyy-MM-dd"));
					rowData.put("ypxqksrq",  DateUtil.format(rowData.get("ypxqksrq"),"yyyy-MM-dd"));
					rowData.put("ypxqjsrq",  DateUtil.format(rowData.get("ypxqjsrq"),"yyyy-MM-dd"));
					rowData.put("sqjzryjsrq",  DateUtil.format(rowData.get("sqjzryjsrq"),"yyyy-MM-dd"));
				}
			});
		}
		return list;
	} 

	

	/**
	 * 电脑端
	 * 查询一个人员一段时间的活动情况
	 * @param ｛"aid":'',"startTime":'',endTime:''｝
	 * [
	 * 	{
	 * 		f_id:报警信息id
	 * 		f_level:报警级别
	 * 		f_type:报警类型
	 * 		f_content:报警内容
	 * 		f_address:报警位置
	 * 		f_lat:经度
	 * 		f_lng:纬度
	 * 		f_score:分数
	 * 		f_aid:用户id
	 * 	}
	 * ]
	 */
	public List<BasicMap<String, Object>>  findActivity(BasicMap<String, Object> query){
		String cdate=query.get("datestr").toString().replace("-", "");
		String sqlstr = "  select a.*  from  ( select a.f_aid  aid,a.f_lat lat,a.f_lng lng,null qdlx,a.f_type,a.f_content,a.f_address  address ,a.cts,b.xm,b.xb,b.mz,b.sfzh,1 atype,a.cdate from JZ_ALARM a left join JZ_JZRYJBXX b on a.f_aid = b.id ";
				  sqlstr =sqlstr+" union all";
		          sqlstr =sqlstr+"  select a.aid,a.lat,a.lng,a.qdlx,null  f_type,null f_content,a.qdwz address,a.cts,b.xm,b.xb,b.mz,b.sfzh,2 atype,a.cdate from JZ_QDXXB a join JZ_JZRYJBXX b on a.aid = b.id ) a  where a.aid='"+query.get("aid")+"'  and cdate='"+cdate+"'   order  by cts  desc ";
		SQLAdapter sqlAdapter = new SQLAdapter(sqlstr);
		List<BasicMap<String,Object>> list = dbClient.find(sqlAdapter, new RowDataListener() {
			@Override
			public void processData(BasicMap<String, Object> rowData) {
				rowData.put("cts", DateUtil.format(rowData.get("cts"), "yyyy-MM-dd HH:mm:ss"));
				if(NumberUtil.toInt(rowData.get("xb"))==1){
					rowData.put("xb", "男");
				}else if(NumberUtil.toInt(rowData.get("xb"))==2){
					rowData.put("xb", "女");
				}
				
				if(NumberUtil.toInt(rowData.get("qdlx"))==1){
					rowData.put("jdlxm", "指纹签到");
				}
				if(NumberUtil.toInt(rowData.get("qdlx"))==2){
					rowData.put("jdlxm", "声纹签到");
				}
				if(NumberUtil.toInt(rowData.get("qdlx"))==3){
					rowData.put("jdlxm", "人脸签到");
				}
			}
		});
		return list;
	}
	/**
	 * 平板端人员选择查询结果
	 * @author 何向昕
	 * @param query
	 * @param paginate
	 * @return
	 * [
	 * 	{
	 * 		id:矫正人员id
	 * 		xm:姓名
	 * 		grlxdh:个人联系电话
	 * 		fzlx:犯罪类型
	 * 		online:是否在线(0:离线 1:在线)
	 * 	}
	 * ]
	 */
	public List<BasicMap<String, Object>> findJzryjbxx(BasicMap<String, Object> query,Paginate paginate){
		User user = service.getUser();
		List<BasicMap<String, Object>> list = new ArrayList<>();
		String sqlstr = "select jb.id,jb.xm,jb.xb,jb.sfzh,jb.grlxdh,jz.fzlx,dz.gdjzdmx,jb.online from jz_jzryjbxx jb "
				+ " left join jz_jzryjbxx_jz jz on jb.id = jz.id"
				+ " left join jz_jzryjbxx_dz dz on jb.id = dz.id";
		SqlDbFilter sqlDbFilter = toSqlFilter(query);
		sqlDbFilter.eq("jb.orgid", user.getOrgid());
		SQLAdapter salAdapter = new SQLAdapter(sqlstr);
		salAdapter.setFilter(sqlDbFilter);
		
		list = dbClient.find(salAdapter, paginate).getRows();
		return list;
	}
	
	/**
	 * 查询矫正人员社会关系、家庭成员
	 * @param aid
	 * @return
	 * [
	 * 	{
	 * 		//家庭成员
	 * 		xm:家庭成员姓名
	 * 		gx:家庭成员关系
	 * 		family_szdw:家庭成员所在单位
	 * 		lxdh:家庭成员联系电话
	 * 		jtzz:成员家庭住址
	 * 		
	 * 	}
	 * ]
	 */
	public List<BasicMap<String, Object>> findPersonRelation(String aid){
		List<BasicMap<String, Object>> list = new ArrayList<>();
		String sqlstr = "SELECT b.xm,b.gx,b.szdw AS family_szdw,b.lxdh,b.jtzz " + 
				"FROM jz_jtcyjzyshgx b  ";
		SqlDbFilter sqlDbFilter = new SqlDbFilter();
		sqlDbFilter.eq("b.f_aid", aid);
		SQLAdapter sqlAdapter = new SQLAdapter(sqlstr);
		sqlAdapter.setFilter(sqlDbFilter);
		list = dbClient.find(sqlAdapter,new RowDataListener() {
			
			@Override
			public void processData(BasicMap<String, Object> rowData) {
				String zw = StringUtil.toString(rowData.get("family_szdw"));
				String gxcode = StringUtil.toString(rowData.get("gx"));
				BasicMap<String, Object> map = dbClient.findOne("select f_name as fmgx from sys_dictionary where f_typecode = 'SYS199' and f_code = '"+ gxcode +"'");
				rowData.put("GX",StringUtil.toString(map.get("fmgx")));
				BasicMap<String, Object> map1 = dbClient.findOne("select f_name as zw from sys_dictionary where f_typecode = 'SYS090' and f_code = '"+ zw +"'");
				rowData.put("zw",StringUtil.toString(map1.get("zw")));
				
			}
		});
		return list;
	}
	
	/**
	 * 
	 * 个人简历
	 * @param aid
	 * @return<br>
	 * 返回值格式:<br>
	 *
	 * @author Administrator
	 * @date   2018年4月16日
	 * 方法的作用：TODO
		 * 		qs:起时
		 * 		zr:止日
		 * 		self_szdw:所在单位（所在地）
		 * 		zw:职务（职业）
		 *  */
	public List<BasicMap<String, Object>> findPersonRelation_jl(String aid){
		List<BasicMap<String, Object>> list = new ArrayList<>();
		String sqlstr = "select C .qs,C .zr,C .szdw AS self_szdw,C .zw from jz_sqjzrygrjl c ";
		SqlDbFilter sqlDbFilter = new SqlDbFilter();
		sqlDbFilter.eq("c.f_aid", aid);
		SQLAdapter sqlAdapter = new SQLAdapter(sqlstr);
		sqlAdapter.setFilter(sqlDbFilter);
		list = dbClient.find(sqlAdapter, new RowDataListener() {
			@Override
			public void processData(BasicMap<String, Object> rowData) {
				rowData.put("qs", DateUtil.format(rowData.get("qs"), "yyyy-MM-dd"));
				rowData.put("zr", DateUtil.format(rowData.get("zr"), "yyyy-MM-dd"));
			}
		});
		return list;
	}
	
	/**
	 * 查询当前矫正人员矫正方案
	 * @param aid
	 * @return
	 * [
	 * 	{
	 * 		dxqkfx:矫正对象情况分析
	 * 		jzfanr:矫正方案内容
	 * 	}
	 * ]
	 */
	public BasicMap<String, Object> findCorrectProgramme(String aid){
		BasicMap<String, Object> basicMap = new BasicMap<>();
		String sqlstr = "select dxqkfx,jzfanr from jz_jzfaxx";
		SqlDbFilter sqlDbFilter = new SqlDbFilter();
		sqlDbFilter.eq("faid", aid);
		SQLAdapter sqlAdapter = new SQLAdapter(sqlstr);
		sqlAdapter.setFilter(sqlDbFilter);
		basicMap = dbClient.findOne(sqlAdapter);
		return basicMap;
	}
	
	/**
	 * 查询矫正小组成员信息
	 * @param aid
	 * @return
	 * [
	 * 	{
	 * 		xzcylx:小组成员类型 
	 * 		xzcylb:小组成员类别 
	 * 		xm:姓名 
	 * 		gzdw:工作单位 
	 * 		sj:手机 
	 * 	}
	 * ]
	 */
	public List<BasicMap<String, Object>> findGroup(String aid){
		List<BasicMap<String, Object>> list = new ArrayList<>();
		String sqlstr = "select xzcylx,xzcylb,xm,gzdw,sj from jz_jzxzcy";
		SqlDbFilter sqlDbFilter = new SqlDbFilter();
		sqlDbFilter.eq("f_aid", aid);
		SQLAdapter sqlAdapter = new SQLAdapter(sqlstr);
		sqlAdapter.setFilter(sqlDbFilter);
		list = dbClient.find(sqlAdapter);
		return list;
	}
	/**
	 * 查看当前矫正人员法律文书照片id
	 * @param id
	 * @return
	 */
	public List<BasicMap<String, Object>> findLegalInstrument(String id,String f_code){
		List<BasicMap<String, Object>> list = new ArrayList<>();
		String sqlstr = "select imgid from jz_jzryflws_img";
		SQLAdapter sqlAdapter = new SQLAdapter(sqlstr);
		SqlDbFilter sqlDbFilter = new SqlDbFilter();
		sqlDbFilter.eq("f_aid", id)
		.eq("wslx", f_code);
		sqlAdapter.setFilter(sqlDbFilter);
		list = dbClient.find(sqlAdapter);
		return list;
	}
	
	/**
	 * 法律文书 删除图片
	 */
	public void deleteImg(String id) {
		dbClient.remove(SupConst.Collections.JZ_JZRYFLWS_IMG, new SqlDbFilter().eq("imgid", id));
	}
	
}
