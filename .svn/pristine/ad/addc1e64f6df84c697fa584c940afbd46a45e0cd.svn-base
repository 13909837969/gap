/**
 * @Description TODO(用一句话描述该文件是做什么功能的，哪个地方使用的，android 还是 jsp 用)
 * @author wangbao
 * @date 2018年5月10日
 */
package com.ehtsoft.im.api;


import com.ehtsoft.fw.core.config.Deploy;
import com.ehtsoft.fw.core.dto.BasicMap;
import com.ehtsoft.fw.core.dto.Dataset;
import com.ehtsoft.fw.core.services.HTTPService;
import com.ehtsoft.fw.core.utils.helper.JSONHelper;
import com.ehtsoft.fw.utils.JsonUtil;
import com.ehtsoft.fw.utils.StringUtil;
import com.ehtsoft.im.protocol.Command;
import com.ehtsoft.im.protocol.Location;

/**
 * @Description TODO(用一句话描述该文件是做什么功能的，哪个地方使用的)
 * @author wangbao
 * @date 2018年5月10日
 *
 */
public class ProxyApiFactory implements SMS,Video,WSService{
	
	private static ProxyApiFactory instance;
	
	private HTTPService service = HTTPService.getInstance("");
	
	
	private ProxyApiFactory(){
		
	}
	
	public static ProxyApiFactory getInstance(){
		if(instance==null){
			instance = new ProxyApiFactory();
			String url = Deploy.getProperty("proxy.url.post");
			instance.service.setUrl(url);
		}
		return instance;
	} 
	/* 
	 * 短信接口
	 * @see com.ehtsoft.im.api.SMS#sendMessage(java.lang.String, java.lang.String)
	 * <p>发送短信方法</p>
	 * <p>Description:  </p>
	 * @param mobile  手机号
	 * @param msg     短信内容
	 */
	@Override
	public void sendMessage(String mobile, String msg) {
		Dataset dataset = new Dataset();
		dataset.setService("SMS");
		dataset.setMethod("sendMessage");
		dataset.getArguments().add(mobile);
		dataset.getArguments().add(msg);
		service.doPost(dataset);
	}

	/* 
	 * 视频注册接口
	 * @see com.ehtsoft.im.api.Video#register(java.lang.String, java.lang.String)
	 * <p>Title:register</p>
	 * <p>注册方法</p>
	 * @param accountid  注册账号
	 * @param name       注册名称
	 * @return           注册的token
	 */
	@Override
	public String register(String accountid, String name) {
		Dataset dataset = new Dataset();
		dataset.setService("Video");
		dataset.setMethod("register");
		dataset.getArguments().add(accountid);
		dataset.getArguments().add(name);
		String json = service.doPost(dataset);
		String rtn = "";
		if(JsonUtil.isJsonObject(json)){
			BasicMap<String, Object> bm = JSONHelper.jsonToMap(json);
			if(bm!=null){
				rtn = StringUtil.toEmptyString(bm.get("value"));
			}
		}
		return rtn;
	}

	/* 
	 * 视频登录接口
	 * @see com.ehtsoft.im.api.Video#login(java.lang.String)
	 * <p>Title:login</p>
	 * <p>视频登录的方法 </p>
	 * @param accountid	 登录账号
	 * @return			登录的token
	 */
	@Override
	public String login(String accountid) {
		Dataset dataset = new Dataset();
		dataset.setService("Video");
		dataset.setMethod("login");
		dataset.getArguments().add(accountid);
		String json = service.doPost(dataset);
		String rtn = "";
		if(JsonUtil.isJsonObject(json)){
			BasicMap<String, Object> bm = JSONHelper.jsonToMap(json);
			if(bm!=null){
				rtn = StringUtil.toEmptyString(bm.get("value"));
			}
		}
		return rtn;
	}

	
	/**
	 * 消息推送接口方法（WebSocket代理推送）
	 */
	
	/* (non-Javadoc)
	 * @see com.ehtsoft.im.api.WSService#broadcast(java.lang.String)
	 * <p>Title:broadcast</p>
	 * <p>Description:  </p>
	 * @param base64Message
	 */
	@Override
	public void broadcast(String base64Message) {
		Dataset dataset = new Dataset();
		dataset.setService("WSService");
		dataset.setMethod("broadcast");
		dataset.getArguments().add(base64Message);
		service.doPost(dataset);
	}

	/* (non-Javadoc)
	 * @see com.ehtsoft.im.api.WSService#sendMessage(java.lang.String)
	 * <p>Title:sendMessage</p>
	 * <p>Description:  </p>
	 * @param base64message
	 */
	@Override
	public void sendMessage(String base64message) {
		Dataset dataset = new Dataset();
		dataset.setService("WSService");
		dataset.setMethod("sendMessage");
		dataset.getArguments().add(base64message);
		service.doPost(dataset);
	}

	/* (non-Javadoc)
	 * @see com.ehtsoft.im.api.WSService#sendMessageIsSelf(java.lang.String, boolean)
	 * <p>Title:sendMessageIsSelf</p>
	 * <p>Description:  </p>
	 * @param base64message
	 * @param allowSendSelf
	 */
	@Override
	public void sendMessageIsSelf(String base64message, Boolean allowSendSelf) {
		Dataset dataset = new Dataset();
		dataset.setService("WSService");
		dataset.setMethod("sendMessageIsSelf");
		dataset.getArguments().add(base64message);
		dataset.getArguments().add(allowSendSelf);
		service.doPost(dataset);
	}

	/* (non-Javadoc)
	 * @see com.ehtsoft.im.api.WSService#sendCommand(com.ehtsoft.im.protocol.Command)
	 * <p>Title:sendCommand</p>
	 * <p>Description:  </p>
	 * @param command
	 */
	@Override
	public void sendCommand(Command command) {
		Dataset dataset = new Dataset();
		dataset.setService("WSService");
		dataset.setMethod("sendCommand");
		dataset.getArguments().add(command);
		service.doPost(dataset);		
	}

	/* (non-Javadoc)
	 * @see com.ehtsoft.im.api.WSService#sendLocation(com.ehtsoft.im.protocol.Location)
	 * <p>Title:sendLocation</p>
	 * <p>Description:  </p>
	 * @param location
	 */
	@Override
	public void sendLocation(Location location) {
		Dataset dataset = new Dataset();
		dataset.setService("WSService");
		dataset.setMethod("sendLocation");
		dataset.getArguments().add(location);
		service.doPost(dataset);		
	}

}
