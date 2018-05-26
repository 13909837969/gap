/**
 * @Description TODO(用一句话描述该文件是做什么功能的，哪个地方使用的，android 还是 jsp 用)
 * @author wangbao
 * @date 2018年4月9日
 */
package com.ehtsoft.common.servlet;

import java.io.IOException;
import java.util.Date;
import java.util.Enumeration;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ehtsoft.fw.core.context.AppContext;
import com.ehtsoft.fw.core.dto.BasicMap;
import com.ehtsoft.common.api.IReadFileService;
import com.ehtsoft.fw.core.servlet.AbstractServlet;

/**
 * @author wangbao
 * @date 2018年4月9日
 *
 */
public class ReadFileServlet extends AbstractServlet{
	/**
	 * 获取文件的参数
	 * @param req
	 * @return
	 */
	private BasicMap<String,Object> getRequestParameter(HttpServletRequest req){
		BasicMap<String,Object> param = new BasicMap<String,Object>();
		Enumeration<String>  en = req.getParameterNames();
		while(en.hasMoreElements()){
			String p1 = en.nextElement();
			param.put(p1, req.getParameter(p1));
		}
		return param;
	}
	/**
	 * 得到显示的文件
	 */
	protected void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		long s = new Date().getTime();
		AppContext.putRequest(req);
    	AppContext.putResponse(res);
		//得到请求 uri
		StringBuffer requri = new StringBuffer(req.getRequestURI());
		if(requri.charAt(requri.length()-1)=='/'){
			requri.deleteCharAt(requri.length()-1);
		}
		//在请求中活动 service beanId
		String service = requri.substring(requri.lastIndexOf("/")+1);
		if(logger.isDebugEnabled()){
			logger.debug("文件 doGet 请求开始.");
			logger.debug("service:" + service);
		}
		//得到 serviceBean 对象
		Object serviceBean = AppContext.getService(req, "DefaultReadFileService", false);
		if(!"read".equals(service)){
			serviceBean = AppContext.getService(req, service,false);////// true
		}
		if(serviceBean instanceof IReadFileService){
				ServletOutputStream sos = res.getOutputStream();
				//接口方法实现
				((IReadFileService)serviceBean).read2Stream(getRequestParameter(req),sos);
				sos.flush();
		}else{
			logger.error(serviceBean.getClass().getName()+" File 服务类   必须继承  IReadFileService 类");
		}
		if(logger.isDebugEnabled()){
			logger.debug("文件生成时间：" + (new Date().getTime() - s) + " 毫秒");
		}
	}
	
	protected void doPost(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		AppContext.putRequest(req);
    	AppContext.putResponse(res);
	}
}
