<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="java.util.UUID"%>
<%@page import="com.ehtsoft.fw.utils.Util"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<script type="text/javascript" src="${localCtx}/json/DjjsService.js"></script>
<script type="text/javascript" src="${localCtx}/json/RegionService.js"></script>
<script type="text/javascript" src="${localCtx}/resources/jss/formDjjs.js"></script>
<title>社区服刑人员档案信息采集</title>
</head>

<body>
	<%
		String id = request.getParameter("id");
		if(Util.isNotEmpty(id)){
			out.print("<input type='hidden' value='1' id='form-edit-flag1'>");
		}else{
			out.print("<input type='hidden' value='0' id='form-edit-flag1'>");
			id = UUID.randomUUID().toString();
		} 
	
	%>
	<input id="form_sqjzryjbxx_localctx" type="hidden" value="${localCtx}"/>
	<input id="form_sqjzryjbxx_param_id" type="hidden" value="<%=id%>"/>
	<div>
		<div id="fromXzdh"><!--表单的导航列表  -->
		<ul class="nav nav-tabs  style="color:black;font-size:15px">
			  <li class="active ">
			  	<a href="#formSqjzryjbxx_jbxx" data-toggle="tab" >基本信息录入</a>
			  </li>
	          <li>
	            <a href="#_formSqjzryjbxx_ws" data-toggle="tab" >基本信息文书信息</a>
	           </li>
	         
	          <li >
	          	<a href="#formSqjzryjbxx_Grjl" id="grjl" data-toggle="tab" >个人简历信息</a>
	          </li>
	          <li >
	          	<a href="#formSqjzryjbxx_JtcyjShgx" id="jtcy"  data-toggle="tab" >家庭及社会关系</a>
	          </li>
	          <li >
	          	<a href="#formSqjzryjbxx_Cljs" id="cljs"  data-toggle="tab" >材料接收</a>
	          </li>
		</ul>
		</div>
		<div class="tab-content"  id="form_dagl_tab">
		<!--导航列表页面  -->
			<div class="tab-pane active" id="formSqjzryjbxx_jbxx" load="${localCtx}/module/sqjz/form_jbxx.jsp?load=load&id=<%=id%>"></div>
			<div class="tab-pane" id="_formSqjzryjbxx_ws" load="${localCtx}/module/sqjz/formJzda_ws.jsp?load=load&id=<%=id%>"></div>
			<div class="tab-pane" id="formSqjzryjbxx_Grjl"  load="${localCtx}/module/sqjz/formSqjzryjbxx_Grjl.jsp?load=load&id=<%=id%>"></div>
			<div class="tab-pane" id="formSqjzryjbxx_JtcyjShgx"  load="${localCtx}/module/sqjz/formSqjzryjbxx_JtcyjShgx.jsp?load=load&id=<%=id%>"></div>
			<div class="tab-pane" id="formSqjzryjbxx_Cljs"  load="${localCtx}/module/sqjz/formCljs.jsp?load=load&id=<%=id%>"></div>
		</div>
		
		
		
	</div>
</body>
</html>