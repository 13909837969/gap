package com.ehtsoft.fw.plugin.utils;

import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Types;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import com.ehtsoft.fw.plugin.model.ColumnConfig;
import com.ehtsoft.fw.plugin.model.ForeignConfig;
import com.ehtsoft.fw.plugin.model.PrimaryConfig;
import com.ehtsoft.fw.plugin.model.UniqueConfig;

public class SqlDBMetaData {
	private String  catalog;
	private String  schema;
	private DatabaseMetaData dmd;
	private Connection conn;
	public List<PrimaryConfig> getPrimarys(String table){
		List<PrimaryConfig> rtn = new ArrayList<PrimaryConfig>();
		try {
			Map<String,String> map = new HashMap<String, String>();
			ResultSet rs = dmd.getPrimaryKeys(catalog, schema, table);
			while(rs.next()){
				String column = rs.getString("COLUMN_NAME");
				if(column!=null){
					String pkname = rs.getString("PK_NAME");
					if(map.get(pkname)==null){
						map.put(pkname, column);
					}else{
						map.put(pkname,map.get(pkname)+","+ column);
					}
				}
			}
			for(String name:map.keySet()){
				PrimaryConfig  pc = new PrimaryConfig();
				pc.setName(name);
				pc.setField(map.get(name));
				rtn.add(pc);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return rtn;
	}
	

	public List<UniqueConfig> getUniques(String table){
		List<UniqueConfig> rtn = new ArrayList<UniqueConfig>();
		try {
			Map<String,String> map = new HashMap<String, String>();
			ResultSet rs = dmd.getIndexInfo(catalog, schema, table, true, false);
			while(rs.next()){
				String column = rs.getString("COLUMN_NAME");
				if(column!=null){
					String pkname = rs.getString("INDEX_NAME");
					if(map.get(pkname)==null){
						map.put(pkname, column);
					}else{
						map.put(pkname,map.get(pkname)+","+ column);
					}
				}
			}
			for(String name:map.keySet()){
				UniqueConfig  uc = new UniqueConfig();
				uc.setName(name);
				uc.setField(map.get(name));
				rtn.add(uc);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return rtn;
	}
	
	public List<ForeignConfig> getForeigns(String table){
		List<ForeignConfig> rtn = new ArrayList<ForeignConfig>();
		try {
			ResultSet rs = dmd.getImportedKeys(catalog, schema, table);
			while(rs.next()){
				ForeignConfig fc = new ForeignConfig();
				fc.setName(rs.getString("FK_NAME"));
				fc.setField(rs.getString("FKCOLUMN_NAME"));
				fc.setReference(rs.getString("PKTABLE_NAME"));
				fc.setReferField(rs.getString("PKCOLUMN_NAME"));
				rtn.add(fc);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return rtn;
	}
	
	public List<ColumnConfig> getColumns(String table){
		List<ColumnConfig> rtn = new ArrayList<ColumnConfig>();
		
		try {
			ResultSet rs = dmd.getColumns(catalog, schema, table, null);
			while(rs.next()){

				ColumnConfig cc = new ColumnConfig();
				cc.setField(rs.getString("COLUMN_NAME"));
				if(rs.getString("REMARKS")!=null){
					cc.setLabel(rs.getString("REMARKS"));
				}else{
					cc.setLabel(rs.getString("COLUMN_NAME"));
				}
				cc.setProperty(rs.getString("COLUMN_NAME").toLowerCase());
				cc.setLength(rs.getInt("COLUMN_SIZE"));
				//小数点
				cc.setPrecision(rs.getInt("DECIMAL_DIGITS"));
				cc.setType(getTypeOfString(rs.getInt("DATA_TYPE")));
				cc.setRequired(rs.getInt("NULLABLE")==DatabaseMetaData.columnNoNulls?true:false);
				rtn.add(cc);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return rtn;
	}
	
	
	public List<String> getTables(String tableNamePattern){
		List<String> rtn = new ArrayList<String>();
		try{
			ResultSet rs = dmd.getTables(catalog, schema, tableNamePattern, new String[]{"TABLE"});
			while(rs.next()){
				rtn.add(rs.getString("TABLE_NAME"));
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return rtn;
	}
	
	private String getTypeOfString(int type){
		String rtn = "string";
		switch(type){
			case Types.BIT:
				rtn = "boolean";
			break;
			case Types.TINYINT:
				rtn = "integer";
			break;
			case Types.SMALLINT:
				rtn = "integer";
			break;
			case Types.INTEGER:
				rtn = "integer";
			break;
			case Types.BIGINT:
				rtn = "long";
			break;
			case Types.FLOAT:
				rtn = "float";
			break;
			case Types.REAL:
				rtn = "float";
			break;
			case Types.DOUBLE:
				rtn = "double";
			break;
			case Types.NUMERIC:
				rtn = "double";
			break;
			case Types.DECIMAL:
				rtn = "double";
			break;
			case Types.CHAR:
				rtn = "string";
			break;
			case Types.VARCHAR:
				rtn = "string";
			break;
			case Types.LONGVARCHAR:
				rtn = "string";
			break;
			case Types.DATE:
				rtn = "date";
			break;
			case Types.TIME:
				rtn = "date";
			break;
			case Types.TIMESTAMP:
				rtn = "date";
			break;
			case Types.BINARY:
				rtn = "binary";
			break;
			case Types.VARBINARY:
				rtn = "binary";
			break;
			case Types.LONGVARBINARY:
				rtn = "binary";
			break;
			/*
			case Types.NULL:
			break;
			case Types.OTHER:
			break;
			case Types.JAVA_OBJECT:
			break;
			case Types.DISTINCT:
			break;
			*/
			case Types.BLOB:
				rtn = "binary";
			break;
			case Types.CLOB:
				rtn = "clob";
			break;
			/*
			case Types.REF:
			break;
			case Types.DATALINK:
			break;
			*/
			case Types.BOOLEAN:
				rtn = "boolean";
			break;
			/*
			case Types.ROWID:
			break;
			*/
			case Types.NCHAR:
				rtn = "string";
			break;
			case Types.NVARCHAR:
				rtn = "string";
			break;
			case Types.LONGNVARCHAR:
				rtn = "string";
			break;
			case Types.NCLOB:
				rtn = "clob";
			break;
			/*
			case Types.SQLXML:
			break;
			*/
		}
		return rtn;
	}
	
	public SqlDBMetaData(Connection conn){
		this.conn = conn;
		try {
			this.dmd = conn.getMetaData();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	public boolean isCloseConn(){
		return conn==null;
	}
	public void closeConnection(){
		if(conn!=null){
			try {
				conn.close();
				conn = null;
			} catch (SQLException e) {
			}
		}
	}
	public void setConnection(Connection conn){
		this.conn = conn;
		try {
			this.dmd = conn.getMetaData();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	public List<String> getCatalogs(){
		List<String> rtn = new ArrayList<String>();
		try {
			ResultSet rs = dmd.getCatalogs();
			while(rs.next()){
				String cat = rs.getString("TABLE_CAT");
				if(cat!=null){
					rtn.add(cat);
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return rtn;
	}
	
	public List<String> getSchemas(){
		List<String> rtn = new ArrayList<String>();
		try {
			ResultSet rs = dmd.getSchemas();
			while(rs.next()){
				String schema = rs.getString("TABLE_SCHEM");
				if(schema!=null){
					rtn.add(schema);
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return rtn;
	}
	

	public void setCatalog(String catalog) {
		this.catalog = catalog;
	}

	public void setSchema(String schema) {
		this.schema = schema;
	}


	public static void main(String[] args){
		
		
		
		
		String driver="net.sourceforge.jtds.jdbc.Driver";
		String url="jdbc:jtds:sqlserver://172.16.20.188:1433;";//DatabaseName=HRP_Dev_Normal";// HRP_Dev_System
		String username="sa";
		String password="sa1234";
//		
//		String driver="oracle.jdbc.OracleDriver";
//		String url="dbc:oracle:thin:@172.16.30.58:1521:orcl";
//		String username="fw_core";
//		String password="fw_core";
		
//		String driver="org.postgresql.Driver";
//		String url="jdbc:postgresql://172.16.30.58:5432/fw_core";
//		String username="postgres";
//		String password="root";
		
		Connection conn = null;
		Statement stmt = null;
		try {
			Class.forName(driver);
			
			conn = DriverManager.getConnection(url,username,password);
			
			//HRP_Dev_Normal
			String catalog = "HRP_Dev_Normal";
			String schema = "dbo";
			String ttable ="YBD1";
			
			
			DatabaseMetaData dmd = conn.getMetaData();
			
			ResultSet rs = dmd.getCatalogs();
			while(rs.next()){
				System.out.println( rs.getString("TABLE_CAT"));
			}
			System.out.println("======");
			rs = dmd.getSchemas();
			while(rs.next()){
				System.out.println( rs.getString("TABLE_SCHEM"));
			}
			
			SqlDBMetaData sqldb = new SqlDBMetaData(conn);
			sqldb.catalog = catalog;
			sqldb.schema = schema;
			sqldb.getTables("%");
			sqldb.getPrimarys(ttable);
			sqldb.getUniques( ttable);
			sqldb.getForeigns(ttable);
			sqldb.getColumns(ttable);
			
			System.out.println(UUID.randomUUID());
		} catch (Exception e) {
			e.printStackTrace();
		} finally{
			if(conn!=null){
				try {
					conn.close();
				} catch (SQLException e) {
				}
			}
		}
		
	}
}
