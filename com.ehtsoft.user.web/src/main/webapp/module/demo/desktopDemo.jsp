<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<jsp:include page="../common.jsp"></jsp:include>
<title>Eht.Desktop</title>
<script type="text/javascript">
$(function(){
	var desktop = new Eht.Desktop({selector:"#desktop"});
	var data = [];
	for(var i=0;i<10;i++){
		data.push({icon:"desktop-func-icon16",id:i,label:"个人简历及健康档案查询"+i});
	}
    desktop.loadData(data);
	desktop.click(function(data){
		alert(data);
	});
});
</script>
<style type="text/css">
body{
}
</style>
</head>
<body>
<div id="desktop">
</div>
<!-- <div class="eht-desktop-grid">
<a class="grid-cell">
	<span class='grid-cell-icon desktop-func-icon16'></span>
	<div style="width:75px;white-space: pre-wrap;text-align: center;font-size:12px;">个人简历及健康档案查询</div>
</a>
</div> -->


</body>
</html>