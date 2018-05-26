package com.ehtsoft.common.services;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;

import com.ehtsoft.fw.core.db.SqlDbClient;
/**
 * 清除无效数据（图片）服务
 * @author wangbao
 */
public class CleanService{

	@Resource(name="sqlDbClient")
	private SqlDbClient dbClient;
	
	public void remove(){
		List<String> list = getCleanSql();
		for(String sql : list){
			Connection conn = dbClient.getConnection();
			PreparedStatement psmt = null;
			try {
				psmt = conn.prepareStatement(sql);
				psmt.execute();
				conn.commit();//事物提交
			} catch (SQLException e) {
				try {
					conn.rollback();
				} catch (SQLException e1) {
				}
			} finally{
				try{
					if(psmt!=null){
						psmt.close();
					}
				}catch(SQLException e){
				}
				try {
					if(conn!=null){
						conn.close();
					}
				} catch (SQLException e) {
				}
			}
		}
	}
	
	private List<String> getCleanSql(){
		List<String> rtn = new ArrayList<String>();
		InputStream is = Thread.currentThread().getContextClassLoader().getResourceAsStream("META-INF/conf/clean_invalid_img.xml");
		if(is!=null){
			SAXReader reader = new SAXReader();
			try {
				Document doc = reader.read(is);
				Element root = doc.getRootElement();
				List<Element> list = root.elements("clean-sql");
				for(Element e : list){
					rtn.add(e.getTextTrim());
				}
			} catch (DocumentException e) {
			}
		}
		return rtn;
	}
}
