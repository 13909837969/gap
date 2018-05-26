package com.ehtsoft.supervise.utils;

import java.io.File;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.ehtsoft.fw.core.config.helper.ModelConfigHelper;
import com.ehtsoft.fw.core.config.model.ColumnConfig;
import com.ehtsoft.fw.core.config.model.TableConfig;
import com.ehtsoft.fw.core.dto.Basic;
import com.ehtsoft.fw.core.dto.BasicMap;
import com.ehtsoft.fw.utils.StringUtil;

import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;

public class CreateJavaBean {

	
	public static String fieldPrefix = "F_";
	public static String tablePrefix = "";
	

	public static void main(String[] args){
		
		String var_packagename = "com.ehtsoft.supervise.dto";
		/**
		 * 已经被手动添加方法的 javaBean 本次不重新生成 javaBean 文件
		 * 如果有修改，请手动修改，或者将类备份在创建
		 */
		String[] manualClasses = new String[]{"Dsaa"};
		
    	String modelPath="META-INF/model/sys/SYS_DICTIONARY-model.xml";
    	ModelConfigHelper.init(modelPath);
    	
		String user_dir = System.getProperty("user.dir");
		String dir = user_dir + "/src/main/java/" + var_packagename.replaceAll("\\.", "\\/");
		//dir = "d:/model/java";
		File classpathDir =  new File(dir);
		if(!classpathDir.exists()){
			classpathDir.mkdirs();
		}
		Configuration cfg = new Configuration(Configuration.DEFAULT_INCOMPATIBLE_IMPROVEMENTS);  
		try {
			cfg.setDirectoryForTemplateLoading(new File(user_dir + "/src/main/resources/META-INF"));
			
			/* 获取模板文件 */  
	        Template template = cfg.getTemplate("model-javabean.ftl");  
			Map<String,Object> root = new HashMap<>();
			List<TableConfig> tcs = ModelConfigHelper.getAllTableConfig();
			BasicMap<String,String> map = new BasicMap<String,String>();
			Field[] fields = Basic.class.getDeclaredFields();
			for(int i=0;i<fields.length;i++){
				map.put(fields[i].getName(),fields[i].getName());
			}
			BasicMap<String,String> classMap = new BasicMap<String,String>();
			for(String clazz:manualClasses){
				classMap.put(clazz, clazz);
			}
			for(TableConfig tc : tcs){
				TableConfig tableConfig = new TableConfig();
				String tname = tc.getName().indexOf("_")>0?tc.getName().substring(tc.getName().indexOf("_")+1):tc.getName();
				String[] names = tname.toLowerCase().split("\\_");
				StringBuffer name = new StringBuffer();
				for(String n : names){
					name.append(StringUtil.toFirstUpperCase(n));
				}
				if(classMap.containsKey(name)){
					continue;
				}
				tableConfig.setName(StringUtil.toFirstUpperCase(name.toString()));
				tableConfig.setLabel(tc.getLabel());
				List<ColumnConfig> columns = new ArrayList<>();
				for(ColumnConfig cc:tc.getColumns()){
					if(!map.containsKey(cc.getProperty())){
						cc.setProperty(getPropertyName(cc.getProperty()));
						columns.add(cc);
					}
				}
				tableConfig.setColumns(columns);
				root.put("packagename", var_packagename);
				root.put("tableConfig", tableConfig);
				FileOutputStream fos = new FileOutputStream(classpathDir.getAbsolutePath() + "/" + tableConfig.getName() + ".java");
				
				Writer out = new OutputStreamWriter(fos,"utf-8");
				root.put("StringUtil", StringUtil.class);
		        template.process(root, out);
		        fos.close();
		        out.close();
		        System.out.println(var_packagename+ "." + tableConfig.getName() + "创建完成！");
			}
		} catch (IOException e) {
			e.printStackTrace();
		} catch (TemplateException e) {
			e.printStackTrace();
		}
	}
	
	
	private static String getPropertyName(String field){
		String rtn = field;
		if(fieldPrefix!=null && !"".equals(fieldPrefix)){
			field = field.toLowerCase();
			fieldPrefix = fieldPrefix.toLowerCase();
			
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
}
