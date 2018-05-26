package com.ehtsoft.supervise.api.services;

import java.io.ByteArrayInputStream;
import java.util.List;

import javax.xml.namespace.QName;

import org.apache.cxf.endpoint.Client;
import org.apache.cxf.jaxws.endpoint.dynamic.JaxWsDynamicClientFactory;
import org.dom4j.Document;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;
import org.springframework.stereotype.Service;

import com.ehtsoft.fw.core.dto.BasicMap;
import com.ehtsoft.fw.core.services.AbstractService;

/**
 * 内蒙民政信息共享-接口
 */
public class MzdbService extends AbstractService {
	
	private String url;
	private String name;
	private String namespace;
	
	public void setName(String name) {
		this.name = name;
	}

	public void setNamespace(String namespace) {
		this.namespace = namespace;
	}
	
	public void setUrl(String url) {
		this.url = url;
	}

	@SuppressWarnings("unchecked")
	public BasicMap<String,Object> getMzdbMap(String sfzh){
		JaxWsDynamicClientFactory factory = JaxWsDynamicClientFactory
				.newInstance();
		Client client = factory.createClient(url);
		BasicMap<String,Object> map = new BasicMap<String,Object>();
		try {
			String xml = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>"
					+ "<MsgText> "
					+ "<username>test</username> "
					+ "<password>test</password> "
					+ "<dealingid>MZCX1010</dealingid> "
					+ "<sfzhm>"+sfzh+"</sfzhm>"
					+ "</MsgText>";
			QName opName = new QName(namespace,name);
			Object[] ry = client.invoke(opName, xml);
			
			SAXReader reader = new SAXReader();
			Document document = reader.read(new ByteArrayInputStream(ry[0].toString().getBytes("utf-8")));//读取xml字符串，注意这里要转成输入流  
			
			Element root = document.getRootElement();//获取根元素  
	        List<Element> childElements = root.elements();//获取当前元素下的全部子元素  
	  
	        for (Element child : childElements) {//循环输出全部childElements的相关信息  
	                String name = child.getName();//获取当前元素名  
	                String text = child.getText();//获取当前元素值  
	                map.put(name, text);
	        }  
		} catch (Exception e) {               
			System.out.println("错误："+e.getMessage());
		}
		return map;
	}
}
