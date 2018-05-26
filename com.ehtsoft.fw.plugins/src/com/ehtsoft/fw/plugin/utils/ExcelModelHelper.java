package com.ehtsoft.fw.plugin.utils;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.rmi.CORBA.Util;

import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.DateUtil;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;

import com.ehtsoft.fw.plugin.model.ColumnConfig;
import com.ehtsoft.fw.plugin.model.ForeignConfig;
import com.ehtsoft.fw.plugin.model.PrimaryConfig;
import com.ehtsoft.fw.plugin.model.TableConfig;
import com.ehtsoft.fw.plugin.model.UniqueConfig;

public class ExcelModelHelper {
	public static String fieldPrefix = "F_";
	public static String tablePrefix = "";
	public static List<TableConfig> getTableInfo(InputStream xlsStream ,String tableName){
		 List<TableConfig> rtn = new ArrayList<TableConfig>();
		 try {
			Workbook workbook = WorkbookFactory.create(xlsStream);
			
			int sheetNum = workbook.getNumberOfSheets();
			
			for(int i=2;i<sheetNum;i++){
				if(tableName!=null && !"".equals(tableName)) {
					if(workbook.getSheetName(i).equalsIgnoreCase(tableName)) {
						parsetable(workbook,i,rtn);
						break;
					}
				}else {
					parsetable(workbook,i,rtn);
				}
			}
			
		} catch (InvalidFormatException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} finally{
			if(xlsStream!=null){
				try {
					xlsStream.close();
				} catch (IOException e) {
				}
			}
		}
		 return rtn;
	}
	
