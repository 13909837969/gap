<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<jsp:include page="module/common.jsp"></jsp:include>
<script type="text/javascript" src="resources/script/amq/amq_jquery_adapter.js"></script>
<script type="text/javascript" src="resources/script/amq/amq.js"></script>
<link rel="stylesheet" href="resources/css/usercss/main.css">
<script type="text/javascript" src="resources/script/medical/main.js"></script>
<script type="text/javascript" src="json/MenuService.js"></script>
<script type="text/javascript" src="json/PermissionService.js"></script>
<script type="text/javascript" src="json/LoginService.js"></script>
<script type="text/javascript" src="json/MessageService.js?debug=false"></script>
<script type="text/javascript" src="json/SSO.js"></script>
<style type="text/css">
.eht-taskbar-start-icon{
	width:38px;
	height:38px;
    margin: 2px auto;
    background-position:0px 0px;
	background-image: url(resources/images/main/start2.png);
}
.eht-taskbar-start-icon:hover{
	background-position:38px 0px;
	background-image: url(resources/images/main/start2.png);
}
.eht-taskbar-startbg{
	background-image: url(resources/images/main/startbg.png);
}
.taskbar-icon-message-tips{
background-image: url(resources/images/icon/msgtips.gif);
}
#message-tips div{
	padding:2px;
}
#message-option {
}
#message-option .mes-opt-active{
	background:#fff;
}
#message-option div{
	display:inline-block; 
	padding:0px 5px 0px 5px;
	border:0;
	cursor:pointer;
}
</style>
<%-- <title>颐乐康复中心养老管理系统(当前登录:${CURRENT_USER_SESSION.name})</title> --%>
<title>红山区智慧社区应用服务管理(当前登录:${CURRENT_USER_SESSION.name})</title>
</head>
<input type="hidden" id="corgname" value ="${CURRENT_USER_SESSION.orgname}"/>
<input type="hidden" id="corgcode" value ="${CURRENT_USER_SESSION.orgcode}"/>
<input type="hidden" id="cname" value ="${CURRENT_USER_SESSION.name}"/>
<body class="mainDesktop">
	<div id="desktop">
		<div id="winMessage" style="overflow:auto;">
			<div>
				<div id="message-tips" style='padding:5px;'></div>
			</div>
		</div>
		<div id="messageWindow">
			<%--<iframe src="chatManager.jsp"></iframe>--%>
		</div>
	</div>
	<div id="taskbar"></div>
	<div id="task-toolbar" style="vertical-align: middle;">
		<a id="msg" icon='eht-talk-icon'></a>
	</div>
	<div id="winMenu" style="display:none;">
		<div id='snapTop' style="height:30px;">
			<div id="toolBar">
				<a id="psavebtn" icon='eht-savebtn-icon'>创建</a>
			</div>
		</div>
		<div id='snapBottom' style="height:540px">
			<div id="menuTree"></div>
		</div>
	</div>
	<div id="rightMenu"></div>
	<div id="form"  style="align:center;display:none;">
	<br>
	<table align="center">
	<tr><td>当前密码</td><td><input type="password" name="dqmm" validate="[{required:true}]" /></td></tr>
	<tr><td>新密码</td><td><input type="password" id="xmm" name="xmm"  validate="[{required:true}]" /></td></tr>
	<tr><td>新密码确认</td><td><input type="password" id="xmmqr" name="xmmqr"   validate="[{required:true}]"/></td></tr>
	<tr><td  align="center" colspan="2"><input type="button" id="savebtn" value=" 确认 "></td></tr>
	<tr><td align="center" colspan="2"><div id="errortips" style="color:#f00;"></div></td></tr>
	</table>
	</div>

</body>
</html>