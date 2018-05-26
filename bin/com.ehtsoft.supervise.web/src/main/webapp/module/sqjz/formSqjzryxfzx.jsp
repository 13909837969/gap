<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<script type="text/javascript" src="${localCtx}/json/XfzxService.js"></script>
<script type="text/javascript" src="${localCtx}/resources/jss/formxfzx.js"></script>
<title>刑罚执行信息（司法所）</title>
</head>
<body>
	<input id="form_sqjzryxfzx_localctx" type="hidden" value="${localCtx}"/>
	<input id="form_sqjzryxfzx_param_id" type="hidden" value="${param.id}"/>
	<div>
		<div id="fromXzdh"><!--表单的导航列表  -->
		<ul class="nav nav-tabs  style="color:black;font-size:15px">
			  <li class="active ">
			  	<a href="#formSqjzryxfzx_jbxx" data-toggle="tab" >基本信息录入</a>
			  </li>
	          <li>
	            <a href="#_formSqjzryxfzx_jc" data-toggle="tab" >奖惩情况</a>
	           </li>
	         
	          <li>
	          	<a href="#_formSqjzryxfzx_jzjc" data-toggle="tab" >解除(终止、变更)矫正信息</a>
	          </li>
	          <li>
	          	<a href="#_formSqjzryxfzx_yzqk" data-toggle="tab" id="yzqk">余罪或再罪有关情况</a>
	          </li>
	         
	          <!-- <li>
	          	<a href="#listJzYsxx" data-toggle="tab">押送信息</a>
	          </li>  -->
	         <!--  <li>
	          	<a href="#listJzTaf" data-toggle="tab">同案犯信息</a>
	          </li>
	          <li>
	          	<a href="#listJzXnsfxx" data-toggle="tab">虚拟身份信息</a>
	          </li> -->
				<!-- <a href="#tab-jtcyjshgx">禁止信息 <span class="caret"></span></a> -->
	          <!-- <li>
	          	<a href="#listJzJzlxx" data-toggle="tab">禁止令信息</a>
	          </li> -->
	          <!-- <li>
	          	<a href="#formJrtdqy" data-toggle="tab">进入特点区域信息</a>
	          </li> -->
		</ul>
		</div>
		<div class="tab-content"  id="fromXfzx">
		<!--导航列表页面  -->
			<div class="tab-pane active" id="formSqjzryxfzx_jbxx" load="${localCtx}/module/sqjz/formSqjzryxfzx_jbxx.jsp?load=load&id=${param.id}"></div>
			<div class="tab-pane" id="_formSqjzryxfzx_jc" load="${localCtx}/module/sqjz/formSqjzryxfzx_jc.jsp?load=load&id=${param.id}"></div>
			<div class="tab-pane" id="_formSqjzryxfzx_jzjc"  load="${localCtx}/module/sqjz/formSqjzryxfzx_jzjc.jsp?load=load&id=${param.id}"></div>
			<div class="tab-pane" id="_formSqjzryxfzx_yzqk"  load="${localCtx}/module/sqjz/formSqjzryxfzx_yzqk.jsp?load=load&id=${param.id}"></div>
		</div>
	</div>
</body>
</html>