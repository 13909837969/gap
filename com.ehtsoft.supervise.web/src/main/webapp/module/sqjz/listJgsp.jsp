<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
	<title>监管审批</title>
	<jsp:include page="../ltrhao-common.jsp"></jsp:include>
	<script type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
$(function(){
	$("#sqjz_listJgsp_all #panel-264904").load("${localCtx}/module/sqjz/listQj_sp.jsp?load=load");
	
	
	$("#sqjz_listJgsp_all #qjsp").click(function(){
		$("#sqjz_listJgsp_all #panel-264904").addClass("active");
		$("#sqjz_listJgsp_all #panel-34950").removeClass("active");
		$("#sqjz_listJgsp_all #panel-34949").removeClass("active");
		$("#sqjz_listJgsp_all #panel-264904").load("${localCtx}/module/sqjz/listQj_sp.jsp?load=load");
	});
	
	$("#sqjz_listJgsp_all #jzdbgsp").click(function(){
		$("#sqjz_listJgsp_all #panel-264904").removeClass("active");
		$("#sqjz_listJgsp_all #panel-34950").removeClass("active");
		$("#sqjz_listJgsp_all #panel-34949").addClass("active");
		$("#sqjz_listJgsp_all #panel-34949").load("${localCtx}/module/sqjz/listJzdbg_sp.jsp?load=load");
	});
	
	$("#sqjz_listJgsp_all #tsqyjrsp").click(function(){
		$("#sqjz_listJgsp_all #panel-264904").removeClass("active");
		$("#sqjz_listJgsp_all #panel-34950").addClass("active");
		$("#sqjz_listJgsp_all #panel-34949").removeClass("active");
		$("#sqjz_listJgsp_all #panel-34950").load("${localCtx}/module/sqjz/listTsqyjr_sp.jsp?load=load");
	});
	
});


</script>
</head>
<body>
		<!-- <fieldset>
			<legend>监管审批</legend>
			 姓名：<input id="name" type="text" />
			 性别：<input id="sex" type="text" />
			<input  id="btn" type="button" class="btn btn-default btn-sm" value="查询">
		</fieldset>	 -->
		<!-- 切换卡 -->
		<div id="sqjz_listJgsp_all"><!--  class="container-fluid" -->
			<div class="row-fluid">
				<div class="span12">
					<div class="tabbable" id="tabs-610833">
						<ul class="nav nav-tabs">
							<li class="active">
								<a href="panel-264904" id="qjsp" data-toggle="tab">请假审批</a>
							</li><!-- javascript:void(0) -->
							<li>
								<a href="panel-34949" id="jzdbgsp" data-toggle="tab">居住地变更审批</a>
							</li>
							<li>
								<a href="panel-34950" id="tsqyjrsp" data-toggle="tab">特殊区域进入审批</a>
							</li>
						</ul>
						<div class="tab-content" id="all" style="height:100%">
							<div class="tab-pane active" id="panel-264904">
							</div>
							<div class="tab-pane" id="panel-34949">
							</div>
							<div class="tab-pane" id="panel-34950">
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

</body>
</html>