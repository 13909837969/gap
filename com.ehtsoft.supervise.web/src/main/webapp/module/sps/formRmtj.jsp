<%@ page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>
<html>
<head>
<title>人民调解</title>
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<link href="${localCtx}/resources/css/ltrhao-dasOrg.css" rel="stylesheet">
<link href="${localCtx}/resources/css/ltrhao-formRmtj.css" rel="stylesheet">
<script type="text/javascript" src="${localCtx}/resources/jquery/ltrhao.formRmtj.js"></script>
<script type="text/javascript" src="http://echarts.baidu.com/gallery/vendors/echarts/extension/bmap.min.js"></script>
<script type="text/javascript" src="${localCtx}/json/BoundaryService.js"></script>
<script type="text/javascript" src="${localCtx}/json/RegionService.js"></script>
<script type="text/javascript" src="${localCtx}/json/JzJzryjbxxService.js"></script>
</head>
<body>
	<div style="position: absolute; top: 0px; bottom: 0px; right: 0px; left: 0px; background-color: #08304B; overflow: hidden;">
		<div style="height: 100%; width: 100%;">
			<!--全区矫正人员分布情况  -->
			<div>
				<div id="das_mapID" style="height: 100%"></div>
			</div>
		</div>
		<div id="container-left1">
			<input id="container-left1-div1" type="text" placeholder="区域"><span class="glyphicon glyphicon-triangle-bottom" id="glyphicon-triangle-bottom"></span>
			<input id="container-left1-div2" type="text" class="input-append date form_datetime" placeholder="开始时间"><span class="glyphicon glyphicon-calendar" id="span1"></span>
			<input id="container-left1-div3" type="text" class="input-append date form_datetime" placeholder="结束日期"><span class="glyphicon glyphicon-calendar" id="span2"></span>
			<input id="container-left1-div4" type="button" value="查询">
		</div>
		<div id="container-left2">
			<div id="container-left2-div1">
				<span id="container-left2-div13">2330</span>
				<span id="container-left2-div11"><a href="http://localhost:8080/user/main-cool.jsp">调解案件总数</a></span>
				<!-- <div id="container-left2-div12"></div> -->
			</div>
			<div id="container-left2-div2">
				<div id="container-left2-div21">
					<div id="container-left2-div211">调解申请<span class="container-left2-div2-span">20344</span></div>
					<div class="container-left2-div2-div">口头调解<span class="container-left2-div2-span">203</span></div>
					<div class="container-left2-div2-div1">书面协调<span class="container-left2-div2-span">203</span></div>
				</div>
				<div id="container-left2-div22">
					<div id="container-left2-div221">受理登记<span class="container-left2-div2-span">203</span></div>
					<div class="container-left2-div2-div">当事人总数<span class="container-left2-div2-span">203</span></div>
					<div class="container-left2-div2-div1">疑难复杂案件<span class="container-left2-div2-span">203</span></div>
				</div>
				<div id="container-left2-div23">
					<div id="container-left2-div231">调解协议<span class="container-left2-div2-span">203</span></div>
					<div class="container-left2-div2-div">已履行<span class="container-left2-div2-span">203</span></div>
					<div class="container-left2-div2-div1">司法确认<span class="container-left2-div2-span">203</span></div>
				</div>
				<div id="container-left2-div24">
					<div id="container-left2-div241">回访记录<span class="container-left2-div2-span">203</span></div>
					<div class="container-left2-div2-div">排查纠<span class="container-left2-div2-span">203</span></div>
					<div class="container-left2-div2-div1">预防纠<span class="container-left2-div2-span">203</span></div>
				</div>
			</div>
			<div id="container-left2-div3">
				<div id="container-left2-div31">2330万元</div>
				<div id="container-left2-div32">协议涉及金额</div>
			</div>
		</div>
		<div id="container-right1">
			<div id="container-right1-div1">呼和浩特市人民调解工作总览<span class="glyphicon glyphicon-user"></span></div>
			<div id="container-right1-div2">
				<input id="container-right1-div2-input1" type="button" value="最优排名">
				<input id="container-right1-div2-input2" type="button" value="最差排名">
			</div>
			<div id="container-right1-div3">
				<span id="container-right1-div3-span1">序号</span>
				<span id="container-right1-div3-span2">区域</span>
				<span id="container-right1-div3-span3">工作量</span>
				<span id="container-right1-div3-span4">成功率</span>
			</div>
		</div>
		<div id="container-right2">
			<div id="container-right2-div1">呼和浩特市人民调解工作总览<span class="glyphicon glyphicon-random"></span></div>
			<div id="container-right2-div2">
				<input id="container-right2-div2-input1" type="button" value="最优排名">
				<input id="container-right2-div2-input2" type="button" value="最差排名">
			</div>
			<div id="container-right2-div3">
				<span id="container-right2-div3-span1">序号</span>
				<span id="container-right2-div3-span5">姓名</span>
				<span id="container-right2-div3-span2">区域</span>
				<span id="container-right2-div3-span3">工作量</span>
				<span id="container-right2-div3-span4">成功率</span>
			</div>
		</div>
	</div>
</body>
</html>