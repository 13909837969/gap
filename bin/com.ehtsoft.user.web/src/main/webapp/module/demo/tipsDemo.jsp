<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Tips </title>
<jsp:include page="../common.jsp"></jsp:include>
<script type="text/javascript">

$(function(){
	$("#btn1").click(function(){
		new Eht.Tips().show();
	});
	
});
</script>
<style type="text/css">
div{
	 
}
</style>
</head>
<body>
<input type="button" id = "btn1" value="test"/>
</body>
</html>
