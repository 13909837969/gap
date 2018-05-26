/**
 * @Description TODO(用一句话描述该文件是做什么功能的，哪个地方使用的，android 还是 jsp 用)
 * @author wangbao
 * @date 2018年4月22日
 */
package com.ehtsoft.im.api;

import org.apache.cxf.endpoint.Client;
import org.apache.cxf.frontend.ClientProxy;
import org.apache.cxf.jaxws.JaxWsProxyFactoryBean;
import org.apache.cxf.transport.http.HTTPConduit;
import org.apache.cxf.transports.http.configuration.HTTPClientPolicy;

import com.ehtsoft.fw.core.config.Deploy;
import com.ehtsoft.fw.core.dto.Dataset;
import com.ehtsoft.fw.core.services.HTTPService;
import com.ehtsoft.im.api.SMS;
import com.ehtsoft.im.api.Video;
import com.ehtsoft.im.protocol.Command;
import com.ehtsoft.im.protocol.Location;
import com.ehtsoft.im.services.VideoService;


/**
 * @Description TODO(用一句话描述该文件是做什么功能的，哪个地方使用的)
 * @author wangbao
 * @date 2018年4月22日
 * CXF Webservice 生产环境 连接超时 （暂时不用）
 * 目前采用的是  http post 请求
 */
@Deprecated
public class JaxWsProxyFactoryUtil {

	/**
	 * 
	 * 获取 WS 客户端
	 * @param address
	 * @param clazz
	 * @return<br>
	 * 返回 WS 客户端接口方法
	 * @author wangbao
	 * @date   2018年4月22日
	 */
	public static <T> T getWebServiceClient(String address,Class<T> clazz){
		JaxWsProxyFactoryBean factory = new JaxWsProxyFactoryBean();
	    factory.setServiceClass(clazz);
	    factory.setAddress(address);
	 	T  client = (T) factory.create();
	 	setTimeout(client);
	 	return client;
	}
	/**
	 * 发送短信方法
	 * @param mobile  
	 * @param message
	 * @return<br>
	 * @author wangbao
	 * @date   2018年4月22日
	 */
	public static String sendSmsMessage(String mobile,String message){
		String smsAddr = Deploy.getProperty("proxy.sms.address");
		SMS sms = getWebServiceClient(smsAddr, SMS.class);
		sms.sendMessage(mobile, message);
		return null;
	}
	
	/**
	 * 视频注册功能
	 * @param accountid
	 * @param name
	 * @return<br>
	 * @author wangbao
	 * @date   2018年4月22日
	 * 方法的作用：TODO
	 */
	public static String registerVideo(String accountid,String name){
		String videoAddr = Deploy.getProperty("proxy.video.address");
		Video video = getWebServiceClient(videoAddr, Video.class);
		String rtn = video.register(accountid, name);
		return rtn;
	}
	
	/**
	 * 刷新 video token
	 * @param accountid
	 * @return<br>
	 * 返回值格式:<br>
	 * 
	 * @author wangbao
	 * @date   2018年4月22日
	 * 方法的作用：TODO
	 */
	public static String loginVideo(String accountid){
		String videoAddr = Deploy.getProperty("proxy.video.address");
		Video video = getWebServiceClient(videoAddr, Video.class);
		String rtn = video.login(accountid);
		return rtn;
	}
	
	/**
	 * 获取 WebSocket 接口服务
	 * @return<br>
	 * 返回值格式:<br>
	 *
	 * @author wangbao
	 * @date   2018年5月2日
	 * 方法的作用：TODO
	 */
	public static WSService getWSService(){
		String wsAddr = Deploy.getProperty("proxy.ws.address");
		return getWebServiceClient(wsAddr, WSService.class);
	}
	
	public static void setTimeout(Object proxyObject){
		Client proxy = ClientProxy.getClient(proxyObject);
		HTTPConduit conduit = (HTTPConduit) proxy.getConduit();
	    HTTPClientPolicy policy = new HTTPClientPolicy();
	    policy.setConnectionTimeout(10000); //连接超时时间
	    policy.setReceiveTimeout(20000);//请求超时时间.
	    conduit.setClient(policy);
	}
	
	public static void main(String[] args){
		//sendSmsMessage("18640860665","用一句话描述该文件是做什么功能的");
//		System.out.println(registerVideo("test01", "test"));
//		System.out.println(loginVideo("test01"));
//		WSService video = getWebServiceClient("http://10.12.1.14:8085/proxy/services/wsservice?wsdl", WSService.class);
	
//		video.http://10.12.1.14:8085/http://10.12.1.14:8085/sendCommand(new Command());
		
		ProxyApiFactory proxy = ProxyApiFactory.getInstance();
		
		proxy.broadcast("aaaaaa");
		proxy.login("test");
		proxy.register("test", "test");
		proxy.sendCommand(new Command());
		proxy.sendLocation(new Location());
		proxy.sendMessage("message");
		proxy.sendMessage("18640860665", "18640860665");
		proxy.sendMessageIsSelf("base64message", true);
	
	}
	
}
