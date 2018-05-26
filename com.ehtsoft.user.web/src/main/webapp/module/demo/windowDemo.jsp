<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<jsp:include page="../common.jsp"></jsp:include>
<style>
</style>
<script type="text/javascript">
$(function(){
	var win1 = new Eht.Window({selector:"#window1",iframe:false,title:"window 1"});
	var win2 = new Eht.Window({iframe:true,url:"http://www.baidu.com",title:"编辑健康体检表"});
	new Eht.WindowManager(win1,win2);
	$("#open1").click(function(){
		win1.open();
	});
	$("#open2").click(function(){
		win2.open();
	});
});
</script>
</head>
<body>
<div>
<input type="button" value="open window 1" id="open1"/>
<input type="button" value="open window 2" id="open2"/>
<div id="window1" style="display:none;">
	
</div>
</div>
</div>
</body>
</html>