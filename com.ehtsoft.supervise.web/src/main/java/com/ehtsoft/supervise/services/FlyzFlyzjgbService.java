package com.ehtsoft.supervise.services;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.bouncycastle.i18n.filter.SQLFilter;
import org.springframework.stereotype.Service;

import com.ehtsoft.common.services.SSOService;
import com.ehtsoft.fw.core.db.RowDataListener;
import com.ehtsoft.fw.core.db.SQLAdapter;
import com.ehtsoft.fw.core.db.SqlDbClient;
import com.ehtsoft.fw.core.db.SqlDbFilter;
import com.ehtsoft.fw.core.dto.BasicMap;
import com.ehtsoft.fw.core.dto.Paginate;
import com.ehtsoft.fw.core.sso.User;
import com.ehtsoft.fw.utils.StringUtil;
import com.ehtsoft.supervise.api.SupConst;
/**
 * 法律援助服务窗口
 * @author GeiLaBa
 * 2018.3.5
 *
 */
@Service("FlyzFlyzjgbService")
public class FlyzFlyzjgbService {
	@Resource(name = "sqlDbClient")
	private SqlDbClient dbClient;
	@Resource(name = "SSOService")
	private SSOService ssoService;
	@Resource
	private RegionService regionService;
	
	public List<BasicMap<String,Object>> findList(Paginate paginate,BasicMap<String, Object> query){
		User user=ssoService.getUser();
		List<BasicMap<String,Object>> data = new ArrayList<>();
		String sqlStr = "select * from FLYZ_FLYZJGB";
		SQLAdapter adapter = new SQLAdapter(sqlStr);
		
		SqlDbFilter sqlFilter = new SqlDbFilter();
		sqlFilter.like("bmmc", StringUtil.toEmptyString(query.get("bmmc")))
				 .like("jgdz", StringUtil.toEmptyString(query.get("jgdz")))
				 .eq("orgid", user.getOrgid()).desc("cts");
		adapter.setFilter(sqlFilter);
		dbClient.find(adapter,paginate,new RowDataListener() {
			@Override
			public void processData(BasicMap<String, Object> rowData) {
				String id  = rowData.get("id").toString();
				String sqlStr = "select * from FLYZ_FLYZJGB_IMG where PFHDDJID='" + id + "'";
				SQLAdapter sqlAdapter = new SQLAdapter(sqlStr);
				List<BasicMap< String, Object>> listMap = dbClient.find(sqlAdapter);
				if(	listMap!=null&listMap.size()>0) {
					 String headIds = listMap.get(listMap.size()-1).get("IMGID").toString();
		                rowData.put("HEAD_IMG_ID", headIds);
				}
				data.add(rowData);
			}
		}).getRows();
		return data;
	}
	
	public List<BasicMap<String, Object>> findList(){
		List<BasicMap<String,Object>> data = new ArrayList<>();
		String sqlStr = "select * from FLYZ_FLYZJGB";
		SQLAdapter adapter = new SQLAdapter(sqlStr);
		data = dbClient.find(adapter);
		return data;
	}
	
	public BasicMap<String, Object> findOne(String id){
		BasicMap<String, Object> data  = new BasicMap<>();
		String sqlStr = "select * from FLYZ_FLYZJGB";
		SQLAdapter adapter = new SQLAdapter(sqlStr);
		adapter.getFilter().eq("id", id);
		data  = dbClient.findOne(adapter);
		StringBuffer buffer = new StringBuffer();
		String[] addressStr = StringUtil.toEmptyString(data.get("xzqy")).split(",");
		for(String str : addressStr) {
			buffer.append(regionService.getRegionName(str));
		}
		data.put("address", buffer.toString());
		return data;
	}
	
	public void saveOne(BasicMap<String, Object> data) {
		dbClient.save(SupConst.Collections.FLYZ_FLYZJGB, data);
	}
	
	public List<BasicMap<String, Object>> getImageList(String id){
		List<BasicMap<String, Object>> data  = new ArrayList<>();
	    String sqlStr = "select imgid from FLYZ_FLYZJGB_IMG";
	    SQLAdapter adapter = new SQLAdapter(sqlStr);
	    adapter.getFilter().eq("PFHDDJID", id);
	    data = dbClient.find(adapter);
		return data;
	}
	
	public void delete(String id) {
		dbClient.remove(SupConst.Collections.FLYZ_FLYZJGB, new SqlDbFilter().eq("id", id));
	}
	
	public void deleteImg(String id) {
		dbClient.remove(SupConst.Collections.FLYZ_FLYZJGB_IMG, new SqlDbFilter().eq("imgid", id));
	}
	
	
}
