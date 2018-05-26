package com.ehtsoft.supervise.services;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.bson.Document;
import org.codehaus.groovy.tools.shell.commands.LoadCommand;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.stereotype.Service;

import com.ehtsoft.fw.core.db.MongoClient;
import com.ehtsoft.fw.core.db.RowDataListener;
import com.ehtsoft.fw.core.dto.BasicMap;
import com.ehtsoft.fw.core.services.AbstractService;
import com.ehtsoft.fw.core.utils.ReflectUtil;
import com.ehtsoft.fw.utils.NumberUtil;
import com.ehtsoft.im.protocol.Location;
import com.ehtsoft.supervise.api.SupConst;
import com.ehtsoft.supervise.dto.Address;

/**
 * 禁入区域设置表
 * mongodb : sys_prohibit
 * @author wangbao
 */
@Service("ProhibitService")
public class ProhibitService extends AbstractService{
	
	@Resource(name="mongoClient")
	private MongoClient mongoClient;
	
	@Resource
	private BoundaryService boundaryService;
	
	/**
	 * 根据 禁止类型 获取区域禁入的区域坐标
	 * @param type
	 * @return
	 */
	public List<BasicMap<String,Object>> find(String type){
		return find(type,true);
	}
	/**
	 * 根据 禁止类型 获取区域禁入的区域数据
	 * @param type
	 * @param hasCoordinates  true 包含坐标数据, false 不包含坐标数据
	 * @return
	 * {
	 *   _id:主键，
	 *   name:名称，
	 *   type:类型，
	 *   address:地址，
	 *   remark:注释，
	 *   enable:是否启用 1 启用  0 关闭
	 * }
	 */
	public List<BasicMap<String,Object>> find(String type,final Boolean hasCoordinates){
		List<BasicMap<String, Object>> rtn = new ArrayList<>();
		mongoClient.find(SupConst.Collections.SYS_PROHIBIT, Query.query(Criteria.where("type").is(type)),null,new RowDataListener() {
			@SuppressWarnings("rawtypes")
			public void processData(BasicMap<String, Object> rowData) {
				BasicMap<String,Object> data = new BasicMap<String,Object>();
				data.put("_id", rowData.get("_id"));
				data.put("name", rowData.get("name"));
				data.put("type", rowData.get("type"));
				data.put("address", rowData.get("address"));
				data.put("remark", rowData.get("remark"));
				data.put("enable", rowData.get("enable"));
				
				if(hasCoordinates){
					List<BasicMap<String,Double>> polygon = new ArrayList<>();
					Object boundary = rowData.remove("boundary");
					if(boundary instanceof Document){
						Document doc = (Document)boundary;
						List ls = (List) doc.get("coordinates");
						if(ls!=null && !ls.isEmpty()){
							List polyg =  (List)ls.get(0);
							for(int i=0;i<polyg.size();i++){
								BasicMap<String, Double> m = new BasicMap<>();
								List list = (List)polyg.get(i);
								m.put("lng",NumberUtil.to_double(list.get(0)));
								m.put("lat", NumberUtil.to_double(list.get(1)));
								polygon.add(m);
							}
						}
					}
					// polygon:[{lng: 116.449831, lat: 39.890359}]
					data.put("polygon", polygon);
				}
				
				rtn.add(data);
			}
		});
		return rtn;
	}
	/**
	 * 设置进入区域设置表
	 * 表：  sys_prohibit
	 * @param prohibit
	 * {
	 *    _id:"",
	 *    name:"名称",
	 *    address:"地址",
	 *    polygon:[{lng: 116.449831, lat: 39.890359}],
	 *    type:"禁入区域类型"
	 *    enable:"1" 启用  0 关闭启用
	 *    remark:说明
	 * }
	 */
	public void save(BasicMap<String, Object> prohibit){
		BasicMap<String,Object> data = new BasicMap<>();
		data.put("_id", prohibit.get("_id"));
		data.put("name", prohibit.get("name"));
		data.put("type", prohibit.get("type"));
		data.put("address", prohibit.get("address"));
		data.put("remark", prohibit.get("remark"));
		data.put("enable", prohibit.get("enable"));
		BasicMap<String,Object> boundary = new BasicMap<String,Object>();
		List<BasicMap<String,Object>> list = (List<BasicMap<String,Object>>)prohibit.get("polygon");
		List<List> coordinates = new ArrayList<>();
		List<List> polygon = new ArrayList<>();
		double lng = 0;
		double lat = 0;
		for(int i=0;i<list.size();i++){
			BasicMap<String,Object> obj = list.get(i);
			lng = NumberUtil.to_double(obj.get("lng"));
			lat = NumberUtil.to_double(obj.get("lat"));
			polygon.add(Arrays.asList(lng,lat));
		}
		// add by liuzh 首位一致坐标
		if(list!=null&&list.size()>0){
			BasicMap<String,Object> obj=list.get(0);
			lng = NumberUtil.to_double(obj.get("lng"));
			lat = NumberUtil.to_double(obj.get("lat"));
			polygon.add(Arrays.asList(lng,lat));
		}
		
		polygon.add(Arrays.asList(lng,lat));
		coordinates.add(polygon);
		boundary.put("type", "Polygon");
		boundary.put("coordinates",coordinates);
		Location location = new Location();
		location.setLng(lng);
		location.setLat(lat);
		Address address = boundaryService.findAddress(location);
		if(address!=null){
			data.putAll(ReflectUtil.bean2Map(address));
		}
		data.put("boundary", boundary);
		/**
		 * {
		 * 	   type:"类型",
		 *     boundary:{
				  type : "Polygon",
				  coordinates : [
				     [ [ 0 , 0 ] , [ 3 , 6 ] , [ 6 , 1 ] , [ 0 , 0 ] ],
				     [ [ 2 , 2 ] , [ 3 , 3 ] , [ 4 , 2 ] , [ 2 , 2 ] ]
				  ]
				}
			}
		 */
		// 禁入区域设置表
		mongoClient.save(SupConst.Collections.SYS_PROHIBIT, data);
	}
}
