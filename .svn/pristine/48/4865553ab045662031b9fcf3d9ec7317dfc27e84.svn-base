package com.ehtsoft.im.services;

import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ehtsoft.common.services.SSOService;
import com.ehtsoft.fw.core.annotation.NotGeneratedJs;
import com.ehtsoft.fw.core.context.AppException;
import com.ehtsoft.fw.core.db.SQLAdapter;
import com.ehtsoft.fw.core.db.SqlDbClient;
import com.ehtsoft.fw.core.db.SqlDbFilter;
import com.ehtsoft.fw.core.dto.BasicMap;
import com.ehtsoft.fw.core.dto.Paginate;
import com.ehtsoft.fw.core.sso.User;
import com.ehtsoft.fw.core.utils.ReflectUtil;
import com.ehtsoft.fw.utils.DateUtil;
import com.ehtsoft.fw.utils.NumberUtil;
import com.ehtsoft.fw.utils.StringUtil;
import com.ehtsoft.fw.utils.Util;
import com.ehtsoft.im.api.ImConst;
import com.ehtsoft.im.api.ProxyApiFactory;
import com.ehtsoft.im.api.SMS;
import com.ehtsoft.im.dto.Userinfo;
import com.ehtsoft.im.protocol.Command;
import com.ehtsoft.im.protocol.CommandType;
import com.ehtsoft.supervise.api.SupConst;
import com.ehtsoft.supervise.utils.ParameterUtil;

/**
 * 消息用户信息服务
 * @author wangbao
 */
@NotGeneratedJs
@Service("UserinfoService")
public class UserinfoService {

	@Resource(name="sqlDbClient")
	private SqlDbClient dbClient;
	
	@Resource
	private GroupService groupService;
	
	@Resource
	private SSOService ssoService;
	
	@Resource
	private GroupAfficheService afficheService;
	
	@Resource
	private IMSService broadcastService;
	
	
	private String fieldPrefix = "F_";
	
	/**
	 * 
	 * TODO(根据 code 返回 name)
	 * @param code
	 * @return<br>
	 * 返回值格式:String
	 *
	 * @author Administrator
	 * @date   2018年3月15日
	 * 方法的作用：获取网易云的用户名
	 */
	public String findNameByCode(String code) {
		String sqlstr="select F_NICKNAME from IM_USERINFO where F_CODE = ? ";
		BasicMap<String,Object> one = dbClient.findOne(sqlstr, code);
		String rtn = "";
		if(one!=null){
			rtn = StringUtil.toEmptyString(one.get("F_NICKNAME"));
		}
		return rtn;

	}
	
	
	
	/**
	 * 根据用户登录账号获取用户信息
	 * @param accountId
	 * @return
	 */
	public User findOne(String accountId ){
		User rtn = null;
		BasicMap<String,Object> bm = dbClient.findOne("SELECT * FROM IM_USERINFO_ACCOUNT WHERE F_ACCOUNTID = ?", accountId);
		if(bm!=null){
			String aid = StringUtil.toString(bm.get("f_aid"));
			BasicMap<String,Object> one = dbClient.findOne("SELECT F_AID,F_CODE,F_GENDER,F_NICKNAME,F_PASSWORD,F_DISABLE,F_FLAG FROM IM_USERINFO WHERE F_AID = ?", aid);
			if(one==null){
				return null;
			}
			rtn = new User();
			rtn.setAccountid(accountId);
			rtn.setAid(StringUtil.toString(one.get("F_AID")));
			rtn.setCode(StringUtil.toString(one.get("F_CODE")));
			rtn.setName(StringUtil.toString(one.get("F_NICKNAME")));
			rtn.setNickname(StringUtil.toString(one.get("F_NICKNAME")));
			rtn.setPassword(StringUtil.toString(one.get("F_PASSWORD")));
			
			//标识：0 矫正人员  1 工作人员  2 机构
			int flag = NumberUtil.toInt(one.get("F_FLAG"));
			rtn.setFlag(flag);
			if(flag == 1){ //工作人员登录的时候，需要给工作人员赋值上级所属的机构id 及 编码
				//登录人员所在机构 ---- 以下为测试机构的数据
				rtn.setOrgid("00000000-0000-0000-0000-000000000004");
				rtn.setOrgcode("15010201");
			}
		}
		return rtn;
	}
	
