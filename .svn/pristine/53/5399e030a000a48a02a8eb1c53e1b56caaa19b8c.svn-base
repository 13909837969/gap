package com.ehtsoft.im.services;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import com.ehtsoft.common.services.SSOService;
import com.ehtsoft.fw.core.context.AppException;
import com.ehtsoft.fw.core.db.RowDataListener;
import com.ehtsoft.fw.core.db.SQLAdapter;
import com.ehtsoft.fw.core.db.SqlDbClient;
import com.ehtsoft.fw.core.db.SqlDbFilter;
import com.ehtsoft.fw.core.dto.BasicMap;
import com.ehtsoft.fw.core.sso.User;
import com.ehtsoft.fw.core.utils.ReflectUtil;
import com.ehtsoft.fw.utils.StringUtil;
import com.ehtsoft.fw.utils.Util;
import com.ehtsoft.im.api.ImConst;
import com.ehtsoft.im.dto.Group;
import com.ehtsoft.im.dto.GroupUser;
import com.ehtsoft.im.protocol.IMProtocol;
import com.ehtsoft.im.protocol.Message;
import com.ehtsoft.im.protocol.IMProtocol.PGFlag;

/**
 * 群主服务
 * 备注：群组分 5种类型，前四种类型 分别为：司法厅，司法局，区县司法局，司法所，
 *      前四种类型的 IM_GROUP.F_GID 值为机构的主键信息（orgid），群主默认为当前机构的主键
 *      后期，群主的信息可以修改，前四种类型主要发送各部门的通知及公告信息，无需回复
 * @author wangbao
 */
@Service("GroupService")
public class GroupService {

	@Resource(name="sqlDbClient")
	private SqlDbClient dbClient;
	
	@Resource
	private SSOService ssoService;
	
	@Resource
	private IMSService broadcastService;
	
	//字段前缀
	private String fieldPrefix = "f_";
	
	public Group findGroup(String gid){
		BasicMap<String,Object> map = dbClient.findOne("SELECT * FROM IM_GROUP WHERE F_GID = ?", gid);
		if(map!=null){
			return ReflectUtil.map2Bean(map, Group.class, fieldPrefix);
		}
		return null;
	}
	/**
	 * 创建群
	 * @param group
	 */
	public String createGroup(Group group){
		if(Util.isEmpty(group.getAid())){
			throw new AppException("群主ID不能为空");
		}
		if(Util.isEmpty(group.getName())){
			throw new AppException("群名不能为空");
		}
		BasicMap<String,Object> one = dbClient.findOne("SELECT * FROM IM_USERINFO WHERE F_AID = ?", group.getAid());
		if(one==null){
			throw new AppException("群主ID " + group.getAid() + " 不存在");
		}
		BasicMap<String,Object> data = ReflectUtil.bean2Map(group, fieldPrefix);
		dbClient.insert(ImConst.Collections.IM_GROUP, data);
		group.setGid(StringUtil.toString(data.get("f_gid")));
		//将群组插入到成员表中
		GroupUser gu = new GroupUser();
		gu.setGid(group.getGid());
		gu.setAid(group.getAid());
		gu.setType(2);//群主
		dbClient.insert(ImConst.Collections.IM_GROUP_USER, ReflectUtil.bean2Map(gu, fieldPrefix));
		return group.getGid();
		
	}
	/**
	 * 移除群
	 * @param gid  群的主键
	 */
	public void removeGroup(String gid){
		dbClient.updateSql("DELETE FROM IM_GROUP_USER WHERE F_GID = ?", gid);
		dbClient.updateSql("DELETE FROM IM_GROUP WHERE F_GID = ? ", gid);
	}
	/**
	 * 修改群组信息
	 * @param group
	 */
	public void updateGroup(Group group){
		BasicMap<String,Object> data = ReflectUtil.bean2Map(group, fieldPrefix);
		data.remove("F_AID");//群主不允许修改
		dbClient.update(ImConst.Collections.IM_GROUP, data);
	}
	/**
	 * 加入成员到群组
	 * @param gid  群的ID
	 * @param aid  添加成员的ID
	 */
	public void addUserToGroup(GroupUser groupUser){
		BasicMap<String,Object> data = new BasicMap<>();
        data.put("F_GID", groupUser.getGid());
        data.put("F_AID", groupUser.getAid());
        data.put("F_TYPE", 0);
        data.put("F_NAME",groupUser.getName());
        data.put("remark",groupUser.getRemark());
		dbClient.insert(ImConst.Collections.IM_GROUP_USER, data);
	}
	/**
	 * 更新成员在群组中的类型
	 * @param gid  群的ID
	 * @param aid  成员的ID
	 * @param type 成员类型：0 普通成员 1 管理员  2 群主
	 */
	public void updateUserType(String gid,String aid,int type){
		dbClient.updateSql("UPDATE IM_GROUP_USER SET F_TYPE = ? WHERE F_GID = ? AND F_AID = ?", type,gid,aid);
	}
	/**
	 * 修改成员备注信息
	 */
	public void updateUserRemark(GroupUser groupUser){
		if(Util.isEmpty(groupUser.getGid()) || Util.isEmpty(groupUser.getAid())){
			throw new AppException("群ID（gid）和 成员ID（aid）不能为空");
		}
		BasicMap<String,Object> data = ReflectUtil.bean2Map(groupUser, fieldPrefix);
		data.remove("f_type");//成员类型不修改
		dbClient.update(ImConst.Collections.IM_GROUP_USER, data);
	}

