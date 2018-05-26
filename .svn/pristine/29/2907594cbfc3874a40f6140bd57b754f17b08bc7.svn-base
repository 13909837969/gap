<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<jsp:include page="../common.jsp"></jsp:include>
<title>系统用户管理(组织机构)  暂时没有用到 </title>
<link rel="stylesheet" href="${localCtx}/resources/css/usercss/listSystemManag.css">
<script type="text/javascript" src="${localCtx}/json/OsaOrganizationService.js"></script>
<script src="${localCtx}/resources/script/medical/listOrganization.js"></script>
</head>
<body>

<div id="left" style="width:250px;">
	<div id="tree" style="overflow:auto;margin-left:3px; margin-top:5px;"></div>
</div>
<div id="center">
<div id="top" class="systemTop">
	<div class="systemTopbody">
		<div style="margin:0px auto;text-align:center;">
			<label  for="agency">机构编码:</label><input type="text" name="orgcode"  id="agency" style="width:120px;" disabled="disabled" />
			<label  for="lvl" style="margin-left:30px;">类    型:</label>
			<select name="lvl" disabled="disabled"  id="lvl" style="width:120px;" >
					<option value=1>省</option>
					<option value=2>市</option>
					<option value=3>区</option>
					<option value=4>医院</option>
					<option value=5>社区卫生服务中心</option>	
					<option value=6>乡镇卫生院</option>	
					<option value=7>村卫生室</option>
			</select>
			<label style="margin-left:30px;" for="orgname">机构名称:</label><input name="orgname" disabled="disabled" type="text" id="orgname" style="width:250px;" />
		</div>
	</div>
	<div class="systemTopbut">
		<span class="addbut"><input type="button" value="新增机构" id="addbut"   ></span>
		<span class="savebut"><input type="button" value="保存" id="savebut" disabled="disabled" ></span>
	</div>
</div>
<div id="infList" >
	<div id="tab">
		<div label="人员信息"  selected="true" style='padding:10px;'>
			<table  id="personInf" >
				<tr>
					<td field="orgname" enable="false" width="130" align="center">组织机构</td>
					<td field="coding" width="130" align="center">编码</td>
					<td field="name"  width="100" align="center">姓名</td>
					<td field="sex" id="sex" width="70" align="center">性别</td>
					<td field="cardid" width="130"  align="center">身份证号</td>
					<td field="birthday" width="120" id="birthday"  align="center">出生日期</td>
					<td field="telephone" width="120" id="telephone"  align="center">联系电话</td>
					<td field="email" width="120" id="email"  align="center">email</td>		
					<td field="cts" width="200" enable="false" align="center">创建时间</td>
					<td field="uts" width="200" enable="false" align="center">更新时间</td>
				</tr>
			</table>
			<div id="perbut">
				<a id="paddbtn" icon='eht-addbtn-icon'>新增</a>
				<a id="peditbtn" icon='eht-editbtn-icon'>编辑</a>
				<a id="psavebtn" icon='eht-savebtn-icon'>保存</a>
				<a id="pdel" icon='eht-deletebtn-icon'>删除</a>
				<a id="initAcc" icon='window-modify-psw'>初始账户</a>
			</div>
		</div>
		<div label="账户信息" style='padding:10px;'>
			<table  id="accountInf" >
				<tr>
					<td field="accountid"  width="130" align="center">账号</td>
					<td field="name" width="130" align="center">用户</td>
					<td field="flag" id="flag" width="80" align="center">开启/禁用</td>
					<td field="cts" width="200"  enable="false" align="center">创建时间</td>
					<td field="uts" width="200"  enable="false"  align="center">更新时间</td>
				</tr>
			</table>
			<div style="display:none">
			<table id="downperson" >
				<tr>
					<td field="coding">编码</td>
					<td field="name">姓名</td>
					<td field="sex">性别</td>
				</tr>
			</table>
			</div>
			<div id="accbut">
				<a id="iaddbtn" icon='eht-addbtn-icon'>新增</a>
				<a id="ieditbtn" icon='eht-editbtn-icon'>编辑</a>
				<a id="isavebtn" icon='eht-savebtn-icon'>保存</a>
				<a id="idel" icon='eht-deletebtn-icon'>删除</a>
			</div>
		</div>
	</div>
</div>
</div>
</body>
</html>