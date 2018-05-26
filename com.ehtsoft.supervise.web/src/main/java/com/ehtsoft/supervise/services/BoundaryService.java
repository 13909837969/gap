package com.ehtsoft.supervise.services;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.annotation.Resource;

import org.bson.Document;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.stereotype.Service;

import com.ehtsoft.fw.core.db.MongoClient;
import com.ehtsoft.fw.core.db.RowDataListener;
import com.ehtsoft.fw.core.db.SqlDbClient;
import com.ehtsoft.fw.core.dto.BasicMap;
import com.ehtsoft.fw.core.utils.script.MongoScriptUtil;
import com.ehtsoft.fw.utils.NumberUtil;
import com.ehtsoft.fw.utils.StringUtil;
import com.ehtsoft.fw.utils.Util;
import com.ehtsoft.im.protocol.Location;
import com.ehtsoft.supervise.api.SupConst;
import com.ehtsoft.supervise.dto.Address;

@Service("BoundaryService")
public class BoundaryService {
	
	@Resource(name = "sqlDbClient")
	private SqlDbClient dbClient;
	
	@Resource(name="mongoClient")
	private MongoClient mongoClient;
	
	/**
	 *生成一个人员/一个机构电子围栏信息
	 *
	 * @param polygons   ["x1,y1;x2,y2"]
	 * @param data
	 * {
	 *   regionid:"",
	 *   region_name:"",
	 *   lvl:1,2,3
	 * }
	 * String regionid,String region_name
	 * @author wangbao
	 */
	public void saveBoundary(List<String> polygons,BasicMap<String,Object> map){
		
		BasicMap<String,Object> data = new BasicMap<>();
		String regionid = StringUtil.toEmptyString(map.get("regionid"));
		String region_name = StringUtil.toEmptyString(map.get("region_name"));
		
		data.put("code", regionid);
		data.put("_id", regionid);
		data.put("name", region_name);
		data.put("parentid", map.get("parentid"));
		data.put("lvl", NumberUtil.toInt(map.get("lvl")));
		
		BasicMap<String,Object> boundary = new BasicMap<String,Object>();
		
		List<List> coordinates = new ArrayList<>();
		for(String points : polygons){
			List<List> polygon = new ArrayList<>();
			String[] ps = points.split(";");
			if(ps.length>3){
				for(String xy : ps){
					String[] p = xy.split(",");
					polygon.add(Arrays.asList(NumberUtil.to_double(p[0]),NumberUtil.to_double(p[1])));
				}
				coordinates.add(polygon);
			}
		}
		boundary.put("type", "Polygon");
		boundary.put("coordinates",coordinates);
		
		data.put("boundary", boundary);
		
		/**
		 * {
		 *     boundary:{
				  type : "Polygon",
				  coordinates : [
				     [ [ 0 , 0 ] , [ 3 , 6 ] , [ 6 , 1 ] , [ 0 , 0 ] ],
				     [ [ 2 , 2 ] , [ 3 , 3 ] , [ 4 , 2 ] , [ 2 , 2 ] ]
				  ]
				}
			}
		 */
	    mongoClient.save(SupConst.Collections.SYS_BOUNDARY, data);
	}

	/**
	 * 获取边界数据
	 * @param lvl  1 省  2 市  3 区/县
	 */
	public List<BasicMap<String,Object>> findBoundary(Integer lvl){
		return  findBoundary(null,lvl);
	}
	
	/**
	 * 获取边界数据
	 * @param lvl  1 省  2 市  3 区/县 
	 * regionid 
	 */
	public List<BasicMap<String,Object>> findBoundary(String regionId,Integer lvl){
		Query query;
		if(Util.isEmpty(regionId)){
			query=Query.query(Criteria.where("lvl").is(lvl));
		}else{
			query=Query.query(Criteria.where("code").is(regionId));
		}
		List<BasicMap<String,Object>> rtn = mongoClient.find(SupConst.Collections.SYS_BOUNDARY,query,null,new RowDataListener() {
			public void processData(BasicMap<String, Object> rowData) {
				Object boundary = rowData.remove("boundary");
				List<String> polygons = new ArrayList<>();
				if(boundary instanceof Document){
					Document doc = ((Document) boundary);
					List coordinates = (List) doc.get("coordinates");
					if(coordinates!=null){
						for(Object o : coordinates){
							if(o instanceof List){
								StringBuffer sb = new StringBuffer();
								List polygon = (List)o;
								for(Object pp : polygon){
									List p = (List)pp;
									if(p.size()==2){
										sb.append(p.get(0)+","+p.get(1) + ";");
									}
								}
								polygons.add(sb.toString());
							}
						}
					}
				}
				rowData.put("boundary", polygons);
			}
		});
		
		return rtn;
	}
	/**
	 * 
	 * @param location
	 * {
     *    lat 纬度,
     *	  lng 经度,
	 * }
	 * @return Address
	 * {
	 *  province:"省",
	 *  city:"市",
	 *  district:"区县"
	 * }
	 */
 	public Address findAddress(Location location){
		BasicMap<String,Object> query = new BasicMap<String,Object>();
		query.put("lng", location.getLng());
		query.put("lat", location.getLat());
		//根据坐标获取 地址信息（省，市，区）
		String cmd = MongoScriptUtil.getMongoCommand("boundary-range-region", query);
		List<BasicMap<String,Object>> list= mongoClient.find(SupConst.Collections.SYS_BOUNDARY, cmd,new String[]{"code","name","lvl"});
		Address address = null;
		if(list.size()>0){
		    address = new Address();
			for(BasicMap<String,Object> b:list){
				if(NumberUtil.toInt(b.get("lvl"))==1){
					address.setProvince(StringUtil.toEmptyString(b.get("name")));
					address.setProvinceCode(StringUtil.toEmptyString(b.get("code")));
				}
				if(NumberUtil.toInt(b.get("lvl"))==2){
					address.setCity(StringUtil.toEmptyString(b.get("name")));
					address.setCityCode(StringUtil.toEmptyString(b.get("code")));
				}
				if(NumberUtil.toInt(b.get("lvl"))==3){
					address.setDistrict(StringUtil.toEmptyString(b.get("name")));
					address.setDistrictCode(StringUtil.toEmptyString(b.get("code")));
				}
			}
		}
		return address;
	}
	/**
	 * 判断人员当前位置是否在规定范围内（电子围栏中）
	 * @return  true:在范围内  false:不再范围内
	 */
	public Boolean findIsWithIn(Location location){
		Boolean flag=true;
		//查询本次定位是否在点子围栏中	
		BasicMap<String,Object> query = new BasicMap<String,Object>();
		if(location!=null&&Util.isNotEmpty(location.getOrgid())){
			String findStr="SELECT regionid from jc_sfxzjgjbxx where id='"+location.getOrgid()+"'";
			BasicMap<String,Object> map= dbClient.findOne(findStr);
			if(map!=null&&Util.isNotEmpty(map.get("regionid"))){
				query.put("code", map.get("regionid"));
				query.put("lng", location.getLng());
				query.put("lat", location.getLat());
				String cmd = MongoScriptUtil.getMongoCommand("boundary-range-cmd01", query);
				BasicMap<String,Object> tBasicMap= mongoClient.findOne(SupConst.Collections.SYS_BOUNDARY, cmd,new String[]{"code","name"});
				if(tBasicMap==null){
					flag=false;
				}
			}
		}
		return flag;
	}
}
