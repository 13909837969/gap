<%@ page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>
<html>
<head>
<title>安置帮教</title>
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<link href="${localCtx}/resources/css/ltrhao-dasOrg.css" rel="stylesheet">
<link href="${localCtx}/resources/css/ltrhao-spsAzbj.css" rel="stylesheet">
<script type="text/javascript" src="${localCtx}/resources/jss/spsAzbj.js"></script>
<script type="text/javascript" src="http://echarts.baidu.com/gallery/vendors/echarts/extension/bmap.min.js"></script>
<script type="text/javascript" src="${localCtx}/json/BoundaryService.js"></script>
<script type="text/javascript" src="${localCtx}/json/RegionService.js"></script>
<script type="text/javascript" src="${localCtx}/json/JzJzryjbxxService.js"></script>
<script type="text/javascript">

</script>
</head>
<body>
	<div id="ltrhao-spsAzbj-body-div" >
		<div id="ltrhao-spsAzbj-body-div1">
			<!--全区矫正人员分布情况  -->
			<div>
				<div id="das_mapID"></div>
			</div>
		</div>
		<div id="spsAzbj-container-left1">
			<input id="spsAzbj-container-left1-diva" type="text" placeholder="区域">
			<input id="spsAzbj-container-left1-div2" type="text" class="input-append date form_datetime" placeholder="开始时间">
			<input id="spsAzbj-container-left1-div3" type="text" class="input-append date form_datetime" placeholder="结束日期">
			<input id="spsAzbj-container-left1-div4" type="button" value="查询">
		</div>
		<div id="spsAzbj-container-left2">
			<div class="ltrhao-spsSqjz-body-rightSel-opacity"></div>
			<div>
				<div class="spsAzbj-container-left2-div1">2330人</div>
				<div class="spsAzbj-container-left2-div2">安置帮教对象</div>
				<div class="spsAzbj-container-left2-div3">重点帮教对象</div>
				<div class="spsAzbj-container-left2-div4">543人</div>
				<div class="spsAzbj-container-left2-div5">一般帮教对象</div>
				<div class="spsAzbj-container-left2-div6">550人</div>
			</div>
		</div>
		<div id="spsAzbj-container-left3">
			<div class="ltrhao-spsSqjz-body-rightSel-opacity"></div>
			<div>
				<div class="spsAzbj-container-left2-div1">2330人</div>
				<div class="spsAzbj-container-left2-div2">应衔接人数</div>
				<div class="spsAzbj-container-left2-div3">重点人群</div>
				<div class="spsAzbj-container-left2-div4">543人</div>
				<div class="spsAzbj-container-left2-div5">一般人群</div>
				<div class="spsAzbj-container-left2-div6">550人</div>
			</div>
		</div>
		<div id="spsAzbj-container-left4">
			<div class="ltrhao-spsSqjz-body-rightSel-opacity"></div>
			<div>
				<div class="spsAzbj-container-left2-div1">2330人</div>
				<div class="spsAzbj-container-left2-div2">危险性未评估</div>
				<div class="spsAzbj-container-left2-div3">重点人群</div>
				<div class="spsAzbj-container-left2-div4">543人</div>
				<div class="spsAzbj-container-left2-div5">一般人群</div>
				<div class="spsAzbj-container-left2-div6">550人</div>
			</div>
		</div>
		<div id="spsAzbj-container-left5">
			<div class="ltrhao-spsSqjz-body-rightSel-opacity2"></div>
			<div>
				<span class="glyphicon glyphicon-list-alt"></span>
				<div id="spsAzbj-container-left2-div51">2330人</div>
				<div id="spsAzbj-container-left2-div52">下落不明人数</div>
			</div>
		</div>
		<div id="spsAzbj-container-right1">
			<div class="ltrhao-spsSqjz-body-rightSel-opacity"></div>
			<div>
				<div id="spsAzbj-container-right1-div1">全区安置帮教人员情况
					<span class="glyphicon glyphicon-list" id="spsAzbj-glyphicon-list"></span>
				</div>
				<div id="spsAzbj-container-right1-div3">
					<span id="spsAzbj-container-right1-div3-span1">序号</span>
					<span id="spsAzbj-container-right1-div3-span2">区域</span>
					<span id="spsAzbj-container-right1-div3-span3">帮教对象总数</span>
				</div>
				<div id="spsAzbj-container-right1-div4"  class="spsAzbj-innerbox">
				    	<table  width="100%"   id="azbjTable" class="table table-hover"></table>
				</div>
			</div>
		</div>
		<div id="spsAzbj-container-right2">
			<div class="ltrhao-spsSqjz-body-rightSel-opacity"></div>
			<div>
				<div id="spsAzbj-container-right2-div1">呼和浩特市优秀调解人员总览
					<span class="glyphicon glyphicon-sort-by-attributes-alt" id="spsAzbj-by-attributes-alt"></span>
				</div>
				<div id="spsAzbj-container-right2-div3">
					
				</div>
			</div>
		</div>
		<!--  区域显示隐藏的div  -->
 		<div type="hiden" id="spsAzbj-hidenDiv" style="display:none;">
			<div class="spssjfx-indicate"></div>
			<div id="spsSqjz-hidenDiv-div1">
				<div id="spsSqjz-hidenDiv-div11">区域选择</div>
				<input type="button" class="btn btn-warning"   id="spsSqjz-hidenDiv-qc" value="清除" style="padding:4px 8px;">
				<input type="button" class="btn btn-info"  id="spsSqjz-hidenDiv-qd" value="确定" style="padding:4px 8px;">
				<a href="#"><div id="spsSqjz-hidenDivBtn" class="glyphicon glyphicon-remove-circle" style="opacity:0.7;"></div></a>
			</div>
			<div id="spsSqjz-hidenDivSS"></div>
		</div>
	</div>
</body>
</html>