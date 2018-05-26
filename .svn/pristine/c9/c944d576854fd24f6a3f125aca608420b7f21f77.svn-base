package com.ehtsoft.user.utils;

import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;

import com.ehtsoft.fw.core.context.AppException;
import com.ehtsoft.fw.core.dto.BasicMap;
import com.ehtsoft.fw.core.utils.AppUtil;

public class InitUtil {

	public static List<BasicMap<String,Object>> getAccountList(InputStream is) throws AppException{
		List<BasicMap<String,Object>>  rtn = new ArrayList<BasicMap<String,Object>>();
		
		SAXReader reader = new SAXReader();
		try {
			Document doc = reader.read(is);
			Element root = doc.getRootElement();
			if(!"accounts".equals(root.getName())){
				throw new AppException("导入应用文件格式错误");
			}
			List<Element> accounts = root.elements("account");
			if(accounts!=null){
				for(Element account : accounts){
					BasicMap<String,Object> r = new BasicMap<String,Object>();
					for(int i=0;i<account.attributeCount();i++){
						r.put(account.attribute(i).getName(), account.attribute(i).getValue());
					}
					rtn.add(r);
					
					List<Element> roles = account.elements("role");
					if(roles!=null){
						List<BasicMap<String,Object>> children = new ArrayList<BasicMap<String,Object>>();
						for(Element menu : roles){
							BasicMap<String,Object> m = new BasicMap<String,Object>();
							m.put("rolecode", menu.attributeValue("rolecode"));
							m.put("rolename", menu.attributeValue("rolename"));
							children.add(m);
						}
						r.put("children", children);
					}
				}
			}
		} catch (DocumentException e) {
			throw new AppException("导入应用文件格式错误");
		}
		return rtn;
	}
	
	public static List<BasicMap<String,Object>> getRoleList(InputStream is) throws AppException{
		List<BasicMap<String,Object>>  rtn = new ArrayList<BasicMap<String,Object>>();
		
		SAXReader reader = new SAXReader();
		try {
			Document doc = reader.read(is);
			Element root = doc.getRootElement();
			if(!"roles".equals(root.getName())){
				throw new AppException("导入应用文件格式错误");
			}
			List<Element> roles = root.elements("role");
			if(roles!=null){
				for(Element role : roles){
					BasicMap<String,Object> r = new BasicMap<String,Object>();
					for(int i=0;i<role.attributeCount();i++){
						r.put(role.attribute(i).getName(), role.attribute(i).getValue());
					}
					rtn.add(r);
					
					List<Element> menus = role.elements("menu");
					if(menus!=null){
						List<BasicMap<String,Object>> children = new ArrayList<BasicMap<String,Object>>();
						for(Element menu : menus){
							BasicMap<String,Object> m = new BasicMap<String,Object>();
							m.put("menucode", menu.attributeValue("menucode"));
							m.put("menuname", menu.attributeValue("menuname"));
							children.add(m);
						}
						r.put("children", children);
					}
				}
			}
		} catch (DocumentException e) {
			throw new AppException("导入应用文件格式错误");
		}
		return rtn;
	}
	//解析场景
	public static List<BasicMap<String,Object>> getSceneList(InputStream is) throws AppException{
		List<BasicMap<String,Object>>  rtn = new ArrayList<BasicMap<String,Object>>();
		
		SAXReader reader = new SAXReader();
		try {
			Document doc = reader.read(is);
			Element root = doc.getRootElement();
			if(!"scenes".equals(root.getName())){
				throw new AppException("导入应用文件格式错误");
			}
			List<Element> roles = root.elements("scene");
			if(roles!=null){
				for(Element role : roles){
					BasicMap<String,Object> r = new BasicMap<String,Object>();
					for(int i=0;i<role.attributeCount();i++){
						r.put(role.attribute(i).getName(), role.attribute(i).getValue());
					}
					rtn.add(r);
				}
			}
		} catch (DocumentException e) {
			throw new AppException("导入应用文件格式错误");
		}
		return rtn;
	}
}
