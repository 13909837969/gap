package com.ehtsoft.im.dto;

import com.ehtsoft.fw.core.dto.Basic;
/**
 * 组合消息用户信息关联表
 * <br>
 * @author wangbao
 */
public class GroupUser extends Basic {
    /**
     * 群组信息ID
     * <br>
     */
    private String gid;
    /**
     * 群成员ID
     * <br>
     */
    private String aid;
    /**
     * 成员类型
     * <br>成员类型：0 普通成员 1 管理员  2 群主
     */
    private Integer type;
    /**
     * 成员备注名
     * <br>
     */
    private String name;
    /**
     * 群组信息ID
     * <br>
     */
    public String getGid() {
        return gid;
    }
    /**
     * 群组信息ID
     * <br>
     */
    public void setGid(String gid) {
        this.gid = gid;
    }
    /**
     * 群成员ID
     * <br>
     */
    public String getAid() {
        return aid;
    }
    /**
     * 群成员ID
     * <br>
     */
    public void setAid(String aid) {
        this.aid = aid;
    }
    /**
     * 成员类型
     * <br>成员类型：0 普通成员 1 管理员  2 群主
     */
    public Integer getType() {
        return type;
    }
    /**
     * 成员类型
     * <br>成员类型：0 普通成员 1 管理员  2 群主
     */
    public void setType(Integer type) {
        this.type = type;
    }
    /**
     * 成员备注名
     * <br>
     */
    public String getName() {
        return name;
    }
    /**
     * 成员备注名
     * <br>
     */
    public void setName(String name) {
        this.name = name;
    }
}
