package com.ehtsoft.im.services;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ConcurrentLinkedQueue;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.LinkedBlockingQueue;
import java.util.concurrent.PriorityBlockingQueue;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.socket.BinaryMessage;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;

import com.ehtsoft.fw.core.utils.helper.JSONHelper;
import com.ehtsoft.fw.utils.NumberUtil;
import com.ehtsoft.fw.utils.Util;
import com.ehtsoft.im.api.OnConnectionNotify;
import com.ehtsoft.im.dto.GroupUser;
import com.ehtsoft.im.protocol.Command;
import com.ehtsoft.im.protocol.IMProtocol;
import com.ehtsoft.im.protocol.IMProtocol.PGFlag;
import com.ehtsoft.im.protocol.IMProtocol.Type;
import com.ehtsoft.im.protocol.Location;
import com.ehtsoft.im.protocol.Message;
import com.ehtsoft.im.websocket.WebSocketContext;
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
public class BroadcastService {
	private Log logger = LogFactory.getLog(BroadcastService.class);
	//需要发送到客户端的消息队列
	private LinkedBlockingQueue<Message> messageQueue = new LinkedBlockingQueue<>();
	private ConcurrentLinkedQueue<Message> failureCache = new ConcurrentLinkedQueue<Message>();
	//服务器向客户端发送失败的消息队列
	private PriorityBlockingQueue<Message> failureQueue = new PriorityBlockingQueue<Message>(1024,new Comparator<Message>() {
		@Override
		public int compare(Message msg1, Message msg2) {
			int r = 0;
			if(msg1.getTimeMillis() > msg2.getTimeMillis()){
				r = 1;
			}
			if(msg1.getTimeMillis() < msg2.getTimeMillis()){
				r = -1;
			}
			if(msg1.getTimeMillis() == msg2.getTimeMillis()){
				r = 0;
			}
			return r;
		}
	});
	//服务器向客户端发送消息的缓存,用于判断客户端向服务器发送确认的回执信息（客户端接受消息成功后，清除该条信息的缓存）
	private volatile ConcurrentHashMap<String, Message> cacheMessageMap = new ConcurrentHashMap<>();
	//未确认的消息调度线程池数量
	private int SCHEDULED_THREAD_POOL = 150;
	//消息发送到客户端后未收到消息确认超时时间（秒数）
	private int RECEIPT_ACKNOWLEDGE_TIMEOUT = 30;
	//OnConnectionNotify
	private Set<OnConnectionNotify> onConnectionNotifySet = new HashSet<>();
	
	//组信息
	@Resource
	private GroupService groupService;
	
	
	@PostConstruct
	public void init(){
		//正常发送消息
		new Thread(()->{
			while(true){
				asyncSend(false);
			}
		}).start();
		//发送失败信息
		new Thread(()->{
			while(true){
				try {
					//失败队列为空的时候
					if(failureQueue.isEmpty()){
						//失败缓存不为空时，把缓存中的数据放到 失败队列中
						while(!failureCache.isEmpty()){
							failureQueue.put(failureCache.poll());
						}
						//休眠 5 之后再发送失败的数据（如果不休眠，CPU使用率非常高）
						Thread.sleep(5000);
					}
					Message msg = failureQueue.take();
					Map<String,WebSocketSession> clients = WebSocketContext.getSessionClients();
					WebSocketSession session = clients.get(msg.getTo());
					if(session!=null){
						sendMessage(session, msg,false);
					}else{
						//没有上线的数据，放到失败的缓存中
						failureCache.offer(msg);
					}
				} catch (InterruptedException e) {
				}
			}
		}).start();
	}
	
	private ExecutorService executorService = Executors.newCachedThreadPool();
	
