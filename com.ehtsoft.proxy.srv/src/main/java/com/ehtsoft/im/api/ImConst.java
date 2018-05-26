package com.ehtsoft.im.api;

public class ImConst {

	public static final String APP_SUBJECT = "【智慧社区】";
	public static String SESSION_VALIDATE_CODE = "SESSION_VALIDATE_CODE";
	/**
	 * 系统参数设置属性KEY 
	 * @author wangbao
	 */
	public static class ParameterKey{

	}
	
	public static class ErrorCode{

	}
	/**
	 * IM 对应的表
	 * @author wangbao
	 */
	public static class Collections{
		/**
		 * 消息用户信息表
		 */
		public final static String IM_USERINFO = "IM_USERINFO";
		/**
		 * 消息用户账号信息
		 */
		public final static String IM_USERINFO_ACCOUNT = "IM_USERINFO_ACCOUNT";
		/**
		 * 好友信息表（关联表）
		 */
		public final static String IM_USERINFO_FRIEND = "IM_USERINFO_FRIEND";
		
		/**
		 * 好友信息备注表
		 */
		public final static String IM_FRIEND_REMARK = "IM_FRIEND_REMARK";
		
		/**
		 * 群组信息
		 */
		public final static String IM_GROUP = "IM_GROUP";
		
		/**
		 * 组合消息用户信息关联表
		 */
		public final static String IM_GROUP_USER = "IM_GROUP_USER";
		
		/**
		 * 群公告
		 */
		public final static String IM_GROUP_AFFICHE = "IM_GROUP_AFFICHE";
		
		/**
		 * 发送及接受消息的历史记录
		 */
		public final static String IM_HIS_MESSAGE = "IM_HIS_MESSAGE";
		
		/**
		 * 足迹信息表(计算后的结果表)
		 */
		public final static String IM_FOOTPRINT_SOURCE = "IM_FOOTPRINT_SOURCE";
		
		/**
		 * 足迹信息表(计算后的结果表)
		 */
		public final static String IM_FOOTPRINT = "IM_FOOTPRINT";
		
		/**
		 * 当前位置
		 */
		public final static String IM_CURRENT_LOCATION = "IM_CURRENT_LOCATION";
	}
}
