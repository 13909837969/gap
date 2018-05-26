package com.ehtsoft.supervise.utils;

import java.util.Comparator;
import java.util.List;

import com.ehtsoft.fw.core.config.Deploy;
import com.ehtsoft.fw.core.config.helper.ModelConfigHelper;
import com.ehtsoft.fw.core.config.helper.ModelConfigHelper.CONVERT_SQL_FLAG;
import com.ehtsoft.fw.core.config.model.ColumnConfig;
import com.ehtsoft.fw.core.config.model.ForeignConfig;
import com.ehtsoft.fw.core.config.model.TableConfig;
import com.ehtsoft.fw.core.config.model.UniqueConfig;
import com.ehtsoft.fw.core.context.AppException;

public class CreateSqlUtil {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
//		System.out.println("生成"+Deploy.getProperty("database.type") + "数据库脚本");
//		Deploy.setProperty("database.type", "oracle");
		Deploy.setProperty("database.type", "postgres");
    	String modelPath="META-INF/model/*/*-model.xml";
//    	ModelConfigHelper.DIR="d:/";
    	ModelConfigHelper.init(modelPath);
    	
    	
//    	System.out.println(ModelConfigHelper.convertSql());
//    	
//    	System.out.println(convertDropForegin());
    	
//    	System.out.println(convertCommentSql());
    	
//    	System.out.println(oraclePostgresqlForeignLink());
//    	
//    	createDropSql();
    	
