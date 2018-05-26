<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<meta http-equiv="Content-Type" content="text/html;" charset="UTF-8">
<title>考核信息</title>
</head>
<body>
	<input id="form_khxx_localctx" type="hidden" value="${localCtx}"/>
	<input id="form_khxx_param_id" type="hidden" value="${param.id}"/>
	<div>
		<div id="fromXzdh"><!--表单的导航列表  -->
		<ul class="nav nav-tabs  style="color:black;font-size:15px">
			  <li class="active ">
			  	<a href="#formSqjzryjbxx_jbxx" data-toggle="tab" >季度考核</a>
			  </li>
	          <li>
	            <a href="#_formSqjzryjbxx_ws" data-toggle="tab" >年度考核</a>
	           </li>
		</ul>
		</div>
		<div class="tab-content"  id="form_khxx_tab">
		<!--导航列表页面  -->
			<div class="tab-pane active" id="formSqjzryjbxx_jbxx" load="${localCtx}/module/sqjz/formJzda.jsp?load=load&id=${param.id}"></div>
			<div class="tab-pane" id="_formSqjzryjbxx_ws" load="${localCtx}/module/sqjz/formJzda_ws.jsp?load=load&id=${param.id}"></div>
			
		</div>
		
		
		
	</div>
	
	
	
</body>
</html>