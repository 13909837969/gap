<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<jsp:include page="module/common.jsp"></jsp:include>
<script type="text/javascript" src="json/MenuService.js"></script>
<link rel="stylesheet" href="resources/css/main.css">
<title>捷丰租赁信息管理系统(当前登录:${CURRENT_USER_SESSION.name})</title>
<script type="text/javascript">
$(function(){
	var menu = new MenuService();
	new Eht.Layout({top:"#top",left:"#left",center:"#center",bottom:"#bottom"});
	
	var tab = new Eht.Tab({selector:"#tabnav",iframe:true,
				labelField:"menuname",showClose:true});
	
	var accord = new Eht.Accordion({selector:"#accordion",labelField:"menuname"});
	accord.loadData(function(res){
			menu.findMenusByUser(res);
		});
	accord.click(function(data){
		data.selected = true;
		tab.addTab(data);
	});

});
</script>
</head>
<body>
<div id="top" style="height:80px;background:url(resources/images/main/bannerbg.png);margin:0;padding:0;">
	<div style="height:79px;background:url(resources/images/main/banner.png) no-repeat;text-align:right;"></div>
</div>
<div id="left" style="width:200px;">
<div id="accordion"></div>
</div>
<div id="center">
	<div id="tabnav"></div>
</div>
<div id="bottom" class="main-footer">
	<div style="float:left;">当前用户:admin</div>
	<div>系统支持IE7以上及
		<a href="download/D:/browser/Firefox-latest.exe?absolute=true" title="点击下载网络安装包" target="iframedownload" style="color:#fff;">火狐</a>、
		<a href="download/D:/browser/google-chrome-26.0.1410.64.rar?absolute=true" title="点击下载绿色包，解压即用" target="iframedownload" style="color:#fff;">chrome浏览器</a>
	</div>
</div>
</body>
</html>