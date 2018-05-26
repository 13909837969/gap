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
	//var mbs = new MBasicService();
	var bar = new Eht.Toolbar({selector:"#toolbar"});
	var dg = new Eht.Datagrid({selector:"#datagrid",multable:true,isPaginate:true,footerSelector:"#toolbar"});

	Eht.DataCode={};Eht.DataCode["cv0025"]=[{bm:"1",mc:"男"},{bm:"2",mc:"女"}];
	
	dg.renderer("field1",function(){
		return new Eht.ComboBox({feature:new Eht.DatePicker()});
	});
	dg.renderer("field2",function(){
		var combo = new Eht.ComboBox({labelField:"mc",valueField:"bm"});
		combo.loadData(Eht.DataCode["cv0025"]);
		return combo; 
	});
	
	dg.renderer("field3",function(){
		var combo = new Eht.ComboBox({labelField:"mc",valueField:"bm"});
		combo.setFeature(new Eht.Tree({labelField:"mc"}));
		combo.loadData(Eht.DataCode["cv0025"]);
		return combo; 
	});
	dg.renderer("field4",function(){
		var combo = new Eht.ComboBox({labelField:"mc",valueField:"bm"});
		return combo; 
	});
	dg.cellChange(function(field,rowData,data,rowIndex){
		console.log(rowData);
		if(field=="field3"){
			if(data){
				this.setRendererData(rowIndex,"field4",data);
			}
		}
	});
	bar.click(function(id){
		switch(id){
			case "addbtn":
				var rindex = dg.addRow({});
				dg.editRow(rindex);
			break;
		}
	});

});
</script>
<style type="text/css">
.eht-datagrid-body .datagrid-col-field1{
	background:#f00;
}
.eht-datagrid-body .datagrid-col-field1 td{
	color:#00f;
}
</style>
</head>
<body>
<div id='toolbar'>
	<a id="addbtn" icon='eht-addbtn-icon'>新增</a>
</div>
<div style="left:10px;top:20px;right:30px;bottom:200px;height:300px;width:800px;">
	<table id="datagrid">
		<tr>
			<td field="field1" width="100px">field1</td>
			<td field="field2" width="100px">field2</td>
			<td field="field3" width="100px">field3</td>
			<td field="field4" width="100px">field4</td>
			<td field="field5" width="100px">field5</td>
			<td field="field6" width="100px">field6</td>
		</tr>
	</table>
</div>
</body>
</html>