<%@ page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>
<html>
<head>
<title>人民调解</title>
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<link href="${localCtx}/resources/css/ltrhao-dasOrg.css" rel="stylesheet">
<link href="${localCtx}/resources/css/ltrhao-formRmtj.css" rel="stylesheet">
<script type="text/javascript" src="http://echarts.baidu.com/gallery/vendors/echarts/extension/bmap.min.js"></script>
<script type="text/javascript" src="${localCtx}/json/BoundaryService.js"></script>
<script type="text/javascript" src="${localCtx}/json/RegionService.js"></script>
<script type="text/javascript" src="${localCtx}/json/JzJzryjbxxService.js"></script> 
<script type="text/javascript" src="${localCtx}/json/Rep_Rmtj_Test.js"></script><!-- 静态页面使用 -->
<%-- <script type="text/javascript" src="${localCtx}/resources/jss/spsRmtj.js"></script> --%>
<!-- 测试版使用  spsRmtj.js 即可  ，
	   正式版本使用  spsRmtj2.0.js 需要从后台配置 省的编码  例如：内蒙古自治区 的编码： 150000【默认设置】 
	   【配置地址： module/sps/formParameter.jsp】 【注：需要考虑 时间的关系问题】-->
<script type="text/javascript" src="${localCtx}/resources/jss/spsRmtj2.0.js"></script>
<style>

</style>
</head>
<body>
	<div id="ltrhao-formRmtj-body-div" >
		<div id="ltrhao-formRmtj-body-div1">
			<!--全区矫正人员分布情况  -->
			<div>
				<div id="das_mapID"></div>
			</div>
		</div>
		<!-- 查询按钮 -->
		<!-- <div id="container-left1">
			<input id="container-left1-div1" type="text" placeholder="区域">
			<input id="container-left1-div2" type="text" class="input-append date form_datetime" placeholder="开始时间">
			<input id="container-left1-div3" type="text" class="input-append date form_datetime" placeholder="结束日期">
			<input id="container-left1-div4" type="button" value="查询">
		</div> -->
		<!-- 查询按钮结束 -->
		<div id="container-left2">
		  <div class="ltrhao-spsSqjz-body-rightSel-opacity"></div>
		  <div>
			<div id="container-left2-div1"class="col-sm-2">
				<div id="container-left2-div11"><a href="${localCtx}/module/rep/viewRepAnjqk.jsp">人民调解案件数据</a></div>
			</div>
			<div id="container-left2-div2" class="col-sm-8">
			    <div style="margin:0 auto;">
					<div id="container-left2-div21" class="col-sm-3">
						<a href="#"><div class="container-left2-div241">调解案件总数<span id="anjian" class="container-left2-div2-span">105942</span></div></a>
						<a href="#"><div class="container-left2-div242">调委会总数<span id="jigou" class="container-left2-div2-span">16495</span></div></a>
					</div>
					<div id="container-left2-div22" class="col-sm-3">
						<a href="#"><div class="container-left2-div241">人民调解员总数<span id="renyuan" class="container-left2-div2-span">73458</span></div></a>
						<a href="#"><div class="container-left2-div242">调解成功总数<span id="chenggong" class="container-left2-div2-span">99658</span></div></a>
					</div>
					<div id="container-left2-div23" class="col-sm-3">
						<a href="#"><div class="container-left2-div241">口头协议<span id="koutou" class="container-left2-div2-span">57693</span></div></a>
						<a href="#"><div class="container-left2-div242">书面协议<span id="shumian" class="container-left2-div2-span">42781</span></div></a>
					</div>
					<div id="container-left2-div24" class="col-sm-3">
						<a href="#"><div class="container-left2-div241">主动调解<span id="zhudong" class="container-left2-div2-span">25573</span></div></a>
						<a href="#"><div class="container-left2-div242">依申请调解<span id="yishen" class="container-left2-div2-span">77114</span></div></a>
					</div>
			   </div>
		   </div>
		   <div id="container-left2-div3" class="col-sm-2">
		   	   <div id="container-left2-div32">协议涉及金额</div>
			   <div class="container-left2-div2-span" id="jine">291004.68万元</div>
		   </div>
	  </div>
	</div>
	
		
		<div id="container-right1">
		  <div class="ltrhao-spsSqjz-body-rightSel-opacity"></div>
		  <div>
			<div id="container-right1-div1">全区人民调解工作总览<span class="glyphicon glyphicon-user" id="glyphicon-user"></span></div>
			<div id="container-right1-div3">
				<span id="container-right1-div3-span1">序号 </span>
				<span id="container-right1-div3-span2">区域</span>
				<span id="container-right1-div3-span3">工作量</span>
				<span id="container-right1-div3-span333">占比</span>
				<span id="container-right1-div3-span4">增长率</span>
			</div>
	       <div  id="container-right1-div4" >
	         	<table  style="width:100%;"   id="rmtjTable" class="table table-hover"></table>
	       </div>
	      </div>
		</div>
		<div id="container-right2">
		  <div class="ltrhao-spsSqjz-body-rightSel-opacity"></div>
		  <div>
			<div id="container-right2-div1">全区优秀调解人员总览<span class="glyphicon glyphicon-random" id="glyphicon-random"></span></div>
			<div id="container-right2-div3">
				<span id="container-right2-div3-span1">序号</span>
				<span id="container-right2-div3-span5">姓名</span>
				<span id="container-right2-div3-span2">区域</span>
				<span id="container-right2-div3-span3">占比</span>
				<span id="container-right2-div3-span4">成功率</span>
			</div>
			<div id="container-right2-div4"></div>
		  </div>
		</div>
		 <!--  区域显示隐藏的div
 		<div type="hiden" id="spssqjz-hidenDiv" style="display:none;">
			<div class="spssjfx-indicate"></div>
			<div id="spsSqjz-hidenDiv-div1">	
				<div id="spsSqjz-hidenDiv-div11">区域选择</div>
				<input type="button" class="btn btn-warning"   id="spsSqjz-hidenDiv-qc" value="清除" style="padding:4px 8px;">
				<input type="button" class="btn btn-info"  id="spsSqjz-hidenDiv-qd" value="确定" style="padding:4px 8px;">
				<div id="spsSqjz-hidenDivBtn" class="glyphicon glyphicon-remove-circle" style="opacity:0.7;"></div>
			</div>
			<div id="spsSqjz-hidenDivSS"></div>
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
	
	
	
	<!-- <script type="text/javascript">
	$(function(){
		//调解案件总数定义单击按钮事件
		$("#container-left2-div11").unbind("click").bind("click",function(){
			location.href="${localCtx}/module/rep/viewRepAnjqk.jsp?token=${param.token}";
		});
	});
	</script> -->
</body>
</html>