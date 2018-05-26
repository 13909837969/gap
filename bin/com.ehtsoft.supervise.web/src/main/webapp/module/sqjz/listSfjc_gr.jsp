<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
	<title>个人奖惩情况</title>
	<jsp:include page="../ltrhao-common.jsp"></jsp:include>
	<script type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
	<!-- 切换卡 -->
	<div class="container-fluid" id="sqjz_listDagl_gr_all">
		<div class="row-fluid">
			<div class="span12">
				<div class="tabbable" id="tabs-610833">
					<ul class="nav nav-tabs">
						<li class="active">
							<a href="#panel-264904" data-toggle="tab">警告</a>
						</li>
						<li>
							<a href="#panel-34949" data-toggle="tab">治安处罚</a>
						</li>
						<li>
							<a href="#panel-34950" data-toggle="tab">提请减刑</a>
						</li>
					</ul>
					<div class="tab-content" style="height:100%">
						<div class="tab-pane active" id="panel-264904">
							<iframe src="${localCtx}/module/sqjz/formSqjzryxxb.jsp?id=${param.id}" height="450px" width="100%" scrolling="yes" frameborder="0">
									
							</iframe>
						</div>
						<div class="tab-pane" id="panel-34949">
							<iframe src="${localCtx}/module/sqjz/formFlws.jsp?id=${param.id}" height="450px" width="100%" scrolling="yes" frameborder="0">
									
							</iframe>
						</div>
						<div class="tab-pane" id="panel-34950">
							<iframe src="${localCtx}/module/sqjz/formXfzx.jsp?id=${param.id}" height="450px" width="100%" scrolling="yes" frameborder="0">
									
							</iframe>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

</body>
</html>