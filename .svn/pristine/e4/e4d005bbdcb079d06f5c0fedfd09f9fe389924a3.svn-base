<%@ page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>
<html>
<head>
<title>法制宣传</title>
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<link href="${localCtx}/resources/css/ltrhao-dasOrg.css" rel="stylesheet">
<link href="${localCtx}/resources/css/ltrhao-formRmtj.css" rel="stylesheet">
<script type="text/javascript"
	src="http://echarts.baidu.com/gallery/vendors/echarts/extension/bmap.min.js"></script>
<script type="text/javascript" src="${localCtx}/json/BoundaryService.js"></script>
<script type="text/javascript" src="${localCtx}/json/RegionService.js"></script>
<script type="text/javascript" src="${localCtx}/json/JzJzryjbxxService.js"></script>
</head>
<body>
	<div id="ltrhao-formRmtj-body-div" >
		<div id="ltrhao-formRmtj-body-div1">
			<!--全区矫正人员分布情况  -->
			<div>
				<div id="das_mapID"></div>
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
				<div id="container-left2-div13">2330</div>
				<span id="container-left2-div11">调解案件总数</span>
				<div id="container-left2-div12"></div>
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
			<div id="container-right1-div1">呼和浩特市人民调解工作总览<span class="glyphicon glyphicon-user" id="glyphicon-user"></span></div>
			<div id="container-right1-div2">
				<input id="container-right1-div2-input1" type="button" value="最优排名">
				<input id="container-right1-div2-input2" type="button" value="最差排名">
			</div>
			<div id="container-right1-div3">
				<span id="container-right1-div3-span1">排名</span>
				<span id="container-right1-div3-span2">区域</span>
				<span id="container-right1-div3-span3">工作量</span>
				<span id="container-right1-div3-span4">成功率</span>
			</div>
			<div id="container-right1-div4"></div>
		</div>
		<div id="container-right2">
			<div id="container-right2-div1">呼和浩特市优秀调解人员总览<span class="glyphicon glyphicon-random" id="glyphicon-random"></span></div>
			<div id="container-right2-div2">
				<input id="container-right2-div2-input1" type="button" value="最优排名">
				<input id="container-right2-div2-input2" type="button" value="最差排名">
			</div>
			<div id="container-right2-div3">
				<span id="container-right2-div3-span1">排名</span>
				<span id="container-right2-div3-span5">姓名</span>
				<span id="container-right2-div3-span2">区域</span>
				<span id="container-right2-div3-span3">工作量</span>
				<span id="container-right2-div3-span4">成功率</span>
			</div>
			<div id="container-right2-div4"></div>
		</div>
		<!--默认隐藏的div  -->
		<div type="hiden" id="formRmtj-hidenDiv" style="display:none;">
			<div id="formRmtj-hidenDiv-div1">
				<div id="formRmtj-hidenDiv-div11">区域选择</div>
				<div id="formRmtj-hidenDivBtn" class="glyphicon glyphicon-remove-circle"></div>
			</div>
			<div id="formRmtj-hidenDivSS"></div>
		</div>
		<!--调解案件总数分析  -->
		<div id="spsRmtj-ajfx-div" style="display:none;">
			<div id="spsRmtj-ajfx-header">
				<div id="spsRmtj-ajfx-header1">案件分类情况</div>
				<div id="spsRmtj-ajfx-header2">案件分类情况统计明细表</div>
				<div id="spsRmtj-ajfx-header3" class="glyphicon glyphicon-remove-circle"></div>
			</div>
			<div id="spsRmtj-ajfx-left">
				<div id="spsRmtj-ajfx-left-div1">2016</div>
				<div id="spsRmtj-ajfx-left-div2">案件总数</div>
			</div>
			<div id="spsRmtj-ajfx-right">
				<table id="spsRmtj-ajfx-right-table">
					<thead>
						<tr>
							<td>组织<span class="glyphicon glyphicon-triangle-top"></span></td>
							<td>案件<span class="glyphicon glyphicon-triangle-top"></span></td>
							<td>案件<span class="glyphicon glyphicon-triangle-top"></span></td>
							<td>案件<span class="glyphicon glyphicon-triangle-top"></span></td>
							<td>案件<span class="glyphicon glyphicon-triangle-top"></span></td>
							<td>案件<span class="glyphicon glyphicon-triangle-top"></span></td>
							<td>案件<span class="glyphicon glyphicon-triangle-top"></span></td>
							<td>案件<span class="glyphicon glyphicon-triangle-top"></span></td>
							<td>案件<span class="glyphicon glyphicon-triangle-top"></span></td>
							<td>案件<span class="glyphicon glyphicon-triangle-top"></span></td>
							<td>案件<span class="glyphicon glyphicon-triangle-top"></span></td>
							<td>案件<span class="glyphicon glyphicon-triangle-top"></span></td>
							<td>案件<span class="glyphicon glyphicon-triangle-top"></span></td>
							<td>案件<span class="glyphicon glyphicon-triangle-top"></span></td>
							<td>案件<span class="glyphicon glyphicon-triangle-top"></span></td>
						</tr>
					</thead>
					<tbody>
						<tr class="spsRmtj-ajfx-right-table-tr1">
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr class="spsRmtj-ajfx-right-table-tr2">
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr class="spsRmtj-ajfx-right-table-tr1">
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr class="spsRmtj-ajfx-right-table-tr2">
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr class="spsRmtj-ajfx-right-table-tr1">
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr class="spsRmtj-ajfx-right-table-tr2">
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr class="spsRmtj-ajfx-right-table-tr1">
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr class="spsRmtj-ajfx-right-table-tr2">
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr class="spsRmtj-ajfx-right-table-tr1">
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr class="spsRmtj-ajfx-right-table-tr2">
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr class="spsRmtj-ajfx-right-table-tr1">
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr class="spsRmtj-ajfx-right-table-tr2">
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr class="spsRmtj-ajfx-right-table-tr1">
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr class="spsRmtj-ajfx-right-table-tr2">
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	<script type="text/javascript" src="${localCtx}/resources/jss/spsRmtj.js"></script>
</body>
</html>