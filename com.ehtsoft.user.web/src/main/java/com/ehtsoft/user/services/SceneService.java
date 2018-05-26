package com.ehtsoft.user.services;

import java.io.ByteArrayInputStream;
import java.io.OutputStream;
import java.sql.Blob;
import java.sql.SQLException;

import javax.annotation.Resource;

import com.ehtsoft.fw.core.context.AppContext;
import com.ehtsoft.fw.core.context.AppException;
import com.ehtsoft.fw.core.db.SQLAdapter;
import com.ehtsoft.fw.core.db.SqlDbClient;
import com.ehtsoft.fw.core.dto.BasicMap;
import com.ehtsoft.fw.core.dto.Paginate;
import com.ehtsoft.fw.core.dto.ResultList;
import com.ehtsoft.fw.core.dto.UploadObject;
import com.ehtsoft.fw.core.services.AbstractService;
import com.ehtsoft.fw.core.services.api.IUploadService;
import com.ehtsoft.fw.core.services.api.ImageService;
import com.ehtsoft.fw.core.utils.AppUtil;
import com.ehtsoft.fw.core.utils.ImageUtil;
import com.ehtsoft.fw.utils.NumberUtil;
import com.ehtsoft.user.api.UserConst;
/**
 * 场景
 * @author wangbao
 */
public class SceneService extends AbstractService implements IUploadService,ImageService{

	@Resource(name="sqlDbClient")
	private SqlDbClient client;
	
	public ResultList<BasicMap<String,Object>> find(Paginate page){
		SQLAdapter sql = new SQLAdapter("SELECT SYSID,SCENECODE,SCENENAME,MAINURL,DEFAULTFLAG FROM CORE_SCENE");
		sql.getFilter().asc("SYSID");
		return client.find(sql, page);
	}
	public Long save(BasicMap<String,Object> data) throws AppException{
		client.save(UserConst.Collections.CORE_SCENE, data);
		return NumberUtil.toLong(data.get("SYSID"));
	}
	@Override
	public String upload(UploadObject uploadObject, String dir)
			throws AppException {
		BasicMap<String, Object> data = new BasicMap<String, Object>();
		data.put("SYSID", AppContext.getRequest().getParameter("sysid"));
		data.put("IMGSCENE",  AppUtil.toByteArray(uploadObject.getInputStream()));
		//data.put("IMGSCENE", uploadObject.getInputStream());
		client.update(UserConst.Collections.CORE_SCENE, data);
		return null;
	}
	@Override
	public void image2Stream(BasicMap<String, Object> param, OutputStream out) {
		
		try {
			BasicMap<String,Object> bm = client.findOne(new SQLAdapter("SELECT IMGSCENE FROM CORE_SCENE WHERE SYSID = '" + param.get("sysid") + "'"));
			if(bm!=null){
				String width = AppContext.getRequest().getParameter("width");
				if(width==null){
					width = "240";
				}
				String height=AppContext.getRequest().getParameter("height");
				if(height==null){
					height = "110";
				}
				if(bm.get("IMGSCENE") instanceof byte[]){
					byte[] b = (byte[])bm.get("IMGSCENE");
					ImageUtil.scaledImage(new ByteArrayInputStream(b),out,NumberUtil.toInt(width),NumberUtil.toInt(height),true,"JPG");
				}
				if(bm.get("IMGSCENE") instanceof Blob){
					Blob b = (Blob)bm.get("IMGSCENE");
					ImageUtil.scaledImage(b.getBinaryStream(),out,NumberUtil.toInt(width),NumberUtil.toInt(height),true,"JPG");
				}
			}
		} catch (AppException e) {
		} catch (SQLException e) {
		}
	}
}
