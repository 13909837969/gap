<%@page import="java.util.Enumeration"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
<meta name="viewport" content="width=device-width,intial-scale=1.0,maximum-scale=1, user-scalable=no" />
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">

<title>内蒙司法平板APP</title>
<script type="text/javascript" src="/user/resources/script/jquery/jquery-1.11.0.min.js"></script>

<style>
#downloadDiv{
	width:100%;
	height:100%;
	background-color: #fff;
	vertical-align:middle;
}
#zhuanxiang{
padding-top:10px;
font-size:150%;
color:rgb(62, 119, 217);
width:100%;
height:30%;
}
.android{
    background:url('android.png') no-repeat;
	text-decoration:none;
	display:inline-block;
	width:198px;
	height:55px;
	margin-left:10px;
	margin-right:10px;
}
.ios{
    background:url('android.png') no-repeat;
	text-decoration:none;
	display:inline-block;
	width:198px;
	height:55px;
	margin-left:10px;
	margin-right:10px;
}
.tiaozhuan{
	background:url('tiaozhuan.png') no-repeat;
	width:640px;
	height:257px;
	display:block;
}
img{
	border:0px;
}
</style>
<script type="text/javascript">
	$(function(){
		var w = $(window).width();
		$("#tiaozhuanimg").css("width",w);
		$(window).resize(function(){
			var width = $(window).width();
			$("#tiaozhuanimg").css("width",width);
		});
	});
</script>
</head> 
<body style="padding:0px;">
<%--
Enumeration es = request.getHeaderNames();
while(es.hasMoreElements()){
	Object o = es.nextElement();
	String header = o.toString();
	System.out.println(header + "=" + request.getHeader(header));
	out.println(header + "=" + request.getHeader(header) + "<br/>");
}
--%>
<%
	String userAgent = request.getHeader("user-agent");
	//userAgent.matches("micromessenger")
%>
<div align="center" id="downloadDiv">
<img src="tiaozhuan.jpg" id="tiaozhuanimg"/>
<H3 id="zhuanxiang">
	下载内蒙司法矫正APP
</H3>
<a class="android" onClick="android()" href="http://110.16.70.41:38080/supervise-release.apk"></a>
<!-- <a class="ios" onClick="apple()" href="https://itunes.apple.com/cn/app/ben-xi-di-yi-ren-min-yi-yuan/id1052739654?mt=8"></a> -->
</div>
</body>
</html>  
<script type="text/javascript">  
function isWeiXin(){
var ua = window.navigator.userAgent.toLowerCase(); 
	if(ua.match(/MicroMessenger/i) == 'micromessenger'){  
		return true;  
		}else{  
			return false;  
		}  
}  
function  android(){
	if(isWeiXin()){
		alert("下载请选择在浏览器中打开");
		window.open("http://110.16.70.41:38080/updateapk/supervise-download.jsp");
	}
}
/*
function  apple(){
	if(isWeiXin()){  
		alert("下载请选择在浏览器中打开");
		window.open("https://itunes.apple.com/cn/app/ben-xi-di-yi-ren-min-yi-yuan/id1052739654?mt=8");
	}
}
*/
</script>