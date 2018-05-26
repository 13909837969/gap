<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<jsp:include page="../common.jsp"></jsp:include>
<title>datePicker demo</title>
<script type="text/javascript">
$(function(){
	var dp = new Eht.DatePicker({selector:"#datePicker"});
	dp.open();
	dp.click(function(v){
		$("#txt").val(v);
	});
	
	$("#setValue").click(function(){
		dp.setValue($("#txt").val());
	});
});
</script>
</head>
<body>
<input id="txt" type="text"/>
<div id="datePicker"></div>

<input id='setValue' type="button" value='setValue'>
</body>
</html>