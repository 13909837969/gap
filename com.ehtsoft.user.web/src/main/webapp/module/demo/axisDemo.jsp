<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<jsp:include page="../common.jsp"></jsp:include>
<title>轴心图</title>
<script type="text/javascript">
$(function(){
	var paper = Raphael("axis",800,400);
	
	var rect = paper.rect(0,0,200,200).attr("stroke-width","0.5");
	
	
	
	
	
});
</script>
</head>
<body>
<div id="axis">

</div>
</body>
</html>