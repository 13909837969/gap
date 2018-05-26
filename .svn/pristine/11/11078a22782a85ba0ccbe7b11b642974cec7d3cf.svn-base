<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<jsp:include page="../common.jsp"></jsp:include>
<title>功能角色管理</title>
<script type="text/javascript" src="${localCtx}/json/RoleService.js"></script>
<script type="text/javascript" src="${localCtx}/json/MenuService.js"></script>
<script src="${localCtx}/resources/script/medical/listOsaRole.js"></script>
</head>
<body>
<div id="topbar">
	<div id="toolbar" >
		<a id="addbut" value="新增" icon='eht-addbtn-icon'>新增</a>
		<a id="savebut" value="保存" icon='eht-savebtn-icon'>保存</a>
		<a id="delbtn" icon='eht-deletebtn-icon'>删除</a>
	</div>
</div>
<div id="right" style="width:250px;">
	<div id="tree" style="overflow:auto;margin-left:20px; margin-top:20px;"></div>
</div>
<div id="center">
	<div id="top" style="border-bottom:0px;">
			<div id="formRole">
				<div style="padding:10px;text-align:center;">
					<label  for="rolecode" style="margin-left:20px;">编码：</label><input type="text"  id="rolecode" name="rolecode" style="width:120px;" />
					<label  for="rolename" style="margin-left:30px;">角色名称：</label><input type="text"  id="rolename" name="rolename"  style="width:120px;"  />
					<label  for="flag" style="margin-left:30px;">开启：</label>
					<select name="flag"  id="flag" style="width:100px">
						<option value="1" selected="selected">开启</option>
						<option value="0" >禁用</option>
					</select>
					<label  for="frule" style="margin-left:30px;">角色类型：</label>
					<select name="frule"  id="frule" style="width:120px">
						<option value="-1" selected="selected">机构普通用户</option>
						<!-- 
						<option value="OSA">机构用户管理员</option>
						<option value="OBM">机构业务角色</option>
						-->
					</select>
				</div>
			</div>
	</div>
	<div id="infList">
		<table  id="personInf" >
			<tr>
				<td field="rolecode"  align="center">编码</td>
				<td field="rolename" width="130" align="center">角色名称</td>
				<td field="flag" align="center">开启/禁用</td>
				<td field="frule" align="center">角色类型</td>
				<td field="cts" width="150"  align="center">创建时间</td>
				<td field="uts" width="150"  align="center">更新时间</td>
			</tr>
		</table>
	</div>
</div>
</body>
</html>