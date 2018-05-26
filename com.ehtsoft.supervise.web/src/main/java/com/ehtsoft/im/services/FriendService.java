package com.ehtsoft.im.services;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ehtsoft.fw.core.db.SQLAdapter;
import com.ehtsoft.fw.core.db.SqlDbClient;
import com.ehtsoft.fw.core.db.SqlDbFilter;
import com.ehtsoft.fw.core.dto.BasicMap;
import com.ehtsoft.fw.core.utils.ReflectUtil;
import com.ehtsoft.im.api.ImConst;
import com.ehtsoft.im.dto.FriendRemark;
import com.ehtsoft.im.dto.UserinfoFriend;

/**
 * 好友服务类
 * @author wangbao
 */
@Service("FriendService")
public class FriendService {

	@Resource(name="sqlDbClient")
	private SqlDbClient dbClient;
	
	//字段前缀
	private String fieldPrefix = "f_";
	/**
	 * 获取好友信息
	 * @param aid  当前用户的ID
	 * @return 好友的信息
	 * [{
	 *  f_aid0:用户信息ID
	 * 	f_aid1:"好友信息ID",
	 *  f_nickname:"好友的昵称",
	 *  f_name:"对好友的备注名",
	 *  f_tel:"好友的备注电话",
	 *  f_email:"好友的备注mail",
	 *  remark:"备注信息"
	 * }]
	 * 提供 andorid 的接口方法
	 */
	public List<BasicMap<String,Object>> getFriends(String aid){
		String sqlstr = "select f_aid,f_nickname,f_name,f_tel,f_email,fr.remark,u.f_code from im_userinfo_friend uf "
				+ " inner join im_userinfo u on uf.f_aid1 = u.f_aid "
				+ " left join im_friend_remark fr on u.f_aid = fr.f_aid1 and fr.f_aid0 = uf.f_aid0 "
				+ " where uf.f_aid0 = '" + SqlDbFilter.convertSqlParameter(aid) +"'";
		SQLAdapter sql = new SQLAdapter(sqlstr);
		
		return dbClient.find(sql);
	}
	
	/**
	 * 添加好友
	 * @param aid  用户的ID
	 * @param faid 好友的ID
	 */
	public void addFriend(String aid,String faid){
		BasicMap<String,Object> data = new BasicMap<>();
		data.put("f_aid0", aid);
		data.put("f_aid1", faid);
		dbClient.insert(ImConst.Collections.IM_USERINFO_FRIEND, data);
		data.put("f_aid0", faid);
		data.put("f_aid1", aid);
		dbClient.insert(ImConst.Collections.IM_USERINFO_FRIEND, data);
	}
	
	/**
	 * 移除好友
	 * @param aid    用户的ID
	 * @param faid   好友的ID
	 */
	public void removeFriend(String aid,String faid){
		dbClient.updateSql("DELETE FROM IM_USERINFO_FRIEND WHERE f_aid0 = ? AND f_aid1 = ?", aid,faid);
	}
	/**
	 * 更新好友备注信息
	 * @param friendRemark
	 */
	public void updateFriend(FriendRemark friendRemark){
		BasicMap<String,Object> data = ReflectUtil.bean2Map(friendRemark, fieldPrefix);
		dbClient.save(ImConst.Collections.IM_FRIEND_REMARK, data);
	}
	
}
