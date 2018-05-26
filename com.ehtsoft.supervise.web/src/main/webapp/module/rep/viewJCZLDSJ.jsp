<%@ page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<title>决策总揽大数据展示</title>
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<link href="${localCtx}/resources/css/ltrhao-dasOrg.css" rel="stylesheet">
<link href="css/ltrhao-spsDasbird2.css?"<%=Math.random() %>" rel="stylesheet">
<script type="text/javascript"  src="http://echarts.baidu.com/gallery/vendors/echarts/extension/bmap.min.js"></script>
<script type="text/javascript"  src="${localCtx}/json/BoundaryService.js"></script>
<script type="text/javascript"  src="${localCtx}/json/RegionService.js"></script><!-- 区域的管理 -->
<script type="text/javascript"  src="${localCtx}/json/JzJzryjbxxService.js"></script><!-- 矫正人员基本信息表 -->
<script type="text/javascript"  src="${localCtx}/json/RepJzryService.js"></script><!-- 矫正人员部分 -->
<script type="text/javascript"  src="${localCtx}/json/RepJszlService.js"></script><!-- 决策总揽界面部分 -->
<script type="text/javascript"  src="${localCtx}/module/rp/jss/rangSelect.js"></script>
<script type="text/javascript"  src="js/spsDasbord2.js?"<%=Math.random() %>"></script>	 <!-- 检索使用 -->
<style type="text/css">
#sdfsdfgsd{
	width:450px;
	height:30px;
	position:absolute;
	top:54%;
	left:10px;
}
</style>
</head>
<body>
	<div id="ltrhao-body-div">
		<div style="height:100%;width:100%;">
			<!--全区矫正人员分布情况  -->
			<div>
				<div id="das_mapID" style="height: 100%"></div>
			</div>
		</div>
		<div id="ltrhao-body-left1"  >
			<div class="ltrhao-spsSqjz-body-rightSel-opacity"></div>
			<div>
				<div style="width:120px;position:absolute;left:0px;top:0px;bottom:0px;">
					<div id="ltrhao-body-left1-div11"></div>
					<div id="ltrhao-body-left1-div12" >矫正人员总览</div>
				</div>
				<div style="width:330px;height:100%;position:absolute;right:0px;">
					
					<div class="ltrhao-body-left1-div12-box1">
						<div id="ltrhao-body-left1-div15">400人</div>
						<div id="ltrhao-body-left1-div13">管制数量</div>
					</div>
					<div class="ltrhao-body-left1-div12-box2">
						<div id="ltrhao-body-left1-div16">13846人</div>
						<div id="ltrhao-body-left1-div14">缓刑数量</div>
					</div>
					<div class="ltrhao-body-left1-div12-box3">
						<div id="ltrhao-body-left1-div17">82人</div>
						<div id="ltrhao-body-left1-div18">假释数量</div>
					</div>
					<div class="ltrhao-body-left1-div12-box4">
						<div id="ltrhao-body-left1-div19">244人</div>
						<div id="ltrhao-body-left1-div20">暂予监外执行数量</div>
					</div>
					
				</div>
			</div>
		</div>
		<div id="ltrhao-body-left2">
			<div class="ltrhao-spsSqjz-body-rightSel-opacity"></div>
			<div>
				<div id="ltrhao-body-left2-div1">
					<div id="ltrhao-body-left2-div11">律师工作总览</div>
				</div>
				<div id="ltrhao-body-left2-div2">
					<div id="ltrhao-body-left2-div21">案件办理</div>
					<div id="ltrhao-body-left2-div22"></div>
					<div id="ltrhao-body-left2-div23">同比增长</div>
					<div id="ltrhao-body-left2-div24"></div>
				</div>
			</div>
		</div>
		<div id="ltrhao-body-left3">
			<div class="ltrhao-spsSqjz-body-rightSel-opacity"></div>
			<div>
				<div id="ltrhao-body-left3-div1">
					<div id="ltrhao-body-left3-div11">法律援助总览</div>
				</div>
				<div id="ltrhao-body-left3-div2">
					<div id="ltrhao-body-left3-div21">承办案件总计</div>
					<div id="ltrhao-body-left3-div22">29254件</div>
					<div id="ltrhao-body-left3-div23">同比增长</div>
					<div id="ltrhao-body-left3-div24"></div>
				</div>
			</div>
		</div>
		
		
		<div id="ltrhao-body-left4">
			<div class="ltrhao-spsSqjz-body-rightSel-opacity"></div>
			<di		v>
				<div id="ltrhao-body-left4-div1">
					<div id="ltrhao-body-left4-div11">
						<div id="ltrhao-body-left4-div111">法律宣传</div>
					</div>
					<div id="ltrhao-body-left4-div12">
						<div id="ltrhao-body-left4-div121">队伍宣传总数</div>
						<div id="ltrhao-body-left4-div122">84693人</div>
						<div id="ltrhao-body-left4-div123">队伍建设总数</div>
						<div id="ltrhao-body-left4-div124">76464人</div>
					</div>
				</div>
				<div class="ltrhao-body-left4-div33">
					<div class="ltrhao-body-left4-div22">
						<div id="ltrhao-body-left4-div2">专职队伍数</div>
						<div id="ltrhao-body-left4-div3"></div>
					</div>
					<div class="ltrhao-body-left4-div44">
						<div id="ltrhao-body-left4-div4">兼职队伍数</div>
						<div id="ltrhao-body-left4-div5"></div>
					</div>
				</div>
			</div>
		</div>
		
		
		
		<div id="ltrhao-body-left5" style="width:40%;">
			<div class="ltrhao-spsSqjz-body-rightSel-opacity"></div>
			<div>
				<div id="ltrhao-body-left5-div1">
					<a href="../rep/viewZyqk.jsp"><div id="ltrhao-body-left5-div11">机构<br>建设</div></a>
				</div>
				<div id="ltrhao-body-left5-div2" style="width:100%;">
				
				</div>
			</div>
		</div>
		<div id="ltrhao-body-right1">
			<div class="ltrhao-spsSqjz-body-rightSel-opacity"></div>
			<div>
				<div id="ltrhao-body-right1-div1">
					<div id="ltrhao-body-right1-div11">
						<div id="ltrhao-body-right1-div111">安置帮教</div>
					</div>
					<div id="ltrhao-body-right1-div12">衔接人员总数</div>
					<div id="ltrhao-body-right1-div13"></div>
					<div id="ltrhao-body-right1-div14">安置率</div>
					<div id="ltrhao-body-right1-div15">94.7%</div>
					<!-- <div id="ltrhao-body-right1-div16">帮助率</div>
					<div id="ltrhao-body-right1-div17">100%</div> -->
				</div>
				<div id="ltrhao-body-right1-div2" style="top:58px;"></div>
			</div>
		</div>
		
		<div id="ltrhao-body-right2">
			<div class="ltrhao-spsSqjz-body-rightSel-opacity"></div>
			<div>
				<div id="ltrhao-body-right2-div1">
					<div id="ltrhao-body-right2-div11">
						<div id="ltrhao-body-right2-div111">人民调解</div>
					</div>
					<div id="ltrhao-body-right2-div12">调解案件总数</div>
					<div id="ltrhao-body-right2-div13"></div>
					<div id="ltrhao-body-right2-div14">调解成功</div>
					<div id="ltrhao-body-right2-div15"></div>
				</div>
				<div id="ltrhao-body-right2-div2"></div>
			</div>
		</div>
		
		<div id="ltrhao-body-left9">
			<div class="ltrhao-spsSqjz-body-rightSel-opacity"></div>
			<div>
				<div id="ltrhao-body-left9-div1">
					<div id="ltrhao-body-left9-div11">
						<div id="ltrhao-body-left9-div111">司法鉴定</div>
					</div>
					<div id="ltrhao-body-left9-div12">
						<div class="ltrhao-body-left9-div1111">
							<div id="ltrhao-body-left9-div121">鉴定业务</div>
							<div id="ltrhao-body-left9-div122">21950件</div>
						</div>
						<div class="ltrhao-body-left9-div1112">
							<div id="ltrhao-body-left9-div123">同比增长</div>
							<div id="ltrhao-body-left9-div124">40.08%</div>
						</div>
					</div>
					<div id="ltrhao-body-left9-div125">
						
					</div>
				</div>
			</div>
		</div>
		<div id="sdfsdfgsd"></div>
		
		<div id="ltrhao-body-right3"  style= "width:40%;">
			<div class="ltrhao-spsSqjz-body-rightSel-opacity"></div>
			<div>
				<div id="ltrhao-body-right3-div1">
					<div id="ltrhao-body-right3-div11">工作<br>人员</div>
				</div>
				<div id="ltrhao-body-right3-div2" style= "width:100%;">
					
				</div>
			</div>
		</div>
				<div id="container-right4"  class="panel panel-default">
					<input id="searchbtn"   class="btn btn-info btn-sm center-block"  type="button"   value="查询"
						style="float: right; width: 40px; height: 80px;text-align:left;">
					<input id="inputQyDiv"    class="form-control"   type="text"   placeholder="选择区域"
						style="width: 120px; height: 26px;position: relative; bottom: 80px; text-align: center;">
					<input type="text" class="form-control input-append date form_datetime" placeholder="开始时间"
						data-date-format="yyyy-MM-dd" id="formDasbord-kssj"
						style="width: 120px; height: 27px; border: 1px soild #03A9F4; position: relative; bottom: 80px;text-align: center;">
					<input type="text" class="form-control input-append date form_datetime" placeholder="结束时间"
						data-date-format="yyyy-MM-dd"  id="formDasbord-jssj"
						style="width: 120px; height: 27px; border: 1px soild #03A9F4; position: relative; bottom: 80px;text-align: center;">
				</div>
	</div>
	<!--区域矫正人员情况详情  -->
				<div class="rangDitail" id="rangDitail" style="display:none;left:10px;top:30px;">
					<div class="ltrhao-spsSqjz-body-rightSel-opacity"></div>
					<div>
						<div class="panel panelDitail">
							<!-- Default panel contents -->
							<div style=" background:#f0f3f5;"><span class="city-name" style="margin-top:5px; color:#fff;">呼和浩特市</span><span class="province-name" style="color:#fff;">综合排名</span></div>
							<div class="panel-body ditail-body">
								<div class="col-xs-6">
									<div class="card" style="border-radius:5px;">
										<div class="card-title">
											<span class="text" style="color:#fff;font-size:18px;">矫正人员管理比例</span>
											<span class="detail-icon"></span>
										</div>
										   <div id="dasbord-jz-chart" style="height:200px;width:300px;margin:0 auto; top:10px;"></div>
										</div>
								</div>
								<div class="col-xs-6">
									<div class="card" style="border-radius:5px;">
										<div class="card-title">
											<span class="text" style="color:#fff; font-size:18px;">报警情况处理情况</span>
										</div>
											<div id="dasbord_az_chart" style="height:200px;width:300px;margin:0 auto;top:10px;"></div>
										</div>
                                </div>
                                <div class="col-xs-6">
									<div class="card" style="border-radius:5px;">
										<div class="card-title">
											<span class="text" style="color:#fff;font-size:18px;">人民调解处理情况</span>
											<span class="detail-icon"></span>
										</div>
											<div id="dasbord_rm_chart" style="margin: 20px 0px;height:200px;width:300px;margin:0 auto;top:10px;"></div>
										</div>
								</div>
								<div class="col-xs-6">
									<div class="card" style="border-radius:5px;">
										<div class="card-title">
											<span class="text" style="color:#fff;font-size:18px;">安置帮教情况</span>
											<span class="detail-icon"></span>
										</div>
											<div id="dasbord_fx_chart" style="margin: 20px 0px;height:200px;width:300px;margin:0 auto;top:10px;"></div>
										</div>
                                	</div>
								</div>
							</div>
						</div>
					</div>
	<!--  区域显示隐藏的div  -->
 		<div type="hiden" id="spssjfx-hidenDiv" style="display:none;width: 27%;">
			<div class="spssjfx-indicate"></div>
			<div id="spsSqjz-hidenDiv-div1">
				<div id="spsSqjz-hidenDiv-div11">区域选择</div>
				<input type="button" class="btn btn-warning"   id="spsSqjz-hidenDiv-qc" value="清除" style="padding:4px 8px;">
				<input type="button" class="btn btn-info"  id="spsSqjz-hidenDiv-qd" value="确定" style="padding:4px 8px;">
				<div id="spsSqjz-hidenDivBtn" class="glyphicon glyphicon-remove-circle" style="opacity:0.7;"></div>
			</div>
			<div id="spsSqjz-hidenDivSS"></div>
		</div>

</body>
</html>
