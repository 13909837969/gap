<%@ page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<title>决策总揽</title>
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<link href="${localCtx}/resources/css/ltrhao-dasOrg.css" rel="stylesheet">
<link href="${localCtx}/resources/css/ltrhao-spsDasbord.css?"<%=Math.random() %>" rel="stylesheet">
<script type="text/javascript"  src="http://echarts.baidu.com/gallery/vendors/echarts/extension/bmap.min.js"></script>
<script type="text/javascript"  src="${localCtx}/json/BoundaryService.js"></script>
<script type="text/javascript"  src="${localCtx}/json/RegionService.js"></script><!-- 区域的管理 -->
<script type="text/javascript"  src="${localCtx}/json/JzJzryjbxxService.js"></script><!-- 矫正人员基本信息表 -->
<script type="text/javascript"  src="${localCtx}/json/RepJzryService.js"></script><!-- 矫正人员部分 -->
<script type="text/javascript"  src="${localCtx}/json/RepJszlService.js"></script><!-- 决策总揽界面部分 -->
<script type="text/javascript"  src="${localCtx}/module/rp/jss/rangSelect.js"></script>
<script type="text/javascript"  src="${localCtx}/resources/jss/new_spsDasbord.js?"<%=Math.random() %>"></script>	 <!-- 检索使用 -->
<style type="text/css">
.ltrhao-body-right1-div21{
	width: 100%;
    height: 30px;
    font-size: 22px;
    color: white;
    text-align:center;
    margin-top: 8%;
	}
.ltrhao-body-left{
    width: 100%;
    border-bottom: 1px solid #557386;
    font-size: 26px;
    color: white;
    top: 10px;
    position: absolute;
}
#ltrhao-body-left1-div121{
    width: 100%;
    border-bottom: 1px solid #557386;
    font-size: 26px;
    color: white;
    top: 10px;
    padding-left: 26%;
    position: absolute;
}
.card-title>span{
	color:#557386;
}
.left_1{
	position: absolute !important;
	color: #fff;
	top: 48%;
	margin-left: 14%;
	padding-right: 11%;
	font-size: 20px; 
	text-align:center;
	border-right: 1px solid #557386;
}
.left_2{
	position: absolute !important;
	color: white;
	top: 48%;
	margin-right:0;
	text-align:center;
	padding-right: 11%;
	font-size: 20px;
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
		<div id="ltrhao-body-left1"  style="height:116px;margin-bottom: 5px;">
			<div class="ltrhao-spsSqjz-body-rightSel-opacity"></div>
			<div>
				<div id="ltrhao-body-left1-div111" class="ltrhao-body-left" style="padding-left: 18%;" >公证案件管理数据</div>
			</div>
			<div id="ltrhao-body-left1-div111_1" class="left_1">
				<div>1300</div>
				<div>机构总数</div>
			</div>
			<div id="ltrhao-body-left1-div111_2"  class="left_2">
				<div>1300</div>
				<div>人员总数</div>
			</div>
		</div>
		<div id="ltrhao-body-left2" style="top:153px;height:116px;">
			<div class="ltrhao-spsSqjz-body-rightSel-opacity"></div>
			<div>
				<div id="ltrhao-body-left2-div121" class="ltrhao-body-left" style="padding-left: 26%;">律师管理数据</div>
			</div>
			<div id="ltrhao-body-left2-div121_1" class="left_1">
				<div>1300</div>
				<div>机构总数</div>
			</div>
			<div id="ltrhao-body-left2-div111_2" class="left_2">
				<div>1300</div>
				<div>人员总数</div>
			</div>
		</div>
		<div id="ltrhao-body-left3" style="top:290px;height:116px;">
			<div class="ltrhao-spsSqjz-body-rightSel-opacity"></div>
			<div>
				<div id="ltrhao-body-left3-div121" class="ltrhao-body-left" style="padding-left: 18%;">司法鉴定管理数据</div>
			</div>
			<div id="ltrhao-body-left3-div121_1" class="left_1">
				<div>1300</div>
				<div>机构总数</div>
			</div>
			<div id="ltrhao-body-left3-div111_2" class="left_2">
				<div>1300</div>
				<div>人员总数</div>
			</div>
		</div>
		<div id="ltrhao-body-left4" style="top:430px;height:116px;">
			<div class="ltrhao-spsSqjz-body-rightSel-opacity"></div>
			<div>
				<div id="ltrhao-body-left4-div141" class="ltrhao-body-left" style="padding-left: 18%;">法律援助管理数据</div>
			</div>
			<div id="ltrhao-body-left4-div121_1" class="left_1">
				<div>1300</div>
				<div>机构总数</div>
			</div>
			<div id="ltrhao-body-left4-div111_2" class="left_2">
				<div>1300</div>
				<div>人员总数</div>
			</div>
		</div>
		
		<div id="ltrhao-body-left5" style="top:560px;height:116px;width:349px;">
			<div class="ltrhao-spsSqjz-body-rightSel-opacity"></div>
			<div>
				<div id="ltrhao-body-left5-div141" class="ltrhao-body-left" style="padding-left: 18%;">社区服刑资源管理</div>
			</div>
			<div id="ltrhao-body-left5-div121_1" class="left_1">
				<div>1300</div>
				<div>机构总数</div>
			</div>
			<div id="ltrhao-body-left5-div111_2" class="left_2">
				<div>1300</div>
				<div>人员总数</div>
			</div>
		</div>
		
		<div id="ltrhao-body-right1" style="height: 653px">
			<div class="ltrhao-spsSqjz-body-rightSel-opacity"></div>
			<div>
				<div id="ltrhao-body-right1-div1" style="color: white;font-size: 28px;text-align:center;">业务实时数据</div>
				<div id="ltrhao-body-right1-div2" style="top: 58px;position: absolute;">
					<div style="margin:30px 0px;">
						<div class = "ltrhao-body-right1-div21" >公证案件办证量：<sapn>200</sapn></div>
						<div class = "ltrhao-body-right1-div21">律师工作案件：<sapn>200</sapn></div>
						<div class = "ltrhao-body-right1-div21">司法鉴定案件：<sapn>200</sapn></div>
						<div class = "ltrhao-body-right1-div21">法律援助案件：<sapn>200</sapn></div>
						<div class = "ltrhao-body-right1-div21">社区服刑人员：<sapn>200</sapn></div>
						<div class = "ltrhao-body-right1-div21">安置帮教对象：<sapn>200</sapn></div>
						<div class = "ltrhao-body-right1-div21">人民调解案件：<sapn>200</sapn></div>
					</div>
				</div>
			</div>
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