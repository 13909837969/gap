<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>功能菜单管理</title>
<jsp:include page="../common.jsp"></jsp:include>
<link rel="stylesheet" href="${localCtx}/resources/ltrhao-func-menu.css?<%=Math.random() %>">
<script type="text/javascript" src="${localCtx}/json/MenuService.js"></script>
<script  type="text/javascript" src="${localCtx}/json/ApplicationService.js"></script>
<script src="${localCtx}/resources/script/medical/listMenu.js"></script>
<style type="text/css">
.func_menu_icon{
	width:30px;
 	height:30px;
 	display: block;
 	background-size: 30px 30px;
 	background-repeat: no-repeat;
 	background-position: center;
}
.formItem{
	display: inline-block;
	margin:2px 10px 2px 10px;
}
.formItem .itemlabel{
	display: inline-block;
	width: 80px;
}
.formItem .iteminput{
	display: inline-block;
	width: 150px;
}
.formItem input{
width: 150px;
}
.formItem select{
width: 150px;
}
.eht-combopanel li {
padding: 2px;
border-bottom: 1px dashed #c3d8f9;
height:34px;
}
#icon{
background-repeat: no-repeat;
padding-left:20px;
}
</style>
</head>
<body>
<div id="mtop">
<div id="topBar" style="height:28px;">
	<a type="button" value="新增菜单" id="addbut"  icon='eht-addbtn-icon'>新增菜单</a>
	<a type="button" value="保存" id="savebut" icon='eht-savebtn-icon'>保存</a>
</div>
</div>
<div id="left" style="width:250px;">
	<div id="tree" style="overflow:auto; margin-top:5px;margin-left:3px;"></div>
</div>
<div id="center">
	<div id="top">
			<div id="menuform">
				<div style="margin-left:20px;">
					<div class="formItem">
						<div class="itemlabel">菜单编码:</div>
						<div class="iteminput"><input type="text"  name="menucode" id="menucode"   disabled="disabled"/></div>
					</div>
					<div class="formItem">
						<div class="itemlabel">菜单名称</div>
						<div class="iteminput"><input type="text"  name="menuname" id="menuname" disabled="disabled" /></div>
					</div>
					<div class="formItem">
						<div class="itemlabel">URI</div>
						<div class="iteminput"><input type="text" name="actionuri" id="actionuri" disabled="disabled"  /></div>
					</div>
					<div class="formItem">
						<div class="itemlabel">图标</div>
						<div class="iteminput"><input type="text" name="icon" id="icon" disabled="disabled"  /></div>
					</div>
					<div class="formItem">
						<div class="itemlabel">排序</div>
						<div class="iteminput"><input type="text"  name="sort" id="sort" disabled="disabled"/></div>
					</div>
					<div class="formItem">
						<div class="itemlabel">上级ID</div>
						<div class="iteminput"><input type="text"  name="parentid" id="parentid" disabled="disabled" /></div>
					</div>
					<div class="formItem">
						<div class="itemlabel">说明</div>
						<div class="iteminput"><textarea name="remark" id="remark" disabled="disabled" style="width:430px;resize:none;"></textarea></div>
					</div>
				</div>
			</div>
	</div>
	<div id="infList">
		<table  id="personInf" >
			<tr>
				<td field="sysid"  align="center">ID</td>
				<td field="appid"  align="center">应用</td>
				<td field="menucode" align="center">菜单编码</td>
				<td field="menuname" align="center" width="140">菜单名称</td>
				<td field="actionuri" width="200" align="center">URI</td>
				<td field="sort" align="center">菜单排序</td>
				<td field="icon" align="center">图标</td>
				<td field="cts" align="center" width="130">创建时间</td>
				<td field="uts" align="center" width="130">更新时间</td>
			</tr>
		</table>
	</div>
</div>

<div id="application">
	<span style="float:left;">功能菜单</span>
	<span style="float:right;margin-bottom:3px;"><select style="width:130px;" name="appid" id="appid"></select></span>
</div>
	<table id="app">
			<tr>
				<td field="sysid">sysid</td>
				<td field="appcode">编码</td>
				<td field="appname">名称</td>
			</tr>
		</table>
</body>
</html>