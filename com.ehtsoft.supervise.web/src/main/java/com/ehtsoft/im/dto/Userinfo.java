package com.ehtsoft.im.dto;

import com.ehtsoft.fw.core.dto.Basic;
/**
 * 消息用户信息表
 * <br>
 * @author wangbao
 */
public class Userinfo extends Basic {
    /**
     * 主键
     * <br>系统自动生成
     */
    private String aid;
    /**
     * 编码
     */
    private String code;
    /**
     * 性别
     */
    private String gender;
    /**
     * 用户名/昵称
     * <br>
     */
    private String nickname;
    /**
     * 密码
     * <br>
     */
    private String password;
    /**
     * 是否禁用
     * <br>1 禁用 0 不禁用
     */
    private Integer disable;
    /**
     * 标记
     * 0 矫正人员  1 工作人员
     */
    private Integer flag;
    /**
     * 主键
     * <br>系统自动生成
     */
    public String getAid() {
        return aid;
    }
    /**
     * 主键
     * <br>系统自动生成
     */
    public void setAid(String aid) {
        this.aid = aid;
    }
    /**
     * 编码
     */
    public String getCode() {
		return code;
	}
    /**
     * 编码
     */
	public void setCode(String code) {
		this.code = code;
	}
    /**
     * 性别
     */
	public String getGender() {
		return gender;
	}
    /**
     * 性别
     */
	public void setGender(String gender) {
		this.gender = gender;
	}
	/**
     * 用户名/昵称
     * <br>
     */
    public String getNickname() {
        return nickname;
    }
    /**
     * 用户名/昵称
     * <br>
     */
    public void setNickname(String nickname) {
        this.nickname = nickname;
    }
    /**
     * 密码
     * <br>
     */
    public String getPassword() {
        return password;
    }
    /**
     * 密码
     * <br>
     */
    public void setPassword(String password) {
        this.password = password;
    }
    /**
     * 是否禁用
     * <br>1 禁用 0 不禁用
     */
    public Integer getDisable() {
        return disable;
    }
    /**
     * 是否禁用
     * <br>1 禁用 0 不禁用
     */
    public void setDisable(Integer disable) {
        this.disable = disable;
    }
    /**
     * 标记
     * 0 矫正人员  1 工作人员
     */
	public Integer getFlag() {
		return flag;
	}
    /**
     * 标记
     * 0 矫正人员  1 工作人员
     */
	public void setFlag(Integer flag) {
		this.flag = flag;
	}
    
}
