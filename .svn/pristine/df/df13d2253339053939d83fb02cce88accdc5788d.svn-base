/**
 * @Description TODO(用一句话描述该文件是做什么功能的，哪个地方使用的，android 还是 jsp 用)
 * @author wangbao
 * @date 2018年4月22日
 */
package com.ehtsoft.im.services;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.config.RequestConfig;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;

import com.ehtsoft.fw.core.dto.BasicMap;
import com.ehtsoft.fw.core.utils.helper.JSONHelper;
import com.ehtsoft.fw.utils.EncryptUtil;
import com.ehtsoft.fw.utils.StringUtil;
import com.ehtsoft.im.api.Video;


/**
 * @Description TODO(用一句话描述该文件是做什么功能的，哪个地方使用的)
 * @author wangbao
 * @date 2018年4月22日
 *
 */
public class VideoService implements Video{
	private Log logger = LogFactory.getLog(VideoService.class);
	private String regAddr = "https://api.netease.im/nimserver/user/create.action";
	private String refreshAddr = "https://api.netease.im/nimserver/user/refreshToken.action";
	
	private String key = "95654677f6aa75b4e69d098e69338668";
	private static String secret = "bb43842e22a0"; // 67bbb59fc6c1

	@Override
	public String register(String accountid, String name) {
		CloseableHttpClient httpclient = HttpClients.createDefault();
		HttpPost httpPost = new HttpPost(regAddr);
		
		RequestConfig requestConfig = RequestConfig.custom()    
		        .setConnectTimeout(1500)
		        .setConnectionRequestTimeout(1500)
		        .setSocketTimeout(1500).build();
		httpPost.setConfig(requestConfig);
		
		addWYHeader(httpPost);
		
		// 设置请求的参数
		// 打印执行结果
		String json= null;
		List<NameValuePair> nvps = new ArrayList<NameValuePair>();
		nvps.add(new BasicNameValuePair("accid", accountid));//设置自己的登陆用户名
		nvps.add(new BasicNameValuePair("name", name));//设置自己的账号
		// 执行请求
		HttpResponse response = null ;
		try {
			UrlEncodedFormEntity ent = new UrlEncodedFormEntity(nvps, "utf-8");
			httpPost.setEntity(ent);
			// 执行请求
			response = httpclient.execute(httpPost);
			// 打印执行结果
			json =   EntityUtils.toString(response.getEntity(), "utf-8");
		} catch (Exception e) {
			e.printStackTrace();
		}
	    String rtn = neteaseToken(json);
	    logger.debug("netease video register success : " + rtn);
	    return rtn;
	}

	@Override
	public String login(String accountid){
		  String jsons = refreshToken(accountid); //第一次 解析
	        if(jsons!=null){
	        	String r = neteaseToken(jsons);
	        	logger.debug("netease video login success : " + r);
	        	return r;
	        }else{
	        	logger.debug("netease video login error.");
	        	return "";
	        }
	}

	private String refreshToken(String accountid) {
		//打印结果
		String  json = null;
	
		CloseableHttpClient httpclient = HttpClients.createDefault();
		HttpPost httpPost = new HttpPost(refreshAddr);
		
		RequestConfig requestConfig = RequestConfig.custom()    
		        .setConnectTimeout(1500)
		        .setConnectionRequestTimeout(1500)    
		        .setSocketTimeout(1500).build();   
		httpPost.setConfig(requestConfig);
		
		addWYHeader(httpPost);
		// 设置请求的参数
		List<NameValuePair> nvps = new ArrayList<NameValuePair>();
		nvps.add(new BasicNameValuePair("accid", accountid));//设置自己的登陆用户名
		// 执行请求
		HttpResponse response;
		try {
			UrlEncodedFormEntity ent = new UrlEncodedFormEntity(nvps, "utf-8");
			httpPost.setEntity(ent);
			// 执行请求
			 response = httpclient.execute(httpPost);
			// 打印执行结果
			 json = EntityUtils.toString(response.getEntity(), "utf-8");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return json;
	}
	
	
	/**
	 * json解析
	 * @param jsons
	 * @return
	 */
	private String neteaseToken(String jsons) {
		  if(jsons!=null){
			   BasicMap<String,Object> basicMap =  JSONHelper.jsonToMap(jsons);
		       try {
			       Object jsonss = basicMap.get("info");
			       if(jsonss instanceof Object) {
			       		return StringUtil.toString(((BasicMap<String, Object>)jsonss).get("token"));
			       }
		       }catch(Exception ex) {
		       }
		   }
	       return "";
	}
	
	private void addWYHeader(HttpPost httpPost) {

		String nonce = "12345";
		String curTime = String.valueOf((new Date()).getTime() / 1000L);
		String check = secret + nonce + curTime;
		String checkSum = EncryptUtil.encrypt(EncryptUtil.ALGORITHM_SHA1, check);

		// 设置请求的header
		httpPost.addHeader("AppKey", key);
		httpPost.addHeader("Nonce", nonce);
		httpPost.addHeader("CurTime", curTime);
		httpPost.addHeader("CheckSum", checkSum);
		httpPost.addHeader("Content-Type", "application/x-www-form-urlencoded;charset=utf-8");
	}
	
	
	public void setRegAddr(String regAddr) {
		this.regAddr = regAddr;
	}

	public void setRefreshAddr(String refreshAddr) {
		this.refreshAddr = refreshAddr;
	}

	public void setKey(String key) {
		this.key = key;
	}

	public static void setSecret(String secret) {
		VideoService.secret = secret;
	}

	//测试
	public static void main(String[] args) {
		VideoService vs = new VideoService();
		System.out.println(vs.register("A0001", "张三"));
		
		System.out.println("==========================");
		
		System.out.println(vs.login("A0001"));
	}

}
