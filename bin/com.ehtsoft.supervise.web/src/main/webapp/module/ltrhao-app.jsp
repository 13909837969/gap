<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
String ctx= (String)request.getAttribute("com.ehtsoft.fw.sso.url");
if(ctx==null){
	ctx = "/user";
}
response.setHeader("Pragma","No-cache"); 
response.setHeader("Cache-Control","no-cache"); 
response.setDateHeader("Expires", 0); 
String localCtx = application.getContextPath();

request.setAttribute("localCtx",localCtx);
request.setAttribute("ctx", ctx);
%>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">

<%if(!"load".equals(request.getParameter("load"))){ %>
<link rel="stylesheet" href="${localCtx}/resources/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="${localCtx}/resources/bootstrap/css/bootstrap-datetimepicker.min.css">
<link rel="stylesheet" href="${localCtx}/resources/bootstrap/css/animate.min.css">
<link rel="stylesheet" href="${localCtx}/resources/ltrhao-bootstrap.css">
<style>
html,body{
	height: 100%;
}
</style>
<script type="text/javascript" src="${localCtx}/resources/jquery/ltrhao.rmi.json.js"></script>
<script type="text/javascript" src="${localCtx}/resources/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="${localCtx}/resources/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${localCtx}/resources/bootstrap/js/bootstrap-datetimepicker.min.js"></script>
<script type="text/javascript" src="${localCtx}/resources/bootstrap/js/bootstrap-treeview.min.js"></script>
<script type="text/javascript" src="${localCtx}/resources/bootstrap/js/jquery-plugin.js"></script>


<script type="text/javascript" src="${localCtx}/resources/jquery/ltrhao.ui.utils.js"></script>
<script type="text/javascript" src="${localCtx}/resources/jquery/ltrhao.sps.datacode.js"></script>
<script type="text/javascript" src="${localCtx}/resources/jquery/ltrhao.rmi.paginate.js"></script>
<script type="text/javascript" src="${localCtx}/resources/jquery/ltrhao.rmi.responder.js"></script>
<script type="text/javascript" src="${localCtx}/resources/jquery/ltrhao.rmi.view.js"></script>
<script type="text/javascript" src="${localCtx}/resources/jquery/ltrhao.rmi.form.js"></script>
<script type="text/javascript" src="${localCtx}/resources/jquery/ltrhao.ui.tips.js"></script>

<script type="text/javascript" src="${localCtx}/resources/jquery/ltrhao.ui.accordion.js"></script>
<script type="text/javascript" src="${localCtx}/resources/jquery/ltrhao.ui.tableview.js"></script>
<script type="text/javascript" src="${localCtx}/resources/jquery/ltrhao.ui.navtabs.js"></script>
<script type="text/javascript" src="${localCtx}/resources/jquery/ltrhao.ui.tree.js"></script>
<script type="text/javascript" src="${localCtx}/resources/jquery/ltrhao.ui.calendar.js"></script>
<script type="text/javascript" src="${localCtx}/resources/echart/echarts.min.js"></script>

<div class="modal" id="ltrhao-login-panel" data-backdrop="static">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">系统重新登录</h4>
			</div>
			<div class="modal-body">
				<div class="form-horizontal" id="form-create-wjxx">
					<div class="form-group">
						<div style="margin:20px;">由于您长时间没有使用系统，为了保证系统数据安全，系统自动退出，请重新登录</div>
					</div>
					<div class="form-group">
						<label class="control-label col-sm-3">用户名</label>
						<input type="text" name="accountid" class="col-sm-8" id="ltrhao_login_accountid"/>
						<input type="hidden" name="forward"/>
					</div>
					<div class="form-group">
						<label class="control-label col-sm-3">密码</label> 
						<input type="password" name="password" class="col-sm-8 password" id="ltrhao_login_password"/>
					</div>
					<div class="form-group">
						<div class="text-right" style="margin:0px 30px;color:#f00;" id="ltrhao-login-errorinfo"></div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" skipSsoValid="true" id="ltrhao_login_exitButton">退出</button>
				<button type="button" class="btn btn-primary" skipSsoValid="true" id="ltrhao_login_loginButton">登录</button>
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<script type="text/javascript" src="${ctx}/json/LoginService.js"></script>
	<script type="text/javascript">
		function openLoginPanel(){
			$("#ltrhao-login-panel").modal("show");
		}
		$(function(){
			var ls = new LoginService();
    		//清空表单
    		$("#ltrhao_login_exitButton").click(function(e){
    			$("#ltrhao-login-errorinfo").html("");
    			ls.logout();
				top.location.href = "${ctx}";
    		});
    		
			$("#ltrhao_login_loginButton").click(function(){
				var aid = $("#ltrhao_login_accountid").val();
				var pwd = $("#ltrhao_login_password").val();
				var resp = new Eht.Responder();
				resp.success=function(data, textStatus, jqXHR){
					$("#ltrhao-login-errorinfo").html("");
					$("#ltrhao-login-panel").modal("hide");
				};
				resp.error=function(request, textStatus, error){
					$("#ltrhao-login-errorinfo").html(request.responseText);
				};
				ls.login(aid,pwd,resp);
			});
		});
	</script>
	<!-- /.modal -->
</div>
<%}%>