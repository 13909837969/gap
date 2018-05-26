package com.ehtsoft.supervise.fwapi;

import java.util.ArrayList;
import java.util.List;

import org.dom4j.Document;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;

import com.ehtsoft.supervise.fwapi.conf.ApiConfig;
import com.ehtsoft.supervise.fwapi.conf.FieldConfig;
import com.ehtsoft.supervise.fwapi.conf.HeaderConfig;
import com.ehtsoft.supervise.fwapi.conf.RespBodyConfig;
import com.ehtsoft.supervise.fwapi.conf.SwapConfig;

public class FwApiHelper {
	
	public static SwapConfig getSwapConfig() throws Exception{
		SwapConfig swap = new SwapConfig();
		HeaderConfig header = new HeaderConfig();
		
		swap.setHeaderConfig(header);
		//读取XML文件,获得document对象  
		SAXReader reader = new SAXReader();    
        Document document = reader.read(FwApiHelper.class.getClassLoader().getResourceAsStream("META-INF/conf/fwapi/fw-api.xml"));
        //获取文档的根节点 -swaps
        Element root = document.getRootElement(); 
        //设置url
        swap.setUrl(root.attributeValue("url"));
        Element eHeader=root.element("header");
        
        header.setAppId(eHeader.elementText("appId"));
        header.setMac(eHeader.elementText("mac"));
        
        Element apis = root.element("apis");
        List<Element> apiList = apis.elements("api");
        swap.setApiList(apiList);
        
        List<ApiConfig> acs = new ArrayList<>();
        for(Element e : apiList) {
        	ApiConfig ac = new ApiConfig();
        	ac.setApiUrl(e.attributeValue("url"));
        	ac.setMethod(e.attributeValue("method"));
        	ac.setAdmOrgCode(e.attributeValue("admOrgCode"));
        	List<RespBodyConfig> lrs = new ArrayList<>();
        	for(Object rso : e.elements("respBody")) {
        		Element rs = (Element)rso;
        		RespBodyConfig rb = new RespBodyConfig();
	        	rb.setLabel(rs.attributeValue("label"));
	        	rb.setLtTable(rs.attributeValue("ltTable"));
	        	lrs.add(rb);
	        	
	        	List<FieldConfig> fcs = new ArrayList<>();
	        	for(Object fie: rs.elements("field")) {
	        		Element fi = (Element)fie;
	        		FieldConfig fied=new FieldConfig();
	        		fied.setFwField(fi.attributeValue("fwField"));
	        		fied.setLabel(fi.attributeValue("label"));
	        		fied.setLtField(fi.attributeValue("ltField"));
	        		fied.setMd5(fi.attributeValue("md5"));
	        		fied.setCode(fi.attributeValue("code"));
	        		fcs.add(fied);
	        	}
	        	rb.setFieldConfigs(fcs);
        	}
        	ac.setRespBodyConfigs(lrs);
        	acs.add(ac);
        }
        swap.setApiConfigs(acs);
     
		return swap;
	   }  
	
	public static void main(String[] args) throws Exception {
		SwapConfig swapConfig = getSwapConfig();
		System.out.println(swapConfig);
	}
}