package com.ehtsoft.supervise.services;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ehtsoft.fw.core.context.AppException;
import com.ehtsoft.fw.core.db.RowDataListener;
import com.ehtsoft.fw.core.db.SQLAdapter;
import com.ehtsoft.fw.core.db.SqlDbClient;
import com.ehtsoft.fw.core.dto.BasicMap;
import com.ehtsoft.fw.core.utils.ReflectUtil;
import com.ehtsoft.fw.utils.Util;
import com.ehtsoft.supervise.api.SupConst;
import com.ehtsoft.supervise.dto.Parameter;
import com.ehtsoft.supervise.utils.ParameterUtil;

@Service("ParameterService")
public class ParameterService {

	
	@Resource(name = "sqlDbClient")
	private SqlDbClient dbClient;
	
	private String fieldPrefix = "f_";
	
	//保存系统参数设置信息
	public void save(List<BasicMap<String,Object>> list)throws AppException{
		if(Util.isNotEmpty(list)){
			for(BasicMap<String,Object> m : list){
				Parameter p = ReflectUtil.map2Bean(m, Parameter.class);
				dbClient.save(SupConst.Collections.SYS_PARAMETER,ReflectUtil.bean2Map(p, fieldPrefix));
			}
		}
		ParameterUtil.cleanInstance();
	}	
	
	//查询该机构系统参数设置信息
	public List<Parameter> find() throws AppException{
		final List<Parameter> rtn = new ArrayList<>();
		String str = "select F_ID,F_ENABLE,F_VALUE,orgid from SYS_PARAMETER";
		SQLAdapter sql = new SQLAdapter(str);
		dbClient.find(sql,new RowDataListener() {
			public void processData(BasicMap<String, Object> rowData) {
				rtn.add(ReflectUtil.map2Bean(rowData, Parameter.class, fieldPrefix));
			}
		});
		return rtn;
	}
}
