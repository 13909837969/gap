package com.ehtsoft.im.websocket;

import javax.annotation.Resource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.socket.BinaryMessage;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.AbstractWebSocketHandler;

import com.ehtsoft.fw.core.dto.BasicMap;
import com.ehtsoft.fw.core.utils.ReflectUtil;
import com.ehtsoft.fw.core.utils.helper.JSONHelper;
import com.ehtsoft.fw.utils.JsonUtil;
import com.ehtsoft.fw.utils.StringUtil;
import com.ehtsoft.fw.utils.Util;
import com.ehtsoft.im.protocol.Command;
import com.ehtsoft.im.protocol.IMProtocol;
import com.ehtsoft.im.protocol.IMProtocol.Type;
import com.ehtsoft.im.protocol.Location;
import com.ehtsoft.im.protocol.Message;
import com.ehtsoft.im.services.IMSService;
/**
 * WebSocket handler 通用触发方法
 * @author wangbao
 */
public class ProxyWebSocketHandler extends AbstractWebSocketHandler{
	private Log logger = LogFactory.getLog(ProxyWebSocketHandler.class);
	
	@Resource
	private IMSService broadcastService;
	/**
	 * 成功建立连接
	 */
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		String accountid = WebSocketContext.getAccountId(session);
		if(logger.isDebugEnabled()){
			logger.debug("AID: "+accountid + " 已连接到平台系统");
		}
		try{
			WebSocketContext.addSession(accountid, session);
			//发送在线通知
			broadcastService.sendOnlineNotify(accountid);
		}catch(Exception ex){
			logger.error(ex.getMessage(),ex);
		}
	}
	
	@Override
	public boolean supportsPartialMessages() {
		//支持部分消息，通过客户端，返回 true 有问题，（还未找到原因，不能返回 true）
		return false;
	}

	/**
	 * 接受文本消息
	 */
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		try{
			String msgstr = message.getPayload();
			if(JsonUtil.isJsonObject(msgstr)){
				BasicMap<String,Object> map = JSONHelper.jsonToMap(msgstr);
		        //包含经纬度信息转化成 Location 对象
		        if(map.containsKey("lat") && map.containsKey("lng")){
		            Location location = ReflectUtil.map2Bean(map,Location.class);
		            if(Util.isNotEmpty(location.getAid()) && WebSocketContext.getSessionClients().get(location.getAid())==null){
		            	WebSocketContext.addSession(location.getAid(), session);
		            }
		            broadcastService.sendLocation(location);
		        }else if(map.containsKey("command")){
		        	//包含命令属性，转化成 Command 对象
		            Command command = ReflectUtil.map2Bean(map,Command.class);
		            if(Util.isNotEmpty(command.getFrom()) && WebSocketContext.getSessionClients().get(command.getFrom())==null){
		            	WebSocketContext.addSession(command.getFrom(), session);
		            }
		            broadcastService.sendCommand(command);
		        }else{
					Message msg = IMProtocol.wrap(Type.TEXT, message.asBytes());
					String aid = WebSocketContext.getAccountId(session); 
					msg.setFrom(aid);
					if(Util.isNotEmpty(aid) && WebSocketContext.getSessionClients().get(aid)==null){
						WebSocketContext.addSession(aid, session);
					}
					broadcastService.broadcast(msg);
		        }
			}else{
				Message msg = IMProtocol.wrap(Type.TEXT, message.asBytes());
				msg.setFrom(WebSocketContext.getAccountId(session));
				broadcastService.broadcast(msg);
			}
		}catch(Exception ex){
			logger.error(ex.getMessage(),ex);
		}
	}
	

	/**
	 * 和 app 客户端进行通讯采用 二进制进行数据传输
	 * 数据协议：1 +1 + 36 + 36 + 13 + 4 + 8102
	 * 接受二进制消息
	 */
	@Override
	protected void handleBinaryMessage(WebSocketSession session, BinaryMessage message) throws Exception {
		try{
			if(logger.isDebugEnabled()){
				logger.debug("handleBinaryMessage() 方法接受到 " + WebSocketContext.getAccountId(session) + " 消息，内容为：" + message.getPayload());
			}
			//接受 二进制 数据信息，并发送给指定的 to 对象
			broadcastService.broadcast(IMProtocol.unwrap(message.getPayload().array()));
		}catch(Exception ex){
			logger.error(ex.getMessage(),ex);
		}
	}
	
	@Override
	public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception {
			logger.error("handleTransportError() " + exception.getMessage(),exception);
	}
	
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		String accountId = WebSocketContext.getAccountId(session);
		if(logger.isDebugEnabled()){
			logger.debug("用户 " + accountId + " 已经关闭，" + status.getReason() + "("+status.getCode()+")");
		}
		try{
			//发送离线通知（给管理人员）
			broadcastService.sendOfflineNotify(accountId);
			WebSocketContext.removeSession(session);
			//连接关闭的用户，要发送到 屏幕及 兼管人员的 app 上，进行预警
		}catch(Exception ex){
			logger.error(ex.getMessage(),ex);
		}
	}
}
