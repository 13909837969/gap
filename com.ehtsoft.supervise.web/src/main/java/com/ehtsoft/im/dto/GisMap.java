package com.ehtsoft.im.dto;

import java.util.HashMap;

public class GisMap<K, V> extends HashMap<String, V> {
	public GisMap(V ... args){
		if(args!=null){
			for(int i=0;i<args.length;i++){
				if(i+1>=args.length){
					break;
				}
				this.put(String.valueOf(args[i]), args[i+1]);
				i++;
			}
		}
	}
}
