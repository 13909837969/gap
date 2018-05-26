<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@page import="com.ehtsoft.fw.utils.Util"%>
<%@page import="java.util.UUID"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<script type="text/javascript" src="${localCtx}/json/DaglService.js"></script>
<script type="text/javascript" src="${localCtx}/json/XfzxService.js"></script>
<script type="text/javascript" src="${localCtx}/json/RegionService.js"></script>
<title>社区服刑人员档案信息采集</title>
</head>
<script type="text/javascript">
$(function(){
	var count = 0;
	var tabCnt = $("#view_dagl_tab").children().size();
	$("#view_dagl_tab").children().each(function(){
		$(this).load($(this).attr("load"),function(){
			count++;
			initJzryjbxxForm();
		});
	});
	var initJzryjbxxForm = function(){
		if(count!=tabCnt){
			return;
		}
	}
})
</script>

<body
	
	<input id="form_sqjzryjbxx_localctx" type="hidden" value="${localCtx}"/>
	<input id="form_sqjzryjbxx_param_id" type="hidden" value="${param.id}"/>
	<div>
		<div id="fromXzdh"><!--表单的导航列表  -->
		<ul class="nav nav-tabs  style="color:black;font-size:15px">
			  <li class="active ">
			  	<a href="#view_jbxx" data-toggle="tab" >基本信息</a>
			  </li>
	          <li>
	            <a href="#view_ws" data-toggle="tab" >基本信息文书</a>
	           </li>
	          <li>
			  	<a href="#view_xfzx" data-toggle="tab" >刑罚信息录入</a>
			  </li>
	          <li>
	          	<a href="#view_jzjc" data-toggle="tab" >解除(终止、变更)矫正信息</a>
	          </li>
	          
		</ul>
		</div>
		<div class="tab-content"  id="view_dagl_tab">
		<!--导航列表页面  -->
			<div class="tab-pane active" id="view_jbxx" load="${localCtx}/module/sqjz/view_jbxx.jsp?load=load&id=${param.id}"></div>
			<div class="tab-pane" id="view_ws" load="${localCtx}/module/sqjz/view_wsxx.jsp?load=load&id=${param.id}"></div>
			<div class="tab-pane" id="view_xfzx"  load="${localCtx}/module/sqjz/view_xfzx.jsp?load=load&id=${param.id}"></div>
			<div class="tab-pane" id="view_jzjc"  load="${localCtx}/module/sqjz/view_jcjz.jsp?load=load&id=${param.id}"></div>
		</div>
		
		
		
	</div>
</body>
</html>