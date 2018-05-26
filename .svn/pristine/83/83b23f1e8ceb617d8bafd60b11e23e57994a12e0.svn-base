package com.ehtsoft.user.services;

import java.util.ArrayList;
import java.util.List;


import com.ehtsoft.fw.core.context.AppException;
import com.ehtsoft.fw.core.context.GlobalsName;
import com.ehtsoft.fw.core.dto.BasicMap;
import com.ehtsoft.fw.core.dto.Paginate;
import com.ehtsoft.fw.core.dto.ResultList;
import com.ehtsoft.fw.core.services.SqlBasicService;
import com.ehtsoft.user.api.UserConst;


public class WorkgroupService extends SqlBasicService{
	
	/**
	 * 获取工作较色数据
	 */
	public ResultList <BasicMap<String,Object>> findWork(BasicMap<String,Object> query,Paginate paginate) throws AppException{
		return find(UserConst.Collections.CORE_WORKGROUP, query,paginate);
	}
	
	/**
	 * 保存工作较色数据
	 */
	public void saveWork(BasicMap<String,Object> data) throws AppException{
		super.save(UserConst.Collections.CORE_WORKGROUP, data);
		
		List<BasicMap<String,Object>> list=new ArrayList<BasicMap<String,Object>>();
		for(String obj:data.keySet()){
				String key=obj;
				if(key.equals("groupid")){
					BasicMap<String,Object> map=new BasicMap<String,Object>();
					map.put("groupid", data.get(key));
					map.put("personnelid", data.get(GlobalsName.SQLDB_PK_FIELD));
					list.add(map);
				}
		}
		super.save(UserConst.Collections.CORE_WORKGROUP_PERSONNEL, list);
	}
}