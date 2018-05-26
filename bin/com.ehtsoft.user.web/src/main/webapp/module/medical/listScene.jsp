<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<jsp:include page="../common.jsp"></jsp:include>
<script type="text/javascript" src="${localCtx}/json/SceneService.js"></script>
<title>场景信息管理</title>
<script type="text/javascript">
var common = $(function(){
	var toolbar = new Eht.Toolbar({selector:"#toolbar"});
	toolbar.disable();
	toolbar.enable("#addbtn");
	new Eht.Layout({top:"#top",center:"#center"});
	new Eht.Layout({top:"#ctop",center:"#ccenter"});
	
	var form = new Eht.Form({selector:"#form"});
	form.disable();
	var ss = new SceneService();
	var dg = new Eht.Datagrid({selector:"#dg"});
	dg.transColumn("imgscene",function(data,rowIndex,cell,field){
		return "<img src='${localCtx}/image/SceneService?sysid="+data.sysid+"'/>";
	});
	dg.loadData(function(page,res){
		ss.find(page,res);
	});
	dg.clickRow(function(data){
		form.fill(data);
		form.enable();
		toolbar.enable("#savebtn,#uploadimg");
	});
	
	toolbar.click(function(id){
		switch(id){
			case "addbtn":
				form.enable();
				form.clearData();
				form.clear();
				toolbar.enable("#addbtn");
				toolbar.enable("#savebtn");
				toolbar.disable("#uploadimg");
				break;
			case "savebtn":
				ss.save(form.getData(),new Eht.Responder({success:function(data){
					form.setData({sysid:data.value});
					new Eht.Tips().show();
					form.clearData();
					form.clear();
					dg.refresh();
				}}));
				break;
		}
	});
	$("#filename").change(function(){
		$("#uploadForm").attr("action","${localCtx}/upload/SceneService?sysid="+form.getData().sysid);
		$("#uploadForm").submit();
	});
	
	$.fn.refresh=function(){
		dg.refresh();
	};
});
function uploadSuccess(msg){
	common.refresh();
}
</script>
<style type="text/css">
#form{
	margin:8px 16px 8px 16px;
}
#form div{
	display:inline-block;
}
#form label{
	width:80px;
	display: inline-block;
	text-align: right;
}
</style>
</head>
<body>
<div id="top">
	<div id="toolbar">
		<a id="addbtn" icon='eht-addbtn-icon'>新增</a>
		<a id="savebtn" icon='eht-savebtn-icon'>保存</a>
		<label id="uploadimg" for="filename" icon="eht-upbtn-icon">
			上传场景预览图
			<form id="uploadForm" action="${localCtx}/upload/SceneService" method="post" enctype="multipart/form-data" target="importFrame" style="diaplay:none;height:0px;width:0px;">
				<input type="file" name="filename" id="filename" 
				class="eht-toolbar-file">
				<iframe name="importFrame" style="display:none;width:0px;height:0px;"></iframe>
			</form>
		</label>
	</div>
</div>
<div id="center">
	<div id="ctop">
		<div id="form">
			<div><label>场景编码</label><input type="text" name="scenecode"/></div>
			<div><label>场景名称</label><input type="text" name="scenename"/></div>
			<div><label>主页面 url</label><input type="text" name="mainurl"/></div>
		</div>
	</div>
	<div id="ccenter">
		<div id="dg">
			<div field="scenecode" label="场景编码"></div>
			<div field="scenename" label="场景名称"></div>
			<div field="mainurl" label="主页面 url"></div>
			<div field="imgscene" label="场景预览图" width="160"></div>
		</div>
	</div>
</div>
</body>
</html>