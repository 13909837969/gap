<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<jsp:include page="../common.jsp"></jsp:include>
<script type="text/javascript" src="../../json/MBasicService.js"></script>
<script type="text/javascript">
$(function(){
	var bar = new Eht.Toolbar({selector:"#command"});
	dg = new Eht.Datagrid({selector:"#dd",footerSelector:"#command"});
	dg.loadData([{label1:"label1"}]);
	bar.click(function(){
		dg.openRowForm();
	});
});
</script>
<style type="text/css">
table{
	border-collapse: collapse;
}
td{
	border:1px solid #f00;
}
.eht-datagrid-body .datagrid-col-field1{
	background:#f00;
}
.eht-datagrid-body .datagrid-col-field1 td{
	color:#00f;
}
</style>
</head>
<body>
<div id="dd">
 
	<div label="label1" field="label1"></div>
	<div label="label2" field="label2"></div>
	<div label="label3" field="label3"></div>
	<div label="label4" field="label4"></div>
	<div label="label5" field="label5"></div>
	<div label="label6" field="label6"></div>
	 
</div>
<div id="command">
	<a id="addbtn" icon='eht-addbtn-icon'>新增</a>
</div>
</body>
</html>