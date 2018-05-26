package com.ehtsoft.common.services;

import java.awt.AlphaComposite;
import java.awt.BasicStroke;
import java.awt.Color;
import java.awt.Graphics2D;
import java.awt.Rectangle;
import java.awt.RenderingHints;
import java.awt.Transparency;
import java.awt.geom.Ellipse2D;
import java.awt.geom.RoundRectangle2D;
import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.Blob;
import java.sql.SQLException;
import java.util.Enumeration;

import javax.annotation.Resource;
import javax.imageio.ImageIO;
import javax.imageio.stream.ImageInputStream;
import javax.imageio.stream.ImageOutputStream;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;

import com.ehtsoft.fw.core.context.AppContext;
import com.ehtsoft.fw.core.context.AppException;
import com.ehtsoft.fw.core.db.SQLAdapter;
import com.ehtsoft.fw.core.db.SqlDbClient;
import com.ehtsoft.fw.core.db.SqlDbFilter;
import com.ehtsoft.fw.core.dto.BasicMap;
import com.ehtsoft.fw.core.dto.UploadObject;
import com.ehtsoft.fw.core.services.api.IUploadService;
import com.ehtsoft.fw.core.services.api.ImageService;
import com.ehtsoft.fw.core.utils.AppUtil;
import com.ehtsoft.fw.core.utils.ImageUtil;
import com.ehtsoft.fw.utils.BooleanUtil;
import com.ehtsoft.fw.utils.NumberUtil;
import com.ehtsoft.fw.utils.StringUtil;
import com.ehtsoft.fw.utils.Util;

@Service("RMIImageService")
public class RMIImageService implements IUploadService,ImageService{

	Log logger = LogFactory.getLog(RMIImageService.class);
	public static String KEY_TABLE_NAME = "_table_name";
	
	@Resource(name = "sqlDbClient")
	private SqlDbClient dbClient;
	
	private final String PK_FIELD_ID = "IMGID";
	
	/**
	 * 图片上传
	 */
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

	/**
	 * 图片读取
	 */
	@Override
	public void image2Stream(BasicMap<String, Object> param, OutputStream out) {
		String imgid = StringUtil.toString(param.get(PK_FIELD_ID));
		String tablename = StringUtil.toString(param.get(KEY_TABLE_NAME));
		String faceImg = StringUtil.toString(param.get("face"));
		try {
			BasicMap<String,Object> bm = null;
			if(Util.isEmpty(faceImg)){ //不为空的时候，直接到对应的表查
				if("SYS_FACE_IMG".equalsIgnoreCase(StringUtil.trim(tablename))) {
					bm = dbClient.findOne(new SQLAdapter("SELECT mimetype,data FROM  JZ_JZRYJBXX_IMG  WHERE "+ PK_FIELD_ID +" = '" + imgid + "'"));
				}
			}
			if(bm==null) {
				bm = dbClient.findOne(new SQLAdapter("SELECT mimetype,data FROM "+tablename+" WHERE "+ PK_FIELD_ID +" = '" + imgid + "'"));
			}
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
						makeRoundedCornerImg(is,out,NumberUtil.toInt(width),NumberUtil.toInt(height),format);
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
	
	/**
	 * 
	 * 把图片转化成圆形
	 * @param sfile
	 * @param tfile
	 * @param cornerRadius
	 * @throws IOException
	 * void
	 * @创建人  ：Administrator
	 * @创建时间：2017年12月2日上午12:21:49
	 * @修改人  ：Administrator
	 * @修改时间：2017年12月2日上午12:21:49
	 * @修改备注：
	 * @version 1.0
	 *
	 */
	public static void makeRoundedCornerImg(InputStream is,OutputStream out,int width,int height,String format) throws IOException {
		ImageInputStream iis = ImageIO.createImageInputStream(is);
		BufferedImage bi1 = ImageIO.read(iis);
		int cornerRadius=bi1.getHeight()*2;
		BufferedImage output = new BufferedImage(bi1.getWidth(),bi1.getHeight(),
				BufferedImage.TYPE_INT_ARGB);
		Graphics2D g2 = output.createGraphics();
		g2.setComposite(AlphaComposite.Src);
		g2.setRenderingHint(RenderingHints.KEY_ANTIALIASING,
				RenderingHints.VALUE_ANTIALIAS_ON);
		g2.setColor(Color.WHITE);
		g2.fill(new RoundRectangle2D.Float(0, 0,bi1.getWidth(),bi1.getHeight(), cornerRadius,
				cornerRadius));
		g2.setComposite(AlphaComposite.SrcAtop);
		g2.drawImage(bi1, 0, 0, null);
		g2.setColor(Color.darkGray);     
		/*int num=5;
        g2.setStroke(new BasicStroke(num));
        g2.drawRoundRect(num, num, bi1.getWidth() - 2 * num,bi1.getHeight() - 2 * num, cornerRadius, cornerRadius); */
		g2.dispose();
        try {
        	ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
        	 ImageOutputStream imageOutput = ImageIO.createImageOutputStream(byteArrayOutputStream);
            ImageIO.write(output, "png", imageOutput);
            InputStream inputStream = new ByteArrayInputStream(byteArrayOutputStream.toByteArray());
            ImageUtil.scaledImage(inputStream,out,width,height,true,"png",true);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

	/**
	 * 删除图片信息
	 * @param tablename
	 * @param imgid
	 * @throws AppException
	 */
	public void remove(String tablename,String imgid) throws AppException{
		dbClient.remove(tablename, new SqlDbFilter().eq(PK_FIELD_ID, imgid));
	}
}
