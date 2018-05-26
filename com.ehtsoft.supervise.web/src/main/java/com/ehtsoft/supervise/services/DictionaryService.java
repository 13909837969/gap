package com.ehtsoft.supervise.services;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ehtsoft.fw.core.context.AppException;
import com.ehtsoft.fw.core.db.InsertOperation;
import com.ehtsoft.fw.core.db.RowDataListener;
import com.ehtsoft.fw.core.db.SQLAdapter;
import com.ehtsoft.fw.core.db.SaveOperation;
import com.ehtsoft.fw.core.db.SqlDbClient;
import com.ehtsoft.fw.core.db.SqlDbFilter;
import com.ehtsoft.fw.core.dto.BasicMap;
import com.ehtsoft.fw.core.dto.Paginate;
import com.ehtsoft.fw.core.dto.ResultList;
import com.ehtsoft.fw.core.dto.UploadObject;
import com.ehtsoft.fw.core.services.api.IUploadService;
import com.ehtsoft.fw.core.utils.AppUtil;
import com.ehtsoft.fw.core.utils.ReflectUtil;
import com.ehtsoft.fw.dto.Dictionary;
import com.ehtsoft.fw.utils.StringUtil;
import com.ehtsoft.fw.utils.Util;
import com.ehtsoft.fw.utils.api.IDictionary;
import com.ehtsoft.supervise.api.SupConst;
import com.ehtsoft.supervise.utils.ExcelUtil;

@Service("DictionaryService")
public class DictionaryService implements IUploadService,IDictionary{
	@Resource(name = "sqlDbClient")
	private SqlDbClient dbClient;
	
	private BasicMap<String,String> cacheMap;
	
	//保存
	public String save(final BasicMap<String,Object> data,List<BasicMap<String,Object>> detail) throws AppException{
		if(Util.isNotEmpty(data)){
			data.put("F_TS", System.currentTimeMillis());
			data.put("F_TYPECODE", StringUtil.toUpperCase(StringUtil.toEmptyString(data.get("F_TYPECODE"))));
			dbClient.save(SupConst.Collections.SYS_DICTIONARY_TYPE,data);
		}
		if(Util.isNotEmpty(detail)){
			for(BasicMap<String,Object> d:detail){
				d.remove("selected");
				d.remove("rowindex");
			}
			dbClient.save(SupConst.Collections.SYS_DICTIONARY,detail,new SaveOperation() {
				@Override
				public void saveBefore(BasicMap<String, Object> d) {
					d.put("F_TYPECODE", data.get("F_TYPECODE"));
				}
				@Override
				public void saveAfter(BasicMap<String, Object> d) {
				}
			});
		}
		return String.valueOf(data.get("F_ID"));
	}	
	
	//datagrid查找多条数据
	public ResultList<BasicMap<String,Object>> find(BasicMap<String,Object> data,Paginate paginate) throws AppException{
		return dbClient.find(SupConst.Collections.SYS_DICTIONARY,new SqlDbFilter().eq("F_TYPECODE", data.get("F_TYPECODE")).asc("cts"),paginate);
	}
	//树查找数据
	public List<BasicMap<String,Object>> findTree(BasicMap<String,Object> data) throws AppException{
		List<BasicMap<String,Object>> list = new ArrayList<BasicMap<String,Object>>();
		String sql = "select * from SYS_DICTIONARY_TYPE order by F_TYPECODE";
		SQLAdapter sap = new SQLAdapter(sql);
		list = dbClient.find(sap);
		if(list==null){
			return null;
		} 
		return list;
	}
	
	//获取标准数据明细数据
	public BasicMap<String,List<BasicMap<String,Object>>> findDetail(String f_typecode) throws AppException{
		BasicMap<String,List<BasicMap<String,Object>>> rtn = new BasicMap<String,List<BasicMap<String,Object>>>();
		final BasicMap<String,List<BasicMap<String,Object>>> tmp = new BasicMap<String,List<BasicMap<String,Object>>>();
		String sqlstr = "select F_ID,F_CODE,F_NAME,F_PCODE,F_DEF,F_TYPECODE from SYS_DICTIONARY";
		SQLAdapter sql = new SQLAdapter(sqlstr);
		sql.getFilter().eq("F_TYPECODE", f_typecode).asc("F_TYPECODE,F_CODE");
		
		this.dbClient.find(sql,null,new RowDataListener() {
			public void processData(BasicMap<String, Object> rowData) {
				if(tmp.get(rowData.get("F_TYPECODE"))==null){
				   List<BasicMap<String,Object>> l = new ArrayList<BasicMap<String,Object>>();
				   l.add(rowData);
				   tmp.put(String.valueOf(rowData.get("F_TYPECODE")), l);
				}else{
					tmp.get(rowData.get("F_TYPECODE")).add(rowData);
				}
			}
		});
		for(String key : tmp.keySet()){
			rtn.put(key, AppUtil.list2Tree(tmp.get(key), "F_PCODE", "F_CODE"));
		}
		return rtn;
	}
	
