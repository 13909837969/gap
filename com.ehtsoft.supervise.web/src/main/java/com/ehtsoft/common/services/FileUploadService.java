/**
 * @Description TODO(用一句话描述该文件是做什么功能的，哪个地方使用的，android 还是 jsp 用)
 * @author wangbao
 * @date 2018年4月9日
 */
package com.ehtsoft.common.services;

import java.util.Enumeration;

import javax.annotation.Resource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.ehtsoft.fw.core.context.AppContext;
import com.ehtsoft.fw.core.context.AppException;
import com.ehtsoft.fw.core.db.SqlDbClient;
import com.ehtsoft.fw.core.dto.BasicMap;
import com.ehtsoft.fw.core.dto.UploadObject;
import com.ehtsoft.fw.core.services.api.IUploadService;
import com.ehtsoft.fw.core.utils.AppUtil;
import com.ehtsoft.fw.utils.StringUtil;
import com.ehtsoft.fw.utils.Util;

/**
 * @Description 文件上传
 * @author wangbao
 * @date 2018年4月9日
 *
 */
public class FileUploadService implements IUploadService{


	Log logger = LogFactory.getLog(FileUploadService.class);
	public static String KEY_TABLE_NAME = RMIImageService.KEY_TABLE_NAME;
	
	@Resource(name = "sqlDbClient")
	private SqlDbClient dbClient;
	
	@Override
	public String upload(UploadObject uploadObject, String dir) throws AppException {
		if(Util.isEmpty(uploadObject.getFilename())){
			return null;
		}
		dbClient.getInterceptor().setSkipSso(true);
		BasicMap<String, Object> data = new BasicMap<String, Object>();
		Enumeration<String> es = AppContext.getRequest().getParameterNames();
		while(es.hasMoreElements()){
			String name = es.nextElement();
			data.put(name,AppContext.getRequest().getParameter(name));
		}
		String fname = uploadObject.getFilename();
		if(fname.length()>fname.lastIndexOf(".")){
			data.put("mimetype", fname.substring(fname.lastIndexOf(".")+1));
		}
		byte[] bytes = AppUtil.toByteArray(uploadObject.getInputStream());
		data.put("data", bytes);
		String tableName = StringUtil.toString(data.get(KEY_TABLE_NAME));
		if(tableName!=null){
			dbClient.save(tableName, data);
		}
		logger.debug("上传文件：" + fname + " 长度 为  " + (bytes.length / 1024) + "KB");
		dbClient.getInterceptor().setSkipSso(false);
		return null;
	}

}
