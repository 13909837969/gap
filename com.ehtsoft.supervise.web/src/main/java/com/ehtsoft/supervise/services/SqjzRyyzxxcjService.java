package com.ehtsoft.supervise.services;

import java.util.ArrayList;
import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.ehtsoft.common.services.SSOService;
import com.ehtsoft.fw.core.context.AppException;
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
import com.ehtsoft.fw.utils.NumberUtil;
import com.ehtsoft.fw.utils.StringUtil;
import com.ehtsoft.fw.utils.Util;
import com.ehtsoft.im.api.SMS;
import com.ehtsoft.im.services.UserinfoService;

/**
 * 社区矫正-服刑人员验证信息采集
 * @author huazhuo
 *
 */
@Service("SqjzRyyzxxcjService")
public class SqjzRyyzxxcjService extends AbstractService{
	private static final Object F_ID = null;

	@Resource(name="sqlDbClient")
	private SqlDbClient dbClient;
	
	@Resource(name="UserinfoService")
	private UserinfoService uService;
	
	@Resource(name="SSOService")
	private SSOService ssoservice;
	
	
	@Resource(name="FormSimpleServise")
	private FormSimpleServise FormSimpleServise;
	
	/**
	 * 获取人员采集信息
	 * @param data
	 * @return
	 * {
	 * 	[
	 * 		矫正人员ID		F_ID
	 * 		矫正管理人员ID	F_AID
	 * 		总采集状态		F_STATUS		1 采集完成   0未采集
	 * 		指纹参加状态	F_FINGER	
	 * 		人脸采集状态	F_FACE
	 * 		声纹采集状态	F_VOICE
	 * 	]
	 * }
	 * 
	 */
	public BasicMap<String,Object> findCaijiXx(BasicMap<String,Object> data){
		User user = ssoservice.getUser();
		String sql = "SELECT f_id,f_aid,f_status,f_finger,f_face,f_voice FROM JZ_COLLECT_USER WHERE f_id=?";
		BasicMap<String,Object> cx = dbClient.findOne(sql,data);
		return cx;	
	}
	
	/**
	 * 查询采集信息    
	 */
	public ResultList<BasicMap<String,Object>> findcj(BasicMap<String,Object> data,Paginate paginate){
		User user = ssoservice.getUser();
		ResultList<BasicMap<String, Object>> cx = new ResultList<>();
		if(user != null){
			SqlDbFilter filter = toSqlFilter(data);
			String sql="SELECT A.ID,A.SQJZRYBH,A.XM,A.CYM,A.XB,A.MZ,A.SFZH,A.CSRQ,A.SFCN,A.WCN,A.JGLX,A.WHCD,"
					+ "A.HYZK,A.GRLXDH,A.SFSWRY,A.PQZY,A.JYJXQK,A.XZZMM,A.YZZMM,A.YGZDW,A.XGZDW,A.DWLXDH,A.QTLXFS,"
					+ "a.orgid, b.f_id,b.f_aid,b.f_status,b.f_finger,b.f_face,b.f_voice,c.orgname FROM JZ_JZRYJBXX A "
					+ "LEFT JOIN JZ_COLLECT_USER b ON A .id = b.f_id "
					+ "left join view_rep_jzrys c on a.orgid = c.orgid ";
			SQLAdapter sqlAdapter = new SQLAdapter(sql);
			if(Util.isNotEmpty(data.get("f_status"))){
				filter.eq("b.f_status",NumberUtil.toInt(data.get("f_status")));
			}
			filter.in("a.orgid",user.getOrgidSet());
			filter.unEq("a.jcjz", "1");
			sqlAdapter.setFilter(filter);
			cx=dbClient.find(sqlAdapter,paginate,new RowDataListener() {
				@Override
				public void processData(BasicMap<String, Object> rowData) {
					rowData.put("csrq", DateUtil.format(rowData.get("csrq"), "yyyy-MM-dd"));
				}
			});
		}
		
		return cx;
	}
	
	
	/**
	 * 新增矫正人员信息
	 * @param data 新增矫正人员信息
	 */
	