	private void asyncSend(boolean allowSendSelf){
		Map<String,WebSocketSession> clients = WebSocketContext.getSessionClients();
		try {
			Message message = messageQueue.take();
			/**
			 * 视频 和 语音电话的时候不判断传输失败的情况，然后重发的情况，否则会出现数据错乱现象
			 */
			if(Type.VIDEO_STREAM.equals(message.getType()) || Type.VOICE_STREAM.equals(message.getType())){
				//P2P
				if(message.getPgFlag().equals(PGFlag.P2P)){
					WebSocketSession session = clients.get(message.getTo());
					try{
						if(session!=null && session.isOpen()){
							session.sendMessage(new BinaryMessage(message.getMessages()));
						}
					}catch(Exception e){}
				}else{
					
				}
			}else{
			//P2P
			if(message.getPgFlag().equals(PGFlag.P2P)){
				// p2p （ 点对点发送 ）
				//发送到的用户不为空时
				if(Util.isNotEmpty(message.getTo())){
					// P2P
					WebSocketSession session = clients.get(message.getTo());
					if(session!=null){
						sendMessage(session, message,allowSendSelf);
					}else{
						//不存在登录会话信息（没有上线的客户端，当上线后进行在进行发送）
						failureQueue.put(message);
					}
				}else{
					// P2 something
					// 发送到的用户为空的时候，发给全部的用户
					// （发送给已经上线的用户）
					// 以后考虑发送给没有上线的用户（用户什么时候上线，什么时候发送）
					// 全部发送的情况
					for(WebSocketSession webSession : clients.values()){
						executorService.execute(()->{
							Message msg = IMProtocol.unwrap(message.getMessages());
							msg.setTo(WebSocketContext.getAccountId(webSession));
							sendMessage(webSession, msg,allowSendSelf);
						});
					}
					// TODO
					// to 为空时，没有上线的用户暂时没有考虑，后期加入没有上线的用户
				}
			}else{
				// P2G ...
				String gid = message.getGid();
				//群发的时候，只发一个人（to 的人），后台注册成功 及 欢迎信息的时候调用的
				if(message.isGroupToOneFlag()){
					WebSocketSession session = clients.get(message.getTo());
					if(session!=null){
						sendMessage(session, message,allowSendSelf);
					}else{
						//不存在登录会话信息（没有上线的客户端，当上线后进行在进行发送）
						failureQueue.put(message);
					}
				}else{
					List<GroupUser> list = groupService.getUserinfoFromGroup(gid);
					if(!list.isEmpty()){
						for(GroupUser u : list){
							executorService.execute(()->{
								Message msg = IMProtocol.unwrap(message.getMessages());
								msg.setTo(u.getAid());
								
								WebSocketSession session = clients.get(msg.getTo());
								if(session!=null){
									sendMessage(session, msg, allowSendSelf);
								}else{
									//不存在登录会话信息（没有上线的客户端，当上线后进行在进行发送）
									failureQueue.put(msg);
								}
							});
						}
					}else{
						//向发送客户端的发送者 发送回执确认信息
						if(message.isCompleteStatus()){
							WebSocketSession fromSession = WebSocketContext.getSessionClients().get(message.getFrom());
							if(fromSession!=null && fromSession.isOpen()){
								try {
									fromSession.sendMessage(new BinaryMessage(message.receiptSuccess().getMessages()));
								} catch (IOException e) {
								}
							}
						}
					}
				}
			}
			}
		} catch (InterruptedException e) {
			logger.error(e.getMessage());
		}	
	}
	
