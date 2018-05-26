package com.ehtsoft.supervise.api.services;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLConnection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.ehtsoft.fw.core.dto.BasicMap;
import com.ehtsoft.fw.core.utils.helper.JSONHelper;
import com.ehtsoft.fw.utils.StringUtil;


public class HttpRequest {
    /**
     * 向指定URL发送GET方法的请求
     * 
     * @param url
     *            发送请求的URL
     * @param param
     *            请求参数，请求参数应该是 name1=value1&name2=value2 的形式。
     * @return URL 所代表远程资源的响应结果
     */
	public static void main(String[] args) {
		/*String url = "http://59.196.11.40:88/ec/api/v1/law/firms";
		//String param ="offset=30&limit=5";
		String param ="offset=3&limit=0&admOrgCode=150000";
		String api="9cd161403b144ae79a3a90ec4fbd5465";
		String Rjson = sendGet(url,param,api);
		BasicMap<String,Object> map=JSONHelper.jsonToMap(Rjson);
		List<BasicMap> list = JSONHelper.jsonArrayToList(StringUtil.toString(map.get("respBody")), BasicMap.class);
		list.remove("creditcode");
		System.out.println(map.get("respBody"));*/
	}
	
    public static Map<String, Object> sendGet(String url,String param,String api){
        String result = "";
        BufferedReader in = null;
        Map<String, Object> map1 = new HashMap<String, Object>();
        try {
        		String urlNameString = url + "?" + param;
        	
            // String urlNameString = url;
            URL realUrl = new URL(urlNameString);
            // 打开和URL之间的连接
            URLConnection connection = realUrl.openConnection();
            // 设置通用的请求属性
            connection.setRequestProperty("accept", "*/*");
            connection.setRequestProperty("connection", "Keep-Alive");
            connection.setRequestProperty("user-agent","Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1;SV1)");
            connection.setRequestProperty("appid",api);
            // 建立实际的连接
            connection.connect();
            // 获取所有响应头字段
            Map<String, List<String>> map = connection.getHeaderFields();
            // 遍历所有的响应头字段
            for (String key : map.keySet()) {
      
                if("X-Total-Count".equals(key)){
                	map1.put("X-Total-Count", map.get(key).get(0));
                	//System.out.println(key + "---------------->" + map.get(key));
                }
            }
            // 定义 BufferedReader输入流来读取URL的响应
            in = new BufferedReader(new InputStreamReader(
                    connection.getInputStream(),"utf-8"));//防止乱码
            String line;
            while ((line = in.readLine()) != null) {
                result += line;
            }
            map1.put("result", result);
        } catch (Exception e) {
            System.out.println("发送GET请求出现异常！" + e);
            e.printStackTrace();
        }
        // 使用finally块来关闭输入流
        finally {
            try {
                if (in != null) {
                    in.close();
                }
            } catch (Exception e2) {
                e2.printStackTrace();
            }
        }
        return map1;
    }
}