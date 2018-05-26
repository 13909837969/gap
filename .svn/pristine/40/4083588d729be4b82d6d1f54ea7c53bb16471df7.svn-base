<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<jsp:include page="../common.jsp"></jsp:include>
<title>Insert title here</title>
<script type="text/javascript">
$(function(){
	var t = new Eht.Tab({selector:"#tab",showClose:true,lazyLoad:true});
	for(var i=0;i<10;i++){
		t.addTab({iframe:true,url:"http://www.qq.com",label:"title_" + i});
	}
	t.active(t.getLength()-1);
});
</script>
</head>
<body style="overflow:hidden;">
<div id="tab">
	<div label="tab1" id="aaa" >
		tab1
	</div>
	<div label="tab2">
		tab2
	</div>
	<div label="ApplicationContext" selected="true">
		ApplicationContext
	</div>
	<div label="中文标签">
		中文标签
	</div>
</div>
</body>
</html>