	/**
	  * 广播消息
	  * @param currentSession
	  * @param imProtocol
	  */
	 public void broadcast(Message message){
		/*
		 if(imProtocol.eqType(IMProtocol.Type.VOICE_SHORT)){
			 //生成语音文件（另起一个线程）
			 try {
					System.out.println(imProtocol.getTimeMillis() + ".amr");
					fis = new FileOutputStream("/Users/wangbao/Desktop/" + imProtocol.getTimeMillis() + ".amr",true);
					fis.write(imProtocol.getContent());
					 fis.flush();
					 fis.close();
					if (imProtocol.isCompleteStatus()){
						System.out.println("========================= isCompleteStatus");
	                    fis.close();
	                    fis = null;
					}
			} catch (Exception e) {
				e.printStackTrace();
			}
		 }
		 */
		
		/**
		 * 从客户端发送的确认回执单（发送成功确认单），用于判断数据发送到客户端是否成功，如果长时间没有接受到客户发回的回执信息，这将之前发送给客户的失败信息放入到 失败序列中，等待下一次发送
		 * 注：因为增加了失败数据发送情况，防止语音发生错乱，建议语音采用下载方式-（是否考虑采用顺序的方式进行处理）
		 */
		if(message.eqStatus(IMProtocol.Status.RECEIPT_SUCCESS)){
			//客户端回执的状态成功，删除已经发送的缓存对象
			cacheMessageMap.remove(message.getMessageId());
		}else{
			//客户端发送的信息向序列中加入消息对象
			try {
				messageQueue.put(message);
			} catch (InterruptedException e) {
				logger.error(e.getMessage());
			}
		}
		
		//向发送客户端的发送者 发送回执确认信息
		if(message.isCompleteStatus()){
			logger.debug("向 " + message.getTo() + "发送消息了" + message.getTextContent());
			WebSocketSession fromSession = WebSocketContext.getSessionClients().get(message.getFrom());
			if(fromSession!=null && fromSession.isOpen()){
			    //向发送者发送确认单信息（回执单信息）
				try{
					fromSession.sendMessage(new BinaryMessage(message.receiptSuccess().getMessages()));
				}catch(Exception ex){}
			}
			scheduleExecutor.schedule(()->{
				//将长时间没有确认成功的数据放到失败队列中，用于将来重新发送
				Message msg = cacheMessageMap.remove(message.getMessageId());
				if(msg != null){
					failureQueue.put(msg);
					if(logger.isDebugEnabled()){
						logger.debug(message.getFrom()+" 向 "+message.getTo()+" 消息发送未收到客户端的接受确认");
					}
				}						
			}, RECEIPT_ACKNOWLEDGE_TIMEOUT, TimeUnit.SECONDS);
		}
	 }

	 public void sendMessage(Message message){
		 broadcast(message);
	 }
	 
	 /**
	  * 广播消息
	  * @param message
	  * @param allowSendSelf  true 可以给自己发，false 不给自己发
	  */
	 public void sendMessage(Message message,boolean allowSendSelf){
			//向平板端（管理人员及 web 管理人） 发送矫正人员的 位置信息
		 Map<String,WebSocketSession> clients = WebSocketContext.getSessionClients();
		 String toId = message.getTo();
		 if(toId!=null){
			 WebSocketSession session = clients.get(toId);
			 if(session != null){
				 sendMessage(session,message,allowSendSelf);
			 }
		 }
	 }
	 /**
	  * 发送命令给客户端（android 手机端 或 平板端）
	  * @param command
	  */
	 public void sendCommand(Command command){
		//向平板端（管理人员及 web 管理人） 发送矫正人员的 位置信息
		 Map<String,WebSocketSession> clients = WebSocketContext.getSessionClients();
		 String toId = command.getTo();
		 if(toId!=null){
			 WebSocketSession session = clients.get(toId);
			 if(session != null){
				 String locJson = JSONHelper.beanToJson(command);
				 TextMessage message = new TextMessage(locJson);
				 
				 sendMessage(session,message);
			 }
		 }else{
			 //手机发向平板信息（报警、电量不足、签到信息等），手机矫正人员发送给 矫正管理人员
			 if(Command.DIRECTION_PHONE_TO_PAD == NumberUtil.toInt(command.getDirection())){
				 // 根据当前发过来的
				 List<GroupUser> gusers = groupService.getOwnerManagerGroupByAid(command.getFrom());
				 for(GroupUser u:gusers){
					 WebSocketSession session = clients.get(u.getAid());
					 if(session != null){
						 command.setTo(u.getAid());
						 String locJson = JSONHelper.beanToJson(command);
						 TextMessage message = new TextMessage(locJson);
							
						 sendMessage(session,message);
					 }
				 }
			 }else{
				 for(String sid : clients.keySet()){
					 if(!sid.equals(command.getFrom())){
						 WebSocketSession session = clients.get(sid);
						 command.setTo(sid);
						 String locJson = JSONHelper.beanToJson(command);
						 TextMessage message = new TextMessage(locJson);
						 sendMessage(session,message);
					 }
				 }
			 }
		 }
	 }
	 
