/**
 * @Description TODO(用一句话描述该文件是做什么功能的，哪个地方使用的，android 还是 jsp 用)
 * @author wangbao
 * @date 2018年5月2日
 */
package com.ehtsoft.im.services;

import java.util.Base64;

import javax.annotation.Resource;

import com.ehtsoft.fw.utils.BooleanUtil;
import com.ehtsoft.im.api.OnConnectionNotify;
import com.ehtsoft.im.api.WSService;
import com.ehtsoft.im.protocol.Command;
import com.ehtsoft.im.protocol.IMProtocol;
import com.ehtsoft.im.protocol.Location;
import com.ehtsoft.im.protocol.Message;

/**
 * @Description TODO(用一句话描述该文件是做什么功能的，哪个地方使用的)
 * @author wangbao
 * @date 2018年5月2日
 *
 */
public class WebSocketService implements WSService{

	//消息推送服务
	@Resource
	private BroadcastService broadcastService; 
	
	@Override
	public void broadcast(String base64message) {
		broadcastService.broadcast(IMProtocol.unwrap(Base64.getDecoder().decode(base64message)));
	}


	@Override
	public void sendMessage(String base64message) {
		broadcastService.sendMessage(IMProtocol.unwrap(Base64.getDecoder().decode(base64message)));
	}


	@Override
	public void sendMessageIsSelf(String base64message, Boolean allowSendSelf) {
		broadcastService.sendMessage(IMProtocol.unwrap(Base64.getDecoder().decode(base64message)), BooleanUtil.toBoolean(allowSendSelf));
	}


	@Override
	public void sendCommand(Command command) {
		broadcastService.sendCommand(command);
	}


	@Override
	public void sendLocation(Location location) {
		broadcastService.sendLocation(location);
	}

	
	

	public void sendOnlineNotify(String onlineAid) {
		
	}

	public void sendOfflineNotify(String offineAid) {
		
	}

	public void setOnConnectionNotify(OnConnectionNotify onConnectionNotify) {
		
	}

}
