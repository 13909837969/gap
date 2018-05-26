package com.ehtsoft.im.protocol;

import java.io.Serializable;
import java.util.Date;

import com.ehtsoft.fw.utils.DateUtil;

/**
 * Created by wangbao on 17/9/7.
 */

public class ChatSession implements Serializable{
    //会话类型  1 点对点 (type 属性值)
    public final static int SESSION_TYPE_P2P = 1;
    //会话类型  2 群组  (type 属性值)
    public final static int SESSION_TYPE_P2G = 2;

    /**
     * 接受消息时，该值为 from + to 的 md5 值，发送消息时，该值为 to + from 的 md5 值
     */
    private String sid;
    /**
     * 接受服务器消息时 from 数据存入该字段,发送数据时  to 数据存入该字段
     */
    private String from;
    /**
     * 会话类型 1 点对点  2 群组
     */
    private int type;
    /**
     * 会话最后一条信息的内容
     * （语音为空）
     */
    private byte[] content;
    /**
     * 内容的类型，对应 CHAT_MESSAGE.F_TYPE (文字，语音等)
     */
    private int contentType;
    /**
     *  13位，最后一条记录的发送的 日期 long
     */
    private long contentTime;
    /**
     * 0 未读取  1 已读
     * 是否读取标记
     */
    private int read;
    /**
     * 未读信息的个数
     */
    private int count;
    /**
     * 排序，新消息 F_ORDER + 1 ，显示的时候，降序排列
     */
    private int order;

    public String getSid() {
        return sid;
    }

    public void setSid(String sid) {
        this.sid = sid;
    }

    public String getFrom() {
        return from;
    }

    public void setFrom(String from) {
        this.from = from;
    }

    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }

    public byte[] getContent() {
        return content;
    }

    public void setContent(byte[] content) {
        this.content = content;
    }

    public int getContentType() {
        return contentType;
    }

    public void setContentType(int contentType) {
        this.contentType = contentType;
    }

    public String getTextContent(){
        String rtn = "";
        if (this.getContentType() == IMProtocol.Type.VOICE_SHORT.getValue()) {
            rtn = "语音信息";
        }
        if(this.getContentType() == IMProtocol.Type.TEXT.getValue()){
            if(this.getContent()!=null) {
                rtn = new String(this.getContent());
            }
        }
        return rtn;
    }
    
    public long getContentTime() {
        return contentTime;
    }

    public String getTime(){
        return DateUtil.format(new Date(this.getContentTime()),"H:m:s");
    }

    public void setContentTime(long contentTime) {
        this.contentTime = contentTime;
    }

    public int getRead() {
        return read;
    }

    public void setRead(int read) {
        this.read = read;
    }

    public int getCount() {
        return count;
    }

    public void setCount(int count) {
        this.count = count;
    }

    public int getOrder() {
        return order;
    }

    public void setOrder(int order) {
        this.order = order;
    }

}
