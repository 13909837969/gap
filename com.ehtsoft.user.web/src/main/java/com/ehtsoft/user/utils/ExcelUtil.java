package com.ehtsoft.user.utils;

import java.io.FileInputStream;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.ehtsoft.fw.core.config.Deploy;
import com.ehtsoft.fw.core.config.helper.ModelConfigHelper;
import com.ehtsoft.fw.core.context.AppException;
import com.ehtsoft.fw.core.dto.BasicMap;
import com.ehtsoft.fw.utils.StringUtil;
import com.ehtsoft.fw.utils.Util;
import com.ehtsoft.user.services.OrganizationService;
/**
 * Excel 模板解析类
 * @author wangbao
 */
public class ExcelUtil {

	public static void main(String[] args){
		
		
		String file ="/workspace/gap/com.ehtsoft.supervise.web/doc/02.设计文档/04.数据模板/司法机构数据.xlsx";
//		file ="/workspace/gap/com.ehtsoft.supervise.web/doc/02.设计文档/04.数据模板/Sys02.系统菜单.xls";
		try{
			InputStream is = new FileInputStream(file);
			
//			parseMenuXls2Xml(is);
			
			List<BasicMap<String, Object>> list = parseOrgXls(is);
			/*
			System.out.println(list.size());
			
			List<BasicMap<String, Object>> tree = Util.list2Tree(list, "parentid", "sysid");
			
			System.out.println(tree.size());
			*/
			
			Deploy.setProperty("database.type", "postgres");
	    	String modelPath="META-INF/model/*/*-model.xml";
//	    	ModelConfigHelper.DIR="d:/";
	    	ModelConfigHelper.init(modelPath);
	    	
	    	ApplicationContext appContext = new ClassPathXmlApplicationContext("classpath:META-INF/com.ehtsoft.sso.appContext.xml",
	    			"classpath:META-INF/com.ehtsoft.sync.appContext.xml",
	    			"classpath:META-INF/com.ehtsoft.user.web.appContext.xml"
	    			);
	    	
	    	OrganizationService os = appContext.getBean("OrganizationService", OrganizationService.class);
	    	
	    	for(BasicMap<String, Object> b:list){
	    		System.out.println("UPDATE CORE_ORGANIZATION SET REGIONCODE = '"+StringUtil.toEmptyString(b.get("REGIONID"))+"' WHERE SYSID = '"+StringUtil.toString(b.get("SYSID"))+"';");
	    		//os.updateRegionCode(StringUtil.toString(b.get("SYSID")), StringUtil.toEmptyString(b.get("REGIONID")));
	    	}
			
		}catch(Exception ex){
			ex.printStackTrace();
		}
		
	}


