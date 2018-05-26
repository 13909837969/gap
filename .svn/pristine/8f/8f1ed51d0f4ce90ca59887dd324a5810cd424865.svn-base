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
	var dg = new Eht.Datagrid({selector:"#cc"});
	dg.loadData([{},{},{}]);
	
	dg = new Eht.Datagrid({selector:"#dd"});
	dg.loadData([{},{},{}]);
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
<div id="cc" style="height:100px;width:800px;">
	<div label="label_1">
		<div field="field1" width="200" label="label_1_1"></div>
		<div label="label_1_2">
			<div  label="label_1_2_1" field="field2"></div>
			<div label="label_1_2_2" field="field3"></div>
			<div label="label_1_2_3" field="field4"></div>
			<div label="label_1_2_4" field="field5"></div>
		</div>
		<div label="label_1_3">
			<div label="label_1_3_1"  field="field6"></div>
			<div label="label_1_3_2"  field="field7"></div>
			<div label="label_1_3_3"  field="field8"></div>
			<div label="label_1_3_4"  field="field9"></div>
		</div>
	</div>
	<div label="label_3">
		<div label="label_3_1">
			<div label="label_3_1_1">
				<div label="label_3_1_1_1"  field="field10">
				</div>
				<div label="label_3_1_1_2">
					<div label="label_3_1_1_2_1" field="field11"></div>
					<div label="label_3_1_1_2_2" field="field12"></div>
				</div>
			</div>
			<div label="label_3_1_2" field="field13">
			
			</div>
		</div>
		<div label="label_3_2" field="field14"></div>
	</div>
	<div label="label_4" field="field15"></div>
</div>
<div id="dd">
	<div label="label1" field="label1"></div>
	<div label="label2" field="label2"></div>
	<div label="label3" field="label3"></div>
	<div label="label4" field="label4"></div>
	<div label="label5" field="label5"></div>
	<div label="label6" field="label6"></div>
</div>
</body>
</html>