	public void saveJzry(BasicMap<String,Object> data) {
		FormSimpleServise.save(data);
	}
	
	
	/**
	 * 查询F_id设置人脸采集信息
	 */
	public BasicMap<String,Object> findRlxx(BasicMap<String, Object> data){
		String sql="select IMGID from SYS_FACE_IMG";
		SqlDbFilter filter = toSqlFilter(data);
		SQLAdapter sqlAdapter = new SQLAdapter(sql);
		filter.eq("imgid",data);
		BasicMap<String, Object> rl=dbClient.findOne(sqlAdapter);
		return rl;
		
	}
	
	
	/**
	 * 发送验证码（密码）
	 * @param aid 服刑人员ID
	 * @param tel 服刑人员手机号
	 */
	public void sendPassword(String aid,String tel){
		uService.sendPassword(aid, tel);
	}
	
	/**
	 * 批量发送验证码（密码）
	 * @param senders 服刑人员数组
	 * [
	 * 	{aid:"服刑人员ID",tel:"服刑人员手机号"}
	 * ]
	 */
	public void sendPassword(List<BasicMap<String,Object>> senders){
		uService.sendPassword(senders);
	}
	
	/**
	 * 重置采集
	 * @param aid
	 */
	public void resetCorrect(String aid){
		uService.resetCorrect(aid);
	}
	
	/**
	 * 点击完成功能（网页）
	 * @param aid
	 */
	 public void updateArrivalUser(String aid) {
		 uService.updateArrivalUser(aid);
	 }
	 /**
	  * 查询一个人的签到信息
	  * @param id
	  * @return
	  */
	 public BasicMap<String, Object> findOne(String id){
		 String sql = "SELECT A.ID,A.XM,A.XB,A.GRLXDH,b.f_status,b.f_finger,b.f_face,b.f_voice FROM JZ_JZRYJBXX A LEFT JOIN JZ_COLLECT_USER b ON A .id = b.f_id where a.id='"+id+"'";
		 SQLAdapter adapter = new SQLAdapter(sql);
		 return dbClient.findOne(adapter);
	 }
	 /**
	  * 查询所有司法所
	  * @return
	  */
	 public List<BasicMap<String, Object>> findJg(){
		 User user = ssoservice.getUser();
		 String parentid = user.getOrgid();
		 List<BasicMap<String, Object>> map = new ArrayList<>();
		 if(user != null){
			 String sql = "select id,jgmc from jc_sfxzjgjbxx s where s.parentid='"+parentid+"' and jgmc like'%司法所'";
			 SQLAdapter adapter = new SQLAdapter(sql);
			 map = dbClient.find(adapter);
			 if(map.size() == 0){
				 String sqlsfs = "select id,jgmc from jc_sfxzjgjbxx s where s.id='"+parentid+"' and jgmc like'%司法所'";
				 SQLAdapter adaptersfs = new SQLAdapter(sqlsfs);
				 map = dbClient.find(adaptersfs);
			 }
		 }
		 return map ;
	 }
	 /**
	  * 验证手机号是否被注册
	  * @param tel
	  */
	 public BasicMap<String, Object> sendpdSjh(String tel){
		 BasicMap<String,Object> uacc = dbClient.findOne("SELECT * FROM IM_USERINFO_ACCOUNT WHERE F_ACCOUNTID = ?",tel);
			if(uacc==null){
				uacc = new BasicMap<String,Object>();
			}
			// 手机号已经存在的时候（已经被注册上去了，判断当前手机号对应的 aid 是不是同一个人，如果是同一个人，表示重新注册，如果不是同一个人，提醒手机号已经被注册）
			String f_aid = StringUtil.toEmptyString(uacc.get("F_AID"));
			BasicMap<String,Object> tmp = dbClient.findOne("select * from IM_USERINFO where F_AID = ?",f_aid);
			if(tmp!=null){
				tmp.put("yzc", "手机号 " + tel  + " 已经被【"+StringUtil.toEmptyString(tmp.get("F_NICKNAME"))+"】注册");
			}else{
				throw new AppException("手机号 " + tel  + " 已经被注册");
			}
			return tmp;
			
			
	 }
}