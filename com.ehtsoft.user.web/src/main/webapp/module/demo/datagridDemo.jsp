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
	var mbs = new MBasicService();
	new Eht.Toolbar({selector:"#b"});
	var dg = new Eht.Datagrid({selector:"#datagrid",multable:true,isPaginate:true,footerSelector:"#b"});
	var obj = new Object();
	
	dg.loadData(function(page,res){
		mbs.find("ph_test",obj,page,res);
	});
	dg.transColumn("field1",function(data){
		return "<a href=''>sssss</a>";
	});
	dg.transColumn("field2",function(data){
		return "<a href=''>22222</a>";
	});
	dg.cellChange(function(data,rowIndex){
		console.log(data);
		dg.setCell(rowIndex,"field3",data.field2 * data.field1,false);
	});
	
	
	var combodatas = [];
	for(var i=0;i<10;i++){
		combodatas.push({value:"value_" + i,label:"label_" + i});
	}
	dg.dblclickRow(function(data,rowIndex){
		var c = new Eht.ComboBox({readOnly:true});
		c.loadData(combodatas);
		//var opt = {field:"field6",editor:c}; // or
		var opt = [{field:"field6",editor:c},
		           {field:"field7",validate:[{required:true}]}
				  ];
		dg.editRow(rowIndex,opt);
	});
	$("#addrow").click(function(){		
		var rowIndex = dg.addRow({"field4":22,"field3":23333});
		dg.editRow(rowIndex);
		
		//dg.updateRow({"field1":"11111111111"},3);
	});
	
	$("#loadData").click(function(){
		var n = parseInt($("#maxdata").val());
		var data = new Array();
		for(var i=1;i<=n;i++){
			var obj = {};
			for(var j=0;j<22;j++){
				obj["field"+j]="value_" + i + "_" +j;
			}
			data.push(obj);
		}
		var s = new Date().getTime();
		dg.loadData(data);
		var e = new Date().getTime();
		$("#time").html("加载表格所需要的时间 ：" + (e - s)+"毫秒 ");
	});
	
	$("#search").click(function(){
		obj["field0[like]"] = $("#f0").val();
		
		dg.refresh();
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
<input type="button" id="loadData" value="Datagrid 加载性能测试"/>
<label>数据条数</label><input type="text" id="maxdata" value="200"/>
<span id="time"></span>
<div>
	<label>field0:</label>
	<input type="text" id="f0"/>
	<input type="button" value="search" id="search"/>
	<input type="button" value="add row" id="addrow"/>
</div>
<div id='b'>
	<a id="addbtn" icon='eht-addbtn-icon'>新增</a>
	<a id="savebtn" icon='eht-savebtn-icon'>保存</a>
	<a id="editbtn">编辑</a>
	<a id="del">删除</a>
	<a icon="eht-checkbtn-icon">检测</a>
</div>
<div style="left:10px;top:20px;right:30px;bottom:200px;height:300px;width:800px;">
<table id="datagrid">
	<tr>
		<td rowspan="3" field="field0" width="100px"><a href="2">field0 rowspan=3</a></td>
		<td colspan="4" width="100px">field1-4</td>
		<td rowspan="3" width="100px" field="field5">field5</td>
		<td colspan="4" width="100px">field4-5</td>
		<td rowspan="3" field="field10">field10</td>
		<td colspan="4">field11-14</td>
		<td rowspan="3" field="field15">field15</td>
		<td colspan="4">field16-19</td>
		<td rowspan="3" field="field20">field20</td>
		<td rowspan="3" field="field21">field21</td>
	</tr>
	<tr>
		<td field="field1" colspan="2" codes="[{v:1,d:'nan'},{v:2,d:'nv'}]" config='SGSGSGSG'>field1</td>
		<td field="field2" colspan="2">field3-4</td>
		<td field="field4" colspan="2">field4-7</td>
		<td field="field5"  colspan="2">field8-9</td>
		<td field="field7"  colspan="2">field11-12</td>
		<td field="field8"  colspan="2">field13-14</td>
		<td field="field10"  colspan="2">field16-17</td>
		<td field="field11"  colspan="2">field18-19</td>
	</tr>
	<tr>
		<td field="field1" width="100px" style="width:120px;">field1</td>
		<td field="field2" width="100px">field2</td>
		<td field="field3" width="100px">field3</td>
		<td field="field4" width="100px">field4</td>
		<td field="field6" width="100px">field6</td>
		<td field="field7" width="100px">field7</td>
		<td field="field8" width="100px">field8</td>
		<td field="field9" width="100px">field9</td>
		<td field="field11" width="100px">field11</td>
		<td field="field12" width="100px">field12</td>
		<td field="field13" width="100px">field13</td>
		<td field="field14" width="100px">field14</td>
		<td field="field16" width="100px">field16</td>
		<td field="field17" width="100px">field17</td>
		<td field="field18" width="100px">field18</td>
		<td field="field19" width="100px">field19</td>
	</tr>
</table>
</div>
<div id="dg">
	<div label="label1" field="field1"></div>
	<div label="label2" field="field2"></div>
	<div label="label3" field="field3"></div>
	<div label="label4">
		<div label="label4_1" field="field4_1"></div>
		<div label="label4_2" field="field4_2"></div>
	</div>
</div>
</body>
</html>