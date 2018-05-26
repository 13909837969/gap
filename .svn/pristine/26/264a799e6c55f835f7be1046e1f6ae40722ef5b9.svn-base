package com.ehtsoft.supervise.utils;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;

import com.ehtsoft.fw.core.config.helper.ModelConfigHelper;
import com.ehtsoft.fw.core.config.model.TableConfig;
import com.ehtsoft.fw.core.context.AppException;
import com.ehtsoft.fw.core.dto.BasicMap;
import com.ehtsoft.fw.utils.StringUtil;
/**
 * Excel 模板解析类
 * @author wangbao
 */
public class ExcelUtil {

	/**
	 * 解析 初始化 Excel数据 
	 * @param is
	 * @return BasicMap<String,List<BasicMap<String,Object>>>  String 为表的名字   
	 * @throws AppException 
	 */
	public static BasicMap<String,List<BasicMap<String,Object>>> parseXlsData(InputStream is,List<String> tables) throws AppException{
		BasicMap<String,List<BasicMap<String,Object>>> rtn = new BasicMap<String,List<BasicMap<String,Object>>>();
		try{
			Workbook workbook = WorkbookFactory.create(is);
			for(int i=0 ;i<workbook.getNumberOfSheets();i++){
				Sheet sheet = workbook.getSheetAt(i);
				String table = sheet.getSheetName();
				TableConfig tc = ModelConfigHelper.getTableConfig(table);
				if(tc!=null){
					tables.add(table);
					Row row0 = sheet.getRow(0);
					String[] fields = new String[row0.getLastCellNum()];
					for(int c=0;c<fields.length;c++){
						Cell cell = row0.getCell(c);
						if(cell==null){
							throw new AppException("针对库表："+table + " 的模板第 " + (c+1) + "列头为空");
						}else{
							cell.setCellType(Cell.CELL_TYPE_STRING);
							String v = cell.getStringCellValue();
							fields[c] = StringUtil.trim(v);
						}
					}
					List<BasicMap<String,Object>> tableData = new ArrayList<BasicMap<String,Object>>();
					for(int r=2;r<=sheet.getLastRowNum();r++){
						Row row = sheet.getRow(r);
						BasicMap<String,Object> rowdata = new BasicMap<String,Object>();
						for(int c=0;c<fields.length;c++){
							Cell cell = row.getCell(c);
							if(cell!=null){
								cell.setCellType(Cell.CELL_TYPE_STRING);
								if(cell.getCellType()!=Cell.CELL_TYPE_BLANK && cell.getCellType()!=Cell.CELL_TYPE_ERROR){
									String v = cell.getStringCellValue();
									rowdata.put(fields[c], StringUtil.trim(v));
								}
							}
						}
						tableData.add(rowdata);
					}
					rtn.put(table, tableData);
				}
			}
		} catch (InvalidFormatException e) {
			e.printStackTrace();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} finally{
			try {
				is.close();
			} catch (IOException e) {
			}
		}
		return rtn;
	}
}
