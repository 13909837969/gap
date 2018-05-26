package com.ehtsoft.supervise;

import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import com.ehtsoft.fw.core.config.helper.ModelConfigHelper;
import com.ehtsoft.fw.core.config.model.ColumnConfig;
import com.ehtsoft.fw.core.config.model.TableConfig;

public class Test {
	
	public static void main(String[] args){
//		 printInputCompo();
//		 printDropTable();
		 
		 printCompatEdit();
	}
	
	public static void printDropTable(){
		String driver="org.postgresql.Driver";
		String url="jdbc:postgresql://localhost:5432/supervise";
		String username="postgres";
		String password="root";
		Connection conn = null;
		ResultSet rs = null;
		
		String modelPath="META-INF/model/*/*-model.xml";
    	ModelConfigHelper.init(modelPath);
    	
    
		try {
			Class.forName(driver);
			conn  = DriverManager.getConnection(url,username,password);
	
			DatabaseMetaData dmd = conn.getMetaData();
			rs = dmd.getTables(null, null, null, new String[]{"TABLE"});
			while(rs.next()){
				String tablename = rs.getString(3);
				TableConfig tc = ModelConfigHelper.getTableConfig(tablename);
				if(tc==null){
					System.out.println("drop table " + tablename + ";");
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally{
			if(rs!=null){
				try {
					rs.close();
				} catch (SQLException e) {
				}
			}
		}

	}
	
	public static void printInputCompo(){
    	String modelPath="META-INF/model/*/*-model.xml";
    	ModelConfigHelper.init(modelPath);
    	
    	String tablename = "JZ_JZRYJBXX";
    	TableConfig tc =  ModelConfigHelper.getTableConfig(tablename);
    	
    	if(tc!=null){
    	for(ColumnConfig cc : tc.getColumns()){
    		StringBuffer sb = new StringBuffer("<input id=\""+cc.getProperty()+"\" type=\"text\" label=\""+cc.getLabel()+"\" name=\""+cc.getProperty()+"\"");
    		StringBuffer valid = new StringBuffer("{");
    		if(cc.getRequired()){
    			valid.append("required:true,");
    		}
    		if("date".equalsIgnoreCase(cc.getType())){
    			valid.append("date:true,");
    		}
    		if("double".equalsIgnoreCase(cc.getType())){
    			valid.append("number:true,");
    		}
    		if("integer".equalsIgnoreCase(cc.getType())){
    			valid.append("int:true,");
    		}
    		if(valid.length()>1){
    			valid.deleteCharAt(valid.length()-1);
    		}
    		valid.append("}");
    		
    		if(valid.length()>2){
    			sb.append(" valid=\""+valid.toString()+"\"");
    		}
    		
    		if("date".equalsIgnoreCase(cc.getType())){
    			sb.append(" class=\"form_date\"");
    		}
    		if(cc.getRemark()!=null && cc.getRemark().toLowerCase().contains("sys")){
    			Pattern p = Pattern.compile("(sys\\d\\d\\d)");
    			Matcher m = p.matcher(cc.getRemark().toLowerCase());
    			if(m.find()){
    			sb.append(" code=\""+m.group(1)+"\"");
    			}
    		}
    		sb.append("/>");
    		
    
    		System.out.println(sb.toString());
    	
    	}
    	}
	}

	public static void printCompatEdit(){
		String modelPath="META-INF/model/*/*-model.xml";
    	ModelConfigHelper.init(modelPath);
    	
    	String tablename = "JC_SFXZJGJBXX";
    	TableConfig tc =  ModelConfigHelper.getTableConfig(tablename);
    	
    	if(tc!=null){
            String s = "\t<TextView\n" +
                    "                    android:layout_width=\"match_parent\"\n" +
                    "                    android:layout_height=\"wrap_content\"\n" +
                    "                    android:text=\"%s：\" />\n" +
                    "\n" +
                    "\t                <com.ehtsoft.supervise.widget.CompatEditText\n" +
                    "\t                    android:id=\"@+id/%s\"\n" +
                    "\t                    android:layout_width=\"match_parent\"\n" +
                    "\t                    android:layout_height=\"wrap_content\"\n" +
                    "\t                    android:background=\"@drawable/corners_edittext_border\"\n" +
                    "\t                    app:fieldName=\"%s\"\n" +
                    "\t                    android:textAppearance=\"?android:textAppearance\" />";
        	for(ColumnConfig cc : tc.getColumns()){
        		System.out.println(String.format(s, cc.getLabel(),cc.getProperty(),cc.getProperty(),cc.getLabel()));
        	}
    	}
	}
}
