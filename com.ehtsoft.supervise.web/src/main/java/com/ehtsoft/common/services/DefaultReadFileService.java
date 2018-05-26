/**
 * @Description TODO(用一句话描述该文件是做什么功能的，哪个地方使用的，android 还是 jsp 用)
 * @author wangbao
 * @date 2018年4月9日
 */
package com.ehtsoft.common.services;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.Blob;
import java.sql.SQLException;

import javax.annotation.Resource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;

import com.ehtsoft.common.api.IReadFileService;
import com.ehtsoft.fw.core.context.AppContext;
import com.ehtsoft.fw.core.context.AppException;
import com.ehtsoft.fw.core.db.SQLAdapter;
import com.ehtsoft.fw.core.db.SqlDbClient;
import com.ehtsoft.fw.core.dto.BasicMap;
import com.ehtsoft.fw.core.utils.ImageUtil;
import com.ehtsoft.fw.utils.BooleanUtil;
import com.ehtsoft.fw.utils.NumberUtil;
import com.ehtsoft.fw.utils.StringUtil;
import com.ehtsoft.fw.utils.Util;

/**
 * @Description TODO(用一句话描述该文件是做什么功能的，哪个地方使用的)
 * @author wangbao
 * @date 2018年4月9日
 *
 */
@Service("DefaultReadFileService")
public class DefaultReadFileService implements IReadFileService {


	Log logger = LogFactory.getLog(DefaultReadFileService.class);
	public static String KEY_TABLE_NAME = RMIImageService.KEY_TABLE_NAME;
	
	@Resource(name = "sqlDbClient")
	private SqlDbClient dbClient;
	
	private final String PK_FIELD_ID = "IMGID";
	
	@Override
	public void read2Stream(BasicMap<String, Object> param, OutputStream out) {
		String imgid = StringUtil.toString(param.get(PK_FIELD_ID));
		String tablename = StringUtil.toString(param.get(KEY_TABLE_NAME));
		try {
			BasicMap<String,Object> bm = dbClient.findOne(new SQLAdapter("SELECT mimetype,data FROM "+tablename+" WHERE "+ PK_FIELD_ID +" = '" + imgid + "'"));
			if(bm!=null){
				String width = AppContext.getRequest().getParameter("width");
				String height=AppContext.getRequest().getParameter("height");
				String format = AppContext.getRequest().getParameter("format");
				boolean scale = true;
				if(Util.isNotEmpty(AppContext.getRequest().getParameter("scale"))){
					scale = BooleanUtil.toBoolean(AppContext.getRequest().getParameter("scale"));
				}
				boolean round = false;
				if(Util.isNotEmpty(AppContext.getRequest().getParameter("round"))){
					 round= BooleanUtil.toBoolean(AppContext.getRequest().getParameter("round"));
				}
				
				if(format==null){
					format = "JPG";
				}
				if(bm.get("mimetype")!=null){
					format = StringUtil.toString(bm.get("mimetype"));
				}
				InputStream is = null;
				if(bm.get("data")!=null){
					if(bm.get("data") instanceof byte[]){
						byte[] b = (byte[])bm.get("data");
						is = new ByteArrayInputStream(b);
					}
					if(bm.get("data") instanceof Blob){
						Blob b = (Blob)bm.get("data");
						is = b.getBinaryStream();
					}
					if(width!=null && height!=null&!round){
						ImageUtil.scaledImage(is,out,NumberUtil.toInt(width),NumberUtil.toInt(height),scale,format);
					}else if(round){
//						makeRoundedCornerImg(is,out,NumberUtil.toInt(width),NumberUtil.toInt(height),format);
					}else{
						ImageUtil.toImage(is, out, format);
					}
				}else{
					if("per".equals(param.get("icon"))){
						InputStream ims= getClass().getClassLoader().getResourceAsStream("META-INF/conf/header-def.png");
						ImageUtil.toImage(ims, out, format);
					}else{
						out.write("false".getBytes());
					}
				}
			}else{
				if("per".equals(param.get("icon"))){
					InputStream ims= getClass().getClassLoader().getResourceAsStream("META-INF/conf/header-def.png");
					ImageUtil.toImage(ims, out, "png");
				}else{
					out.write("false".getBytes());
				}
			}
		} catch (AppException e) {
		} catch (SQLException e) {
		} catch (IOException e) {
		}
	}

}
