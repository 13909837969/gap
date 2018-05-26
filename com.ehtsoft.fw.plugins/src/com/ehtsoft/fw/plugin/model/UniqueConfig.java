package com.ehtsoft.fw.plugin.model;

public class UniqueConfig {
	 private String name;
	 /**
	  * 复合唯一用 “,”分割
	  */
	 private String field;
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getField() {
		return field;
	}
	public void setField(String field) {
		this.field = field;
	}
	public String toString(){
		return "unique key name :" + name +" , column field:" + field;
	}
	 
}
