package com.ehtsoft.supervise.utils;

import com.ehtsoft.fw.core.config.Deploy;
import com.ehtsoft.fw.utils.BooleanUtil;
import com.ehtsoft.fw.utils.StringUtil;

public class DeployContext {
	
	/**
	 * 停留时间计算调度开关 StayTimeService
	 */
	public static String DEPLOY_SCHEDULED_STAYTIME_ENABLE = "deploy.scheduled.staytime.enable";
	/**
	 * 足迹坐标点去重复及抖动计算 （FootprintService）
	 */
	public static String DEPLOY_SCHEDULED_FOOTPRINT_ENABLE = "deploy.scheduled.footprint.enable";
	/**
	 * 清除无效数据的调度开关
	 */
	public static String DEPLOY_SCHEDULED_REMOVE_ENABLE = "deploy.scheduled.remove.enable";
	
	public static String getProperty(String key){
		return StringUtil.toEmptyString(Deploy.getProperty(key)).trim();
	}
	
	/**
	 * 是否启动调度
	 * 自定义调度功能（非spring调度）
	 * @param key
	 * @return
	 */
	public static boolean isEnableScheduled(String key){
		return BooleanUtil.toBoolean(getProperty(key));
	}

}
