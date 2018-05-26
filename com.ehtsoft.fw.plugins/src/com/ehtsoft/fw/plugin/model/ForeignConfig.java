package com.ehtsoft.fw.plugin.model;

public class ForeignConfig {
	
	private String name;
	private String field;
	private String reference;
	private String referField;
	
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
	public String getReference() {
		return reference;
	}
	public void setReference(String reference) {
		this.reference = reference;
	}
	public String getReferField() {
		return referField;
	}
	public void setReferField(String referField) {
		this.referField = referField;
	}
	
	public String toString(){
		return "foregin key name:" + name + ",foreign column:"+field +",reference table:" + reference + ",reference column:" + referField;
	}
}
