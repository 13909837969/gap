package com.ehtsoft.user.utils;

import java.io.BufferedWriter;
import java.io.DataOutputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.StringBufferInputStream;
import java.io.StringReader;

import com.ehtsoft.fw.core.config.Deploy;
import com.ehtsoft.fw.core.config.helper.ModelConfigHelper;
import com.ehtsoft.fw.core.context.AppException;

public class CreateSqlUtil {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		System.out.println("生成"+Deploy.getProperty("database.type") + "数据库脚本");
    	String modelPath="META-INF/model/*/*-model.xml";
    	ModelConfigHelper.init(modelPath);
    	
    	try {
			StringBuffer sb = ModelConfigHelper.convertSql(ModelConfigHelper.getAllTableConfig());
			
			DataOutputStream dos = new DataOutputStream(new FileOutputStream("d:/user.sql"));
			
			dos.writeBytes(sb.toString());
			dos.flush();
			dos.close();
			System.out.println("生成完成");
		} catch (AppException e) {
			e.printStackTrace();
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
