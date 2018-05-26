package com.ehtsoft.im.dto;

import com.ehtsoft.fw.core.dto.Basic;
/**
 * 群公告
 * <br>
 * @author wangbao
 */
public class GroupAffiche extends Basic {
    /**
     * 主键
     * <br>系统自动生成
     */
    private String id;
    /**
     * 群组ID
     * <br>
     */
    private String gid;
    /**
     * 公告内容
     * <br>
     */
    private String content;
    /**
     * 类型
     * <br>
     * 0 群公告  1 注册通知
     */
    private Integer type;
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
     * 群组ID
     * <br>
     */
    public String getGid() {
        return gid;
    }
    /**
     * 群组ID
     * <br>
     */
    public void setGid(String gid) {
        this.gid = gid;
    }
    /**
     * 公告内容
     * <br>
     */
    public String getContent() {
        return content;
    }
    /**
     * 公告内容
     * <br>
     */
    public void setContent(String content) {
        this.content = content;
    }
	public Integer getType() {
		return type;
	}
	public void setType(Integer type) {
		this.type = type;
	}
    
}
