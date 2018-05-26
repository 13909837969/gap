<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<jsp:include page="../common.jsp"></jsp:include>
<title>pointer demo</title>
<script type="text/javascript">
$(function(){
	var pointer = new Eht.Pointer({x:100,y:100,paper:Raphael("pointer",300,300)});
	pointer.setRotate(1000);
});
</script>
</head>
<body>
<div id="pointer"></div>
</body>
</html>