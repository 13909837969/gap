<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<jsp:include page="module/common.jsp"></jsp:include>
<script type="text/javascript" src="json/BasicService.js"></script>
<script type="text/javascript">
$(function(){
	Eht.Layout({top:{selector:"#t"},
		left:{selector:"#l"},
		center:{selector:"#c"},
		right:{selector:"#r"},
		bottom:{selector:"#b"}});
	
	Eht.Toolbar({selector:"#toolbar"});
	var bs = new BasicService();
	$("#addbtn").unbind("click").bind("click",function(){
		bs.find("",null,null);
	});
});
</script>
</head>
<body>
	<div id="t" style="border:1px solid #f00;height:80px;">
		<div id="toolbar">
			<a id="addbtn" icon='eht-addbtn-icon'>新增</a>
			<a icon='eht-savebtn-icon'>保存</a>
			<a icon='eht-editbtn-icon'>编辑</a>
			<a icon="eht-deletebtn-icon">删除</a>
			<a icon="eht-checkbtn-icon">检测</a>
			<a icon="eht-preview-icon">浏览</a>
			<a icon="eht-printer-icon">打印</a>
			<a icon="eht-upbtn-icon">上报</a>
			<a icon="eht-refresh-icon">刷新</a>
		</div>
	</div>
	<div id="l" style="background:#ff0;border:1px solid #000;width:200px;"></div>
	<div id="c" style="border:1px solid #000">
		
	</div>
	<div id="r" style="width:200px;background:#00f;border:1px solid #000"></div>
	<div id="b" style="height:40px;background:#0ff;border:1px solid #000"></div>
</body>
</html>
