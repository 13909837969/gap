<%@ page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<title>决策总揽大数据展示</title>
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<link href="${localCtx}/resources/css/ltrhao-dasOrg.css" rel="stylesheet">
<link href="css/new_ltrhao-spsDasbird2.css?"<%=Math.random() %>" rel="stylesheet">
<script type="text/javascript"  src="http://echarts.baidu.com/gallery/vendors/echarts/extension/bmap.min.js"></script>
<script type="text/javascript"  src="${localCtx}/json/BoundaryService.js"></script>
<script type="text/javascript"  src="${localCtx}/json/RegionService.js"></script><!-- 区域的管理 -->
<script type="text/javascript"  src="${localCtx}/json/JzJzryjbxxService.js"></script><!-- 矫正人员基本信息表 -->
<script type="text/javascript"  src="${localCtx}/json/RepJzryService.js"></script><!-- 矫正人员部分 -->
<script type="text/javascript"  src="${localCtx}/json/RepJszlService.js"></script><!-- 决策总揽界面部分 -->
<script type="text/javascript"  src="${localCtx}/module/rp/jss/rangSelect.js"></script>
<script type="text/javascript"  src="js/new_spsDasbord2.js?"<%=Math.random() %>"></script>	 <!-- 检索使用 -->
<style type="text/css">
#sdfsdfgsd{
	width:450px;
	height:30px;
	position:absolute;
	top:37%;
	left:10px;
}
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
#ltrhao-body-right11111{
	position:absolute;
	width:395px;
	right:15px;
	top:20px;
	
}
/*决策总览右侧实时数据*/
#ltrhao-body-sssj{
	position:absolute;
	width:395px;
	right:15px;
	top:75px;
	
}
.jczl_gz{
   background:#FFC957;
   width:170px;
   color:#333
}
</style>
<script type="text/javascript">
$(document).ready(function() {
var monthNames = [ "1月", "2月", "3月", "4月", "5月", "6月", "47月", "8月", "9月", "10月", "11月", "12月" ]; 
var newDate = new Date();
newDate.setDate(newDate.getDate());
$('#Date').html(newDate.getFullYear() + '年' + monthNames[newDate.getMonth()]+newDate.getDate()+ '日');
setInterval( function() {
	var seconds = new Date().getSeconds();
	$("#sec").html(( seconds < 10 ? "0" : "" ) + seconds);
	},1000);
	
setInterval( function() {
	var minutes = new Date().getMinutes();
	$("#min").html(( minutes < 10 ? "0" : "" ) + minutes);
    },1000);
	
setInterval( function() {
	var hours = new Date().getHours();
	$("#hours").html(( hours < 10 ? "0" : "" ) + hours);
    }, 1000);
	
}); 
</script>
</head>
<body>
	<div id="ltrhao-body-div">
		<div style="height:100%;width:100%;">
			<!--全区矫正人员分布情况  -->
			<div>
				<div id="das_mapID" style="height: 100%"></div>
			</div>
		</div>
		<!-- <div id="ltrhao-body-left1"  >
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
		</div> -->
		<div id="ltrhao-body-left2">
			<div class="ltrhao-spsSqjz-body-rightSel-opacity"></div>
			<div>
				<div id="ltrhao-body-left2-div1">
					<div id="ltrhao-body-left2-div11">公证案件管理数据</div>
				</div>
				<div id="ltrhao-body-left2-div2">
					<div id="ltrhao-body-left2-div21">机构总数</div>
					<div id="ltrhao-body-left2-div22"></div>
					<div id="ltrhao-body-left2-div23">人员总数</div>
					<div id="ltrhao-body-left2-div24"></div>
				</div>
			</div>
		</div>
		<div id="ltrhao-body-left3">
			<div class="ltrhao-spsSqjz-body-rightSel-opacity"></div>
			<div>
				<div id="ltrhao-body-left3-div1">
					<div id="ltrhao-body-left3-div11">律师管理数据</div>
				</div>
				<div id="ltrhao-body-left3-div2">
					<div id="ltrhao-body-left3-div21">机构总数</div>
					<div id="ltrhao-body-left3-div22"></div>
					<div id="ltrhao-body-left3-div23">人员总数</div>
					<div id="ltrhao-body-left3-div24"></div>
				</div>
			</div>
		</div>
		
		
		<div id="ltrhao-body-left4">
			<div class="ltrhao-spsSqjz-body-rightSel-opacity"></div>
			<div>
				<div id="ltrhao-body-left4-div1">
					<div id="ltrhao-body-left4-div11">
						<div id="ltrhao-body-left4-div111">法律援助案件</div>
					</div>
					<div id="ltrhao-body-left4-div12">
						<!-- <div id="ltrhao-body-left4-div121">人员总数</div>
						<div id="ltrhao-body-left4-div122">84693人</div>
						<div id="ltrhao-body-left4-div123">机构总数</div>
						<div id="ltrhao-body-left4-div124">1212个</div> -->
					</div>
				</div>
				<div class="ltrhao-body-left4-div33">
					<div class="ltrhao-body-left4-div22">
						<div id="ltrhao-body-left4-div2">人员总数</div>
						<div id="ltrhao-body-left4-div3"></div>
					</div>
					<div class="ltrhao-body-left4-div44">
						<div id="ltrhao-body-left4-div4">机构总数</div>
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
						<div id="ltrhao-body-right1-div111">安置帮教对象</div>
					</div>
					<div style="width:320px;position:absolute;right:0;height:60px;">
						<div id="ltrhao-body-right1-div12">人员总数</div>
						<div id="ltrhao-body-right1-div13"></div>
						<div id="ltrhao-body-right1-div14">机构总数</div>
						<div id="ltrhao-body-right1-div15">1254个</div>
					</div>
					<!-- <div id="ltrhao-body-right1-div16">帮助率</div>
					<div id="ltrhao-body-right1-div17">100%</div> -->
				</div>
				<div id="ltrhao-body-right1-div2" style="top:58px;"></div>
			</div>
		</div>
		
		<!-- <div id="ltrhao-body-right2">
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
		</div> -->
		
		<div id="ltrhao-body-left9">
			<div class="ltrhao-spsSqjz-body-rightSel-opacity"></div>
			<div>
				<div id="ltrhao-body-left9-div1">
					<div id="ltrhao-body-left9-div11">
						<div id="ltrhao-body-left9-div111">司法鉴定管理数据</div>
					</div>
					<div id="ltrhao-body-left9-div12">
						<div class="ltrhao-body-left9-div1111">
							<div id="ltrhao-body-left9-div121">机构总数</div>
							<div id="ltrhao-body-left9-div122">21950个</div>
						</div>
						<div class="ltrhao-body-left9-div1112">
							<div id="ltrhao-body-left9-div123">人员总数</div>
							<div id="ltrhao-body-left9-div124">1300</div>
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
				<!-- <div id="container-right4"  class="panel panel-default">
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
				</div> -->
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
					<!-- 全区 -->
	<div id="ltrhao-body-right11111" style="height: 50px;">
		<div class="ltrhao-spsSqjz-body-rightSel-opacity"></div>
		<div>
			<div id="ltrhao-body-right1-div1321"
				style="color: #fff; font-size: 28px; padding: 8px 20px; position: absolute;">
			        <span id="Date"></span>
					<span id="hours"></span>
					<span id="point">:</span>
					<span id="min"></span>
					<span id="point">:</span>
					<span id="sec"></span>

			</div>
		</div>
	</div>
		 <div id="ltrhao-body-sssj" style="height:450px;">
			<div class="ltrhao-spsSqjz-body-rightSel-opacity"></div>
			<div>
				<div id="ltrhao-body-right1-div1321" style="color:#fff;font-size:28px;padding:10px 70px;position:absolute;">主要业务实时大数据</div>
				<div id="ltrhao-body-right1-div1322" style="top: 58px;position: absolute;">
					<div style="margin-left:10px;">
						<div class = "ltrhao-body-right1-div21"><span>公证案件办证量：</span><sapn class='jczl_gz'>200件</sapn></div>
						<div class = "ltrhao-body-right1-div21"><span>律师工作案件数：</span><sapn class='jczl_gz'>200件</sapn></div>
						<div class = "ltrhao-body-right1-div21"><span>司法鉴定案件数：</span><sapn class='jczl_gz'>200件</sapn></div>
						<div class = "ltrhao-body-right1-div21"><span>法律援助案件数：</span><sapn class='jczl_gz'>200件</sapn></div>
						<div class = "ltrhao-body-right1-div21"><span>社区服刑人员数：</span><sapn class='jczl_gz'>200人</sapn></div>
						<div class = "ltrhao-body-right1-div21"><span>安置帮教对象数：</span><sapn class='jczl_gz'>200人</sapn></div>
						<div class = "ltrhao-body-right1-div21"><span>人民调解案件数：</span><sapn class='jczl_gz'>200件</sapn></div>
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
