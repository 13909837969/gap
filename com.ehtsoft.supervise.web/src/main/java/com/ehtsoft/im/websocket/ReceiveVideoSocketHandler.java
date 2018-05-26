package com.ehtsoft.im.websocket;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.socket.BinaryMessage;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.AbstractWebSocketHandler;

/**
 * 接受视频通道
 * @author wangbao
 */
public class ReceiveVideoSocketHandler extends AbstractWebSocketHandler{
	private Log logger = LogFactory.getLog(ReceiveVideoSocketHandler.class);
	
	/**
	 * 成功建立连接
	 */
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		String fromAid = VideoSocketContext.getFromAid(session);
		if(logger.isDebugEnabled()){
			logger.debug("AID: "+fromAid + " 视频通道已连接到平台系统");
		}
		try{
			//将当前连接加载到缓存中
			VideoSocketContext.addReceiveSession(fromAid, session);
		}catch(Exception ex){
			logger.error(ex.getMessage(),ex);
		}
	}
	
	@Override
	public boolean supportsPartialMessages() {
		//支持部分消息，通过客户端，返回 true 有问题，（还未找到原因，不能返回 true）
		return true;
	}
	/**
	 * 和 app 客户端进行通讯采用 二进制进行数据传输
	 * 数据协议：1 +1 + 36 + 36 + 13 + 4 + 8102
	 * 接受二进制消息
	 */
	@Override
	protected void handleBinaryMessage(WebSocketSession session, BinaryMessage message) throws Exception {
		try{
			String toAid = VideoSocketContext.getToAid(session);
			if(toAid!=null){
				WebSocketSession toSession = VideoSocketContext.getReceiveSessionClient(toAid);
				try{
					if(toSession!=null && toSession.isOpen()){
						//发送视频信息
						toSession.sendMessage(message);
					}
				}catch(Exception ex){}
			}
		}catch(Exception ex){
			logger.error(ex.getMessage(),ex);
		}
	}
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		String fromAid = VideoSocketContext.getFromAid(session);
		if(logger.isDebugEnabled()){
			logger.debug("用户 " + fromAid + " 视频通道已经关闭，" + status.getReason() + "("+status.getCode()+")");
		}
		try{
			VideoSocketContext.removeReceiveSession(session);
		}catch(Exception ex){
			logger.error(ex.getMessage(),ex);
		}
	}
}