	/**
	 * 从群中移除成员
	 * @param gid
	 * @param aid
	 */
	public void removeUserFromGroup(String gid,String aid){
		dbClient.updateSql("DELETE FROM IM_GROUP_USER WHERE F_GID = ? AND F_AID = ?",gid,aid);
	}
	
	/**
	 * 获取当前群组中的用户信息
	 * @param gid 当前群的ID
	 */
	public List<GroupUser> getUserinfoFromGroup(String gid){
		List<GroupUser> rtn = new ArrayList<GroupUser>();
		String sqlstr = "SELECT * FROM IM_GROUP_USER";
		SQLAdapter sql = new SQLAdapter(sqlstr);
		sql.getFilter().eq("F_GID", gid);
		dbClient.find(sql,new RowDataListener() {
			@Override
			public void processData(BasicMap<String, Object> rowData) {
				GroupUser gu = ReflectUtil.map2Bean(rowData, GroupUser.class, fieldPrefix);
				rtn.add(gu);
			}
		});
		return rtn;
	}
	
	/**
	 * 根据当前用户id 获取当前用户的群列表信息
	 * @param aid
	 */
	public List<Group> getGroupsByAid(String aid){
		final List<Group> rtn = new ArrayList<>();
		String sqlstr = "SELECT G.* FROM IM_GROUP G INNER JOIN IM_GROUP_USER GU ON G.F_GID = GU.F_GID WHERE GU.F_AID = '"+aid+"'"
				+ " union all SELECT * FROM IM_GROUP WHERE F_TYPE IN (1,2,3,4)" ;
		
		dbClient.find(new SQLAdapter(sqlstr),new RowDataListener() {
			public void processData(BasicMap<String, Object> rowData) {
				Group g = ReflectUtil.map2Bean(rowData, Group.class, fieldPrefix);
				rtn.add(g);
			}
		});
		return rtn;
	}
	
	/**
	 * 获取当前用户所在的群中的所有群用户信息
	 * @param aid
	 * @return
	 */
	public List<GroupUser> getAllGroupUserByAid(String aid){
		final List<GroupUser> rtn = new ArrayList<>();
		String sqlstr = "SELECT * FROM IM_GROUP_USER WHERE F_GID IN (select f_gid from IM_GROUP_USER WHERE F_AID = '"+aid+"')";
		SQLAdapter sql = new SQLAdapter(sqlstr);
		dbClient.find(sql, new RowDataListener() {
			@Override
			public void processData(BasicMap<String, Object> rowData) {
				rtn.add(ReflectUtil.map2Bean(rowData, GroupUser.class, fieldPrefix));
			}
		});
		return rtn;
	}
	/**
	 * 获取当前用户所在的群中的 群主 及 管理员信息
	 * @param aid
	 * @return
	 */
	//@Cacheable
	public List<GroupUser> getOwnerManagerGroupByAid(String aid){
		final List<GroupUser> rtn = new ArrayList<>();
		// 1 管理员  2 群主
		String sqlstr = "SELECT * FROM IM_GROUP_USER WHERE F_GID IN (select f_gid from IM_GROUP_USER WHERE F_AID = '"+aid+"') AND F_TYPE IN (1,2)";
		SQLAdapter sql = new SQLAdapter(sqlstr);
		dbClient.find(sql, new RowDataListener() {
			@Override
			public void processData(BasicMap<String, Object> rowData) {
				rtn.add(ReflectUtil.map2Bean(rowData, GroupUser.class, fieldPrefix));
			}
		});
		return rtn;
	}

	/**
	 * 请求发送的群通知信息
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
	public void sendGroupNotify(String aid){
		// flag: 0 公众账号（矫正人员）, 1 平台工作人员账号 ， 2 机构账号 
		final User user = ssoService.getUser();
		String sqlstr = "SELECT G.* FROM IM_GROUP G INNER JOIN IM_GROUP_USER GU ON G.F_GID = GU.F_GID WHERE GU.F_AID = '"+aid+"'";
		List<BasicMap<String,Object>> list = dbClient.find(new SQLAdapter(sqlstr),new RowDataListener() {
			@Override
			public void processData(BasicMap<String, Object> rowData) {				
				String content = "";
				// 4 注册通知 
				BasicMap<String,Object> one = dbClient.findFirstData(new SQLAdapter("SELECT * FROM IM_GROUP_AFFICHE WHERE F_GID = '"+StringUtil.toString(rowData.get("F_GID"))+"'"
						+ " and F_TYPE = 4  ORDER BY CTS DESC"));
				if(one!=null){
					content = StringUtil.toEmptyString(one.get("F_CONTENT"));
				}
				if(user.getFlag()!=0){
					content = "欢迎使用掌上司法，掌上司法让工作更快捷，信息更畅通";
				}
				Message message = IMProtocol.wrap(IMProtocol.Type.TEXT, content.getBytes());
				message.setFrom(StringUtil.toString(rowData.get("F_AID"))); //群主
				message.setTo(aid);
				message.setGid(StringUtil.toString(rowData.get("F_GID")));  //群id
				message.setPgFlag(PGFlag.P2G);
				message.setGroupToOneFlag();
				if(user.getFlag()==0){
					//发送给 矫正人员
					broadcastService.sendMessage(message);
				}else{
					//发送给  1 平台工作人员账号 ， 2 机构账号 
					broadcastService.sendMessage(message,true);
				}
			}
		});
	}
}
