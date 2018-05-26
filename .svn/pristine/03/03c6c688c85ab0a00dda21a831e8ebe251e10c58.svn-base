package com.ehtsoft.im.api;

import javax.jws.WebMethod;
import javax.jws.WebService;

import com.ehtsoft.im.protocol.Message;
import com.ehtsoft.im.protocol.Command;
import com.ehtsoft.im.protocol.Location;

/**
 * @Description 调用 WebSocket 的 webservice 接口 （业务系统消息命令推送的时候使用）
 * @author wangbao
 * @date 2018年5月2日
 *
 */
@WebService
public interface WSService {

		/**
		  * 广播消息
		  * @param currentSession
		  * @param imProtocol
		  */
		 @WebMethod
		 public void broadcast(String base64Message);//public void broadcast(Message message);

		 @WebMethod
		 public void sendMessage(String base64message);//public void sendMessage(Message message);
		 
		 /**
		  * 广播消息
		  * @param message
		  * @param allowSendSelf  true 可以给自己发，false 不给自己发
		  */
		 @WebMethod
		 public void sendMessageIsSelf(String base64message,Boolean allowSendSelf);//public void sendMessageIsSelf(Message message,boolean allowSendSelf);
		 /**
		  * 发送命令给客户端（android 手机端 或 平板端）
		  * @param command
		  */
		 @WebMethod
		 public void sendCommand(Command command);
		 
		 /**
		  * 向平板或 web 网页发送 矫正人缘的 位置信息
		  * @param location
		  */
		 @WebMethod
		 public void sendLocation(Location location);
}
