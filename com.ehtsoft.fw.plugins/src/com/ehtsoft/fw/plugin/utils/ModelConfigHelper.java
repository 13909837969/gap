package com.ehtsoft.fw.plugin.utils;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.dom4j.Document;
import org.dom4j.DocumentFactory;
import org.dom4j.Element;
import org.dom4j.io.OutputFormat;
import org.dom4j.io.SAXReader;
import org.dom4j.io.XMLWriter;



import com.ehtsoft.fw.plugin.model.ColumnConfig;
import com.ehtsoft.fw.plugin.model.ForeignConfig;
import com.ehtsoft.fw.plugin.model.PrimaryConfig;
import com.ehtsoft.fw.plugin.model.TableConfig;
import com.ehtsoft.fw.plugin.model.UniqueConfig;

public class ModelConfigHelper {

	/**
	 * 根据 Excel 表格解析后的数据，生成 model xml 文件
	 * main 方法临时使用
	 * @param tableConfig
	 * @throws Throwable
	 */
	public static void createModelXml(TableConfig tableConfig) throws Throwable{
		String userHome = System.getProperty("user.home");
		File dir = new File(userHome+"/Desktop/model");
		if(!dir.exists()){
			dir.mkdirs();
		}
		FileOutputStream rtn = new FileOutputStream( dir.getPath() + "/" + tableConfig.getName()+"-model.xml");
		
		//column
		List<ColumnConfig> cols = tableConfig.getColumns();
		//primary
		PrimaryConfig primary = tableConfig.getPrimary();
		//unique
		List<UniqueConfig> uns = tableConfig.getUniques();
		//foregin
		List<ForeignConfig> fcs = tableConfig.getForeigns();
		
		DocumentFactory factory = DocumentFactory.getInstance();
		Document doc = factory.createDocument();
		Element root = doc.addElement("model");
		root.addNamespace("xsi","http://www.w3.org/2001/XMLSchema-instance");
		root.addAttribute("xsi:noNamespaceSchemaLocation", "../schema.xsd");
		Element table = root.addElement("table");
		table.addAttribute("name", tableConfig.getName());
		table.addAttribute("label", tableConfig.getLabel());
		if(tableConfig.isBase()){
			table.addAttribute("base", "true");
		}
		if(cols!=null){
			for(ColumnConfig c:cols){
				Element column = table.addElement("column");
				column.addAttribute("field", c.getField());
				//column.addAttribute("property",c.getProperty());
				column.addAttribute("type", c.getType());
				if(c.getLength()!=null && c.getLength()!=0){
					column.addAttribute("length",c.getLength()+"");
				}
				if(c.getPrecision()!=null && c.getPrecision()!=0){
					column.addAttribute("precision",c.getPrecision()+"");
				}
				if(AppUtil.isNotEmpty(c.getDefaultValue())){
					column.addAttribute("defaultValue", c.getDefaultValue());
				}
				column.addAttribute("label", c.getLabel()==null?c.getField():c.getLabel());
				if(c.getRequired()){
					column.addAttribute("required", c.getRequired()+"");
				}
				if(AppUtil.isNotEmpty(c.getRemark())){
					column.addAttribute("remark", c.getRemark());
				}
			}
		}
		if(primary!=null){
			Element pri = table.addElement("primary");
			pri.addAttribute("name", primary.getName());
			pri.addAttribute("field",primary.getField());
		}
		if(uns!=null){
			for(UniqueConfig uc : uns){
				Element un = table.addElement("unique");
				un.addAttribute("name", uc.getName());
				un.addAttribute("field",uc.getField());
			}
		}
		if(fcs!=null){
			for(ForeignConfig fc : fcs){
				Element f = table.addElement("foreign");
				f.addAttribute("name", fc.getName());
				f.addAttribute("field",fc.getField());
				f.addAttribute("reference", fc.getReference());
				f.addAttribute("referField",fc.getReferField());
			}
		}
		if(AppUtil.isNotEmpty(tableConfig.getRemark())){
			Element remark = table.addElement("remark");
			remark.addCDATA(tableConfig.getRemark());
		}
		doc.setXMLEncoding("utf-8");
		XMLWriter writer = new XMLWriter(rtn,OutputFormat.createPrettyPrint());
		writer.write(doc);
		writer.close();
	}
	
