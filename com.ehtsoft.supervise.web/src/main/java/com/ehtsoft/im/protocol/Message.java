package com.ehtsoft.im.protocol;

import com.ehtsoft.fw.utils.DateUtil;
import com.ehtsoft.fw.utils.MD5Util;
import com.ehtsoft.im.protocol.IMProtocol.PGFlag;
import com.ehtsoft.im.protocol.IMProtocol.Status;
import com.ehtsoft.im.protocol.IMProtocol.Type;

import java.io.UnsupportedEncodingException;
import java.util.Date;


/**
 * 消息对象类，用于针对 消息协议 IMProtocol 的数据包装
 * @author 王宝
 * 2017-08-08
 */
public class Message {
	private String messageId;
	//类型：TEXT,VOICE,VAIDE 等
	private IMProtocol.Type type;
	private IMProtocol.Status status;
	//点对点或点对群组或@标识
	private IMProtocol.PGFlag pgFlag = IMProtocol.PGFlag.P2P;
	private IMProtocol.PGFlag at = new IMProtocol.PGFlag(0x0);
	private String from;
	private String to;
	//群ID
	private String gid;
	/**
	 * 发送的时间，毫秒数，同时作为语音arm文件名
	 */
	private long timeMillis;
	/**
	 * 语音短信或视频短信时间长度，单位秒
	 */
	private int duration;
	/**
	 * 数据内容
	 */
	private byte[] content;

	/**
	 * 消息头信息( type(1) + status(1) + from(36) + to(36) + time(13) + 视频及语音短信秒数(3位) + messageId(36)
	 */
	private byte[] header;

	//是否是发送的消息  true 发送的消息  false 不是发送的消息(接受的消息）
	private boolean send = false;

	public  Message(){
		header = new byte[IMProtocol.MESSAGE_HEAD_LENGTH];
	}

	public IMProtocol.Type getType() {
		return type;
	}

	public void setType(IMProtocol.Type type) {
		this.type = type;
		int h = this.header[0];
		h = h & 0xf0;
		int t =  h|type.getValue();
		this.header[0] = (byte)t;
	}

	public IMProtocol.Status getStatus() {
		return status;
	}

	public void setStatus(IMProtocol.Status status) {
		this.status = status;
		int h = this.header[0];
		h = h & 0x0f;
		int t = h|status.getValue();
		this.header[0] = (byte)t;
	}

	/**
	 * 设置回执状态(成功状态)
	 */
	public Message receiptSuccess(){
		Message rtn = new Message();
		rtn.setMessageId(this.getMessageId());
		rtn.setFrom(this.getFrom());
		rtn.setTo(this.getTo());
		rtn.setTimeMillis(this.getTimeMillis());
		rtn.setStatus(IMProtocol.Status.RECEIPT_SUCCESS);
		return rtn;
	}

	/**
	 * 设置回执状态（失败状态）
	 */
	public Message receiptFailure(){
		Message rtn = new Message();
		rtn.setMessageId(this.getMessageId());
		rtn.setFrom(this.getFrom());
		rtn.setTo(this.getTo());
		rtn.setTimeMillis(this.getTimeMillis());
		rtn.setStatus(IMProtocol.Status.RECEIPT_FAILURE);
		return rtn;
	}

	public IMProtocol.PGFlag getPgFlag() {
		return pgFlag;
	}

	public void setPgFlag(IMProtocol.PGFlag pgFlag) {
		/**
		 * 点对点或群组 （个人对个人或对群组）低位
		 */
		this.pgFlag = pgFlag;
		int h = this.header[1];
		h = h&0xf0;
		int t = h|pgFlag.getValue();
		this.header[1] = (byte)t;
	}

	public void setAt(){
		this.at = IMProtocol.PGFlag.at;
		int h = this.header[1];
		h = h&0x0f;
		int t = h|this.at.getValue();
		this.header[1]=(byte)t;
	}
	public void setAt(IMProtocol.PGFlag at){
		this.at = at;
		int h = this.header[1];
		h = h&0x0f;
		int t = h|this.at.getValue();
		this.header[1]=(byte)t;
	}
	/**
	 * 群发的时候，定向发个一个人标记
	 */
	public void setGroupToOneFlag(){
		int h = this.header[1];
		h = h&0x0f;
		int t = h|IMProtocol.PGFlag.one.getValue();
		this.header[1]=(byte)t;
	}
	/**
	 * 群发的时候，是否 定向发个一个人标记
	 * @return true 群发的时候，只发一个人 to 的人  false ，群发的时候，发所有的人
	 */
	public boolean isGroupToOneFlag(){
		int h1 = this.header[1];
		return PGFlag.one.equals(new PGFlag(h1 & 0xf0));
	}

	public void cancelAt(){
		byte h = this.header[1];
		this.header[1] = (byte)(h & 0x0f);
		this.at = new IMProtocol.PGFlag(0x0);
	}

	public String getFrom() {
		return from;
	}

	public void setFrom(String from) {
		this.from = from;
		if(from!=null) {
			byte[] fromBytes = from.getBytes();
			int fromLen = fromBytes.length;
			if (fromLen > 36) {
				fromLen = 36;
			}
			byte[] empty = new byte[36];
			//发信人，从 2 开始
			System.arraycopy(empty, 0, this.header, 2, empty.length);
			System.arraycopy(fromBytes, 0, this.header, 2, fromLen);
		}
	}

	public String getTo() {
		return to;
	}

