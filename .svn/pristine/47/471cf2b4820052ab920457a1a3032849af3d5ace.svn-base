package com.ehtsoft.fw.plugin.model;

import java.io.Serializable;
/**
 * 数据库设置对象
 * @author 王宝
 */
public class DBSettingData implements Serializable {
	private static final long serialVersionUID = 923929777178954760L;
	private String dbType;
	private String driver;
	private String url;
	private String username;
	private String password;
	private String catalog;
	private String schema;
	
	public String getDriver() {
		return driver;
	}
	public void setDriver(String driver) {
		this.driver = driver;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getCatalog() {
		return catalog;
	}
	public void setCatalog(String catalog) {
		this.catalog = catalog;
	}
	public String getSchema() {
		return schema;
	}
	public void setSchema(String schema) {
		this.schema = schema;
	}
	public String getDbType() {
		return dbType;
	}
	public void setDbType(String dbType) {
		this.dbType = dbType;
	}
	
	@Override
	public String toString(){
		String rtn = dbType + "-"+this.catalog +"-"+ this.url.replaceAll(".*?@|.*?//", "").replaceAll(":.*", "");
		if("Oracle".equals(dbType)){
			rtn = dbType + "-" + username + "-" + this.url.replaceAll(".*?@|.*?//", "").replaceAll(":.*", "");
		}
		return rtn;
	}
	
}
