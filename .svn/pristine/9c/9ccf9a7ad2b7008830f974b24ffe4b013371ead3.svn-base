<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

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
%>


<%=ctx %><br>
<%=localCtx %><br>
getServerName:<%=request.getServerName() %><br>
getServerPort:<%=request.getServerPort() %><br>
getRequestURL:<%=request.getRequestURL() %><br>
getRequestURI:<%=request.getRequestURI() %><br>
getLocalAddr:<%=request.getLocalAddr() %><br>
getProtocol:<%=request.getProtocol() %><br>
getLocalPort:<%=request.getLocalPort() %><br>
getRemoteAddr:<%=request.getRemoteAddr() %><br>
getRemoteHost:<%=request.getRemoteHost() %><br>
getRemotePort:<%=request.getRemotePort() %><br>

<%
String ip = request.getHeader("X-real-ip");//先从nginx自定义配置获取  
if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
    ip = request.getHeader("x-forwarded-for");  
}  
if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
    ip = request.getHeader("Proxy-Client-IP");  
}  
if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
    ip = request.getHeader("WL-Proxy-Client-IP");  
}  
if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
    ip = request.getRemoteAddr();  
}  
out.println(ip);
out.println(request.getHeader("X-real-port") + "<br>");

out.println(application.getContextPath());

out.println("<br>" + request.getHeader("host"));
out.println("===" + request.getHeader("X-forwarded-for"));
%>

</body>
</html>