	public void setTo(String to) {
		this.to = to;
		if(to!=null) {
			byte[] toBytes = to.getBytes();
			int toLen = toBytes.length;
			if (toLen > 36) {
				toLen = 36;
			}
			byte[] empty = new byte[36];
			System.arraycopy(empty, 0, this.header, 38, empty.length);
			System.arraycopy(toBytes, 0, this.header, 38, toLen);
		}
	}

	public String getGid() {
		return gid;
	}

	public void setGid(String gid) {
		this.gid = gid;
		if(gid!=null) {
			byte[] gidBytes = gid.getBytes();
			int midLen = gidBytes.length;
			if (midLen > 36) {
				midLen = 36;
			}
			byte[] empty = new byte[36];
			System.arraycopy(empty, 0, this.header, 126, empty.length);
			System.arraycopy(gidBytes,0,this.header,126,midLen);
		}
	}

	public long getTimeMillis() {
		return timeMillis;
	}

	public void setTimeMillis(long timeMillis) {
		this.timeMillis = timeMillis;
		if(timeMillis>0){
			//时间戳（发送的时间 13 位毫秒数）
			String time = String.valueOf(timeMillis);
			byte[] timeBytes = time.getBytes();
			int timeLen = timeBytes.length;
			if(timeLen>13){
				timeLen = 13;
			}
			System.arraycopy(timeBytes, 0, this.header, 74, timeLen);
		}
	}

	public int getDuration() {
		return duration;
	}

	public void setDuration(int duration) {
		this.duration = duration;
		byte[] durationBytes = String.valueOf(duration).getBytes();
		int durLen = durationBytes.length;
		if(durLen > 3){
			durLen = 3;
		}
		System.arraycopy(durationBytes, 0, this.header, 87, durLen);
	}

	public String getMessageId(){
		return this.messageId;
	}

	public void setMessageId(String messageId){
		this.messageId = messageId;
		if(messageId!=null) {
			byte[] messageIdBytes = messageId.getBytes();
			int midLen = messageIdBytes.length;
			if (midLen > 36) {
				midLen = 36;
			}
			byte[] empty = new byte[36];
			System.arraycopy(empty, 0, this.header, 90, empty.length);
			System.arraycopy(messageIdBytes,0,this.header,90,midLen);
		}
	}

	public byte[] getContent() {
		return content;
	}

	public String getTextContent(){
		String rtn = null;
		if(this.type.equals(IMProtocol.Type.TEXT)){
			rtn = new String(this.getContent());
		}
		return rtn;
	}

	public void setContent(byte[] contents) {
		this.content = contents;
	}

	public byte[] getMessages() {
		int len = this.header.length;
		if(this.content!=null){
			len = len + this.content.length;
		}
		byte[] messages = new byte[len];
		System.arraycopy(this.header, 0, messages, 0, this.header.length);
		if(this.content != null) {
			System.arraycopy(this.content, 0, messages, this.header.length, this.content.length);
		}
		return messages;
	}


	//// #####################

	public boolean isSend() {
		return send;
	}

	public void setSend(boolean send) {
		this.send = send;
	}

	/**
	 * 向群组发送信息  true 群组，false 点对点
	 * @return
	 */
	public boolean isP2G(){
		return this.pgFlag.equals(IMProtocol.PGFlag.P2G);
	}

    /**
     * 是否 @ 发送给的人（to）
     * @return
     */
    public boolean isAt(){
        return this.at.equals(IMProtocol.PGFlag.at);
    }
    
	public boolean isCompleteStatus(){
		return this.status.equals(IMProtocol.Status.TRANSFER_COMPLETE);
	}

	/**
	 * 获取语音短信的文件名
	 * @return
	 */
	public String getVoiceFilename(){
		return this.getMessageId() + ".amr";
	}

	public String getTime(){
		Date date = new Date(timeMillis);
		return DateUtil.format(date,"HH:mm:ss");
	}

	public boolean isOverflow(){
		boolean rtn = false;
		if(this.getContent()!=null){
			rtn = this.getContent().length > IMProtocol.MAX_PAYLOAD_BUFFERSIZE - IMProtocol.MESSAGE_HEAD_LENGTH;
		}
		return rtn;
	}

	public boolean eqType(IMProtocol.Type type){
		boolean rtn = false;
		if(type!=null && this.type!=null){
			rtn = this.type.equals(type);
		}
		return rtn;
	}

	public boolean eqStatus(IMProtocol.Status status){
		boolean rtn = false;
		if(status!=null && this.status!=null){
			rtn = this.status.equals(status);
		}
		return rtn;
	}

    public String getSid(){
        /**
         * 接受消息时，该值为 from + to 的 md5 值，发送消息时，该值为 to + from 的 md5 值
         */
        String sid = this.getGid(); // 群组的 id （gid）
        //接受服务器消息时 from 数据存入该字段,发送数据时  to 数据存入该字段 (f_from 字段)
        if(!this.isP2G()) { //非群组消息发送
            sid = MD5Util.encrypt((this.from + this.to).getBytes());
            //发送的消息
            if (this.isSend()) {
                sid = MD5Util.encrypt((this.to + this.from).getBytes());
            }
        }
        return sid;
    }

    public ChatSession toChatSession(){
        ChatSession chatSession = new ChatSession();
        chatSession.setSid(getSid()); // 群组时候为 to
        chatSession.setFrom(this.from);
        //  会话类型 1 点对点  2 群组
        chatSession.setType(this.getPgFlag().getValue());
        if(this.type.equals(IMProtocol.Type.TEXT)) {
            chatSession.setContent(this.getContent());
        }
        chatSession.setContentType(this.type.getValue());
        chatSession.setContentTime(this.getTimeMillis());
        return chatSession;
    }

}