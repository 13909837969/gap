<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<jsp:include page="../common.jsp"></jsp:include>
<title>Eht.Accordion</title>
<script>
$(function(){
	var ds = new Array();
	for(var i=1;i<10;i++){
		var obj = {label:"header_" + i};
		ds.push(obj);
		obj.children = [];
		for(var j=1;j<10;j++){
			var o2 = {label:"item_"+i+"_" + j};
			o2.children = [];
			if(i==3 || i==5 || i==7){
				for(var k=1;k<4;k++){
					o2.children.push( {label:"item_"+i+"_" + j + "_" + k});
				}
			}
			obj.children.push( o2);
		}
	}
	//方法1
	var accordion = new Eht.Accordion({selector:"#accordion"});
	accordion.loadData(ds);
	accordion.click(function(data){
		console.log(data);
	});
	//方法2
	new Eht.Accordion({selector:"#accordion2"});
});
</script>
<style type="text/css">

</style>
</head>
<body>
<div style="height:400px;">
	<div id="accordion" ></div>
</div>
<hr/>
<div style="height:200px;">
	<div id="accordion2">
		<div label="ssssss1">
			<input type="text"/>
			SFSFSF
		</div>
		<div label="ssssss2">
			<input type="text"/>
			AFAF
		</div>
		<div label="ssssss3">
			<input type="text"/>
			AFAFA
		</div>
	</div>
</div>
</body>
</html>