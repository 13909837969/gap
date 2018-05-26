package com.ehtsoft.im.protocol;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement(name="Location")
@XmlAccessorType(XmlAccessType.FIELD)
public class Location {
	
	public Location(){
		
	}
    /**
     * 当前用户ID
     */
    private String aid;
    /**
     * 是否在线  true 在线 ，false 离线
     */
    private boolean online = true;
    /**
     * 发送
     */
    private String to;
    /**
     * 具体地址（长地址)
     */
    private  String address;
    /**
     * 位置描述，xxx附近
     */
    private String describe;
    /**
     * 纬度
     * <br>
     */
    private double lat;
    /**
     * 经度
     * <br>
     */
    private double lng;
    /**
     * 海拔
     * <br>
     */
    private double altitude;
    /**
     * 楼层
     */
    private int floor;
    /**
     * 速度
     */
    private float speed;
    /**
     * 距离上一个点的记录
     */
    private float distance;
    /**
     * step 步数
     * @return
     */
    private int step;
    
    /**
     * 定位类型
     */
    private int type;
    /**
     * 姓名
     */
    private String name;
    
    /**
     * 性别
     */
    private String gender;
    
    /**
     * 矫管类别
     */
    private String jglx;
    /**
     * 当前登录矫正人员所属管辖部门orgid
     */
    private String orgid;

    public String getOrgid() {
        return orgid;
    }

    public void setOrgid(String orgid) {
        this.orgid = orgid;
    }
    
    
	public String getAid() {
		return aid;
	}
	public void setAid(String aid) {
		this.aid = aid;
	}
	
	public boolean isOnline() {
		return online;
	}
	public void setOnline(boolean online) {
		this.online = online;
	}
	public String getTo() {
		return to;
	}
	public void setTo(String to) {
		this.to = to;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getDescribe() {
		return describe;
	}
	public void setDescribe(String describe) {
		this.describe = describe;
	}
	public double getLat() {
		return lat;
	}
	public void setLat(double lat) {
		this.lat = lat;
	}
	public double getLng() {
		return lng;
	}
	public void setLng(double lng) {
		this.lng = lng;
	}
	public double getAltitude() {
		return altitude;
	}
	public void setAltitude(double altitude) {
		this.altitude = altitude;
	}
	public float getSpeed() {
		return speed;
	}
	public void setSpeed(float speed) {
		this.speed = speed;
	}
	public int getStep() {
		return step;
	}
	public void setStep(int step) {
		this.step = step;
	}
	public float getDistance() {
		return distance;
	}
	public void setDistance(float distance) {
		this.distance = distance;
	}
	/**
	 * 楼层
	 * @return
	 */
	public int getFloor() {
		return floor;
	}
	/**
	 * 楼层
	 * @param floor
	 */
	public void setFloor(int floor) {
		this.floor = floor;
	}
	
	public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	
	public void setJglx(String jglx){
		this.jglx = jglx;
	}
    public String getJglx() {
        return jglx;
    }
    @Override
    public String toString(){
    	return "{lat:"+lat + "," + "lng:" + lng + "}";
    }
}
