package com.ehtsoft.im.websocket;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.http.server.ServerHttpRequest;
import org.springframework.http.server.ServerHttpResponse;
import org.springframework.http.server.ServletServerHttpRequest;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.server.support.HttpSessionHandshakeInterceptor;

import com.ehtsoft.fw.utils.Util;
/**
 * 
 * @author wangbao
 *
 */
public class ProxyWebSocketInterceptor extends HttpSessionHandshakeInterceptor{
	private Log logger = LogFactory.getLog(ProxyWebSocketInterceptor.class);
	/**
	 * 获取 websocket 登录用户信息，并把信息放到 WebSocketSession 的 attribure 属性中
	 * @param request
	 * @param response
	 * @param wsHandler
	 * @param attributes
	 * @return
	 * @throws Exception
	 */
	@Override
	public boolean beforeHandshake(ServerHttpRequest serverHttpRequest, ServerHttpResponse serverHttpResponse, WebSocketHandler wsHandler, Map<String,Object> attributes) throws Exception {
		if(logger.isDebugEnabled()){
			logger.debug("拦截用户信息，并把用户信息嵌入到 WebSocketSession attribute 中");
		}
		ServletServerHttpRequest ssRequest = (ServletServerHttpRequest)serverHttpRequest;
		HttpServletRequest request = ssRequest.getServletRequest();
		String accountid = request.getParameter(WebSocketContext.UNIQUE_ACCOUNT_ID);
		String clientType = request.getParameter(WebSocketContext.CLIENT_TYPE);
		if(accountid==null){
			throw new RuntimeException("参数 " + WebSocketContext.UNIQUE_ACCOUNT_ID + " 不能为空");
		}
		attributes.put(WebSocketContext.UNIQUE_ACCOUNT_ID, accountid);
		if(Util.isNotEmpty(clientType)){
			attributes.put(WebSocketContext.CLIENT_TYPE, clientType);
		}
		return super.beforeHandshake(serverHttpRequest, serverHttpResponse, wsHandler, attributes);
	};
	
	@Override
	public void afterHandshake(ServerHttpRequest request, ServerHttpResponse response, WebSocketHandler wsHandler,
			Exception ex) {
		super.afterHandshake(request, response, wsHandler, ex);
	}
	
}
