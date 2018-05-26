package com.ehtsoft.im.websocket;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.springframework.web.socket.WebSocketSession;

import com.ehtsoft.fw.utils.StringUtil;

public class VideoSocketContext {
	/**
	 * session 用户ID
	 */
	public final static String FROM_ACCOUNT_ID = "fromAid";
	public final static String TO_ACCOUNT_ID   = "toAid";
	
	/**
	 * 发送 session video
	 */
	private static Map<String, WebSocketSession> sendVideoClients    = new ConcurrentHashMap<>();
	/**
	 * 接受 session video
	 */
	private static Map<String, WebSocketSession> receiveVideoClients = new ConcurrentHashMap<>();
	 
	 /**
	  * 添加 send video websession 信息到缓存中
	  * @param aid     用户的ID,唯一的
	  * @param session 
	  */
	 public static void addSendSession(String aid,WebSocketSession session){
		 sendVideoClients.put(aid, session);
	 }
	 
	 /**
	  * 添加 receive video websession 信息到缓存中
	  * @param aid     用户的ID,唯一的
	  * @param session 
	  */
	 public static void addReceiveSession(String aid,WebSocketSession session){
		 receiveVideoClients.put(aid, session);
	 }
	 /**
	  * 移除 发送 的 session
	  * @param session
	  */
	 public static void removeSendSession(WebSocketSession session){
		 sendVideoClients.remove(getFromAid(session));
	 }
	 /**
	  * 移除 接受的 session
	  * @param session
	  */
	 public static void removeReceiveSession(WebSocketSession session){
		 receiveVideoClients.remove(getFromAid(session));
	 }
	 /**
	  * 获取 send clients
	  * @return
	  */
	 public static Map<String, WebSocketSession> getSendSessionClients(){
		 return sendVideoClients;
	 }
	 /**
	  * 获取接受的 clients
	  * @return
	  */
	 public static Map<String, WebSocketSession> getReceiveSessionClients(){
		 return receiveVideoClients;
	 }
	 /**
	  * 获取 send session
	  * @param aid
	  * @return
	  */
	 public static WebSocketSession getSendSessionClient(String aid){
		 return sendVideoClients.get(aid);
	 }
	 /**
	  * 获取 接受的 session
	  * @param aid
	  * @return
	  */
	 public static WebSocketSession getReceiveSessionClient(String aid){
		 return receiveVideoClients.get(aid);
	 }
	 /**
	  * 获取 fromAid
	  * @param session
	  * @return
	  */
	public static String getFromAid(WebSocketSession session){
		return StringUtil.toString(session.getAttributes().get(FROM_ACCOUNT_ID));
	}
	/**
	 * 获取 toAid
	 * @param session
	 * @return
	 */
	public static String getToAid(WebSocketSession session){
		return StringUtil.toString(session.getAttributes().get(TO_ACCOUNT_ID));
	}
}
