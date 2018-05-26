<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- 当前页面只能用于  OSA 角色用户  及  医疗机构人员的用户  --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<jsp:include page="../common.jsp"></jsp:include>
<title>系统用户管理(组织机构)</title>
<link rel="stylesheet" href="${localCtx}/resources/css/usercss/listSystemManag.css">
<script type="text/javascript" src="${localCtx}/json/OsaOrganizationService.js"></script>
<!-- 本页只用 PsaOrganizationService 自动编码 -->
<script type="text/javascript" src="${localCtx}/json/PsaOrganizationService.js"></script>
<script src="${localCtx}/resources/script/medical/listOsaOrganization.js"></script>
<script type="text/javascript" src="${localCtx}/json/SSO.js"></script>
<style type="text/css">
.formItem{
	display: inline-block;
	margin:2px 10px 2px 10px;
}
.formItem .itemlabel{
	display: inline-block;
	width: 60px;
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
</style>
</head>
<body>
<div id="lefttitle">
<span style="float:left;">&nbsp;机构</span>
<span style="float:right;margin-bottom:3px;">
<a id="addSub" >
<!-- 
icon="eht-addbtn-icon"  class="eht-buttonbar eht-buttonbar-hover"
<span class="eht-button-icon eht-addbtn-icon"></span>
<span>新增子机构</span>
 -->
</a>
</span>
</div>
<div id="left" style="width:230px;">
	<div id="orgtree" style="width:100%;"></div>
</div>
<div id="right">
	<div id="top" class="systemTop"style="height:100px">
		<!-- <div id="toolbar">
		<input type="text"name="jjmc"id="jjmc"style="border-style:none;text-align:right">机构用户设置
		
		</div> -->
		<div style="padding:20px;">
			<div style="margin:0px auto;text-align:center;">
			<table id="querycon">
				<tr>
					<td>姓名</td><td><input type="text"name="name[like]"></td>
					<td>编码</td><td><input type="text"name="coding[like]"></td>
					<td>账号</td><td><input type="text"name="accountid[like]" id="accountid"></td>
				</tr>
			</table>
			</div>
		</div>
		<div class="systemTopbut">
			<span class="addbut"><input type="button" value="查询" id="search"   ></span>
		</div>
	</div>
	<div id="infList" >
		<div id="tab">
			<div label="人员信息"  selected="true" style='padding:10px' >
				<table  id="personInf" >
					<tr>
						<td field="orgid" enable="false" width="130" align="center">机构名称</td>
						<td field="coding" width="130" align="center">编码</td>
						<td field="name"  width="100" align="center">姓名</td>
						<td field="sex" id="sex" width="70" align="center">性别</td>
						<td field="post" width="100" align="center">职位</td>
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
						<td field="orgname" enable="false">机构名称</td>
						<td field="accountid"  width="130" align="center">账号</td>
						<td field="userid" width="130" align="center">用户</td>
						<td field="flag" id="flag" width="80" align="center">开启/禁用</td>
						<td field="frule" enable="false">角色</td>
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
					<!-- 
					<a id="iaddbtn" icon='eht-addbtn-icon'>新增</a>
					<a id="ieditbtn" icon='eht-editbtn-icon'>编辑</a>
					<a id="isavebtn" icon='eht-savebtn-icon'>保存</a>
					-->
					<a id="idel" icon='eht-deletebtn-icon'>删除</a>
				</div>
			</div>
		</div>
	</div>
</div>
<div id="win_form">
	<div>
	<div id="form">
		<div class="formItem">
			<div class="itemlabel">编码</div>
			<div class="iteminput"><input type="text" name="orgcode" validate="[{required:true},{unique:true,table:'core_organization'}]" disabled="true"/></div>
		</div>
		<div class="formItem">
			<div class="itemlabel">名称</div>
			<div class="iteminput"><input type="text" name="orgname"/></div>
		</div>
		<div class="formItem">
			<div class="itemlabel">类型</div>
			<div class="iteminput">
				<select name="lvl" style="margin-top:13px;height:21px;width:130px;" id="lvlid">
					<option value=4>医院</option>
					<option value=5>社区卫生服务中心</option>	
					<option value=6>乡镇卫生院</option>	
					<option value=7>村卫生室</option>		
				</select>
			</div>
		</div>
		<div style="text-align: right;margin-top:10px;">
			<input type="button" value="保存" id="saveOrg"/>
		</div>
	</div>
	</div>
</div>
</body>
</html>