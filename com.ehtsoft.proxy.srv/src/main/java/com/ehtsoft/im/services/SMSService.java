/**
 * @Description TODO(用一句话描述该文件是做什么功能的，哪个地方使用的，android 还是 jsp 用)
 * @author wangbao
 * @date 2018年4月22日
 */
package com.ehtsoft.im.services;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.ehtsoft.im.api.SMS;

/**
 * @author wangbao
 * @date 2018年4月22日
 *
 */
public class SMSService implements SMS{

	private Log logger = LogFactory.getLog(SMSService.class);
	private String address;
	private String uid;
	private String key;
	private boolean enable = false;
	
	public static void main(String[] args){
		String sms_address="http://utf8.sms.webchinese.cn/?Uid=";
//		sms_address="http://utf8.api.smschinese.cn/?Uid=";
		String sms_uid="faw-interlog-sub";
		String sms_key="b32c8fabe03c0242d373";
		
		sms_uid = "ltsms";
		sms_key = "58e8ae952c9439a77c06";
		
		SMSService sms = new SMSService();
		sms.setAddress(sms_address);
		sms.setUid(sms_uid);
		sms.setKey(sms_key);
		sms.setEnable(true);
		String s = "18640860665";//"18947188074";
		sms.sendMessage(s, "密码验证码：222222");
	}
	
	@Override
	public void sendMessage(String mobile, String msg) {
		System.out.println("向手机 " + mobile + " 发送消息为 " + msg);
		logger.info("向手机 " + mobile + " 发送消息为 " + msg);
		Thread thread = new Thread(new Runnable() {
			@Override
			public void run() {
				  if(!enable){
					  return;
				  }
				  HttpURLConnection httpconn = null;
				  try {
					  StringBuilder sb = new StringBuilder();
					  sb.append(address);
					  sb.append(uid);
					  sb.append("&Key=").append(key);
					  sb.append("&smsMob=").append(mobile); 
					  sb.append("&smsText=").append(URLEncoder.encode(msg, "utf-8"));
					  
					  URL url = new URL(sb.toString());
					  httpconn = (HttpURLConnection) url.openConnection();
					  BufferedReader rd = new BufferedReader(new InputStreamReader(httpconn.getInputStream()));
					  String result = rd.readLine();
					  logger.info("执行短信发送返回值为:" + result);
					  if("-1".equals(result)){				  
						  logger.error("短信平台没有该用户账户");
					  }
					  if("-2".equals(result)){				  
						  logger.error("接口密钥不正确 [查看密钥]");
					  }
					  if("-21".equals(result)){
						  logger.error("MD5接口密钥加密不正确");
					  }
					  if("-3".equals(result)){
						  logger.error("短信数量不足");
					  }
					  if("-11".equals(result)){
						  logger.error("该用户被禁用");
					  }
					  if("-14".equals(result)){
						  logger.error("短信内容出现非法字符");
					  }
					  rd.close();
				  } catch (MalformedURLException e) {
					  e.printStackTrace();
				  } catch (IOException e) {
					  e.printStackTrace();
				  } finally{
					  if(httpconn!=null){
						  httpconn.disconnect();
						  httpconn=null;
					  }
				  }
			}
		});
		thread.start();
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getUid() {
		return uid;
	}
	public void setUid(String uid) {
		this.uid = uid;
	}
	public String getKey() {
		return key;
	}
	public void setKey(String key) {
		this.key = key;
	}
	public boolean isEnable() {
		return enable;
	}
	public void setEnable(boolean enable) {
		this.enable = enable;
	}

}
