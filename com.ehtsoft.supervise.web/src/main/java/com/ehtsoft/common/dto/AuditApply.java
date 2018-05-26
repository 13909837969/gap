package com.ehtsoft.common.dto;

import com.ehtsoft.fw.core.dto.Basic;
/**
 * 审批单据的内容
 * @author 王宝
 */
public class AuditApply extends Basic{
		/**
		 * 主键
		 */
	   private String id;
	   /**
	    * 审批单据ID
	    */
	    private String billid;
	    //单据名称（类型）
	    private String billname;
	    /**
	     * 申请业务ID
	     * <br>
	     * 申请业务如外出申请单据等数据的主键
	     */
	    private String bsid;
	    /**
	     * 申请标题
	     * <br>
	     * 内容如：到xxxx地的外出申请,迁入xxxx（呼和浩特市新城区xx街道）的变更申请,进入xxxx区域的申请
	     */
	    private String title;
	    /**
	     * 申请内容
	     * <br>
	     * 内容如：申请的理由等
	     */
	    private String content;
	    /**
	     * 日期及时间范围
	     */
	    private String timearea;
	    /**
	     * 申请人ID
	     */
	    private String aid;
	    /**
	     * 申请人姓名
	     */
	    private String name;
	    /**
	     * 申请地地址
	     */
	    private String addr;
	    /**
	     * 申请的位置
	     * <br>
	     * 纬度
	     */
	    private Double lat;
	    /**
	     * 申请的位置
	     * <br>
	     * 经度
	     */
	    private Double lng;
	    /**
	     * 过程审批的状态
	     */
	    private int auditing;
	    /**
		 * 主键
		 */
		public String getId() {
			return id;
		}
		/**
		 * 主键
		 */
		public void setId(String id) {
			this.id = id;
		}
		public String getBillid() {
			return billid;
		}
		public void setBillid(String billid) {
			this.billid = billid;
		}
		public String getBsid() {
			return bsid;
		}
		public void setBsid(String bsid) {
			this.bsid = bsid;
		}
		public String getTitle() {
			return title;
		}
		public void setTitle(String title) {
			this.title = title;
		}
		public String getContent() {
			return content;
		}
		public void setContent(String content) {
			this.content = content;
		}
		public String getTimearea() {
			return timearea;
		}
		public void setTimearea(String timearea) {
			this.timearea = timearea;
		}
		public String getAid() {
			return aid;
		}
		public void setAid(String aid) {
			this.aid = aid;
		}
		public String getName() {
			return name;
		}
		public void setName(String name) {
			this.name = name;
		}
		public String getAddr() {
			return addr;
		}
		public void setAddr(String addr) {
			this.addr = addr;
		}
		public Double getLat() {
			return lat;
		}
		public void setLat(Double lat) {
			this.lat = lat;
		}
	    /**
	     * 申请的位置
	     * <br>
	     * 经度
	     */
		public Double getLng() {
			return lng;
		}
	    /**
	     * 申请的位置
	     * <br>
	     * 经度
	     */
		public void setLng(Double lng) {
			this.lng = lng;
		}
		public String getBillname() {
			return billname;
		}
		public void setBillname(String billname) {
			this.billname = billname;
		}
	    /**
	     * 过程审批的状态
	     */
		public int getAuditing() {
			return auditing;
		}
	    /**
	     * 过程审批的状态
	     */
		public void setAuditing(int auditing) {
			this.auditing = auditing;
		}
		
}