    	cleanInvalidImg();
	}

	public static void cleanInvalidImg(){
		String sqlstr = "    <clean-sql><![CDATA[DELETE FROM %s IMG WHERE not exists (SELECT %s FROM %s WHERE %s.%s = IMG.%s)]]></clean-sql>";

		List<TableConfig> list = ModelConfigHelper.getAllTableConfig();
		list.sort(new Comparator<TableConfig>() {
			public int compare(TableConfig o1, TableConfig o2) {
				int rtn = o1.getName().compareTo(o2.getName());
				return rtn;
			}
		});
		System.out.println("<cleanconf>");
		for(TableConfig tc:list){
			String table_img = tc.getName().toUpperCase();
			if(!"CSM_AAAB_IMG".equals(table_img)){
				if(table_img.endsWith("_IMG")){
					String table = table_img.replace("_IMG", "");
					String tableId = table.replace("CSM_","")+"01";
					System.out.println(String.format(sqlstr, table_img,tableId,table,table,tableId,tableId));
				}
			}
		}
		System.out.println("</cleanconf>");
	}
	
	public static void createDropSql(){
		List<TableConfig> list = ModelConfigHelper.getAllTableConfig();
			
		for(TableConfig table:list){
			List<ForeignConfig> fs = table.getForeigns();
			if(fs!=null){
				for(ForeignConfig f:fs){
					//System.out.println("ALTER TABLE " + table.getName() + " DROP CONSTRAINT " + f.getName() + ";");
					System.out.println(f.getReference());
				}
			}else{
				
				System.out.println("aa:"+table.getName());
			}
		}

	}
	
	
	/**
	 * 将模型文件转换成数据库脚本
	 * @return
	 * @throws AppException
	 */
	public static StringBuffer convertSql() throws AppException{
		
		return convertSql(ModelConfigHelper.getAllTableConfig(),CONVERT_SQL_FLAG.ALL);
	}
	public static StringBuffer convertSql(CONVERT_SQL_FLAG flag) throws AppException{
		return convertSql(ModelConfigHelper.getAllTableConfig(),flag);
	}
	
	public static StringBuffer convertDropForegin(){
		StringBuffer rtn = new StringBuffer();
		for(TableConfig table:ModelConfigHelper.getAllTableConfig()){
			StringBuffer foreignsql=new StringBuffer();
			if(table.getForeigns()!=null){
				for(ForeignConfig f:table.getForeigns()){
					foreignsql.append("ALTER TABLE " + table.getName() + " DROP CONSTRAINT " + f.getName() + ";\n");
				}
			}
			rtn.append(foreignsql);
		}
		return rtn;
	}
	
	public static StringBuffer convertSql(List<TableConfig> tableList,CONVERT_SQL_FLAG flag) throws AppException{
		StringBuffer rtn = new StringBuffer();
		try {
			if(CONVERT_SQL_FLAG.ONLY_TABLE==flag || CONVERT_SQL_FLAG.ALL == flag){
				//生成 创建表的sql
				for(TableConfig table:tableList){
					StringBuffer sql=new StringBuffer();
					sql.append("CREATE TABLE "+table.getName()+"(\n");
					for(int i=0;i<table.getColumns().size();i++){
						ColumnConfig c=table.getColumns().get(i);
						String notnull="";
						if(c.getRequired()){
							notnull = " not null";
						}
						if(i==table.getColumns().size()-1){
							sql.append(c.getField() + " "+c.getTypeOfSql() + notnull);
						}else{
							sql.append(c.getField() + " "+c.getTypeOfSql()+ notnull +",\n");
						}
					}
					if(table.getUniques()!=null){
						sql.append(",\n");
						for(int i=0;i<table.getUniques().size();i++){
							UniqueConfig u=table.getUniques().get(i);
							if(i==table.getUniques().size()-1){
								sql.append("CONSTRAINT "+u.getName()+" UNIQUE ("+u.getField()+")");
							}else{
								sql.append("CONSTRAINT "+u.getName()+" UNIQUE ("+u.getField()+"),\n");
							}
						}
					}
					if(table.getPrimary()!=null){
						sql.append(",\n");
						sql.append("CONSTRAINT "+table.getPrimary().getName()+" PRIMARY KEY ("+table.getPrimary().getField()+")");
					}
					sql.append("\n);\n\n");
					rtn.append(sql);
				}
			}
			//生成表的外键
			/*alter table GAP_MENUINFO
			add constraint FK_FUNC_MENU_FUNCTION_ID 
			foreign key (FUNCTION_ID)
			references GAP_FUNCTIONINFO (SYSID);
			*/
			if(CONVERT_SQL_FLAG.ONLY_FOREIGN==flag || CONVERT_SQL_FLAG.ALL == flag){
				for(TableConfig table:tableList){
					StringBuffer foreignsql=new StringBuffer();
					if(table.getForeigns()!=null){
						for(ForeignConfig f:table.getForeigns()){
							foreignsql.append("ALTER TABLE " + table.getName() + " ADD CONSTRAINT " + f.getName() + " FOREIGN KEY("+f.getField()+") REFERENCES " + f.getReference()+"("+f.getReferField()+");\n");
						}
					}
					rtn.append(foreignsql);
				}
			}
		} catch (Exception e) {
			throw new AppException(e.getMessage());
		} 
		return rtn;
	}
	
	public static StringBuffer oraclePostgresqlForeignLink(){
		List<TableConfig> tableList = ModelConfigHelper.getAllTableConfig();
		StringBuffer rtn = new StringBuffer();
		//生成 创建表的sql
		for(TableConfig table:tableList){
			StringBuffer sql=new StringBuffer();
			sql.append("CREATE FOREIGN FOR_"+table.getName()+"(\n");
			for(int i=0;i<table.getColumns().size();i++){
				ColumnConfig c=table.getColumns().get(i);
				String notnull="";
//				if(c.getRequired()){
//					notnull = " not null";
//				}
				if(i==table.getColumns().size()-1){
					sql.append(c.getField() + " "+c.getTypeOfSql() + notnull);
				}else{
					sql.append(c.getField() + " "+c.getTypeOfSql()+ notnull +",\n");
				}
			}
			sql.append("\n) server oradb options(schema 'NMSF',table '"+table.getName().toUpperCase()+"');\n\n");
			rtn.append(sql);
		}
		return rtn;
	}
	
	public static StringBuffer convertCommentSql(){
		StringBuffer rtn = new StringBuffer();
		for(TableConfig tc : ModelConfigHelper.getAllTableConfig()){
			String lbltable = tc.getLabel();
			if(lbltable!=null){
				lbltable = lbltable.replaceAll("'", "''");
				rtn.append("\ncomment on table "+tc.getName()+" is '"+lbltable+"';");
			}
			for(ColumnConfig c : tc.getColumns()){
				String lblColumn = c.getLabel();
				if(lblColumn!=null){
					lblColumn = lblColumn.replaceAll("'", "''");
					rtn.append("\ncomment on column "+tc.getName()+"."+c.getField()+" is '"+lblColumn+"';");
				}
			}
			/**
			 * Oracle 添加备注的写法
			 * comment on table tablename is 'comment';
			 * comment on column tablename.SYSID is 'comment';
			 */
			rtn.append("\n");
		}
		return rtn;
	}
}