	/**
	 * 根据人员 aid 获取用户信息
	 * @param aid
	 * @return
	 * 
	 * android
	 */
	public Userinfo findUserinfo(String aid){
		BasicMap<String,Object> one = dbClient.findOne("SELECT * FROM IM_USERINFO WHERE F_AID = ?", aid);
		if(one!=null){
			return ReflectUtil.map2Bean(one, Userinfo.class, fieldPrefix);
		}
		return null;
	}
	
	/**
	 * 获取工作人员信息，默认为当前司法所的用户
	 * （司法所权限暂时不考虑）
	 * @param query
	 * @param paginate
	 * @return
	 * android 平板端
	 */
	public List<BasicMap<String,Object>> findUserinfo(String query,Paginate paginate){
		query = SqlDbFilter.convertSqlParameter(query);
		String sqlstr = "select F_AID,F_NICKNAME,C.JGMC AS ORGNAME,Lower(F_CODE) as F_CODE from IM_USERINFO A"
				+ " INNER JOIN JC_SFXZJGGZRYJBXX B ON A.F_AID = B.ID"
				+ " INNER JOIN JC_SFXZJGJBXX C ON B.ORGID = C.ID"
				+ " WHERE ( F_NICKNAME like '%"+query+"%' ) and F_FLAG = 1";
		List<BasicMap<String, Object>> list = dbClient.find(new SQLAdapter(sqlstr), paginate).getRows() ;
		return list;
	}
	/**
	 * 发送验证码（密码）
	 * @param aid 服刑人员ID
	 * @param tel 服刑人员手机号
	 */
	public void sendPassword(String aid,String tel){
		User user = ssoService.getUser();
		BasicMap<String,Object> bm = dbClient.findOne("SELECT ID,SQJZRYBH,XM,XB,GRLXDH FROM " + SupConst.Collections.JZ_JZRYJBXX + " WHERE ID = ?",aid);
		if(bm!=null){
			if(Util.isEmpty(tel)){
				throw new AppException("手机号不能为空");
			}
			if(!StringUtil.isMobileNum(tel)){
				throw new AppException("手机号码格式不正确");
			}
			BasicMap<String,Object> uacc = dbClient.findOne("SELECT * FROM IM_USERINFO_ACCOUNT WHERE F_ACCOUNTID = ?",tel);
			if(uacc==null){
				uacc = new BasicMap<String,Object>();
			}else{
				// 手机号已经存在的时候（已经被注册上去了，判断当前手机号对应的 aid 是不是同一个人，如果是同一个人，表示重新注册，如果不是同一个人，提醒手机号已经被注册）
				String f_aid = StringUtil.toEmptyString(uacc.get("F_AID"));
				if(!f_aid.equals(aid)){//不想的
					BasicMap<String,Object> tmp = dbClient.findOne("select * from IM_USERINFO where F_AID = ?",f_aid);
					if(tmp!=null){
						throw new AppException("手机号 " + tel  + " 已经被【"+StringUtil.toEmptyString(tmp.get("F_NICKNAME"))+"】注册");
					}else{
						throw new AppException("手机号 " + tel  + " 已经被注册");
					}
				}
			}
			// 发送密码的同时初始化 账号信息
			String random = StringUtil.getRandomNumber(6);
			BasicMap<String,Object> data = new BasicMap<String,Object>();
			//f_aid,f_nickname,f_password,f_code,f_gender
			data.put("f_aid", aid);
			data.put("f_code", bm.get("SQJZRYBH"));
			data.put("f_gender", bm.get("XB"));
			data.put("f_nickname", bm.get("XM"));
			data.put("f_password", random);
			dbClient.save(ImConst.Collections.IM_USERINFO, data);
		
			uacc.put("F_AID", aid);
			uacc.put("F_ACCOUNTID", tel);
			dbClient.save(ImConst.Collections.IM_USERINFO_ACCOUNT, uacc);
			
			/*
			BasicMap<String,Object> group = new BasicMap<>();
			String fgid = MD5Util.encrypt(user.getAid().getBytes());
			//主键
			group.put("F_GID",fgid+"0000");
			//群组名
			group.put("F_NAME", "登记报到管理组");
			//群主ID
			group.put("F_AID", user.getAid());
			//群类型(司法所工作组)
			group.put("F_TYPE",GroupType.GROUP_TYPE_STATION_WORK);
			dbClient.save(ImConst.Collections.IM_GROUP,group);
			*/
			
			BasicMap<String,Object> owner = new BasicMap<>();
			String gid = user.getOrgid();
			//群组信息ID
			owner.put("F_GID", gid);
			//群成员ID
			owner.put("F_AID", user.getAid()); //当前登录用户（管理人员）
			//成员类型：0 普通成员 1 管理员  2 群主
			owner.put("F_TYPE", 2);
			//成员备注名
			owner.put("F_NAME", user.getNickname());
			dbClient.save(ImConst.Collections.IM_GROUP_USER, owner);
			BasicMap<String,Object> jzusr = new BasicMap<>();
			jzusr.put("F_GID", gid);
			jzusr.put("F_AID", aid);
			jzusr.put("F_TYPE", 0);
			jzusr.put("F_NAME", bm.get("XM"));
			dbClient.save(ImConst.Collections.IM_GROUP_USER, jzusr);
			
			//初始化公告信息
			BasicMap<String,Object> affiche = new BasicMap<String,Object>();
			affiche.put("F_ID", gid);
			affiche.put("F_GID", gid);
			String content = ParameterUtil.getParameter(dbClient).get(SupConst.ParameterKey.KEY_SYSTEM_008).getValue();
			if(Util.isEmpty(content)){
				affiche.put("F_CONTENT","注册成功");
			}else{
				affiche.put("F_CONTENT", content);
			}
			affiche.put("F_TYPE", 4); //3 群公告  4 注册通知  5 集中教育通知  6 集中服务通知
			dbClient.save(ImConst.Collections.IM_GROUP_AFFICHE, affiche);
			
			//初始化到好友表中
			BasicMap<String,Object> friend = new BasicMap<>();
			friend.put("f_aid0", aid);
			friend.put("f_aid1", user.getAid());
			dbClient.save(ImConst.Collections.IM_USERINFO_FRIEND, friend);
			friend.put("f_aid0", user.getAid());
			friend.put("f_aid1", aid);
			dbClient.save(ImConst.Collections.IM_USERINFO_FRIEND, friend);
			
			if(!tel.equals(bm.get("GRLXDH"))){ //个人电话不相等的时候，更新其电话号码
				dbClient.updateSql("UPDATE JZ_JZRYJBXX SET GRLXDH = ?  WHERE ID = ?",tel,aid);
			}
			
			BasicMap<String,Object> collect = new BasicMap<>();
			collect.put("F_ID", aid);//矫正人员AID
			collect.put("F_AID", user.getAid());//矫正管理人员 aid
			dbClient.save(SupConst.Collections.JZ_COLLECT_USER, collect);
			
			String text = "密码验证码："+random;
			ProxyApiFactory.getInstance().sendMessage(tel, text);
		}
	}

