package com.ehtsoft.supervise.services;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ehtsoft.common.services.SSOService;
import com.ehtsoft.fw.core.db.RowDataListener;
import com.ehtsoft.fw.core.db.SQLAdapter;
import com.ehtsoft.fw.core.db.SqlDbClient;
import com.ehtsoft.fw.core.db.SqlDbFilter;
import com.ehtsoft.fw.core.dto.Basic;
import com.ehtsoft.fw.core.dto.BasicMap;
import com.ehtsoft.fw.core.dto.Paginate;
import com.ehtsoft.fw.core.sso.User;
import com.ehtsoft.fw.utils.StringUtil;
import com.ehtsoft.supervise.api.SupConst;

/**
 * 法制宣传
 * @author GeiLaBa
 *
 */
@Service("FzxcPfhddjService")
public class FzxcPfhddjService {
	
	@Resource(name = "sqlDbClient")
	private SqlDbClient dbClient;
	
	@Resource(name="SSOService")
	private SSOService ssoService;
	
	/**
	 * 
	 * @param query
	 * @param paginate
	 * @return
	 * [
	 * 	{
	 * 		F_ZZDW:组织单位
	 * 	}
	 * ]
	 */
	public List<BasicMap<String, Object>> findData(String title,Paginate paginate) {
		User user = ssoService.getUser();
		List<BasicMap<String, Object>> list = new ArrayList<>();
		String sqlStr = "select * from FZXC_PFHDDJ";
		SqlDbFilter filter = new SqlDbFilter();
		filter.like("F_HDZT", title).desc("F_HDSJ").eq("orgid", user.getOrgid());
		SQLAdapter sqlAdapter = new SQLAdapter(sqlStr);
//		SqlDbFilter filter=new SqlDbFilter();
//		filter.like("F_ZZDW", StringUtil.toEmptyString(query.get("xm")));
		
		sqlAdapter.setFilter(filter);
		dbClient.find(sqlAdapter,paginate,new RowDataListener() {
			@Override
			public void processData(BasicMap<String, Object> rowData) {
				String F_ID  = rowData.get("F_ID").toString();
				String sqlStr = "select * from FZXC_PFHDDJ_IMG where PFHDDJID='" + F_ID + "'";
				SQLAdapter sqlAdapter = new SQLAdapter(sqlStr);
				List<BasicMap< String, Object>> listMap = dbClient.find(sqlAdapter);
				if(	listMap!=null&listMap.size()>0) {
					 String headIds = listMap.get(listMap.size()-1).get("IMGID").toString();
		                rowData.put("HEAD_IMG_ID", headIds);
				}
				list.add(rowData);
			}
		}).getRows();
		return list;
	}
	//获得某个法宣活动的图片集合
	public  BasicMap<String, Object>  findImgData(String tableName,String uuid){
		List<BasicMap<String, Object>> list = new ArrayList<>();
		String sqlStr = "select IMGID from "+ tableName + " where PFHDDJID='" + uuid + "'";
		SQLAdapter sqlAdapter = new SQLAdapter(sqlStr);
		list = dbClient.find(sqlAdapter);
		BasicMap<String, Object> data = new BasicMap<>();
		List<String> li = new ArrayList<>();
  		if (list.size()> 0) {
			for (int i = 0; i < list.size(); i++) {
				li.add( StringUtil.toString( list.get(i).get("imgid")));
			}
		}
		data.put("images",li);
		return data;
	}
	
	public BasicMap<String, Object> findFirstData(String f_id){
		BasicMap<String, Object> map = new BasicMap<>();
		String sqlStr = "select IMGID from FZXC_PFHDDJ_IMG" + " where PFHDDJID=" +"'" +f_id + "'";
		SQLAdapter sqlAdapter = new SQLAdapter(sqlStr);
		map = dbClient.findFirstData(sqlAdapter);
		return map;
	}
	
	public BasicMap<String, Object> findOne(String id){
		BasicMap<String, Object> rtn = new BasicMap<>();
		rtn = dbClient.findOne(SupConst.Collections.FZXC_PFHDDJ, new SqlDbFilter().eq("f_id", id));
		return rtn;
	}
	
	/**
	 * 删除普法活动登记图片
	 */
	public void deleteImg(String id) {
		dbClient.remove(SupConst.Collections.FZXC_PFHDDJ_IMG, new SqlDbFilter().eq("imgid", id));
	}
	
	/**
	 * 
	 * 保存法制宣传，普法活动登记
	 * @param data<br>
	 * {
	 *   "F_ID":"主键",
	 *   "F_ZZDW":"组织单位(默认当前司法所的名字)",
	 *   "F_HDSJ":"活动时间",
	 *   "F_HDDD":"活动地点",
	 *   "F_HDZT":"活动主题",
	 *   "F_HDXS":"活动形式(活动形式名称 用","分隔)",
	 *   "F_ZDRQ":"针对人群(针对人群名称用","分隔)",
	 *   "F_ZLFFSL":"宣传资料发放数量",
	 *   "hdxsbms":"活动形式编码，用","分隔",
	 *   "zdrqbms":""
	 * }
	 * 返回值格式:<br>
	 *
	 * @author wangbao
	 * @date   2018年4月14日
	 * 方法的作用：保存法制宣传，普法活动登记
	 * andorid pad
	 */
	
	public void save(BasicMap<String, Object> data) {
		dbClient.save(SupConst.Collections.FZXC_PFHDDJ, data);
		
		String fxdjid = StringUtil.toString(data.get("F_ID"));
		
		dbClient.remove(SupConst.Collections.FZXC_PFHDDJ_LX, new SqlDbFilter().eq("FXDJID", fxdjid));
		//1 活动形式  
		String hdxsbms = StringUtil.toEmptyString(data.get("hdxsbms"));
		for(String hdxs:hdxsbms.split(",")){
			BasicMap<String, Object> map = new BasicMap<>();
			map.put("FXDJID", fxdjid);
			map.put("LX", "1");//  1 活动形式  
			map.put("FXXSLX", hdxs);
			dbClient.insert(SupConst.Collections.FZXC_PFHDDJ_LX, map);
		}
		//2 针对人群
		String zdrqbms = StringUtil.toEmptyString(data.get("zdrqbms"));
		for(String zdrq:zdrqbms.split(",")){
			BasicMap<String, Object> map = new BasicMap<>();
			map.put("FXDJID", fxdjid);
			map.put("LX", "2");//  2 针对人群
			map.put("FXXSLX", zdrq);
			dbClient.insert(SupConst.Collections.FZXC_PFHDDJ_LX, map);
		}
	}
					
	public void delete(String id) {
		dbClient.remove(SupConst.Collections.FZXC_PFHDDJ, new SqlDbFilter().eq("f_id", id));
		dbClient.remove(SupConst.Collections.FZXC_PFHDDJ_IMG, new SqlDbFilter().eq("pfhddjid", id));
	}

}
