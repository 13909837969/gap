<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>机构信息</title>
<jsp:include page="../common.jsp"></jsp:include>
<script type="text/javascript" src="${localCtx}/resources/script/medical/listPsaOrganization.js"></script>
<script type="text/javascript" src="${localCtx}/json/PsaOrganizationService.js"></script>
<script type="text/javascript" src="${localCtx}/json/SqlBasicService.js"></script>
<script type="text/javascript" src="${localCtx}/json/SceneService.js"></script>
<script type="text/javascript">
function uploadSuccess(v){
	common.refresh();
};
$(function(){
	$("#importorg").change(function(){
		$("#uploadForm").submit();
	});
});
</script>
<style type="text/css">
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
#form{
	margin:10px;
}
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
	<div id="top" style="height:30px">
		<div id="toolbar" style="vertical-align: middle;">
			<a id="addbtn"  icon='eht-addbtn-icon'>新增</a>
			<a id="savebtn" icon="eht-savebtn-icon">保存</a>
			<span id="orgOpenForm">
				<span>&nbsp;&nbsp;编码：<input type="text" name="orgcode[like]" style="width:100px;"/></span>
				<span>名称：<input type="text" name="orgname[like]" style="width:100px;"/></span>
				<span>类型：
					<select id="lvl" name="lvl[eq]" style="width:100px;">
					</select>
				</span>
			</span>
			<a id="searbtn" icon="eht-checkbtn-icon">查询</a>
			<label icon="eht-upbtn-icon">导入机构
				<form id="uploadForm" action="${localCtx}/upload/PsaOrganizationService" method="post" enctype="multipart/form-data" target="importFrame" style="margin:0px;padding:0px;">
					<input id="importorg" type="file" name="filename" class="eht-toolbar-file"/>
					<iframe id="importFrame" name="importFrame" style="width:0px;height:0px;display:none;"></iframe>
				</form>
			</label>
		</div>
	</div>
	<div id="orgtreeTitle">
		<span style="float:left;">医疗机构信息</span>
		<span style="float:right;margin-bottom:3px;"><select  name="appid" id="appid" style="width:120px;"></select></span>
	</div>
	<div id="left" style="width:220px;">
		
		<div id="tree" style="overflow:auto;width:100%;">
			
		</div>
	</div>	
	<div id="center">
		<div id="r_form1">
			<div style="padding:10px;" id="form">
				<div class="formItem">
					<div class="itemlabel">编码</div>
					<div class="iteminput"><input type="text" name="orgcode" validate="[{required:true},{unique:true,table:'core_organization'}]" disabled="true"/></div>
				</div>
				<div class="formItem">
					<div class="itemlabel">名称</div>
					<div class="iteminput"><input type="text" name="orgname" disabled="true" validate="{required:true}"/></div>
				</div>
				<div class="formItem">
					<div class="itemlabel">类型</div>
					<div class="iteminput">
						<select name="lvl" disabled="true" style="margin-top:13px;height:21px;width:130px;" id="lvlid">
						</select>
					</div>
				</div>
				<div class="formItem">
					<div class="itemlabel">管理员账号</div>
					<div class="iteminput"><input type="text" name="accid" validate="[{required:true},{unique:true,table:'core_organization'}]" disabled="true"></div>
				</div>
				<div class="formItem">
					<div class="itemlabel">所属旗县编码</div>
					<div class="iteminput"><input type="text" name="regioncode" validate="[{required:true}]" disabled="true"></div>
				</div>
			</div>
		</div>
	
		<div id="r_form2">
			<table id="datagrid">
				<tr>
					<td field="orgcode" width="100px">机构编码</td>
					<td field="orgname" width="200px">机构名称</td>
					<td field="lvl" width="100px">类型</td>
					<td field="accid" width="120px">管理员账号</td>
					<td field="accpw">初始密码</td>
					<td field="regioncode">所属行政区域</td>
				</tr>
			</table>
		</div>
	</div>
	<div id="right" style="width:220px;">
		<div id="tab">
			<div label="角色"  selected="true" style="padding:5px;">
				<div id="rolelist"></div>
			</div>
			<div label="风格" style="overflow:auto;padding:5px;">
				<table id="scence"></table>
			</div>
			<div label="具有组织权限" style="overflow:auto;padding:5px;">
				<div id="selectOrgs"></div>
			</div>
		</div>
	</div>
</body>
</html>