	/**
	 * 批量发送验证码（密码）
	 * @param senders 服刑人员数组
	 * [
	 * 	{aid:"服刑人员ID",tel:"服刑人员手机号"}
	 * ]
	 */
	public void sendPassword(List<BasicMap<String,Object>> senders){
		StringBuffer sBuffer = new StringBuffer();
		for(BasicMap<String,Object> bm : senders) {
			if(Util.isNotEmpty(bm.get("aid")) && Util.isNotEmpty(bm.get("tel"))) {
				String aid = StringUtil.toString(bm.get("aid"));
				String tel = StringUtil.toString(bm.get("tel"));
				try{
					sendPassword(aid,tel);
				}catch(AppException ex){
					sBuffer.append(ex.getMessage()+"<br>");
				}
			}
		}
		if(sBuffer.length()>0){
			throw new AppException(sBuffer.toString());
		}
	}
	/**
	 * 手机端修改密码
	 * @param data
	 */
	public boolean updatePassword(BasicMap<String, Object> data){
		boolean rtn = false;
		BasicMap<String, Object> oldData = dbClient.findOne("select f_password from im_userinfo where f_aid = ?", StringUtil.toEmptyString(data.get("aid")));
		String oldPassword = StringUtil.toEmptyString(oldData.get("f_password"));
		if(oldPassword.equals(data.get("oldPassword"))){
			dbClient.updateSql("update im_userinfo set f_password = ? where f_aid = ?", data.get("newPassword1"),data.get("aid"));
			rtn = true;
		}
		return rtn;
	}
	
