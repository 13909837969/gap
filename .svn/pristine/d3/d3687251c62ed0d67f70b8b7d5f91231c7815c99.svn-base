package com.ehtsoft.supervise.hawkeye;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.URL;
import java.net.URLConnection;


/**
 * 
 * 鹰眼轨迹
 * @author Administrator
 * @date 2018年4月21日
 *
 */
public class HawkEyeSerivce {
	/**
	 * 
	 * 上传轨迹【单个】
	 * @param args<br>
	 * 返回值格式:<br>
	 *
	 * @author Administrator
	 * @date   2018年4月21日
	 * 方法的作用：TODO
	 */
	public static void main(String[] args) { 
		
		/**
		 * ak	用户的ak，授权使用	string	必须
			service_id	servicede ID，作为其唯一标识	int	必选
			latitude	纬度	 必选
			longitude	经度 必选
			coord_type	坐标类型	int(1-3)	必选，1：GPS经纬度坐标2：国测局加密经纬度坐标 3：百度加密经纬度坐标。
			speed	速度	double	可选，单位：km/h
			direction	方向	int	可选，范围为[0,359]，0度为正北方向，顺时针
			height	高度	double	可选，单位米
			radius	定位精度，GPS或定位SDK返回的值。	double	可选，单位米
			loc_time	定位时设备的时间	Unix时间戳	必选。输入的loc_time不能大于当前服务端时间10分钟以上，即不支持存未来的轨迹点。
			entity_name	entity唯一标识	string(0-128)	必选
			<column-key>	用户自定义列的column_key	此处值的类型须与用户自定义的column值的类型一致。	在track/create接口中可以为用户自定义的column赋值，当loc_time字段的值大于上一次时，如果输入了自定义的column的值，则这些值也会被更新。
		 */
       
	        
	        String url = "http://yingyan.baidu.com/api/v3/track/addpoint";  
	        String ak = "3p0gC52bsfzsg6usfye6LegbGLeneYk3";  
	        int service_id = 164090;//注意这里是服务的id不是应用的id  
			String param = "123";
	        String entity_name = "Stduy1";  
	        double latitude = 44.881834;  // 40.661834
	        double longitude = 115.944819;  // 109.844819
	        long loc_time = System.currentTimeMillis() / 1000;  
	        String coord_type_input = "bd09ll";  
	        int coord_type = 1;
	     
	        param = "ak=" + ak + "&" + "service_id=" + service_id + "&"  
	                + "entity_name=" + entity_name + "&" + "" + "latitude="  
	                + latitude + "&" + "longitude=" + longitude + "&" + "loc_time="  
	                + loc_time + "&" + "coord_type_input=" + coord_type_input + "&" +"coord_type=" + coord_type;  
	        String str = sendPost(url, param);  
	        System.out.println(str); 
    }
	
	
	
	
	public static String sendPost(String url, String param) {  
        PrintWriter out = null;  
        BufferedReader in = null;  
        String result = "";  
        try {  
            URL realUrl = new URL(url);  
            // 打开和URL之间的连接  
            URLConnection conn = realUrl.openConnection();  
            // 设置通用的请求属性  
            conn.setRequestProperty("accept", "*/*");  
            conn.setRequestProperty("connection", "Keep-Alive");  
            conn.setRequestProperty("user-agent",  
                    "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1;SV1)");  
            // 发送POST请求必须设置如下两行  
            conn.setDoOutput(true);  
            conn.setDoInput(true);  
            // 获取URLConnection对象对应的输出流  
            out = new PrintWriter(conn.getOutputStream());  
            // 发送请求参数  
            out.print(param);  
            // flush输出流的缓冲  
            out.flush();  
            // 定义BufferedReader输入流来读取URL的响应  
            in = new BufferedReader(  
                    new InputStreamReader(conn.getInputStream()));  
            String line;  
            while ((line = in.readLine()) != null) {  
                result += line;  
            }  
        } catch (Exception e) {  
            System.out.println("发送 POST 请求出现异常！" + e);  
            e.printStackTrace();  
        }  
        // 使用finally块来关闭输出流、输入流  
        finally {  
            try {  
                if (out != null) {  
                    out.close();  
                }  
                if (in != null) {  
                    in.close();  
                }  
            } catch (IOException ex) {  
                ex.printStackTrace();  
            }  
        }  
        return result;  
    }  
	
	

}
