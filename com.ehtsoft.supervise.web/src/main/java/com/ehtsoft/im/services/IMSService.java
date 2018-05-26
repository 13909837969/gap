package com.ehtsoft.im.services;

import java.util.Base64;
import java.util.HashSet;
import java.util.Set;
import java.util.concurrent.Executor;
import java.util.concurrent.Executors;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;

import com.ehtsoft.im.api.OnConnectionNotify;
import com.ehtsoft.im.api.ProxyApiFactory;
import com.ehtsoft.im.api.WSService;
import com.ehtsoft.im.protocol.Command;
import com.ehtsoft.im.protocol.Location;
import com.ehtsoft.im.protocol.Message;
/**
 * 消息广播服务
 * @author 王宝
 * 将来做集群的时候，可以考虑将下面的消息队列对象换成消息服务器来进行消息的发送
 * messageQueue、failureQueue
 * 
 * cacheMessageMap 可以考虑采用 Redis 作为全局的缓存
 * 
 * 该服务考虑到没有发送成功的情况下，重新给客户端发送消息
 * 注：分批次发送的语音信息，如果发送失败将导致数据流合并错位现象，后期考虑如何解决这个问题
 * （替代方式，可以发送语音连接给客户端，客户端做播放的时候，边下载边播放）
 */
@Service
public class IMSService {
	
	private Log logger = LogFactory.getLog(IMSService.class);
	//OnConnectionNotify
	private Set<OnConnectionNotify> onConnectionNotifySet = new HashSet<>();
	
	private Executor executor = Executors.newFixedThreadPool(250);
	/**
	  * 广播消息
	  * @param currentSession
	  * @param imProtocol
	  */
	 public void broadcast(Message message){
		 executor.execute(new Runnable() {
			@Override
			public void run() {
				ProxyApiFactory.getInstance().broadcast(Base64.getEncoder().encodeToString(message.getMessages()));
			}
		});
	 }

	 public void sendMessage(Message message){
		 executor.execute(new Runnable() {
			@Override
			public void run() {
				broadcast(message);
			}
		});
	 }
	 
	 /**
	  * 广播消息
	  * @param message
	  * @param allowSendSelf  true 可以给自己发，false 不给自己发
	  */
	 public void sendMessage(Message message,boolean allowSendSelf){
		 executor.execute(new Runnable() {
			 @Override
			 public void run() {
				 ProxyApiFactory.getInstance().sendMessageIsSelf(Base64.getEncoder().encodeToString(message.getMessages()), allowSendSelf);
			 }
		 });
	 }
	 /**
	  * 发送命令给客户端（android 手机端 或 平板端）
	  * @param command
	  */
	 public void sendCommand(Command command){
		 executor.execute(new Runnable() {
			@Override
			public void run() {
				ProxyApiFactory.getInstance().sendCommand(command);
			}
		});
	 }
	 
	 /**
	  * 向平板或 web 网页发送 矫正人缘的 位置信息
	  * @param location
	  */
	 public void sendLocation(Location location){
		 executor.execute(new Runnable() {
			@Override
			public void run() {
				ProxyApiFactory.getInstance().sendLocation(location);
			}
		 });
	 }
	 
	 /**
	  * 发送在线通知
	  * @param onlineAid
	  */
	 public void sendOnlineNotify(String onlineAid){
		 executor.execute(new Runnable() {
			@Override
			public void run() {
				 for(OnConnectionNotify notify : onConnectionNotifySet){
					 notify.onlineNotify(onlineAid);
				 }
			}
		 });
	 }
	 
	 /**
	  * 发送离线通知
	  */
	 public void sendOfflineNotify(String offineAid){
		 executor.execute(new Runnable() {
				@Override
				public void run() {
				 for(OnConnectionNotify notify : onConnectionNotifySet){
					 notify.offlineNotify(offineAid);
				 }
		 }});
	 }
	 
	 
	/**
	 * 设置连接通知事件
	 * @param onConnectionNotify
	 */
	public void setOnConnectionNotify(OnConnectionNotify onConnectionNotify) {
		 onConnectionNotifySet.add(onConnectionNotify);
	}
}
