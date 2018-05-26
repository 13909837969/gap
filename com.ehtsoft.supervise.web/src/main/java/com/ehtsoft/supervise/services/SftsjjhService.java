package com.ehtsoft.supervise.services;


import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ehtsoft.fw.core.db.SqlDbClient;
import com.ehtsoft.fw.core.dto.BasicMap;
import com.ehtsoft.fw.core.utils.helper.JSONHelper;
import com.ehtsoft.fw.utils.MD5Util;
import com.ehtsoft.fw.utils.StringUtil;
import com.ehtsoft.fw.utils.Util;
import com.ehtsoft.fw.utils.api.IDictionary;
import com.ehtsoft.supervise.api.services.HttpRequest;
import com.ehtsoft.fw.dto.Dictionary;
import com.ehtsoft.supervise.fwapi.FwApiHelper;
import com.ehtsoft.supervise.fwapi.conf.ApiConfig;
import com.ehtsoft.supervise.fwapi.conf.FieldConfig;
import com.ehtsoft.supervise.fwapi.conf.RespBodyConfig;
import com.ehtsoft.supervise.fwapi.conf.SwapConfig;


@Service("SftsjjhService")
public class SftsjjhService {
	
	@Resource(name = "sqlDbClient")
	private SqlDbClient dbClient;
	
	@Resource
	private IDictionary dictionary;
	
	private BasicMap<String,List<Dictionary>> cacheMap = new BasicMap<>();
	
	public void addDataImp(){
		
		/*读取XML配置类*/
		HttpRequest hr = new HttpRequest();
		try {
			/*解析方法*/
			SwapConfig sc = FwApiHelper.getSwapConfig();
			/*基本路径*/
			String BUrl=sc.getUrl();
			String api = sc.getHeaderConfig().getAppId();
			/*获取api绝对路径并写入数据库*/
			for(ApiConfig s : sc.getApiConfigs()){
				/*获取api绝对路径，*/
				/*获取传输协议GET*/
				/*分页参数缺省limit=20 和 offset=0;*/
				String url = BUrl + s.getApiUrl();
				String param="admOrgCode="+s.getAdmOrgCode()+"&limit=100&offset=0";
				for(RespBodyConfig r:s.getRespBodyConfigs()) {
					/*数据库表*/
					String tablename = r.getLtTable();
					/*表名称*/
					Map<String, Object> Rjson = hr.sendGet(url,param,api);
				    BasicMap<String,Object> FwMap=JSONHelper.jsonToMap((String) Rjson.get("result"));
				    //记录数据总数
				    int CountNum =Integer.valueOf((String) Rjson.get("X-Total-Count"));
				    System.out.println(Rjson.get("X-Total-Count")+"-----------CountNum");
				    int pageCount = 100;
			    	for (int i = 0; i < Math.ceil(CountNum/pageCount)+1; i++) {
			    		param = "admOrgCode="+s.getAdmOrgCode()+"&limit="+pageCount+"&offset="+i;
			    		Rjson = hr.sendGet(url,param,api);
			    		FwMap.putAll(JSONHelper.jsonToMap((String) Rjson.get("result")));
			    		
					    List<BasicMap> Fwlist = JSONHelper.jsonArrayToList(StringUtil.toString(FwMap.get("respBody")), BasicMap.class);
					    List<BasicMap<String,Object>> list2 = new  ArrayList<>();
					    //int i=0;
					    for(BasicMap l:Fwlist) {
							BasicMap<String,Object> bm = new BasicMap<String,Object>();
							for(FieldConfig f:r.getFieldConfigs()){
								if(Util.isNotEmpty(f.getCode())) {
									bm.put(f.getLtField(),l.get(f.getFwField()));
									List<Dictionary> list = cacheMap.get(f.getCode());
									if(list==null) {
										list = dictionary.findDictionarys(f.getCode());
										cacheMap.put(f.getCode(), list);
									}
									for(Dictionary d:list) {
										if(Util.isNotEmpty(l.get(f.getFwField()))) {
											if(StringUtil.toEmptyString(d.getName())
													.contains(StringUtil.toString(l.get(f.getFwField()))) ||
													 StringUtil.toEmptyString(l.get(f.getFwField())).contains(d.getName())
												) {
												bm.put(f.getLtField(),d.getCode());
												break;
											}
										}
									}
								}else {
									/*获取fwField方维列名*/
									/*获取ltField龙腾列名*/
									/*获取label*/
									if(Util.isNotEmpty(l.get(f.getFwField()))) {
										bm.put(f.getLtField(),l.get(f.getFwField()));
										if("true".equals(StringUtil.toString(f.getMd5()))) {
											bm.put(f.getLtField(), "NM00"+MD5Util.encrypt(StringUtil.toEmptyString(l.get(f.getFwField())).getBytes()));
											//System.out.println(f.getLtField()+"==="+l.get(f.getFwField()));
										}
									}
								}
							}
							list2.add(bm);
						}
					    dbClient.save(tablename,list2);
		    	 }
			  }
			}
			System.out.println("司法厅数据交换平台接口数据导入发生完成!");
		} catch (Exception e) {
			System.out.println("司法厅数据交换平台接口数据导入发生错误:"+e.getMessage());
		}
	}

	public static void main(String[] args) {
		SftsjjhService ss = new SftsjjhService();
		ss.addDataImp();
		System.out.println("==============================");
	}
	
}