	 /**
	  * 向平板或 web 网页发送 矫正人缘的 位置信息
	  * @param location
	  */
	 public void sendLocation(Location location){
		 //向平板端（管理人员及 web 管理人） 发送矫正人员的 位置信息
		 Map<String,WebSocketSession> clients = WebSocketContext.getSessionClients();
		 String toId = location.getTo();
		 if(toId!=null){
			 WebSocketSession session = clients.get(toId);
			 if(session != null){
				 location.setTo(null);
				 String locJson = JSONHelper.beanToJson(location);
				 TextMessage message = new TextMessage(locJson);
				 
				 sendMessage(session, message);
			 }
		 }else{
			 //地理位置推送给全部在线用户
			 for(WebSocketSession session : clients.values()){
				 location.setTo(null);
				 String locJson = JSONHelper.beanToJson(location);
				 TextMessage message = new TextMessage(locJson);
				 sendMessage(session, message);
			 }
		 }
	 }
	 
	 /**
	  * 发送在线通知
	  * @param onlineAid
	  */
	 public void sendOnlineNotify(String onlineAid){
		 for(OnConnectionNotify notify : onConnectionNotifySet){
			 notify.onlineNotify(onlineAid);
		 }
	 }
	 
	 /**
	  * 发送离线通知
	  */
	 public void sendOfflineNotify(String offineAid){
		 for(OnConnectionNotify notify : onConnectionNotifySet){
			 notify.offlineNotify(offineAid);
		 }
	 }
	 
	 
	/**
	 * 设置连接通知事件
	 * @param onConnectionNotify
	 */
	public void setOnConnectionNotify(OnConnectionNotify onConnectionNotify) {
		this.onConnectionNotifySet.add(onConnectionNotify);
	}
	
	ScheduledExecutorService scheduleExecutor =  Executors.newScheduledThreadPool(SCHEDULED_THREAD_POOL);
	
	private synchronized void sendMessage(WebSocketSession session,TextMessage textMessage){
		 try{
			 if(session.isOpen()){
				 session.sendMessage(textMessage);
			 }
		 }catch (Exception e) {
			 e.printStackTrace();
		 }
	}
	/**
	 * 发送消息
	 * @param session
	 * @param message
	 * @param allowSendSelf 允许给自己发消息  true 运行  false 不允许
	 */
	private synchronized void sendMessage(WebSocketSession session,Message message,boolean allowSendSelf){
		if(session.isOpen()){
			try {
				 String from = message.getFrom();
				 //数据超长的时候还没有考虑，超长的时候发送 失败确认单 （ isOverflow() ）
				 //将发送的消息发给 客户端不等于自己的 session
				 if(!from.equals(WebSocketContext.getAccountId(session)) || allowSendSelf){
					 //不是自己的客户端  or  允许发送给自己的
					if(WebSocketContext.isWebClient(session)){
						////发送到 web 网页客户端的消息不放到缓存中（web 端暂时不做是否接受成功的确认信息）
						////cacheMessageMap.put(message.getMessageId(), message);
						//向 web client
						String json = JSONHelper.beanToJson(message);
						System.out.println(json);
						session.sendMessage(new TextMessage(json));
					}else{
						// android or ios client
						cacheMessageMap.put(message.getMessageId(), message);
						session.sendMessage(new BinaryMessage(message.getMessages()));
					}
				 }
			} catch (IOException e) {
				logger.error(e.getMessage());
				//发送消息超时,将消息放到失败的队列中
				failureQueue.put(message);
				//将缓存需要确认的消息给除掉
				cacheMessageMap.remove(message.getMessageId());
			}
		}else{
			//会话关闭的用户，将数据放到发送错误队列中，之后自动发送
			failureCache.offer(message);
			//将缓存需要确认的消息给除掉
			cacheMessageMap.remove(message.getMessageId());
			logger.error("session 不是打开状态，重新发送");
		}
	}
}