	/**
	 * 删除报道人员对应的关系性数据表
	 */
	public void removeArrivalUser(String aid){
		String deleteSql1 = "delete from JZ_COLLECT_USER where F_ID = ?";
		String deleteSql2 = "delete from IM_USERINFO_FRIEND where f_aid0 = ? or f_aid1 = ?";
		String deleteSql3 = "delete from IM_GROUP_USER where F_AID = ?";
		String deleteSql4 = "delete from IM_USERINFO_ACCOUNT where F_AID = ?";
		String deleteSql5 = "delete from IM_USERINFO where F_AID = ?";
		String deleteSql6 = "UPDATE JZ_JZRYJBXX SET BDQK = ? WHERE ID = ?";
		
		dbClient.updateSql(deleteSql1, aid);
		dbClient.updateSql(deleteSql2, aid,aid);
		dbClient.updateSql(deleteSql3, aid);
		dbClient.updateSql(deleteSql4, aid);
		dbClient.updateSql(deleteSql5, aid);
		dbClient.updateSql(deleteSql6,"0",aid);
	}
	
	/**
	 * 人员报到完成(网页调用)
	 * @param aid
	 */
	public void updateArrivalUser(String aid) {
		//获取aid, F_FINGER, F_FACE, F_VOICE
		BasicMap<String,Object> one = dbClient.findOne("SELECT F_FINGER,F_FACE,F_VOICE FROM JZ_COLLECT_USER WHERE  F_ID = ?",aid);
		if(one!=null) {
			int finger = NumberUtil.toInt(one.get("F_FINGER"));
			int face = NumberUtil.toInt(one.get("F_FACE"));
			int voice = NumberUtil.toInt(one.get("F_VOICE"));
			updateArrivalUser(aid,finger,face,voice);
		}
	}
	/**
	 * @param aid
	 * @param status<br>
	 * 1 人脸识别   2 声纹识别   3  指纹识别
	 *
	 * @author wangbao
	 * @date   2018年3月30日
	 * 方法的作用：TODO
	 */
	public void updateCollectStatus(String aid,Integer status){
		if(NumberUtil.toInt(status)==1){
			// 1 人脸识别 
			dbClient.updateSql("UPDATE JZ_COLLECT_USER SET F_FACE = 1 WHERE F_ID = ?", aid);
		}
		if(NumberUtil.toInt(status)==2){
			// 2 声纹 
			dbClient.updateSql("UPDATE JZ_COLLECT_USER SET F_VOICE = 1 WHERE F_ID = ?", aid);
		}
		if(NumberUtil.toInt(status)==3){
			// 3 指纹
			dbClient.updateSql("UPDATE JZ_COLLECT_USER SET F_FINGER = 1 WHERE F_ID = ?", aid);
		}
	}
	/**
	 * 人员报到完成(平板调用)
	 * @param aid
	 */
	public void updateArrivalUser(String aid,Integer F_FINGER,Integer F_FACE,Integer F_VOICE){
		// 01 : 按时报道  02:超出规定时限报到  03:未报到且下落不明
		String bdqk = "01";
		
		BasicMap<String, Object> jzryjbxx=dbClient.findOne("select SQJZRYJSRQ  from  JZ_JZRYJBXX_JZ  WHERE ID = ?",aid);
		if(jzryjbxx!=null && Util.isNotEmpty(jzryjbxx.get("SQJZRYJSRQ"))){
			//获取报道期限设置：
			String value = ParameterUtil.getParameter(dbClient).get(SupConst.ParameterKey.KEY_SYSTEM_007).getValue();
			Calendar ca= new GregorianCalendar();
			if(jzryjbxx.get("SQJZRYJSRQ") instanceof Date){
				if(DateUtil.subtractOfDay(ca.getTime(),(Date)jzryjbxx.get("SQJZRYJSRQ")) > NumberUtil.toInt(value)){
					bdqk = "02";
				}
			}
		}
		
		dbClient.updateSql("UPDATE JZ_JZRYJBXX SET BDQK = ?,SFCJ = ? WHERE ID = ?",bdqk,1,aid);
		dbClient.updateSql("UPDATE JZ_COLLECT_USER set F_STATUS = 1,F_FINGER = ?,F_FACE = ?,F_VOICE = ? WHERE F_ID = ?",F_FINGER,F_FACE,F_VOICE,aid);
		
		//向手机端发送注册公告信息
		afficheService.sendAffiche(aid);
		groupService.sendGroupNotify(aid);
	}
	
