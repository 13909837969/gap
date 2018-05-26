<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>test</title>
<jsp:include page="../common.jsp"></jsp:include>

<style>
table,td{
	border:1px solid #000;
}
</style>
<script type="text/javascript">
$(function(){
	//jquery
	// append()
	// insertAfter();
	// after();
	// insertBefore();
	// before();
	// remove();
	// addClass();
	// attr();
	// css();
	// each(function);
	// parent();
	// position();// get element position  (left:2,top:3)
	// offset();
	// === event
	// click(function);
	// mouseover(function);
	// mouseout(function);
	// hive(function,function);
	// dblclick(function);
	// mousemove();
	// blur(); // ou
	// focus();// in
	var cols = new Array();
	$("td","#table1").each(function(i,item){
			cols.push($(this).attr("field"));
	});
	$("#btn1").click(function(){
		var tr = $("<tr></tr>");
		for(var i=0;i<cols.length;i++){
			tr.append("<td field='"+cols[i]+"'>"+cols[i]+"</td>");
		}
		$("#table1").append(tr);
	});
});
</script>
</head>
<body>
<input id="btn1" type="button" value="addrow"/>
<table id="table1">
<tr>
<td field="col1">lable-1</td>
<td field="col2">lable-2</td>
<td field="col3">lable-3</td>
<td field="col4">lable-4</td>
<td field="col5">lable-5</td>
</tr>
</table>
<hr/>
<table id="table2">
<tr>
<td field="col1">lable-1</td>
<td field="col2">lable-2</td>
<td field="col3">lable-3</td>
<td field="col4">lable-4</td>
<td field="col5">lable-5</td>
</tr>
</table>
</body>
</html>