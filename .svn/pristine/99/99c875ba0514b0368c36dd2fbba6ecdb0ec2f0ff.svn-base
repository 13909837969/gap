<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>EHT Pie Chart Demo  - jquery + raphael pie chart</title>
<jsp:include page="../common.jsp"></jsp:include>
<script type="text/javascript" src="../../resources/script/core/eht.chart.sector.js"></script>
<script type="text/javascript" src="../../resources/script/core/eht.chart.pie.js"></script>
<style>
.eht-chart-background{
	background-color:#fff;
}
</style>
<script type="text/javascript">
$(function(){	
	
	var pie = new Eht.Pie({selector:"#pie",height:400,clickItem:function(item){
		$("#text").html(JSON.stringify(item.data));
	}});
	pie.detach(1);
	$("#reload").click(function(){
		pie.refresh();
		pie.detach(1);
	});
});
</script>
</head>
<body>
<input type="button" value="reload" id="reload"/>
<div id="text"></div>
<div id="pie"></div>
</body>
</html>