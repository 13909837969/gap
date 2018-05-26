<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
	<title>档案管理</title>
	<jsp:include page="../ltrhao-common.jsp"></jsp:include>
	<script type="text/javascript"></script>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<script type="text/javascript">
	</script>
</head>
<body>
	<!-- 切换卡 -->
	<div class="container-fluid" id="viewDagl">
		<div class="row-fluid">
			<div class="span12">
				<div class="tabbable">
					<div  style="position:absolute;top:10px;">
						<ul class="nav nav-tabs nav-pills nav-stacked pull-left" id="jzryjbxx-tabs">
							<li class="active">
								<a href="#tab-jzryjbxx" data-toggle="tab" >基<br>本<br>信<br>息</a>
							</li>
							<li>
								<a href="#tab-jzrygrjl" data-toggle="tab">个<br>人<br>简<br>历</a>
							</li>
							<li>
								<a href="#tab-jtcyjshgx" data-toggle="tab">家<br>庭<br>成<br>员<br>及<br>主<br>要<br>社<br>会<br>关<br>系</a>
							</li>
						</ul>
					</div>
					
					<div class="tab-content" style="height:100%;width:900px">
						<div class="tab-pane active" id="tab-jzryjbxx">
						</div>
						<div class="tab-pane" id="tab-jzrygrjl">
						</div>
						<div class="tab-pane" id="tab-jtcyjshgx">
						</div>
						<script type="text/javascript">
						$(function(){
							$("#tab-jzryjbxx").load("${localCtx}/module/sqjz/formSqjzryjbxx.jsp?load=load$id=${param.id}");
							$("#tab-jzrygrjl").load("${localCtx}/module/sqjz/formGrjl.jsp?load=load$id=${param.id}");
							$("#tab-jtcyjshgx").load("${localCtx}/module/sqjz/formJtcyjShgx.jsp?load=load$id=${param.id}");
						});
						</script>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>