	private static void parsetable(Workbook workbook,int i, List<TableConfig> rtn ) {

		Sheet sheet = workbook.getSheetAt(i);
		//table 对象
		TableConfig table = new TableConfig();
		//table name
		table.setName(sheet.getSheetName());
		rtn.add(table);
		Cell tableLabel = sheet.getRow(1).getCell(5);
		tableLabel.setCellType(Cell.CELL_TYPE_STRING);
		//table label
		if(Cell.CELL_TYPE_BLANK==tableLabel.getCellType()){
			table.setLabel(table.getName());
		}else{
			table.setLabel(tableLabel.getStringCellValue());
		}
		Cell baseCell = sheet.getRow(1).getCell(3);
		if(baseCell!=null){
			table.setBase(baseCell.getBooleanCellValue());
		}
		//列
		List<ColumnConfig> columns = new ArrayList<ColumnConfig>();
		//唯一
		List<UniqueConfig> uniques = new ArrayList<UniqueConfig>();
		List<ForeignConfig> foregins = new ArrayList<ForeignConfig>();
		//主键对象
		PrimaryConfig primary = new PrimaryConfig();
		//主键临时变量
		StringBuffer pkFields = new StringBuffer();
		//唯一键临时变量
		Map<String,String> map = new HashMap<String,String>();
		// 从excel表格的第 4 行开始(去掉最后一行 备注行)
		for(int r = 3;r<sheet.getLastRowNum();r++){
			//0 名称
			Cell label = sheet.getRow(r).getCell(0);
			//1 字段
			Cell field = sheet.getRow(r).getCell(1);
			//2 类型
			Cell type = sheet.getRow(r).getCell(2);
			//3 长度
			Cell length = sheet.getRow(r).getCell(3);
			//4 约束  PK,UK,FK,UUK1,UUK2,UUK3,UUK4
			Cell prikey = sheet.getRow(r).getCell(4);
			//5 是否必须输入项目 Y/N
			Cell required = sheet.getRow(r).getCell(5);
			//6 默认值
			Cell defaultValue = sheet.getRow(r).getCell(6);
			//7 外键表及字段 tablename.column1
			Cell foreign = sheet.getRow(r).getCell(7);
			//8 备注
			Cell remark = sheet.getRow(r).getCell(8);
			
			if(getCellValue(field)==null){
				continue;
			}
			//ColumnConfig 对象
			ColumnConfig cc = new ColumnConfig();
			columns.add(cc);
			//字段
			cc.setField(getCellValue(field));
			//名称
			cc.setLabel(getCellValue(label));
			//默认值
			cc.setDefaultValue(getCellValue(defaultValue));
			//长度
			String s = getCellValue(length);
			if(s!=null && s.contains(",")){
				String[] ss=s.split(",");
				if(ss.length>0){
					cc.setLength(AppUtil.toInteger(ss[0]));
				}
				if(ss.length>1){
					cc.setPrecision(AppUtil.toInteger(ss[1]));
				}
			}else if(s!=null){
				cc.setLength(AppUtil.toInteger(s));
			}
			//备注
			cc.setRemark(getCellValue(remark));
			//是否必须 Required
			if("Y".equalsIgnoreCase(getCellValue(required))){
				cc.setRequired(true);
			}
			//类型
			cc.setType(getCellValue(type));
			if("uuid".equals(cc.getType())){
				cc.setLength(36);
			}
			// PK,UK,FK,UUK1,UUK2,UUK3,UUK4
			// 主键
			if(AppUtil.isNotEmpty(getCellValue(prikey)) && getCellValue(prikey).toUpperCase().contains("PK")){
				pkFields.append(getCellValue(field));
				pkFields.append(",");
			}
			// 唯一
			if("UK".equalsIgnoreCase(getCellValue(prikey))){
				UniqueConfig uc = new UniqueConfig();
				uc.setField(getCellValue(field));
				uc.setName("UK_" + getSimTablename(table.getName())+"_"+getConstraintName(uc.getField()));
				uniques.add(uc);
			}
			if(!"UK".equalsIgnoreCase(getCellValue(prikey))
					&&getCellValue(prikey)!=null
					&&getCellValue(prikey).contains("UUK")){
				String uuk = getCellValue(prikey);
				String[] uuks = uuk.split("\\|");
				for(String u:uuks){
					if(!"FK".equalsIgnoreCase(u)){
						if(map.get(u)==null){
							map.put(u, getCellValue(field));
						}else{
							map.put(u,map.get(u)+"," + getCellValue(field));
						}
					}
				}
			}
			if(AppUtil.isNotEmpty(getCellValue(prikey)) && (getCellValue(prikey).contains("FK"))){
				String f = getCellValue(foreign);
				if(f!=null && f.split("\\.").length==2){
					ForeignConfig fc = new ForeignConfig();
					fc.setField(getCellValue(field));
					fc.setName("FK_"+getSimTablename(table.getName())+"_" + getConstraintName(fc.getField()));
					fc.setReference(f.split("\\.")[0]);
					fc.setReferField(f.split("\\.")[1]);
					foregins.add(fc);
				}
				if("FK|UK".equalsIgnoreCase(getCellValue(prikey))){
					UniqueConfig uc = new UniqueConfig();
					uc.setField(getCellValue(field));
					uc.setName("UK_" + getSimTablename(table.getName())+"_"+getConstraintName(uc.getField()));
					uniques.add(uc);
				}
			}
		}
		int lastRowIndex = sheet.getLastRowNum();
		Row lastRow = sheet.getRow(lastRowIndex);
		if(lastRow!=null){
			Cell c = lastRow.getCell(1);
			if(c!=null){
				String remark = getCellValue(c);
				table.setRemark(remark);
			}
		}
		//设置列
		table.setColumns(columns);
		//设置主键
		if(AppUtil.isNotEmpty(pkFields.toString())){
			pkFields.deleteCharAt(pkFields.length()-1);
			primary.setField(pkFields.toString());
			primary.setName("PK_" + getSimTablename(table.getName()));
			table.setPrimary(primary);
		}
		for(String k:map.keySet()){
			UniqueConfig uc = new UniqueConfig();
			uc.setField(map.get(k));
			
			String[] fs = uc.getField().split(",");
			StringBuffer sb = new StringBuffer();
			for(String f : fs){
				sb.append("_"+getConstraintName(f));
			}
			uc.setName("UK_" + getSimTablename(table.getName())+sb.toString());
			uniques.add(uc);
		}
		//设置唯一
		table.setUniques(uniques);
		//设置外键
		table.setForeigns(foregins);
	
	}
	private static String getCellValue(Cell cell){
		String rtn = null;
		if(cell==null){
			return rtn;
		}
		switch(cell.getCellType()){
			case Cell.CELL_TYPE_BLANK:
			break;
			case Cell.CELL_TYPE_BOOLEAN:
				rtn = Boolean.toString(cell.getBooleanCellValue());
			break;
			case Cell.CELL_TYPE_FORMULA:
			break;
			case Cell.CELL_TYPE_NUMERIC:
				 if(DateUtil.isCellDateFormatted(cell)){  
					 rtn = String.valueOf(cell.getDateCellValue());  
	             }else{   
	               cell.setCellType(Cell.CELL_TYPE_STRING);  
	               rtn = cell.getStringCellValue();  
	             }  
			break;
			case Cell.CELL_TYPE_STRING:
				rtn = cell.getStringCellValue();
			break;
			case Cell.CELL_TYPE_ERROR:
			break;
		}
		if(rtn!=null){
			rtn = rtn.trim();
		}
		return rtn;
	}
	
	private static String getConstraintName(String field){
		String rtn = field;
		if(fieldPrefix!=null && !"".equals(fieldPrefix)){
			field = field.toUpperCase();
			fieldPrefix = fieldPrefix.toUpperCase();
			
			if(field.startsWith(fieldPrefix)){
				rtn = field.replaceFirst(fieldPrefix, "");
			}
		}
		return rtn;
	}
	
	private static String getSimTablename(String tablename){
		String rtn = tablename;
		
		if(tablePrefix!=null && !"".equals(tablePrefix)){
			tablename = tablename.toUpperCase();
			tablePrefix = tablePrefix.toUpperCase();
			
			if(tablename.startsWith(tablePrefix)){
				rtn = tablename.replaceFirst(tablePrefix, "");
			}
		}
		return rtn;
	}
	
	public static void main(String[] args){
		String path = "D:/workspace/hap/com.ehtsoft.jfl.web/doc/01.捷丰项目数据模型设计文档.xlsm";
		try {
			getTableInfo(new FileInputStream(path),null);
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
