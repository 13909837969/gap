<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<jsp:include page="../common.jsp"></jsp:include>
<title>应用配置管理</title>
<script src="${localCtx}/json/ApplicationService.js"></script>
<script src="${localCtx}/resources/script/medical/listApplication.js"></script>
<style type="text/css">
#appform div{
	display: inline-block;
	margin:5px;
}
#appform div label{
	display:inline-block;
	width: 80px;
	text-align: right;
}
#appform div input{
	width: 150px;
	margin-left:2px;
}
</style>
</head>
<body>
<div id="top" >
		<div id="toolbar" style="vertical-align: middle;">
			<a id="addbut" icon='eht-addbtn-icon'>新增</a>
			<a id="savebut" icon='eht-savebtn-icon'>保存</a>
			<a id="delbut" icon="eht-deletebtn-icon">删除</a>
			<a id="import" icon="eht-upbtn-icon">导入应用
			<form id="uploadForm" action="../../upload/ApplicationService" method="post" enctype="multipart/form-data" target="importFrame" style="margin:0px;padding:0px;">
				<input type="file" name="filename" class="eht-toolbar-file"/><input type="hidden" name="bbbb" value="1111"/>
			</form>
			</a>
		</div>
		
		<iframe name="importFrame" style="width:0;height:0;display:none;"></iframe>
</div>
<div id="center">

	<div id="centerTop">
		<div style="margin:8px 30px;" id="appform">
			<div><label for="appcode">应用编码：</label><input type="text" name="appcode"  disabled="disabled" /></div>
			<div><label for="orgname">应用名称：</label><input disabled="disabled" type="text" name="appname"/></div>
			<div><label>应用路径：</label><input disabled="disabled" type="text" value="_self" name="project"/></div>
			<div><label>应用角色：</label>
			<select disabled="disabled" name="frule">
				<option value="PSA">平台管理员</option>
				<option value="OSA">机构用户</option>
			</select>
			</div>
			<br/>
			<div><label>应用地址：</label><input disabled="disabled" type="text" value="_self" style="width:400px;" name="reqaddress"/></div>
			<br/>
			<div><label style="vertical-align: top;">备注：</label>
			<textarea rows="3"  name="remark" style="margin-left:-5px;width:400px;resize:none;"></textarea>
			</div>
		</div>
	</div>

	<div id="centerBom">
		<table id="Information">
			<tr>
					<td field="appcode">应用编码</td>
					<td field="appname" width="140">应用名称</td>
					<td field="project">应用路径</td>
					<td field="reqaddress">应用地址</td>
					<td field="frule">应用角色</td>
					<td field="remark" width="230">备注</td>
					<td field="cts" width="130">创建时间</td>
			</tr>
		</table>
	</div>
</div>
</body>
</html>