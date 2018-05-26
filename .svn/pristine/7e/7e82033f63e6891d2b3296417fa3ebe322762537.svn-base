/**
 * @Description TODO(用一句话描述该文件是做什么功能的，哪个地方使用的，android 还是 jsp 用)
 * @author wangbao
 * @date 2018年4月22日
 */
package com.ehtsoft.proxy.srv;

import org.apache.cxf.jaxws.JaxWsProxyFactoryBean;

import com.ehtsoft.im.api.SMS;

/**
 * @Description TODO(用一句话描述该文件是做什么功能的，哪个地方使用的)
 * @author wangbao
 * @date 2018年4月22日
 *
 */
public class Test {

	public static void main(String[] args){
		JaxWsProxyFactoryBean factory = new JaxWsProxyFactoryBean();
	
	    factory.setServiceClass(SMS.class);
	
	    factory.setAddress("http://localhost:8080/proxy/services/smsservice?wsdl");
	
	 	SMS client = (SMS) factory.create();
	
	    client.sendMessage("1888888888881", "用一句话描述该文件是做什么功能的");
	}
}