	/**
	 * 插件UI调用，生成 model xml 文件
	 * 从数据库中获取表结构等信息生成
	 * @param tablename
	 * @param sqlDb
	 * @return
	 * @throws Throwable
	 */
	public static byte[] createModelXml(String tablename,SqlDBMetaData sqlDb) throws Throwable{
		ByteArrayOutputStream rtn = new ByteArrayOutputStream();
		//主键 name 和 唯一性一直情况，去除 唯一性的 name
		Map<String,String> tmp = new HashMap<String,String>();
		
		//column
		List<ColumnConfig> cols = sqlDb.getColumns(tablename);
		//primary
		List<PrimaryConfig> pris = sqlDb.getPrimarys(tablename);
		//unique
		List<UniqueConfig> uns = sqlDb.getUniques(tablename);
		//foregin
		List<ForeignConfig> fcs = sqlDb.getForeigns(tablename);
		
		DocumentFactory factory = DocumentFactory.getInstance();
		Document doc = factory.createDocument();
		Element root = doc.addElement("model");
		root.addNamespace("xsi","http://www.w3.org/2001/XMLSchema-instance");
		root.addAttribute("xsi:noNamespaceSchemaLocation", "../schema.xsd");
		Element table = root.addElement("table");
		table.addAttribute("name", tablename);
		table.addAttribute("label", tablename);
		
		
		for(ColumnConfig c:cols){
			Element column = table.addElement("column");
			column.addAttribute("field", c.getField());
			//column.addAttribute("property",c.getProperty());
			if("string".equals(c.getType()) && isPrimaryKey(pris,c.getField())){
				column.addAttribute("type", "uuid");
			}else{
				column.addAttribute("type", c.getType());
			}
			if(c.getLength()!=null && c.getLength()!=0){
				column.addAttribute("length",c.getLength()+"");
			}
			if(c.getPrecision()!=null && c.getPrecision()!=0){
				column.addAttribute("precision",c.getPrecision()+"");
			}
			column.addAttribute("label", c.getLabel()==null?c.getField():c.getLabel());
			if(c.getRequired()){
				column.addAttribute("required", c.getRequired()+"");
			}
		}
		
		for(PrimaryConfig pc : pris){
			Element pri = table.addElement("primary");
			pri.addAttribute("name", pc.getName());
			pri.addAttribute("field",pc.getField());
			tmp.put(pc.getName(), pc.getName());
		}
		for(UniqueConfig uc : uns){
			if(tmp.get(uc.getName())==null){
				Element un = table.addElement("unique");
				un.addAttribute("name", uc.getName());
				un.addAttribute("field",uc.getField());
			}
		}
		for(ForeignConfig fc : fcs){
			Element f = table.addElement("foreign");
			f.addAttribute("name", fc.getName());
			f.addAttribute("field",fc.getField());
			f.addAttribute("reference", fc.getReference());
			f.addAttribute("referField",fc.getReferField());
		}
		doc.setXMLEncoding("utf-8");
		XMLWriter writer = new XMLWriter(rtn,OutputFormat.createPrettyPrint());
		writer.write(doc);
		writer.close();
		return rtn.toByteArray();
	}
	
	private static boolean isPrimaryKey(List<PrimaryConfig> pris,String field){
		boolean rtn = false;
		for(PrimaryConfig pc : pris){
			if(pc.getField().equalsIgnoreCase(field)){
				rtn = true;
				break;
			}
		}
		return rtn;
	}
	
	

	
	public static void main(String[] args){
		SqlDBMetaData sqlDb;
		/* 第一种方法，根据数据库中的表生成 model.xml 模型文件
		try {
			sqlDb = SqlDBMetaDataFactory.createSqlDBMetaData("org.postgresql.Driver", "jdbc:postgresql://172.16.30.58:5432/fw_core", "postgres", "root");
			sqlDb.setCatalog("fw_core");
			sqlDb.setSchema("public");
			createModelXml("core_personnel",sqlDb);
		} catch (Throwable e) {
			e.printStackTrace();
		} 
		*/
		
		/**
		 * 根据 Excel 表格生成 model.xml 文件
		 */
		// path = "E:/IDE/workspace/gap/com.ehtsoft.community.web/doc/02.设计文档/01.数据模型/01.社区服务数据模型设计文档.xlsm";
		//path = "/workspace/gap/com.ehtsoft.supervise.web/doc/02.设计文档/01.数据模型/01.即时通讯数据模型设计文档.xlsm";
		/*path = "D:/IDE/workspace/gap/com.ehtsoft.supervise.web/doc/02.设计文档/01.数据模型/03.矫正系统参数设置设计文档 .xlsm";*/
		//String path = "E:/eclipse-workspace/gap/com.ehtsoft.supervise.web/doc/02.设计文档/01.数据模型/02.矫正人员管理系统数据模型设计文档.xlsm";
		//path = "D:/IDE/workspace/gap/com.ehtsoft.supervise.web/doc/02.设计文档/01.数据模型/05.矫正人员管理系统数据模型设计文档.xlsm";
		String path = "C:/Users/wlbrs/Desktop/数据生成Excel/JZ_TQCXHXXXCJB.xlsx";
		
		String tablename = "JZ_TQCXHXXXCJB";
		try {
			ExcelModelHelper.tablePrefix = "IM_"; //表的前缀  （生成 pk 等 去掉前缀部分，减少长度）
			ExcelModelHelper.fieldPrefix = "F_";  //字段的前缀 （生成 pk 等 去掉前缀部分，减少长度）
			List<TableConfig> l = ExcelModelHelper.getTableInfo(new FileInputStream(path),tablename);
			for(TableConfig tc:l){
				createModelXml(tc);
			}
			System.out.println("创建模型文件完成");
		} catch (Throwable e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
	}
}