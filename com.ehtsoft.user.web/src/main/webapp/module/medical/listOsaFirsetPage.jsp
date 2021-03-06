<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<jsp:include page="../common.jsp"></jsp:include>
<title>首页信息设置</title>
<script type="text/javascript" src="${localCtx}/json/FirstPageService.js"></script>
<script type="text/javascript" src="${localCtx}/json/OsaOrganizationService.js"></script>
<script type="text/javascript" src="${localCtx}/json/RoleService.js"></script>
<script type="text/javascript" src="${localCtx}/json/SceneService.js"></script>
<script type="text/javascript" src="${localCtx}/resources/script/medical/listOsaFirstPage.js"></script>
<style type="text/css">
#scence{
	border-collapse: collapse;
	width: 100%;
}
#scence tr:Hover{
	background: #eee;
}
#scence .tr_selected{
	background: #c3d8f9;
}
#scence td{
	padding:5px 0px 5px 0;
	border-bottom: 1px solid #0c8dc4;
}
#scence td h4{
	margin: 4px;
	color: #0c8dc4;
}

</style>
</head>
<body>
<div id="systemTop" style="height:30px;">
	<div id="toolbar">
		<a type="button" value="查询" id="searchbut"  icon='eht-checkbtn-icon'>查询</a>
		<a type="button" value="保存" id="savebut"  icon='eht-savebtn-icon'>保存</a>
	</div>
</div>
<div id="center">
	<div id="top">
			<div>
				<div style="margin:10px;" id="queryform">
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
		<div label="场景风格"  selected="true">
			<div id="scenetab" style="overflow:auto;padding:10px;">
				<div id="scence"></div>
			</div>
		</div>
		<div label="首页设置">
				<div id="funtab" style="overflow:auto;padding:10px;"></div>
		</div>
	</div>
</div>
</body>
</html>