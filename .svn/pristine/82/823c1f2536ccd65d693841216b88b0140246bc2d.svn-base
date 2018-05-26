package com.ehtsoft.supervise.services;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ehtsoft.fw.core.db.MongoClient;
import com.ehtsoft.fw.core.db.RowDataListener;
import com.ehtsoft.fw.core.db.SQLAdapter;
import com.ehtsoft.fw.core.db.SqlDbClient;
import com.ehtsoft.fw.core.dto.BasicMap;
import com.ehtsoft.fw.core.utils.script.MongoScriptUtil;
import com.ehtsoft.fw.utils.StringUtil;
import com.ehtsoft.fw.utils.Util;
import com.ehtsoft.im.protocol.CommandType;
import com.ehtsoft.im.protocol.Location;
import com.ehtsoft.im.services.UserinfoService;
import com.ehtsoft.supervise.api.SupConst;

@Service("SysJzryJrqyService")
public class SysJzryJrqyService {

	@Resource(name = "sqlDbClient")
	private SqlDbClient dbClient;

	@Resource(name = "mongoClient")
	private MongoClient mongoClient;

	@Resource
	private UserinfoService userinfoService;

	@Resource
	private AlarmService alarmService;

	@Resource
	private BoundaryService boundaryService;


	/**
	 *保存一个人的禁止区域
	 * @author liuzh
	 */
	public void saveJzqy(String aid, List<BasicMap<String, Object>> listMap) {

		BasicMap<String, Object> jzqy;
		List<BasicMap<String, Object>> list = new ArrayList<>();
		for (BasicMap<String, Object> map : listMap) {
			jzqy = new BasicMap<String, Object>();
			jzqy.put("F_AID", aid);
			jzqy.put("f_jrlx", map.get("code"));
			list.add(jzqy);
		}
		String sql = "delete from SYS_JZRY_JRQY where f_aid='" + aid + "'";
		dbClient.updateSql(sql);
		dbClient.save(SupConst.Collections.SYS_JZRY_JRQY, list);
	}
	/**
	 *根据人员id查找禁区类型
	 * @author 赵超群
	 */
	 public List<BasicMap<String,Object>> findJzqyls(String aid) {
		 
		 final Map<String,String> tmpMap = new HashMap<String,String>();
		 if(Util.isNotEmpty(aid)) {
			 String sqlstr = "select F_JRLX from SYS_JZRY_JRQY";
			 SQLAdapter sql = new SQLAdapter(sqlstr);
			 sql.getFilter().eq("F_AID", aid);
			 dbClient.find(sql,new RowDataListener() {
				@Override
				public void processData(BasicMap<String, Object> rowData) {
					tmpMap.put(StringUtil.toString(rowData.get("F_JRLX")),"1");
				}
			});
		 }
		 /**
		  * state: {
		    checked: true,
		    disabled: true,
		    expanded: true,
		    selected: true
		  }
		  */
		List<BasicMap<String,Object>> rtn = new ArrayList<>();
		String sqlstr = "select F_CODE as code,F_NAME as name from SYS_DICTIONARY";
		SQLAdapter sql = new SQLAdapter(sqlstr);
		sql.getFilter().eq("F_TYPECODE", StringUtil.toUpperCase("SYS101"));
		dbClient.find(sql,new RowDataListener() {
			public void processData(BasicMap<String, Object> rowData) {
				 boolean b = false;
				 if(Util.isNotEmpty(tmpMap.get(StringUtil.toString(rowData.get("code"))))){
					 b = true;
				 }
				 rowData.put("state", new BasicMap("checked",b));
				 rtn.add(rowData);
			}
		});
		return rtn;
	 }
	 

	/**
	 * 判断是否进去特殊区域或越界,进行报警
	 */
	public void judgeOutOfBounds(Location location) {
		if (!boundaryService.findIsWithIn(location)) {
			BasicMap<String, Object> data = new BasicMap<>();
			data.put("f_aid", location.getAid());
			data.put("f_content", "越界报警");
			data.put("f_type", CommandType.COMMAND_OUT_BOUNDS);
			data.put("f_level", 1);
			data.put("f_address", location.getAddress());
			data.put("f_lat", location.getLat());
			data.put("f_lng", location.getLng());
			data.put("f_flag", 0);
			data.put("orgid", location.getOrgid());
//			alarmService.save(data);
		}
		if (findIsWithInTdqy(location)) {
			BasicMap<String, Object> data = new BasicMap<>();
			data.put("f_aid", location.getAid());
			data.put("f_content", "进入禁止区域");
			data.put("f_type", CommandType.COMMAND_IN_TDQY);
			data.put("f_level", 1);
			data.put("f_address", location.getAddress());
			data.put("f_lat", location.getLat());
			data.put("f_lng", location.getLng());
			data.put("f_flag", 0);
			data.put("orgid", location.getOrgid());
			alarmService.save(data);
		}
	}

	/**
	 * 判断人员当前位置是否进去特定区域
	 * @return  true:是  false:否
	 */
	public Boolean findIsWithInTdqy(Location location) {
		Boolean flag = false;
		if (location != null && Util.isNotEmpty(location.getAid())) {
			BasicMap<String, Object> query = new BasicMap<String, Object>();
			String findStr = "SELECT f_jrlx from sys_jzry_jrqy where f_aid='" + location.getAid() + "'";
			SQLAdapter sqlAdapter = new SQLAdapter(findStr);
			List<BasicMap<String, Object>> listMap = dbClient.find(sqlAdapter);
			if (listMap != null && listMap.size() > 0) {
				String typeStr = "";
				for (BasicMap<String, Object> map : listMap) {
					if (Util.isEmpty(typeStr)) {
						typeStr = "'" + map.get("f_jrlx") + "'";
					} else {
						typeStr = typeStr + ",'" + map.get("f_jrlx") + "'";
					}
				}
				query.put("code", typeStr);
				query.put("lng", location.getLng());
				query.put("lat", location.getLat());
				String cmd = MongoScriptUtil.getMongoCommand("boundary-range-cmd02", query);
				BasicMap<String, Object> tBasicMap = mongoClient.findOne(SupConst.Collections.SYS_PROHIBIT, cmd,
						new String[] { "name" });
				if (tBasicMap != null && tBasicMap.size() > 0) {
					flag = true;
				}
			}
		}
		return flag;
	}
}
