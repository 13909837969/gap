package com.ehtsoft.user.utils;

import java.util.UUID;

public class SYSID {
	public static String INIT_VALUE = "000000000000-0000-0000-0000000-00000";
	private String value = INIT_VALUE;
	
	public SYSID(){
	}
	
	public SYSID(String value){
		this.value = value;
	}
	
	public void setValue(String value){
		this.value = value;
	}
	
	public String getValue(){
		return value;
	}
	@Override
	public String toString(){
		return value;
	}
}