	public static List<BasicMap<String,Object>> parseOrgXls(InputStream is){
		List<BasicMap<String,Object>> rtn = new ArrayList<>();
		Map<String,String> parentidmap = new HashMap<String,String>();
		Map<String,Integer> accidm = new HashMap<String,Integer>();
		try {
			Workbook workbook = WorkbookFactory.create(is);
			Sheet sheet = workbook.getSheetAt(0);
			if(sheet!=null){
				Row row0 = sheet.getRow(0);
				String[] fields = new String[row0.getLastCellNum()];
				for(int c=0;c<fields.length;c++){
					Cell cell = row0.getCell(c);
					if(cell==null){
						throw new AppException("模板第 " + (c+1) + "列头为空");
					}else{
						cell.setCellType(Cell.CELL_TYPE_STRING);
						String v = cell.getStringCellValue();
						fields[c] = StringUtil.trim(v);
					}
				}
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
					String innercode = StringUtil.toEmptyString(rowdata.get("INNERCODE"));
					String sysid = String.format("NM0000000000-0000-0000-0000000-%05d" , r-1);
					rowdata.put("SYSID", sysid);
					String regionid = StringUtil.toEmptyString(rowdata.get("REGIONID"));
					int id = 1;
					if(accidm.get(regionid)==null){
						accidm.put(regionid,id);
					}else{
						id = accidm.get(regionid);
						id += 1;
						accidm.put(regionid,id);
					}
					rowdata.put("ACCID",  String.format(regionid + "%02d", id));
					parentidmap.put(innercode,sysid);
					if(innercode.length()>4){
						rowdata.put("parentid",parentidmap.get(innercode.substring(0, innercode.length()-4)));
					}
					rtn.add(rowdata);
				}
				
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return rtn;
	}

	public static void parseMenuXls2Xml(InputStream is){
		try {
			Workbook workbook = WorkbookFactory.create(is);
			Map<String,List<BasicMap<String,Object>>> apptmp = new BasicMap<String,List<BasicMap<String,Object>>>();
			for(int i=0;i<workbook.getNumberOfSheets();i++){
				Sheet sheet = workbook.getSheetAt(i);
				if(sheet!=null){
					Row row0 = sheet.getRow(0);
					String[] fields = new String[7];
					for(int c=0;c<fields.length;c++){
						Cell cell = row0.getCell(c);
						if(cell==null){
							throw new AppException("模板第 " + (c+1) + "列头为空");
						}else{
							cell.setCellType(Cell.CELL_TYPE_STRING);
							String v = cell.getStringCellValue();
							fields[c] = StringUtil.trim(v);
						}
					}
					for(int r=2;r<=sheet.getLastRowNum();r++){
						BasicMap<String,Object> rowdata = new BasicMap<String,Object>();
						Row row = sheet.getRow(r);
						for(int c=0;c<fields.length;c++){
							Cell cell = row.getCell(c);
							cell.setCellType(Cell.CELL_TYPE_STRING);
							String v = cell.getStringCellValue();
							rowdata.put(fields[c], StringUtil.trim(v));
						}
						String menucode = StringUtil.toEmptyString(rowdata.get("menucode"));
						rowdata.put("id", menucode);
						if(menucode.length()>4){
							rowdata.put("pid", menucode.substring(0, menucode.length()-2));
						}
						String appname = StringUtil.toString(rowdata.get("appname"));
						if(apptmp.get(appname)==null){
							List<BasicMap<String,Object>> list = new ArrayList<>();
							apptmp.put(appname,list);
							list.add(rowdata);
						}else{
							apptmp.get(appname).add(rowdata);
						}
					}
				}
			}
			for(String key:apptmp.keySet()){
				System.out.println("<app appcode=\"\" appname=\""+key+"\" reqaddress=\"_self\" project=\"supervise\" frule=\"OSA\" remark=\"\">");
				mkMenxXml(Util.list2Tree(apptmp.get(key), "pid", "id"),1);
				System.out.println("</app>");
			}
		}catch(Exception ex){
			ex.printStackTrace();
		}
	}
	
	private static void mkMenxXml(List<BasicMap<String,Object>> list,int lvl){
		StringBuffer sb = new StringBuffer();
		for(int i=0;i<lvl;i++){
			sb.append("    ");
		}
		System.out.println(sb+"<children>");
		for(BasicMap<String,Object> map : list){
			if(map.get("nodes")!=null){
				List<BasicMap<String,Object>> nodes = (List<BasicMap<String,Object>>)map.get("nodes");
				System.out.println(sb+"    <menu menucode=\""+StringUtil.toEmptyString(map.get("menucode"))+"\" menuname=\""+StringUtil.toEmptyString(map.get("menuname"))+"\" actionuri=\""+StringUtil.toEmptyString(map.get("actionuri"))+"\" icon=\""+StringUtil.toEmptyString(map.get("icon"))+"\">");
				mkMenxXml(nodes,++lvl);
				System.out.println(sb+"    </menu>");
			}else{
				System.out.println(sb+"    <menu menucode=\""+StringUtil.toEmptyString(map.get("menucode"))+"\" menuname=\""+StringUtil.toEmptyString(map.get("menuname"))+"\" actionuri=\""+StringUtil.toEmptyString(map.get("actionuri"))+"\" icon=\""+StringUtil.toEmptyString(map.get("icon"))+"\"/>");				
			}
			
		}
		System.out.println(sb+"</children>");
	}
}
