<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
response.setHeader("Pragma","No-cache"); 
response.setHeader("Cache-Control","no-cache"); 
response.setDateHeader("Expires", 0); 

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
<link rel="stylesheet" type="text/css" href="${localCtx}/resources/css/core/blue/eht.ui.core.css"/>
<link rel="shortcut icon" type="image/x-icon" href="${localCtx}/resources/images/login/logo.ico" media="screen" />
<script type="text/javascript" src="${localCtx}/resources/script/jquery/eht.rmi.json.js"></script>
<script type="text/javascript" src="${localCtx}/resources/script/jquery/jquery-1.11.0.min.js"></script>
<script type="text/javascript" src="${localCtx}/resources/script/jquery/jquery-myplugin.js"></script>
<script type="text/javascript" src="${localCtx}/resources/script/jquery/jquery.cookie.js"></script>
<script type="text/javascript" src="${localCtx}/resources/script/jquery/raphael-min.js"></script>
<script type="text/javascript" src="${localCtx}/resources/script/core/eht.ui.utils.js"></script>
<script type="text/javascript" src="${localCtx}/resources/script/core/eht.rmi.responder.js"></script>
<script type="text/javascript" src="${localCtx}/resources/script/core/eht.rmi.paginate.js"></script>
<script type="text/javascript" src="${localCtx}/resources/script/core/eht.rmi.form.js"></script>
<script type="text/javascript" src="${localCtx}/resources/script/core/eht.rmi.view.js"></script>
<script type="text/javascript" src="${localCtx}/resources/script/core/eht.ui.layout.js"></script>
<script type="text/javascript" src="${localCtx}/resources/script/core/eht.ui.toolbar.js"></script>
<script type="text/javascript" src="${localCtx}/resources/script/core/eht.ui.datagrid.js"></script>
<script type="text/javascript" src="${localCtx}/resources/script/core/eht.ui.window.js"></script>
<script type="text/javascript" src="${localCtx}/resources/script/core/eht.ui.windowmanager.js"></script>
<script type="text/javascript" src="${localCtx}/resources/script/core/eht.ui.taskbar.js"></script>
<script type="text/javascript" src="${localCtx}/resources/script/core/eht.ui.desktop.js"></script>
<script type="text/javascript" src="${localCtx}/resources/script/core/eht.ui.tree.js"></script>
<script type="text/javascript" src="${localCtx}/resources/script/core/eht.ui.tips.js"></script>
<script type="text/javascript" src="${localCtx}/resources/script/core/eht.ui.menu.js"></script>
<script type="text/javascript" src="${localCtx}/resources/script/core/eht.ui.tab.js"></script>
<script type="text/javascript" src="${localCtx}/resources/script/core/eht.ui.navtoolbar.js"></script>
<script type="text/javascript" src="${localCtx}/resources/script/core/eht.ui.datepicker.js"></script>
<script type="text/javascript" src="${localCtx}/resources/script/core/eht.ui.combobox.js"></script>
<script type="text/javascript" src="${localCtx}/resources/script/core/eht.ui.accordion.js"></script>
<script type="text/javascript" src="${localCtx}/resources/script/core/eht.ui.alert.js"></script>
<script type="text/javascript" src="${localCtx}/resources/script/core/eht.ui.confirm.js"></script>
<script type="text/javascript" src="${localCtx}/resources/script/core/eht.ui.portal.js"></script>
<script type="text/javascript" src="${localCtx}/resources/script/core/eht.chart.rectgrid.js"></script>
<script type="text/javascript" src="${localCtx}/resources/script/core/eht.chart.curveLine.js"></script>
<script type="text/javascript" src="${localCtx}/resources/script/core/eht.chart.sector.js"></script>
<script type="text/javascript" src="${localCtx}/resources/script/core/eht.chart.pie.js"></script>
<script type="text/javascript" src="${localCtx}/resources/script/core/eht.chart.pointer.js"></script>
<script type="text/javascript" src="${localCtx}/resources/script/core/eht.chart.dashboard.js"></script>


<script type="text/javascript" src="${localCtx}/resources/script/core/empi.ui.dialog.js"></script>

