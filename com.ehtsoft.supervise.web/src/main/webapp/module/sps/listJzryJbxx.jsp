<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>矫正人员基本信息</title>
<jsp:include page="../common.jsp"></jsp:include>
<script type="text/javascript" src="../../json/JzJzryjbxxService.js"></script>
<script type="text/javascript" src="../../json/RMIImageService.js"></script>
<script type="text/javascript">
var common = $(function(){
	var toolbar = new Eht.Toolbar({selector:"#toolbar"});
	new Eht.Layout({top:"#top",right:"#right",center:"#center"});
	
	var tbar = new Eht.Toolbar({selector:"#tbar",fixed:true});
	tbar.disable();
	var gdaa = new JzJzryjbxxService();
	var formWin = new Eht.Window({selector:"#formWin",width:630,height:470,modal:true,title:"新增活动信息",resize:false});
	var dg = new Eht.Datagrid({selector:"#dg"});
	var qform = new Eht.Form({selector:"#qform"});
	dg.loadData(function(page,res){
		gdaa.find(qform.getData(),page,res);
	});
	dg.loadComplete(function(data){
		if(data.rows.length>0){
			this.setSelectedRow(0,true);
			var d = data.rows[0];
			//loadImage(d.id);
			tbar.enable();
			$("#uploadForm").attr("action","../../upload/RMIImageService?_table_name=JZ_SQFSFWJLB_IMG&IMGID=" + d.id);
			var img = $("#persionId");
			img.attr("src",'../../image/RMIImageService?_table_name=JZ_SQFSFWJLB_IMG&imgid=' + d.id);
		}
	});
	dg.clickRow(function(data){
		tbar.enable();
		$("#uploadForm").attr("action","../../upload/RMIImageService?_table_name=IM_USERINFO_IMG&imgid=" + data.id);
		var img = $("#persionId");
		img.attr("src",'../../image/RMIImageService?_table_name=JZ_SQFSFWJLB_IMG&imgid=' + data.id);
	});
	var form = new Eht.Form({selector:"#form"});
	toolbar.click(function(id){
		if(id=="addbtn"){
			formWin.open();
		}
		if(id=="query"){
			dg.refresh();
		}
	});
	$("#impfile").change(function(){
		$("#uploadForm").submit();
	});
	$("#savebtn").click(function(){
		if(form.validate()){
			gdaa.save(form.getData(),new Eht.Responder({success:function(d){
				dg.refresh();
				formWin.close();
			}}));
		}
	});
	$.fn.refreshImage=function(){
		var ds = dg.getSelectedData();
		if(ds!=null && ds.length==1){
			loadImage(ds[0].imgid);
		}
	}
});
function uploadSuccess(arg){
	common.refreshImage();
	new Eht.Tips().show();
	return false;
}
</script>
<style type="text/css">
#form input{
	width:100%;
}
#form textarea{
	width:100%;
	resize:none;
}
.image_rect{
	width:200px;
	height:200px;
	position:relative;
	margin:5px;
}
</style>
</head>

<body>
<div id="top">
	<div id="toolbar">
		<a id="addbtn" icon="eht-addbtn-icon">新增</a>
		<!-- <a id="savebtn" icon="eht-savebtn-icon">保存</a> -->
		<a id="query" icon="eht-search-icon">查询</a>
	</div>
	<div>
	</div>
</div>

<div id="center">
	<div id="dg">
		<div field="xm" label="姓名"></div>
		<div field="xb" label="性别" width="420"></div>
	</div>
</div>
<div id="right" style="width:330px;overflow:auto;">
	<div id="tbar">
		<label id="impimg" icon="eht-impfile-icon" for="impfile">导入图片
			<form id="uploadForm" method="post" enctype="multipart/form-data" target="importFrame" style="margin:0px;padding:0px;">
				<input type="file" id="impfile" name="filename" class="eht-toolbar-file">
			</form>
			<iframe name="importFrame" style="width:0;height:0px;display:none;"></iframe>
		</label>
	</div>
	<div id="images">
		<img alt="" id="persionId" src="">
	</div>
</div>
</body>
</html>