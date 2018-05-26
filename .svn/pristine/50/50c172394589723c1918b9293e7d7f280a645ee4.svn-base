package com.ehtsoft.supervise.utils;



import java.lang.reflect.Field;

import com.ehtsoft.fw.core.context.AppContext;
import com.ehtsoft.fw.core.db.RowDataListener;
import com.ehtsoft.fw.core.db.SqlDbClient;
import com.ehtsoft.fw.core.db.SqlDbFilter;
import com.ehtsoft.fw.core.dto.BasicMap;
import com.ehtsoft.fw.core.utils.ReflectUtil;
import com.ehtsoft.supervise.api.SupConst;
import com.ehtsoft.supervise.dto.Parameter;
/**
 * 系统参数
 * @author wangbao
 * 参数放到本地缓存中
 * 做集群的时候，需要本地内存缓存的数据进行更新（建议采用 Redis 缓存机制）
 */
public class ParameterUtil {
	private static ParameterUtil instance;
	
	private BasicMap<String,Parameter> param = new BasicMap<String,Parameter>();
	
	public Parameter get(String parameterKey){
		Parameter rtn = this.param.get(parameterKey);
		if(rtn==null){
			setParameter(AppContext.getSpringBean("sqlDbClient", SqlDbClient.class));
			rtn = this.param.get(parameterKey);
		}
		return rtn;
	}
	
	public static void cleanInstance(){
		instance = null;
	}
	public static ParameterUtil getParameter(SqlDbClient dbClient){
		if(instance == null){
			instance = new ParameterUtil();
			instance.setParameter(dbClient);
		}
		return instance;
	}
	
	public void setParameter(SqlDbClient dbClient){
		//字段前缀
		String fieldPrefix = "f_";
		param.clear();
		dbClient.find(SupConst.Collections.SYS_PARAMETER,new SqlDbFilter(),new RowDataListener() {
			public void processData(BasicMap<String, Object> rowData) {
				Parameter parameter = ReflectUtil.map2Bean(rowData, Parameter.class,fieldPrefix);
				param.put(parameter.getId(), parameter);
			}
		});
		
		Field[] fs = SupConst.ParameterKey.class.getFields();
		 for(Field f:fs){
			try {
				//不存在参数的时候，添加空的参数
				String id = f.get(null).toString();
				if(!param.containsKey(id)){
					Parameter p = new Parameter();
					p.setId(id);
					param.put(id,p);
				}
			} catch (Exception e) {
			}
		 }
	}
	
}
