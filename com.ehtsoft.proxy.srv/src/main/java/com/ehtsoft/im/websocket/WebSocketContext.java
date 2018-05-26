package com.ehtsoft.im.websocket;

import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.socket.AbstractWebSocketMessage;
import org.springframework.web.socket.WebSocketSession;

import com.ehtsoft.fw.utils.StringUtil;
import com.ehtsoft.fw.utils.Util;

public class WebSocketContext {
	private static Log logger = LogFactory.getLog(WebSocketContext.class);
	/**
	 * session 用户ID
	 */
	public final static String UNIQUE_ACCOUNT_ID = "aid";
	
	public final static String CLIENT_TYPE = "client";
	public final static String CLIENT_TYPE_ANDROID="android";
	public final static String CLIENT_TYPE_IOS = "ios";
	
	private static Map<String, WebSocketSession> clients = new ConcurrentHashMap<>();  
	 
	 /**
	  * 添加 websession 信息到缓存中
	  * @param aid     用户的ID,唯一的
	  * @param session 
	  */
	 public static void addSession(String aid,WebSocketSession session){
		 clients.put(aid, session);
	 }
	 
	 public static void removeSession(WebSocketSession session){
		 clients.remove(getAccountId(session));
	 }
	 
	 public static Map<String, WebSocketSession> getSessionClients(){
		 return clients;
	 }

	 
	 static FileOutputStream fis;
	 
	 
	 /**
	  * 向特定的群体发送消息
	  * @param accountids
	  * @param message
	  */
	 public static void broadcast(Set<String> accountids,AbstractWebSocketMessage<?> message){
		 if(Util.isNotEmpty(accountids)){
			 for(String aid:accountids){
				 broadcast(aid,message);
			 }
		 }
	 }
	 /**
	  * 向指定的用户发送消息
	  * @param accountid  user.getAid()
	  * @param message
	  */
	 public static void broadcast(String accountid,AbstractWebSocketMessage<?> message){
		 WebSocketSession session = clients.get(accountid);
		 if(session!=null){
			 try {
				 if(session.isOpen()){
					 session.sendMessage(message);
				 }else{ //已经关闭的用户，将实现离线发送消息
					  // UNDO
				 }
			} catch (IOException e) {
				logger.error(e.getMessage());
			}
		 }else{
			 //没有登录的用户，将实现离线发送消息，什么时候连接上，什么时候发送
			 //// UNDO
			 
			 
		 }
	 }
	 /**
	  * 获取客户端的类型，android,ios 
	  * @param session
	  * @return
	  */
	 public static String getClientType(WebSocketSession session){
		return StringUtil.toString(session.getAttributes().get(WebSocketContext.CLIENT_TYPE));
	 }
	 
	 public static boolean isWebClient(WebSocketSession session){
		 boolean rtn = false;
		 String type = getClientType(session);
		 if(!CLIENT_TYPE_ANDROID.equals(type) && !CLIENT_TYPE_IOS.equals(type)){
			 rtn = true;
		 }else{
			 rtn = false;
		 }
		 return rtn;
	 }
	 
	public static String getAccountId(WebSocketSession session){
		return StringUtil.toString(session.getAttributes().get(WebSocketContext.UNIQUE_ACCOUNT_ID));
	}
}
