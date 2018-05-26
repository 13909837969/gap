package com.ehtsoft.user.plugin.services;

import java.util.List;

import javax.annotation.Resource;

import com.ehtsoft.fw.core.db.InsertOperation;
import com.ehtsoft.fw.core.db.SqlDbClient;
import com.ehtsoft.fw.core.dto.BasicMap;
import com.ehtsoft.user.api.IUserSynchronize;
import com.ehtsoft.user.dto.Personnel;

/**
 * user 用户数据同步到 supervise 的 im_userinfo 表
 * @author wangbao
 */
public class SuperviseUserSyncService implements IUserSynchronize{

	@Resource(name="supSqlDbClient")
	private SqlDbClient dbClient;
	
	@Override
	public void synchronize(List<Personnel> personnels) {
		for(Personnel per : personnels){
			BasicMap<String,Object> data = new BasicMap<String,Object>();
			//主键
			data.put("F_AID", per.getAid());
			//编码
			data.put("F_CODE", per.getCode());
			//性别
			data.put("F_GENDER", per.getGender());
			//用户名/昵称
			data.put("F_NICKNAME", per.getName());
			//密码
			data.put("F_PASSWORD", per.getPassword());
			//是否禁用 1 禁用 0 不禁用
			data.put("F_DISABLE", 0);
			//标记 0 矫正人员  1 工作人员 2 机构
			data.put("F_FLAG", 1); // 1 工作人员 同步的是 工作人员
			dbClient.save("IM_USERINFO", data);
			
			BasicMap<String,Object> gzry = new BasicMap<String,Object>();
			gzry.put("ID", per.getAid());    //ID
			gzry.put("RYBM", per.getCode()); //18 位机构编码 + 4 位人员顺序编码
			gzry.put("XM", per.getName());	  //姓名
			gzry.put("XB", per.getGender());  //性别
			gzry.put("CSRQ", per.getBirthday());  //出生日期
			gzry.put("SFZH", per.getCardid());	  //身份证号
			gzry.put("ZW", per.getPost());		  //职务
			gzry.put("orgid", per.getOrgid());
			dbClient.save("JC_SFXZJGGZRYJBXX", gzry);
			
			BasicMap<String, Object> gusr = new BasicMap<>();
			gusr.put("F_GID",  per.getOrgid());
			gusr.put("F_AID", per.getAid());
			gusr.put("F_NAME", per.getName());
			dbClient.save("IM_GROUP_USER", gusr,new InsertOperation() {
				@Override
				public void insertBefore(BasicMap<String, Object> data) {
					gusr.put("F_TYPE", 1);//：0 普通成员 1 管理员  2 群主
				}
				@Override
				public void insertAfter(BasicMap<String, Object> data) {
				}
			});
		}
	}

}
