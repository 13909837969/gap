package com.ehtsoft.supervise.fwapi.conf;

public class FieldConfig {
	 
	private String fwField;
	private String ltField;
	private String label;
	private String md5;
	
	private String code;
	 
	public String getFwField() {
		return fwField;
	}
	public void setFwField(String fwField) {
		this.fwField = fwField;
	}
	
	public String getLtField() {
		return ltField;
	}
	public void setLtField(String ltField) {
		this.ltField = ltField;
	}
	public String getLabel() {
		return label;
	}
	public void setLabel(String label) {
		this.label = label;
	}
	
	
	public String getMd5() {
		return md5;
	}
	public void setMd5(String md5) {
		this.md5 = md5;
	}
	
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	@Override
	public String toString() {
		return "FieldConfig [fwField=" + fwField + ", ltField=" + ltField + ", label=" + label + "]";
	}
	
	
	
	
}
