<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<jsp:include page="module/common.jsp"></jsp:include>
<script type="text/javascript" src="json/MenuService.js"></script>
<script type="text/javascript" src="json/LoginService.js"></script>
<script type="text/javascript" src="json/FirstPageService.js"></script>
<style type="text/css">
.eht-tab-header {
	border-top: 1px solid #c3d8f9;
	border-left: 1px solid #c3d8f9;
	border-right: 1px solid #c3d8f9;
	padding-bottom: 0px;
	background: url("resources/images/bg/basebar0.png") 50% 50% repeat-x;
	overflow: hidden;
}
#bottom label{
	margin-left:10px;margin-right:10px;
}
</style>
<title>捷丰租赁信息管理系统(当前登录:${CURRENT_USER_SESSION.name})</title>
<script type="text/javascript">
var common = $(function(){
	new Eht.Layout({center:"#top",bottom:"#bottom"});
	var menu = new MenuService();
	var fs = new FirstPageService();
	var pswForm = new Eht.Form({selector:"#pswForm"});
	var winPsw = new Eht.Window({selector:"#pswForm",title:"修改密码",width:"300",height:"200",maxButton:false,modal:true,resize:false});
	//small,lage,middle
	var nav = new Eht.NavToolbar({selector:"#navtoolbar",mouseoverchange:false,iframe:true,labelField:"menuname",customBar:"#customBar",styleType:"small",menucode:"menucode"});
	nav.parentBox = $("#top");
	nav.loadData(function(res){
		menu.findMenusByUser(res);
	});
	nav.loadComplete(function(){
		fs.findFirstPage(new Eht.Responder({success:function(data){
			if(data.url && data.url.length>0){
				nav.setRootUrl(data.url);
				nav.setSelected(data.menucode);
			}
		}}));
	});
	$("#changepsw").click(function(){
		winPsw.open();
		pswForm.clear();
		$("#errortips").html("");
	});

	$("#logout").click(function(){
		var ls = new LoginService();
		ls.logout(new Eht.Responder({success:function(data){
			window.top.location.href = data.value;
		}}));
	});

	/**
	 * 密码修改
	 */
    $("#savebtn").click(function(){
	    var data = pswForm.getData();
	    if(data.xmm!=data.xmmqr){
	        $("#errortips").html("新密码与新密码确认不相同，请重新输入");
	        return;
	    }
	    if(pswForm.validate()){
	    	var ls = new LoginService();
			ls.modifyPsw(data.dqmm,data.xmm,
					new Eht.Responder({success:function(d){
						new Eht.Tips().show();
						winPsw.close();
					},
					error:function(request, textStatus, error){
						$("#errortips").html(request.responseText);
					}
				}));
	    }
	});
	$.fn.refresh=function(){
		nav.refresh();
	}
});
</script>
</head>
<body>
<div id="top">
	<div id="customBar">
		<div style="width: 30px; vertical-align: middle;"></div>
		<a id="logout" icon="window-func-exit" class="eht-buttonbar eht-buttonbar-hover"><span class="eht-button-icon window-func-exit"></span><span>退出系统</span></a>
		<a id="changepsw" icon="window-modify-psw" class="eht-buttonbar eht-buttonbar-hover"><span class="eht-button-icon window-modify-psw"></span><span>修改密码</span></a>	
	</div>
	<div id="navtoolbar">
	
	</div>
	<div id="pswForm"  style="align:center;display:none;">
		<br>
		<table align="center">
		<tr><td>当前密码</td><td><input type="password" name="dqmm" validate="[{required:true}]" /></td></tr>
		<tr><td>新密码</td><td><input type="password" id="xmm" name="xmm"  validate="[{required:true}]" /></td></tr>
		<tr><td>新密码确认</td><td><input type="password" id="xmmqr" name="xmmqr"   validate="[{required:true}]"/></td></tr>
		<tr><td  align="center" colspan="2"><input type="button" id="savebtn" value=" 确认 "></td></tr>
		<tr><td align="center" colspan="2"><div id="errortips" style="color:#f00;"></div></td></tr>
		</table>
	</div>
</div>
<div id="bottom" style="border-bottom:1px solid #a0afc3;border-left:1px solid #a0afc3;border-right:1px solid #a0afc3;">
	<label>当前登录人姓名：${CURRENT_USER_SESSION.name}</label>
	<label>当前登录ID：${CURRENT_USER_SESSION.userid}</label>
	<label>当前机构名称：${CURRENT_USER_SESSION.unitName}</label>
	<label>当前机构编码：${CURRENT_USER_SESSION.unitCode}</label>
</div>
</body>
</html>