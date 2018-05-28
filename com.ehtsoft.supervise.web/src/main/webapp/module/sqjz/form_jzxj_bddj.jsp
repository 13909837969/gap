<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@page import="com.ehtsoft.fw.utils.Util"%>
<%@page import="java.util.UUID"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<script type="text/javascript" src="${localCtx}/json/XfzxService.js"></script>
<script type="text/javascript" src="${localCtx}/json/BddjService.js"></script>
<script type="text/javascript" src="${localCtx}/resources/jss/formxfzx.js"></script>

<title>社区服刑人员档案信息采集</title>
</head>

<body
	
	<input id="form_jzxj_localctx" type="hidden" value="${localCtx}"/>
	<input id="form_jzxj_param_id" type="hidden" value="${param.id}"/>
	<div>
		<div id="fromXzdh"><!--表单的导航列表  -->
			<ul class="nav nav-tabs  style="color:black;font-size:15px">
				  <li class="active">
				  	<a href="#formSqjzryxfzx_jbxx" data-toggle="tab" >刑罚执行信息</a>
				  </li>
		          <li>
		            <a href="#_formSqjzryxfzx_jc" data-toggle="tab" >奖惩情况</a>
		           </li>
		            <li>
		            <a href="#_formSqjzryxfzx_jzjc" data-toggle="tab" >解除（终止、变更）矫正信息</a>
		           </li>
		            <li>
		            <a href="#_formSqjzrysfzx_yzqk" data-toggle="tab" >余罪或再罪有关情况</a>
		           </li>
			</ul>
		</div>
		<div class="tab-content"  id="form_jzxj_bddj">
		<!--导航列表页面  -->
			<div class="tab-pane active" id="formSqjzryxfzx_jbxx" load="${localCtx}/module/sqjz/formSqjzryxfzx_jbxx.jsp?load=load&id=${param.id}"></div>
			<div class="tab-pane" id="_formSqjzryxfzx_jc" load="${localCtx}/module/sqjz/formSqjzryxfzx_jc.jsp?load=load&id=${param.id}"></div>
			<div class="tab-pane" id="_formSqjzryxfzx_jzjc" load="${localCtx}/module/sqjz/formSqjzryxfzx_jzjc.jsp?load=load&id=${param.id}"></div>
			<div class="tab-pane" id="_formSqjzrysfzx_yzqk" load="${localCtx}/module/sqjz/formSqjzryxfzx_yzqk.jsp?load=load&id=${param.id}"></div>
		</div>
		
		
		
	</div>
</body>
</html>