	/**
	 * 根据数据字典类型 及 值 获取字典值对应的 名称
	 * @param typeCode
	 * @param value
	 * @return
	 */
	@Override
	public String getDictionaryName(String typeCode,String value) {
		String rtn = value;
		if(cacheMap==null || Util.isEmpty(cacheMap.get(typeCode + value))) {
			cacheMap = new BasicMap<>();
			String sqlstr = "select F_CODE,F_NAME,F_TYPECODE from SYS_DICTIONARY";
			SQLAdapter sql = new SQLAdapter(sqlstr);
			sql.getFilter().eq("F_TYPECODE", typeCode);
			
			this.dbClient.find(sql,null,new RowDataListener() {
				public void processData(BasicMap<String, Object> rowData) {
					String key = StringUtil.toString(rowData.get("F_TYPECODE")) + StringUtil.toString(rowData.get("F_CODE"));
					cacheMap.put(key, StringUtil.toString(rowData.get("F_NAME")));
				}
			});
		}
		rtn = cacheMap.get(typeCode + value);
		return rtn;
	}
	/**
	 * 获取字典列表数据
	 * 该方法用于 android 本地缓存
	 * 启动android 的时候，通过该方法获取数据，
	 * 保存到 android 本地数据库库表 SYS_DICTIONARY
	 * @return
	 */
	@Override
	public List<Dictionary> findDictionarys(String typecode){
		final List<Dictionary> rtn = new ArrayList<>();
		String sqlstr = "select F_ID,F_CODE,F_NAME,F_PCODE,F_DEF,F_TYPECODE from SYS_DICTIONARY";
		SQLAdapter sql = new SQLAdapter(sqlstr);
		sql.getFilter().eq("F_TYPECODE", StringUtil.toUpperCase(typecode));
		dbClient.find(sql,new RowDataListener() {
			public void processData(BasicMap<String, Object> rowData) {
				rtn.add(ReflectUtil.map2Bean(rowData, Dictionary.class, "f_"));
			}
		});
		return rtn;
	}

	/**
	 * 获取字典类型数据给 android 客户端 
	 * 该方法用于 android 本地缓存
	 * 启动android 的时候，通过该方法获取数据，
	 * 保存到 android 本地数据库库表 SYS_DICTIONARY_TYPE
	 * @return
	 */
	public List<BasicMap<String,Object>> findDictTyps(){
		SQLAdapter sql = new SQLAdapter("SELECT F_TYPECODE,F_TYPENAME,F_TS FROM SYS_DICTIONARY_TYPE");
		return dbClient.find(sql);
	}
	
	@Override
	public String upload(UploadObject uploadObject, String dir) throws AppException {
		String rtn = "";
		try {
			List<String> tables = new ArrayList<String>();
			BasicMap<String,List<BasicMap<String,Object>>> data = ExcelUtil.parseXlsData(uploadObject.getInputStream(),tables);
			for(String t : tables){
				//删除数据
				dbClient.remove(t, new SqlDbFilter().eq("1", 1));
				//保存数据
				dbClient.insert(t, data.get(t),new InsertOperation() {
					@Override
					public void insertBefore(BasicMap<String, Object> data) {
						data.put("F_TYPECODE", StringUtil.toUpperCase(StringUtil.toString(data.get("F_TYPECODE"))));
						data.put("F_TS", System.currentTimeMillis());
					}
					@Override
					public void insertAfter(BasicMap<String, Object> data) {
					}
				});
			}
			rtn = uploadObject.getFilename() + "数据导入成功";
		} catch (AppException e) {
			throw new AppException(uploadObject.getFilename() + "数据导入失败");
		}
		return rtn;
	}
}
