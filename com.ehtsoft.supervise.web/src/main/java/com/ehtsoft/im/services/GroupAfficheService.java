package com.ehtsoft.im.services;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ehtsoft.common.services.SSOService;
import com.ehtsoft.fw.core.db.SQLAdapter;
import com.ehtsoft.fw.core.db.SqlDbClient;
import com.ehtsoft.fw.core.db.SqlDbFilter;
import com.ehtsoft.fw.core.dto.BasicMap;
import com.ehtsoft.fw.core.sso.User;
import com.ehtsoft.fw.core.utils.ReflectUtil;
import com.ehtsoft.fw.utils.NumberUtil;
import com.ehtsoft.fw.utils.StringUtil;
import com.ehtsoft.im.api.ImConst;
import com.ehtsoft.im.dto.GroupAffiche;
import com.ehtsoft.im.protocol.IMProtocol;
import com.ehtsoft.im.protocol.Message;
import com.ehtsoft.supervise.api.SupConst;

import oracle.net.aso.l;

import com.ehtsoft.im.protocol.IMProtocol.PGFlag;

/**
 * 群主公共服务
 * @author wangbao
 */
@Service("GroupAfficheService")
public class GroupAfficheService {

	@Resource(name="sqlDbClient")
	private SqlDbClient dbClient;
	
	@Resource
	private SSOService ssoService;
	
	@Resource
	private IMSService imsService;
	
	//字段前缀
	private String fieldPrefix = "f_";
	
	/**
	 * 发布并保存群公告信息
	 * @param affiche
	 */
	public void save(GroupAffiche affiche){
		User user = ssoService.getUser();
		BasicMap<String,Object> data = ReflectUtil.bean2Map(affiche, fieldPrefix);
		dbClient.save(ImConst.Collections.IM_GROUP_AFFICHE,data);
		String sqlstr = "select f_aid from IM_GROUP_USER where f_gid = '"+StringUtil.toEmptyString(data.get("f_gid"))+"'";
		SQLAdapter sqlAdapter = new SQLAdapter(sqlstr);
		List<BasicMap<String, Object>> list = dbClient.find(sqlAdapter);
		for(int i=0;i<list.size();i++){
			BasicMap<String, Object> query = (BasicMap<String, Object>)list.get(i);
			query.put("f_gaid", data.get("f_id"));
			dbClient.insert(SupConst.Collections.JZ_TZNRGLB, query);
		}
		String content = affiche.getContent();
		Message message = IMProtocol.wrap(IMProtocol.Type.TEXT, content.getBytes());
		message.setMessageId(StringUtil.toString(data.get("f_id")));
		message.setFrom(user.getAid());
		message.setTo(affiche.getGid());
		message.setGid(StringUtil.toString(affiche.getGid()));
		int type = NumberUtil.toInt(affiche.getType());
		//发送类型 群中的类型
		message.setPgFlag(new PGFlag(type));
		imsService.sendMessage(message);
	}
	
	/**
	 * 更新通知确认标志（确认为已接受）
	 */
	public void updateStatus(String aid,String afficheId){
		dbClient.updateSql("UPDATE JZ_TZNRGLB SET F_STATUS = '1' WHERE F_AID = ? AND F_GAID = ?", aid,afficheId);
	}
	
	/**
	 * 删除该公告信息
	 * @param affiche
	 */
	public void remove(String id){
		dbClient.remove(ImConst.Collections.IM_GROUP_AFFICHE, new SqlDbFilter().eq("F_ID", id));
	}
	
	/**
	 * 请求发送的公告
	 * android
	 * 当手机及平板的 app 卸载后，本地的数据将删除掉，重新安装后，手机所在的会话就不存在了
	 * 手机登录后，判断没有历史会话数据的时候，向服务器端请求其会话数据，服务器根据请求发送手机及平板端
	 * （
	 *  临时解决方案，正常情况下，是将会话信息从平台下载到手机端的，
	 *  因为会话的id 通过 android 手机端 md5 后，前端和后端的 md5 值不一样
	 *  以后通过手机及平板的点对点的 md5 生成的值放到 gid 位置，来解决后台存储问题
	 * ）
	 * @param aid
	 */
	public void sendAffiche(String aid){
		User user = ssoService.getUser();
		/**
		 * 群组分 5种类型，前四种类型 分别为：司法厅，司法局，区县司法局，司法所，
		 * 前四种类型的 IM_GROUP.F_GID 值为机构的主键信息（orgid），群主默认为当前机构的主键
		 */
		//F_TYPE  3 群公告  4 注册通知  5 集中教育通知  6 集中服务通知
		SqlDbFilter filter = new SqlDbFilter();
		filter.eq("F_TYPE", 3);
		// 0 公众账号（矫正人员）  1 平台工作人员账号 ， 2 机构账号 ，
		if(user.getFlag() != 0){
			filter.eq("F_GID", user.getOrgid()).asc("CTS");
		}else{
			// = 0 给矫正人员发送
			filter.in("F_GID", "select f_gid from im_group_user where f_aid = '"+aid+"'");
		}
		List<BasicMap<String,Object>> list = dbClient.find(ImConst.Collections.IM_GROUP_AFFICHE,filter);
		if(!list.isEmpty()){
			for(BasicMap<String,Object> bm : list){
				String content = StringUtil.toEmptyString(bm.get("F_CONTENT"));
				Message message = IMProtocol.wrap(IMProtocol.Type.TEXT, content.getBytes());
				message.setFrom(StringUtil.toString(bm.get("F_GID")));
				message.setTo(aid);
				message.setGid(StringUtil.toString(bm.get("F_GID")));
				int type = NumberUtil.toInt(bm.get("F_TYPE"));
				//发送类型 群中的类型
				message.setPgFlag(new PGFlag(type));
				message.setGroupToOneFlag();
				imsService.sendMessage(message);
			}
		}else{
			
		}
	}
	
	/**
	 * 查看群信息
	 * @return
	 * [
	 * 	{
	 * 		F_GID:主键
	 * 		F_NAME:群组名
	 * 		F_AID:群主ID
	 * 		F_TYPE:群类型
	 * 	}
	 * ]
	 */
	public List<BasicMap<String, Object>> findGroup(){
		User user = ssoService.getUser();
		String sqlstr = "select * from IM_GROUP";
		SQLAdapter sqlAdapter = new SQLAdapter(sqlstr);
		sqlAdapter.getFilter().in("ORGID", user.getOrgidSet());
		return dbClient.find(sqlAdapter);
	}
}
