/**
 * @Description TODO(用一句话描述该文件是做什么功能的，哪个地方使用的，android 还是 jsp 用)
 * @author wangbao
 * @date 2018年5月14日
 */
package com.ehtsoft.common.servlet;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.HashMap;
import java.util.Map;


import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.export.JRPdfExporter;
import net.sf.jasperreports.export.PdfReportConfiguration;
import net.sf.jasperreports.export.SimpleExporterInput;
import net.sf.jasperreports.export.SimpleOutputStreamExporterOutput;
import net.sf.jasperreports.export.SimplePdfReportConfiguration;

/**
 * @Description TODO(用一句话描述该文件是做什么功能的，哪个地方使用的)
 * @author wangbao
 * @date 2018年5月14日
 *
 */
public class JasperTest {

	
	
	public static void main(String[] args){
		//
		/**
		 * com.ehtsoft.supervise.database=postgres
			com.ehtsoft.supervise.db.driver=org.postgresql.Driver
			com.ehtsoft.supervise.db.url=jdbc:postgresql://192.168.3.18:5432/supervise
			com.ehtsoft.supervise.db.username=postgres
			com.ehtsoft.supervise.db.password=root
		 */
		
		try {
			Class.forName("org.postgresql.Driver");
			Connection conn = DriverManager.getConnection("jdbc:postgresql://192.168.3.18:5432/supervise", 
					"postgres", 
					"root");
			
//			Statement statement = conn.createStatement();
//			ResultSet rs = statement.executeQuery("select data from jz_jzryjbxx_img where imgid = 'NM0000000000000000JZ0000002018010027'");
//			if(rs.next()){
//				
//			}
			InputStream iStream = JasperTest.class.getClassLoader().getResourceAsStream("META-INF/jasper/jz_sqjzryxx.jrxml");
			JasperReport report = JasperCompileManager.compileReport(iStream);
			Map<String,Object> parameters = new HashMap<>();
			parameters.put("aid", "NM00000000000000000JZ150820150803001");
			JasperPrint jasperPrint = JasperFillManager.fillReport(report, parameters, conn);
		
			JRPdfExporter exporter = new JRPdfExporter();
			PdfReportConfiguration pdfReport = new SimplePdfReportConfiguration();
			exporter.setConfiguration(pdfReport);
			
			exporter.setExporterInput(new SimpleExporterInput(jasperPrint));
			exporter.setExporterOutput(new SimpleOutputStreamExporterOutput(new File("/Users/wangbao/Desktop/model/aaaa.pdf")));
			exporter.exportReport();
			
			System.out.println("=========== 完成 ==========");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
}
