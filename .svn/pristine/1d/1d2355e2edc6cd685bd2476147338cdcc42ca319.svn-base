package com.ehtsoft.common.services;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ehtsoft.supervise.utils.ExcelUtil;
import com.ehtsoft.fw.core.config.helper.ModelConfigHelper;
import com.ehtsoft.fw.core.config.model.TableConfig;
import com.ehtsoft.fw.core.context.AppContext;
import com.ehtsoft.fw.core.context.AppException;
import com.ehtsoft.fw.core.db.InsertOperation;
import com.ehtsoft.fw.core.db.SqlDbClient;
import com.ehtsoft.fw.core.db.SqlDbFilter;
import com.ehtsoft.fw.core.dto.BasicMap;
import com.ehtsoft.fw.core.dto.Paginate;
import com.ehtsoft.fw.core.dto.ResultList;
import com.ehtsoft.fw.core.dto.UploadObject;
import com.ehtsoft.fw.core.services.AbstractService;
import com.ehtsoft.fw.core.services.api.IUploadService;
import com.ehtsoft.fw.core.sso.User;
import com.ehtsoft.fw.utils.Util;
/**
 * Excel模板的导入
 * @author wangbao
 */
@Service("ImpExcelService")
public class ImpExcelService extends AbstractService implements IUploadService{
	
	@Resource(name = "sqlDbClient")
	private SqlDbClient dbClient;
	
	@Resource
	private SSOService sso;
	
	@Override
	public String upload(UploadObject uploadObject, String dir) throws AppException {
		User user = sso.getUser();
		String rtn = "";
		try {
			List<String> tables = new ArrayList<String>();
			BasicMap<String,List<BasicMap<String,Object>>> data = ExcelUtil.parseXlsData(uploadObject.getInputStream(),tables);
			for(String t : tables){
				if(user!=null){
					if(Util.isNotEmpty(user.getOrgid())){
						//删除数据
						dbClient.remove(t, new SqlDbFilter().eq("orgid", user.getOrgid()));
					}else{
						dbClient.remove(t, new SqlDbFilter().addFieldRelation("1 = 1"));
					}
				}
				//保存数据
				dbClient.insert(t, data.get(t),new InsertOperation() {
					@Override
					public void insertBefore(BasicMap<String, Object> data) {
						data.put("impdata", "1");
					}
					@Override
					public void insertAfter(BasicMap<String, Object> data) {
					}
				});
			}
			rtn = uploadObject.getFilename() + "数据导入成功";
			AppContext.getSession().setAttribute("imp_excel_table", tables);
		} catch (AppException e) {
			throw new AppException(uploadObject.getFilename() + "数据导入失败");
		}
		return rtn;
	}
	/**
	 * 获取刚才导入的表结构
	 * @return
	 */
	public List<TableConfig> findTableConfig(){
		List<String> tables = (List<String>)AppContext.getSession().getAttribute("imp_excel_table");
		List<TableConfig> tcs = new ArrayList<>();
		if(tables!=null){
			for(String table:tables){
				tcs.add(ModelConfigHelper.getTableConfig(table));
			}
		}
		return tcs;
	}
	/**
	 * 获取数据
	 * @param query
	 * @param paginate
	 * @return
	 */
	public ResultList<BasicMap<String,Object>> find(String tablename,BasicMap<String,Object> query,Paginate paginate){
		User user = sso.getUser();
		String orgid = null;
		if(user!=null){
			orgid = user.getOrgid();
		}
		return dbClient.find(tablename,toSqlFilter(query).eq("orgid", orgid),paginate);
	}
}

