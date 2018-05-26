package com.ehtsoft.im.protocol;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.util.UUID;


/**
 * WebSocket 消息协议 ( 和 android app 客户端通讯的消息协议 )
 * 消息信息(  [status高位 | type 地位](1) + [ @ 高位|group地位  ](1) + from(36) + to(36) + time(13) + 视频及语音短信秒数(3位) + messageId(36) + gid(36) + content)
 * @author wangbao
 */
public final class IMProtocol{
	public final static int MAX_PAYLOAD_BUFFERSIZE = 819200; //1024 << 3
    //消息信息 [status 高位 | type 低位](1) + [ @ 高位|group地位 ](1) + from(36) + to(36) + time(13)) + 语音短信及视频短信长度（秒 3 位）+ messageId(36) + gid(36) = 162
    public final static int MESSAGE_HEAD_LENGTH = 162;
    //信息体的长度
    public final static int MESSAGE_BODY_LENGTH = MAX_PAYLOAD_BUFFERSIZE - MESSAGE_HEAD_LENGTH;

    public static interface StreamPage{
        //完成
        void complete();
        //分发流每页的字节说
        void handlePage(byte[] bytes);
    }
    /**
     * 录音文件分流
     * @param path
     * @param streamPage
     */
    public static void handleStream(String path,StreamPage streamPage){
        try {
            InputStream is = new FileInputStream(path);
            byte[] bytes = new byte[MESSAGE_BODY_LENGTH];
            int len = 0;
            if(streamPage!=null){
                while((len = is.read(bytes))!=-1){
                    byte[] out = new byte[len];
                    System.arraycopy(bytes,0,out,0,len);
                    streamPage.handlePage(out);
                }
                streamPage.complete();
            }
            is.close();
        } catch (FileNotFoundException e) {
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    /**
     * 类型 第 0 位 低位
     */
    public static class Type {
        /**
         * 文本
         */
        public final static Type TEXT = 		new Type(0x01);  	//文本 (8192字节)
        /**
         * 语音短信
         */
        public final static Type VOICE_SHORT = 	new Type(0x02);   //短语音类型
        /**
         * 视频短信
         */
        public final static Type VIDEO_SHORT =  new Type(0x03);	//短视频类型
        /**
         * 语音电话
         */
        public final static Type VOICE_STREAM = new Type(0x04);   //语音流（语音电话功能)
        /**
         * 视频电话
         */
        public final static Type VIDEO_STREAM = new Type(0x05);   //视频流（视频电话功能）

        private byte value = 0;
        public Type(int value){
            this.value = (byte)value;
        }

        public boolean equals(Type type){
            return this.value == type.value;
        }

        public byte getValue(){
            return this.value;
        }
        @Override
        public String toString(){
            String rtn = "";
            if(this.value == TEXT.value){
                rtn = "TEXT";
            }
            if(this.value == VOICE_SHORT.value){
                rtn = "VOICE_SHORT";
            }
            if(this.value == VIDEO_SHORT.value){
                rtn = "VIDEO_SHORT";
            }
            if(this.value == VOICE_STREAM.value){
                rtn = "VOICE_STREAM";
            }
            if(this.value == VIDEO_STREAM.value){
                rtn = "VIDEO_STREAM";
            }
            return "type:"+rtn;
        }
    };

    /**
     * 状态 第 0 位 高位
     */
    public static class Status{
        /**
         * 大文件及大数据处理中采用 TRANSFER_PROGRESS 进行传输，只有传输到最后一个 数据的是，将状态修改为 TRANSFER_COMPLETE 状态
         */
        public final static Status TRANSFER_PROGRESS = new Status(0x10);
        /**
         * 信息传输完成状态
         */
        public final static Status TRANSFER_COMPLETE = new Status(0x20);
        /**
         * 信息已接受回执的状态（回执给发送者，状态为接受成功状态）
         */
        public final static Status RECEIPT_SUCCESS = new Status(0x30);
        /**
         * 信息已接受回执的状态（回执状态为失败状态）
         */
        public final static Status RECEIPT_FAILURE = new Status(0x40);

        private byte value = 0;

        public Status(int value){
            this.value = (byte)value;
        }

        public boolean equals(Status type){
            return this.value == type.value;
        }
        public byte getValue(){
            return this.value;
        }

        @Override
        public String toString(){
            String rtn = "";
            if(this.value==TRANSFER_PROGRESS.value){
                rtn = "TRANSFER_PROGRESS";
            }
            if(this.value==TRANSFER_COMPLETE.value){
                rtn = "TRANSFER_COMPLETE";
            }
            if(this.value==RECEIPT_SUCCESS.value){
                rtn = "RECEIPT_SUCCESS";
            }
            if(this.value==RECEIPT_FAILURE.value){
                rtn = "RECEIPT_FAILURE";
            }
            return "status:"+rtn;
        }
    }

    /**
     * 点对点群组消息标记
     * 第 1 位
     */
    public static class PGFlag{
        /**
         * 点对点 （个人对个人）低位
         */
        public final static PGFlag P2P = new PGFlag(0x01);
        /**
         * 点对群（群组）  地位
         */
        public final static PGFlag P2G = new PGFlag(0x02);
        
        //------------------
        /**
         * 群公告 - 通知
         */
        public final static PGFlag NOTIFI_GROUP = new PGFlag(0x03);
        /**
         * 注册通知 - 通知
         */
        public final static PGFlag NOTIFI_REG = new PGFlag(0x04);
        /**
         * 教育通知（集中教育） - 通知
         */
        public final static PGFlag NOTIFI_EDU = new PGFlag(0x05);
        /**
         * 集中服务通知 - 通知
         */
        public final static PGFlag NOTIFI_SER = new PGFlag(0x06);

        //-----------\\--------
        
        /**
         * @ 标识  高位
         */
        public final static PGFlag at = new PGFlag(0x50);
        /**
         * 高位
         * 点对群的时候，通过群定向发送给一个人的标识
         * （登记注册成功的时候，服务器发送给客户端的提醒信息及 欢迎信息等）
         * 服务器端使用的标识
         */
        public final static PGFlag one = new PGFlag(0x70);

        private byte value = 0;
        public PGFlag(int value){
            this.value = (byte)value;
        }

        public boolean equals(PGFlag pgflag){
            return this.value == pgflag.value;
        }

        public byte getValue(){
            return this.value;
        }

    }

    private IMProtocol(){
    }

    /**
     * 包装消息
     * 消息的实际长度为 8192 - 90 = 8102 (字节)
     * 封包的时候，需要对 messageBody 的长度进行判断，否则会出现数据被截取的现象
     * @param type
     * @return
     */
    public static Message wrap(Type type){
        return wrap(type, null);
    }
    /**
     * 包装消息
     * 消息的实际长度为 8192 - 90 = 8102 (字节)
     * 封包的时候，需要对 messageBody 的长度进行判断，否则会出现数据被截取的现象
     * @return
     */
    public static Message wrap(Type type,byte[] content){
        return wrap(type, null, null, content);
    }

    /**
     * 包装消息
     * 消息的实际长度为 8192 - 90 = 8102 (字节)
     * 封包的时候，需要对 messageBody 的长度进行判断，否则会出现数据被截取的现象
     * @return
     */
    private static Message wrap(Type type,String from,String to,byte[] content){
        Message rtn = new Message();
        rtn.setMessageId(UUID.randomUUID().toString());
        if(type==null){
            throw new RuntimeException("wrap 参数不能为空");
        }
        int contentLength = 0;
        if(content!=null){
            contentLength = content.length;
        }
        int size = contentLength + MESSAGE_HEAD_LENGTH;
        if(size > MAX_PAYLOAD_BUFFERSIZE){
            size = MAX_PAYLOAD_BUFFERSIZE;
            //rtn.overflow = true;
        }
        //类型
        rtn.setType(type);
        //状态位
        rtn.setStatus(Status.TRANSFER_COMPLETE);
        //默认为 P2P 方法
        rtn.setPgFlag(PGFlag.P2P);
        rtn.cancelAt();
        //发送者
        rtn.setFrom(from);
        //接收者
        rtn.setTo(to);
        //时间戳（发送的时间 13 位毫秒数）
        rtn.setTimeMillis(System.currentTimeMillis());
        //内容
        rtn.setContent(content);
        return rtn;
    }
    /**
     * 拆包
     * @param messages
     * 类型1位（MessageType）+ status(1) + from 36位（发信人ID） + to 36位（目标人ID）+ time(13) + 语音短信及视频短信长度（秒 3 位) + 数据 （8192 - 1 - 1 - 36 - 36 - 13 - 3 = 8192 - 90）
     * @return
     */
    public static Message unwrap(byte[] messages){
        Message rtn = new Message();
        int h0 = messages[0];
        Type type = new Type(h0 & 0x0f);
        rtn.setType(type);
        rtn.setStatus(new Status(h0 & 0xf0));
        int h1 = messages[1];
        //低位
        rtn.setPgFlag(new PGFlag(h1 & 0x0f));
        //高位
        rtn.setAt(new PGFlag(h1 & 0xf0));
        byte[] fromBytes = new byte[36];
        System.arraycopy(messages, 2, fromBytes, 0, fromBytes.length);
        rtn.setFrom(new String(getByteNotZero(fromBytes)));
        byte[] toBytes = new byte[36];
        System.arraycopy(messages, 38, toBytes, 0, toBytes.length);
        rtn.setTo(new String(getByteNotZero(toBytes)));
        byte[] timeBytes = new byte[13];
        System.arraycopy(messages, 74, timeBytes, 0, timeBytes.length);
        rtn.setTimeMillis(Long.valueOf(new String(getByteNotZero(timeBytes))));

        byte[] durationBytes = new byte[3];
        System.arraycopy(messages, 87, durationBytes, 0, durationBytes.length);
        byte[] bs = IMProtocol.getByteNotZero(durationBytes);
        if(bs.length>0){
            rtn.setDuration(Integer.valueOf(new String(bs)));
        }

        byte[] messageIdBytes = new byte[36];
        System.arraycopy(messages,90,messageIdBytes,0,messageIdBytes.length);
        rtn.setMessageId(new String(messageIdBytes));

        byte[] gidBytes = new byte[36];
        System.arraycopy(messages,126,gidBytes,0,gidBytes.length);
        rtn.setGid(new String(gidBytes));

        byte[] contentBytes = new byte[messages.length - MESSAGE_HEAD_LENGTH];
        System.arraycopy(messages, MESSAGE_HEAD_LENGTH, contentBytes, 0, contentBytes.length);
        rtn.setContent(contentBytes);
        return rtn;
    }
    public static byte[] getByteNotZero(byte[] bytes){
        int len = -1;
        for(int i=bytes.length-1;i>=0;i--){
            if(bytes[i]!=(byte)0){
                len = i;
                break;
            }
        }
        byte[] rtn = new byte[len+1];
        System.arraycopy(bytes, 0, rtn, 0, rtn.length);
        return rtn;
    }

    public static void main(String[] args){
        String fromid = UUID.randomUUID().toString();
        System.out.println("FROM:"+fromid);
        String toId = UUID.randomUUID().toString();
        System.out.println("TO:"+toId);

        Message msg = wrap(Type.TEXT,fromid,toId, "我们都有一个家，名字叫中国".getBytes());
        msg.setAt();
        msg.setPgFlag(PGFlag.P2G);
        msg.setGid("000000001");
        msg.setDuration(4);
        System.out.println(msg.getType().toString());
        System.out.println(msg.getStatus());
        System.out.println("MSG-FROM:" + msg.getFrom());
        System.out.println("MSG-TO:" + msg.getTo());
        System.out.println("time:" + msg.getTimeMillis());
        System.out.println("duration:" + msg.getDuration());
        System.out.println("content:" + msg.getTextContent());
        System.out.println("message:" + new String(msg.getMessages()));
        System.out.println("gid:" + msg.getGid());
        System.out.println(msg.getPgFlag().getValue());
        System.out.println("========");
        Message msg2 = unwrap(msg.getMessages());
        System.out.println(msg2.getType().toString());
        System.out.println(msg2.getStatus());
        System.out.println("MSG-FROM:" + msg2.getFrom());
        System.out.println("MSG-TO:" + msg2.getTo());
        System.out.println("time:" + msg2.getTimeMillis());
        System.out.println("duration:" + msg2.getDuration());
        System.out.println("content:" + msg2.getTextContent());
        System.out.println("message:" + new String(msg2.getMessages()));
        System.out.println("gid:" + msg2.getGid());
        System.out.println(msg2.getPgFlag().getValue());
        
    }
}