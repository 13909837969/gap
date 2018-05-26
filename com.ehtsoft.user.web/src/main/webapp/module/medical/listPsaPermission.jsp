<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<jsp:include page="../common.jsp"></jsp:include>
<title>权限授权管理</title>
<link rel="stylesheet" href="${localCtx}/resources/css/usercss/listPermission.css">
<script src="${localCtx}/json/PermissionService.js"></script>
<script type="text/javascript" src="${localCtx}/json/OsaOrganizationService.js"></script>
<script type="text/javascript" src="${localCtx}/json/RoleService.js"></script>
<script src="${localCtx}/resources/script/medical/listPsaPermission.js"></script>

</head>
<body>
<div id="systemTop" style="height:30px;">
	<div id="toolbar">
		<a type="button" value="查询" id="searchbut"  icon='eht-checkbtn-icon'>查询</a>
		<a type="button" value="保存" id="savebut"  icon='eht-savebtn-icon'>保存</a>
	</div>
</div>
<div id="left" style="width:250px;">
	<div id="tree" style="overflow:auto;"></div>
</div>
<div id="center">
	<div id="top" class="SystemTop">
			<div class="SystemTopbody">
				<div style="margin:0px auto;text-align:center;">
					<label  for="agency" style="margin:10px;">账户:</label>
					<input type="text"   id="accountid" style="width:120px;" />
					<label  for="flag" style="margin-left:30px;">开启:</label>
					<select  id="flag"  style="width:100px">
						<option value=""></option>
						<option value="1" >开启</option>
						<option value="0" >禁用</option>
					</select>
				</div>
			</div>
	</div>
	<div id="infList">
		<table  id="personInf" >
			<tr>
				<td field="orgname"  width="130" align="center">机构名称</td>
				<td field="accountid"  width="130" align="center">账号</td>
				<td field="name" width="130" align="center">用户</td>
				<td field="flag" name="flag"  width="80" align="center">开启禁用</td>
				<td field="datalimit" width="130" align="center">数据限制</td>
				<td field="cts" width="200"  align="center">创建时间</td>
				<td field="uts" width="200"  align="center">更新时间</td>
			</tr>
		</table>
	</div>
</div>

<div id="right" style="width:250px;">
	<div id="tab">
		<div label="功能角色"  selected="true">
			<div id="role" style="overflow:auto;padding:10px;"></div>
		</div>
		<div label="部门">
				<div id="org" style="overflow:auto;padding:10px;"></div>
		</div>
		<div label="常用功能">
				<div id="fun" style="overflow:auto;padding:10px;"></div>
		</div>
		
	</div>
</div>
</body>
</html>