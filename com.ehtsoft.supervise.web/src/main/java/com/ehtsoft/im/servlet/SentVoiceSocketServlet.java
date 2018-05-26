package com.ehtsoft.im.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;
import org.springframework.web.socket.server.HandshakeInterceptor;
import org.springframework.web.socket.server.support.WebSocketHttpRequestHandler;

import com.ehtsoft.im.websocket.SentVoiceSocketHandler;
import com.ehtsoft.im.websocket.VoiceSocketInterceptor;

@Deprecated
//@WebServlet(value="/sentVoiceWs/*",loadOnStartup = 2 )
public class SentVoiceSocketServlet extends HttpServlet{


	private static final long serialVersionUID = 7259788388398345188L;
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		ApplicationContext context = WebApplicationContextUtils.getWebApplicationContext(req.getServletContext()); 
		//获取最终 WebSocket 业务处理代理类
		WebSocketHttpRequestHandler handler = new WebSocketHttpRequestHandler(context.getBean(SentVoiceSocketHandler.class));
		List<HandshakeInterceptor> interceptors = new ArrayList<>();
		interceptors.add(context.getBean(VoiceSocketInterceptor.class));
		handler.setHandshakeInterceptors(interceptors);
		
		handler.handleRequest(req, resp);
	}
}
