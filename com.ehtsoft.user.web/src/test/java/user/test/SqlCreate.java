package user.test;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStreamWriter;

import com.ehtsoft.fw.core.config.Deploy;
import com.ehtsoft.fw.core.config.helper.ModelConfigHelper;
import com.ehtsoft.fw.core.config.model.TableConfig;
import com.ehtsoft.fw.core.context.AppException;

public class SqlCreate {

	public static void main(String[] args){
		
		String modelPath="META-INF/model/*/*-model.xml";
		Deploy.setProperty(Deploy.DATABASE_TYPE, Deploy.DATABASE_TYPE_ORACLE);
    	ModelConfigHelper.init(modelPath);
    	try {
			StringBuffer sb = ModelConfigHelper.convertSql();
			try{
				File file = new File("d:/jfl_core.sql");
				FileOutputStream fos = new FileOutputStream(file);
				BufferedWriter writer = new BufferedWriter(new OutputStreamWriter(fos, "gb2312"));
				writer.append(sb.toString());
				StringBuffer comment = ModelConfigHelper.convertCommentSql();
				writer.append(comment.toString());
				writer.flush();
				writer.close();
				for(TableConfig tc : ModelConfigHelper.getAllTableConfig()){
					System.out.println("drop table " + tc.getName()+";");
				}
				System.out.println("SQL 文件生成，位置 " + file.getAbsolutePath());
			}catch(Exception ex){
				ex.printStackTrace();
			}
		} catch (AppException e) {
			e.printStackTrace();
		}
	}
}
