<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
String ctx= (String)request.getAttribute("com.ehtsoft.fw.sso.url");
if(ctx==null){
	ctx = "/user";
}
response.setHeader("Pragma","No-cache"); 
response.setHeader("Cache-Control","no-cache"); 
response.setDateHeader("Expires", 0); 
String localCtx = application.getContextPath();

request.setAttribute("localCtx",localCtx);
request.setAttribute("ctx", ctx);
request.setAttribute("token", request.getParameter("token"));
%>