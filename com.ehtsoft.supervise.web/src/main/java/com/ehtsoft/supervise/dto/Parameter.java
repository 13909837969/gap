package com.ehtsoft.supervise.dto;

import com.ehtsoft.fw.core.dto.Basic;
import com.ehtsoft.fw.utils.NumberUtil;
/**
 * 系统参数设置表
 * <br>
 * @author wangbao
 */
public class Parameter extends Basic {
	private static final long serialVersionUID = 6242360026474764922L;
	/**
     * 主键
     * <br>系统自动生成
     */
    private String id;
    /**
     * 参数描述
     * <br>
     */
    private String desp;
    /**
     * 参数控制状态
     * <br>针对开关方式的参数，该值保存的时候   1 是   0 否
     */
    private String enable;
    /**
     * 参数值
     * <br>
     */
    private String value;
    
    public Parameter(){
    	
    }
	
    /**
     * 主键
     * <br>系统自动生成
     */
    public String getId() {
        return id;
    }
    /**
     * 主键
     * <br>系统自动生成
     */
    public void setId(String id) {
        this.id = id;
    }
    /**
     * 参数描述
     * <br>
     */
    public String getDesp() {
        return desp;
    }
    /**
     * 参数描述
     * <br>
     */
    public void setDesp(String desp) {
        this.desp = desp;
    }
    
	public boolean isEnable(){
		return NumberUtil.toInt(enable)==1;
	}
    /**
     * 参数控制状态
     * <br>针对开关方式的参数，该值保存的时候   1 是   0 否
     */
    public String getEnable() {
        return enable;
    }
    /**
     * 参数控制状态
     * <br>针对开关方式的参数，该值保存的时候   1 是   0 否
     */
    public void setEnable(String enable) {
        this.enable = enable;
    }
    /**
     * 参数值
     * <br>
     */
    public String getValue() {
        return value;
    }
    /**
     * 参数值
     * <br>
     */
    public void setValue(String value) {
        this.value = value;
    }
}
