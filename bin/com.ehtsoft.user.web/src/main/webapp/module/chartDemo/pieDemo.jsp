<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<jsp:include page="../common.jsp"></jsp:include>
<title>饼图 demo</title>
<script type="text/javascript">
$(function(){
	var pie = new Eht.Pie({selector:"#pie"});
	
	pie.loadData([{value:100,label:"label1"},
	              {value:90 ,label:"label2"},
	              {value:30 ,label:"label3"},
	              {value:90 ,label:"label4"},
	              {value:30 ,label:"label5"},
	              {value:90 ,label:"label6"},
	              {value:65 ,label:"label7"}]);
	
	pie.click(function(data){
		console.log(data);
	});


	//图2
var pie = new Eht.Pie({selector:"#pie2",
		valueFields:["a","b","c"],
		labelFields:["描述a","描述b","描述c"]
	});
	
	pie.loadData({a:100,b:30,c:140});
	
	pie.click(function(data){
		console.log(data);
	});
	
});
</script>
</head>
<body>
<div id="pie" style="width:600px;height:400px;"></div>
<div id="pie2" style="width:600px;height:400px;"></div>
</body>
</html>