<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<jsp:include page="../common.jsp"></jsp:include>
<title>Eht.Dashboard 仪表盘</title>
<script type="text/javascript">
$(function(){
	
	var d1 = new Eht.Dashboard({selector:"#dash1",width:300,height:300});
	d1.setValue(78);

	var d2 = new Eht.Dashboard({selector:"#dash2",minValue:0,maxValue:200,
								width:300,height:300});
	d2.setValue(70);
	var d3 = new Eht.Dashboard({selector:"#dash3",minValue:80,maxValue:200,
		width:400,height:400});
	
});

</script>
</head>
<body>
<div id="dash1" style="float:left"></div>
<div id="dash2" style="float:left"></div>
<div id="dash3" style="float:left"></div>
</body>
</html>