	public BasicMap<String, Object> getCollectStatus(String aid){
		String sqlstr = "select f_status,f_finger,f_face,f_voice from jz_collect_user where f_id = ?";
		BasicMap<String, Object> one = dbClient.findOne(sqlstr,aid);
		if(one==null){
			one = new BasicMap<String, Object>();
			one.put("f_status", 0);
			one.put("f_finger", 0);
			one.put("f_face", 0);
			one.put("f_voice", 0);
		}
		return one;
	}
	/**
	 * 判断是否显示矫正人员信息采集页面
	 * @param aid
	 * @return false:数据库不存在该矫正人员数据模型 true:存在数据模型
	 */
	public boolean isInitCorrect(String aid){
		boolean rtn = false;
		if(aid!=null){
			BasicMap<String, Object> data = dbClient.findOne("select F_STATUS from JZ_COLLECT_USER where F_ID = ?", aid);
			if(data!=null && NumberUtil.toInt(data.get("F_STATUS"))==1){
				rtn = true;
			}
		}
		return rtn;
	}
	
	/**
	 * 平板端发送消息重置矫正人员采集的信息
	 * @param aid 矫正人员id
	 */
	public void resetCorrect(String aid){
		User user = ssoService.getUser();
		BasicMap<String, Object> data = new BasicMap<>();
		data.put("f_aid", aid);
		Command command = new Command();
		command.setTo(aid);
		if(user!=null){
			command.setFrom(user.getAid());
		}
		command.setCommand(CommandType.COMMAND_RESET_CORRECT_COLLECT);
		dbClient.updateSql("UPDATE JZ_COLLECT_USER set F_STATUS = 0,F_FINGER = 0,F_FACE = 0,F_VOICE = 0"
				+ " WHERE F_ID = ?", aid);
		dbClient.updateSql("UPDATE JZ_JZRYJBXX SET SFCJ = ? WHERE ID = ?", 0,aid);
		dbClient.remove("sys_face_img", new SqlDbFilter().eq("imgid", aid));
		broadcastService.sendCommand(command);
	}
	
	/**
	 * 
	 * @param sid
	 * @return<br>
	 * 返回值格式:String
	 *
	 * @author Administrator
	 * @date   2018年3月15日
	 * 方法的作用：获取网易云的code
	 */
	public String getNeteaseCode(String sid) {
		BasicMap<String,Object> one = dbClient.findOne("select F_CODE FROM IM_USERINFO WHERE F_AID = ?",sid);
		return StringUtil.toEmptyString(one.get("F_CODE"));
	}
	/**
	 * 手机端获取矫正管理人员的 id
	 * @param aid  矫正人员ID
	 * @return
	 */
	public String getJzglryId(String aid){
		String sqlstr = "SELECT F_AID FROM JZ_COLLECT_USER WHERE F_ID = ?";
		BasicMap<String,Object> one = dbClient.findOne(sqlstr, aid);
		String rtn = "";
		if(one!=null){
			rtn = StringUtil.toEmptyString(one.get("F_AID"));
		}
		return rtn;
	}
}
