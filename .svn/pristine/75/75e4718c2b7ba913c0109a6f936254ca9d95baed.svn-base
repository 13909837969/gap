package com.ehtsoft.im.protocol;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlRootElement;

/**
 * 命令消息对象
 * @author wangbao
 */
@XmlRootElement(name="Command")
@XmlAccessorType(XmlAccessType.FIELD)
public class Command {
	/**
	 * 1 从平台发向手机端
	 */
	public final static int DIRECTION_PHONE_TO_PAD = 1;
	/**
	 * 2 从平台发向平板端
	 */
	public final static int DIRECTION_PAD_TO_PHONE = 2;
	/**
	 * false:非警告
	 * true:警告
	 */
	private boolean alarm = false;
	//发送人的ID
	private String from;
	//发送人姓名
	private String name;
	//接受消息提醒的人的ID
	private String to;
	//发送类型（从平台发向 矫正手机端的时候  ）
	private Integer direction; // 1 从平台发向手机端  2 从平台发向平板端  3 从手机端发向平台
	//发送命令 (CommandType)
	private int command;
	
	private String content;
	
	public Command(){
		
	}
	
	public boolean isAlarm() {
		return alarm;
	}
	public void setAlarm(boolean alarm) {
		this.alarm = alarm;
	}
	public String getFrom() {
		return from;
	}
	public void setFrom(String from) {
		this.from = from;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getTo() {
		return to;
	}
	public void setTo(String to) {
		this.to = to;
	}
	public Integer getDirection() {
		return direction;
	}
	public void setDirection(Integer direction) {
		this.direction = direction;
	}
	public int getCommand() {
		return command;
	}
	public void setCommand(int command) {
		this.command = command;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
}
