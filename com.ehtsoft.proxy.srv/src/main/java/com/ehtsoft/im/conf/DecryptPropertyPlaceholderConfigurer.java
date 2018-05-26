package com.ehtsoft.im.conf;

import java.io.UnsupportedEncodingException;
import java.util.Base64;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.springframework.beans.factory.config.PropertyPlaceholderConfigurer;

import com.ehtsoft.fw.security.LicenseManager;
import com.ehtsoft.fw.utils.RSAUtil;
import com.ehtsoft.fw.utils.Util;
/**
 * 用于deploy.properties 文件的解密操作 
 * @author wangbao
 */
public class DecryptPropertyPlaceholderConfigurer extends PropertyPlaceholderConfigurer {
	String encode = "utf-8";
	/**
	 * encryptProperty 值为 propertyKey* 或 *propery* 多个采用“,”分割
	 */
	private String encryptProperty;
	
	@Override
	protected String convertProperty(String propertyName, String propertyValue) {
		if(isEncryptPropertyVal(propertyName)){  
	            return decrypt(propertyValue);//调用解密方法  
        }else{  
            return propertyValue;  
        }  
	}

	public void setEncryptProperty(String encryptProperty) {
		this.encryptProperty = encryptProperty;
	}

	private boolean isEncryptPropertyVal(String propertyName){  
		 boolean rtn = false;
	     if(Util.isNotEmpty(encryptProperty)){
    		 String[] eps = encryptProperty.split("\\,");
    		 for(String prop:eps){
    			 String regexp = prop.replaceAll("\\.","\\\\.").replaceAll("\\*", ".*");
    			 Pattern p = Pattern.compile(regexp);
    			 Matcher m = p.matcher(propertyName);
    		     rtn = m.matches();
    		     if(rtn){
    		    	 break;
    		     }
    		 }
	     }
	     return rtn;
	}
	
	private String decrypt(String encryptData){
		byte[] privateKey = LicenseManager.getRsaKey(RSAUtil.PRIVATE_KEY_FILE);
		byte[] encrypt = Base64.getDecoder().decode(encryptData);
		byte[] decrypt = RSAUtil.decryptByPrivateKey(encrypt, privateKey);
		String rtn = null;
		if(decrypt!=null){
			try {
				rtn =  new String(decrypt,encode);
			} catch (UnsupportedEncodingException e) {
			}
		}
		return rtn;
	}
}
