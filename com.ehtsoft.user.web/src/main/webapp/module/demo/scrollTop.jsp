<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<jsp:include page="../common.jsp"></jsp:include>
<title>csrroTo</title>
<style>
	*{border:1px solid #333;}
</style>
</head>
<body>
<div style="position:relative">
	<div style="position:fixed;left:10px;top:10px;">
		<div id="tol1"><a href="#">去第一个</a></div>
		<div id="tol2"><a href="#">去第二个</a></div>
		<div id="tol3"><a href="#">去第三个</a></div>
	</div>
	<div id="l1" style="height:700px;">l1</div>
	<div id="l2" style="height:700px;">l2</div>
	<div id="l3" style="height:700px;">l3</div>
</div>
</body>
</html>
<script>

jQuery.fn.scrollTo = function(speed) {
	var targetOffset = $(this).offset().top;
	$('html,body').stop().animate({scrollTop: targetOffset}, speed);
	return this;
}; 

// use
$("#tol1").click(function(){
	$("#l1").scrollTo(500);
	return false;
});	
$("#tol2").click(function(){
	$("#l2").scrollTo(500);
	return false;
});	
$("#tol3").click(function(){
	$("#l3").scrollTo(500);
	return false;
});	

</script>