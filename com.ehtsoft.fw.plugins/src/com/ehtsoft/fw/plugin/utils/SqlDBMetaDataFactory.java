package com.ehtsoft.fw.plugin.utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class SqlDBMetaDataFactory {
	private static SqlDBMetaData  sqlDBMetaData;
	private SqlDBMetaDataFactory(){
	}
	public static SqlDBMetaData getSqlDBMetaData(){
		return sqlDBMetaData;
	}
	public static SqlDBMetaData createSqlDBMetaData(String driver,String url,String username,String password) throws SQLException, ClassNotFoundException{
			Class.forName(driver);
			Connection conn = DriverManager.getConnection(url,username,password);
			if(sqlDBMetaData==null){
				sqlDBMetaData = new SqlDBMetaData(conn);
			}else{
				sqlDBMetaData.closeConnection();
				sqlDBMetaData.setConnection(conn);
			}
		return sqlDBMetaData;
	}
}
