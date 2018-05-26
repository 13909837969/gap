<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<script type="text/javascript" src="${localCtx}/json/DaglService.js"></script>
<script type="text/javascript" src="${localCtx}/resources/jss/formSqjzryjbxx.js"></script>
<title>社区服刑人员档案信息采集</title>
</head>
<body>
	<input id="form_sqjzryjbxx_localctx" type="hidden" value="${localCtx}"/>
	<input id="form_sqjzryjbxx_param_id" type="hidden" value="${param.id}"/>
	<div>
		<div id="fromXzdh" style="position: fixed;top:60px;left:10px"><!--表单的导航列表  -->
		<ul class="nav nav-tabs nav-pills nav-stacked pull-left" style="color:black;font-size:15px">
			  <li class="active ">
			  	<a href="#formSqjzryjbxx_jbxx" data-toggle="tab">基本信息录入</a>
			  </li>
	          <li>
	            <a href="#_formSqjzryjbxx_ws" data-toggle="tab">基本信息文书信息</a>
	           </li>
	          <li>
	            <a href="#_formSqjzryjbxx_dz" data-toggle="tab">基本信息相关地址</a>
	           </li>
	          <li>
	          	<a href="#_formSqjzryjbxx_fz" data-toggle="tab">基本信息犯罪信息</a>
	          </li>
	          <li>
	          	<a href="#_formSqjzryjbxx_jk" data-toggle="tab">基本信息健康信息</a>
	          </li>
	          <li>
	          	<a href="#_formSqjzryjbxx_jz" data-toggle="tab">基本信息矫正信息</a>
	          </li>
	          <li>
	          	<a href="#_formSqjzryjbxx_sf" data-toggle="tab">基本信息附加身份</a>
	          </li>
	          <li>
	          	<a href="#formSqjzryjbxx_Grjl" data-toggle="tab">个人简历信息</a>
	          </li>
	          <li>
	          	<a href="#formSqjzryjbxx_JtcyjShgx" data-toggle="tab">家庭及社会关系</a>
	          </li>
	          <li>
				  <a href="#fromJzryjbxx_Jzfaxx" data-toggle="tab">矫正方案信息 </a> 
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
		<div class="tab-content" style="position: absolute;left: 200px;top: 0px;right: 0px;" id="fromDhlb">
		<!--导航列表页面  -->
			<div class="tab-pane active" id="formSqjzryjbxx_jbxx"></div>
			<div class="tab-pane" id="_formSqjzryjbxx_ws"></div>
			<div class="tab-pane" id="_formSqjzryjbxx_dz"></div>
			<div class="tab-pane" id="_formSqjzryjbxx_fz"></div>
			<div class="tab-pane" id="_formSqjzryjbxx_jk"></div>
			<div class="tab-pane" id="_formSqjzryjbxx_jz"></div>
			<div class="tab-pane" id="_formSqjzryjbxx_sf"></div>
			<div class="tab-pane" id="formSqjzryjbxx_Grjl"></div>
			<div class="tab-pane" id="formSqjzryjbxx_JtcyjShgx"></div>
			<div class="tab-pane" id="fromJzryjbxx_Jzfaxx"></div>
			<!-- <div class="tab-pane" id="listJzYsxx"></div>
			<div class="tab-pane" id="listJzTaf"></div>
			<div class="tab-pane" id="listJzXnsfxx"></div>
			<div class="tab-pane" id="listJzJzlxx"></div> -->
			<!-- <div class="tab-pane" id="formJrtdqy"></div> -->
		</div>
	</div>
</body>
</html>