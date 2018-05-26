<%@ page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>
<!DOCTYPE html>
<head>
<link rel="stylesheet" href="css/viewRepjzryFbqk.css" type="text/css"/>
<title>社区矫正人员数据分析</title>
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<link href="${localCtx}/resources/css/viewRepSqjz.css?<%=Math.random()%>" rel="stylesheet">
<script type="text/javascript" src="http://echarts.baidu.com/gallery/vendors/simplex.js"></script>
<script type="text/javascript" src="${localCtx}/json/RegionService.js"></script>
<script type="text/javascript"  src="${localCtx}/json/RepJzryService.js"></script>
<script type="text/javascript" src="js/viewRepjzryFbqk.js"></script>
</head>
<body>
<!-- 所搜框 -->
<div id="sqjzry-cent" class="container">
  <div id="sqjzry-cent-title" class="row">
    <div id="sqjzry-biati">社区矫正人员数据分析</div>
    <div id="quy-button " class="row quy-button-row">
	  <div id="quy-inputa" class="col-lg-3 col-md-3 col-xs-12 col-sm-12">
	    <span>区域：</span>	
	    <input id="quy-inputa-clickone"   type="text" placeholder="全区域" style="height:30px;color:#d9d9d9;text-align:center;"/> 
	  </div>
	  <div id="quy-inputb" class="col-lg-3 col-md-3 col-xs-12 col-sm-12">
	    <span>机构名称：</span>
	    <input id="quy-inputb-input"  type="text" placeholder="请输入机构名称" style="height:30px;color:#d9d9d9;text-align:center;"/>
	  </div>
	  <div id="quy-inputc" class="col-lg-5 col-md-5 col-xs-12 col-sm-12">
	    <span>查询时间：</span>
	    <input  type="text" id="quy-inputd" class="input-append date form_datetime" placeholder="开始时间"style="height:30px;text-align: center; color:#d9d9d9;"/>
	    <input id="quy-inputda" class="input-append date form_datetime" type="text" placeholder="结束时间"style="height:30px;text-align: center; color:#d9d9d9;"/>
	  </div>
	  <div id="quy-buttonnoe" class="col-lg-1 col-md-1 col-xs-12 col-sm-12">
	    <button id="quy-buttonnoe-cx-button"  type="button" onclick="" style="height:30px;border: 1px solid #e5e5e5; border-radius:3px;">查询</button>
	  </div>
	</div>
  </div>
<!--  结束 -->
<!-- 图表开始 -->
<div id="jzry-shujfx-tub" class="row">
  <div id="jzry-zhuzt" class=" col-md-6 col-sm-12">
	  <div id="jzry-xbfb-xingbfb">
	    <div id="jzry-zhuzt-nlfenb">年龄分布情况</div>
	    <div id="containerzhu" style="height:100%;"></div>
    </div>
  </div>
  <div id="jzry-bingt" class=" col-md-6 col-sm-12">
      <div id="jzry-bing-xbfb">性别分布</div>
      <div id="jzry-xbfb-xingbfb">
	    <div id="containerbing" style="height:100%;"></div>
	</div>
  </div>
  <div id="jzry-dz" class=" col-md-6 col-sm-12">
    <div id="jzry-dz-ryfenbqk">人员分布情况</div>
	<div id="jzry-xbfb-xingbfb1"> 
	  <div id="containerdz"></div>
	</div>
  </div>
  <div id="jzry-whcd" class=" col-md-6 col-sm-12">
      <div id="jzry-quan-whcd">文化程度</div>
      <div id="jzry-xbfb-xingbfb">
	    <div id="containerquan" style="height:100%;"></div>
	</div>
  </div>
</div>
 <!--  区域显示隐藏的div  -->
 		<div type="hiden" id="spssjfx-hidenDiv" style="display:none;">
			<div class="spssjfx-indicate"></div>
			<div id="spsSqjz-hidenDiv-div1">
				<div id="spsSqjz-hidenDiv-div11">区域选择</div>
				<input type="button" class="btn btn-warning"   id="spsSqjz-hidenDiv-qc" value="清除" style="padding:4px 8px;">
				<input type="button" class="btn btn-info"  id="spsSqjz-hidenDiv-qd" value="确定" style="padding:4px 8px;">
				<div id="spsSqjz-hidenDivBtn" class="glyphicon glyphicon-remove-circle" style="opacity:0.7;"></div>
			</div>
			<div id="spsSqjz-hidenDivSS"></div>
		</div>
</div>
</body>
</html>