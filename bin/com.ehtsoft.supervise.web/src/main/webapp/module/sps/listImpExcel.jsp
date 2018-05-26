<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Excel模板导入工具</title>
<jsp:include page="../common.jsp"></jsp:include>
<script type="text/javascript" src="../../json/ImpExcelService.js"></script>
<script type="text/javascript">
var common=$(function(){
	var toolbar = new Eht.Toolbar({selector:"#toolbar"});
	new Eht.Layout({top:"#top",left:{selector:"#left"},center:{selector:"#center"}});
	var ies = new ImpExcelService();
	var tree = new Eht.Tree({selector:"#tree",labelField:"label"});
	tree.transLabel(function(data){
		return "["+data.name + "]" + data.label;
	});

	tree.loadComplete(function(data){
		if(data.length>0){
			initdatagrid(data[0].columns,data[0]);
		}
	});
	tree.loadData(function(res){
		ies.findTableConfig(res);
	});
	tree.clickRow(function(data){
		initdatagrid(data.columns,data);
	});
	function initdatagrid(columns,data){
		$("#center").empty();
		var dgdiv = $('<div id="dg"></div>');
		for(var i=0;i<columns.length;i++){
			console.log(columns[i]);
			var row = $('<div field="'+columns[i].property+'" label="'+columns[i].label+'"></div>');
			dgdiv.append(row);
		}
		$("#center").append(dgdiv);
		var dg = new Eht.Datagrid({selector:"#dg"});
		dg.loadData(function(page,res){
			ies.find(data.name,{},page,res);
		});
	};
	$("#impfile").change(function(){
		$("#uploadForm").submit();
	});
	$.fn.refresh = function(){
		tree.refresh();
	};
});
function uploadSuccess(arg){
	common.refresh();
}
</script>
</head>
<body>
<div id="top">
	<div id="toolbar">
		<label id="import" icon="eht-upbtn-icon" for="impfile">导入应用
			<form id="uploadForm" action="../../upload/ImpExcelService" method="post" enctype="multipart/form-data" target="importFrame" style="margin:0px;padding:0px;">
				<input type="file" id="impfile" name="filename" class="eht-toolbar-file"/>
			</form>
			<iframe name="importFrame" style="width:0;height:0;display:none;"></iframe>
		</label>
	</div>
</div>
<div id="left" style="width:230px">
	<div id="tree"></div>
</div>
<div id="center">
	<div id="dg"></div>
</div>
</body>
</html>