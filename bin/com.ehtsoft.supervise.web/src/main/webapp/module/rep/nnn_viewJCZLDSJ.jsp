<%@ page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<title>决策总揽大数据展示</title>
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<link href="${localCtx}/resources/css/ltrhao-dasOrg.css" rel="stylesheet">
<link href="css/new_ltrhao-spsDasbird3.css?"<%=Math.random() %>" rel="stylesheet">
<script type="text/javascript"  src="http://echarts.baidu.com/gallery/vendors/echarts/extension/bmap.min.js"></script>
<script type="text/javascript"  src="${localCtx}/json/BoundaryService.js"></script>
<script type="text/javascript"  src="${localCtx}/json/RegionService.js"></script><!-- 区域的管理 -->
<script type="text/javascript"  src="${localCtx}/json/JzJzryjbxxService.js"></script><!-- 矫正人员基本信息表 -->
<script type="text/javascript"  src="${localCtx}/json/RepJzryService.js"></script><!-- 矫正人员部分 -->
<script type="text/javascript"  src="${localCtx}/json/RepJszlService.js"></script><!-- 决策总揽界面部分 -->
<script type="text/javascript"  src="${localCtx}/module/rp/jss/rangSelect.js"></script>
 <!-- <script type="text/javascript"  src="js/new_spsDasbord3.js?"<%=Math.random() %>"></script>	 检索使用 -->
<!-- 测试版使用  new_spsDasbord3.js 即可  ，
	   正式版本使用  new_spsDasbord2.0.js 需要从后台配置 省的编码  例如：内蒙古自治区 的编码： 150000【默认设置】 
	   【配置地址： module/sps/formParameter.jsp】 【注：需要考虑 时间的关系问题】-->
<script type="text/javascript"  src="js/new_spsDasbord2.0.js?"<%=Math.random() %>"></script>	 
<script type="text/javascript"  src="${localCtx}/json/Rep_Rmtj_Test.js"></script>
<style type="text/css">
a:link {
 text-decoration: none;
 color:#fff;
}
a:visited {
 text-decoration: none;
 color:#fff;
}
a:hover {
 text-decoration: none;
 color:#fff;
}
a:active {
 text-decoration: none;
 color:#fff;
}
.ltrhao-body-left2-hoveraa{
	background-color:#666;
}
.ltrhao-body-left2-hoveraa a:hover div{
	background-color:#666;
	border-radius:4px 0px 0px 4px;
	transition:0.5s all;
}
#li1,#li2,#li3,#li4,#li5,#li6,#li7,#li8,#li9,#li10,#li11,#li12,#li13,#li14{
	color:#ede43e;
	padding-left:4px;
	}
#sdfsdfgsd{
	width:450px;
	height:20px;
	position:absolute;
	top:25%;
	left:10px;
}
#sdfsdfgsd2{
	width:450px;
	height:20px;
	position:absolute;
	top:84px;
	left:10px;
}
#sdfsdfgsd3{
	width:450px;
	height:20px;
	position:absolute;
	top:40%;
	left:10px;
}
#sdfsdfgsd4{
	width:450px;
	height:20px;
	position:absolute;
	top:55%;
	left:10px;
}
.ltrhao-body-right1-div21{
	width: 100%;
    height: 30px;
    font-size:24px;
    float:left;
    color: #fff;
    text-align:center;
    margin-top: 8%;
	}
.ltrhao-body-right1-div21 span{
	float:left;
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
	width:450px;
	right:15px;
	top:40px;
	
}
.ltrhao-body-left2-title{
	width:450px;
	height:50px;
	background:#0b0d0f;
	font-size:24px;
	border-radius:4px;
	color:#fff;
	position:absolute;
	line-height:50px;
	top:40px;
	left:10px;
	text-align:center;
	opacity: 0.9;
}
/*决策总览右侧实时数据*/
#ltrhao-body-sssj{
	position:absolute;
	width:450px;
	right:15px;
	top:100px;
	
}
.jczl_gz{
	margin-left:20px;
    background:#FFC957;
    width:170px;
    padding:4px 80px;
    color:#333;
    float:left;
    border-radius:4px;
}
.ltrhao-body-right1-div222{
	float:left;
	width:190px;
}
</style>
<script type="text/javascript">
$(document).ready(function() {
var monthNames = [ "1月", "2月", "3月", "4月", "5月", "6月", "7月", "8月", "9月", "10月", "11月", "12月" ]; 
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
		<div class="ltrhao-body-left2-title">监管对象数据</div>
		<div id="ltrhao-body-left2">
			<div class="ltrhao-spsSqjz-body-rightSel-opacity"></div>
			<div class="ltrhao-body-left2-hoveraa">
				<a href="#"><div id="ltrhao-body-left2-div1" class="left-item">
					<div id="ltrhao-body-left2-div11">监狱服刑人员</div>
				</div></a>
				<div id="ltrhao-body-left2-div2">
					<div id="ltrhao-body-left2-div24"></div>
				</div>
			</div>
		</div>
		<div id="ltrhao-body-left3">
			<div class="ltrhao-spsSqjz-body-rightSel-opacity"></div>
			<div class="ltrhao-body-left2-hoveraa">
				<a href="#">
					<div id="ltrhao-body-left3-div1" class="left-item">
						<div id="ltrhao-body-left3-div11">强制隔离戒毒人员</div>
					</div>
				</a>
				<div id="ltrhao-body-left3-div2">
					<div id="ltrhao-body-left3-div24"></div>
				</div>
			</div>
		</div>
		<div id="ltrhao-body-left11">
			<div class="ltrhao-spsSqjz-body-rightSel-opacity"></div>
			<div class="ltrhao-body-left2-hoveraa">
				<a href="#">
					<div id="ltrhao-body-left11-div1" class="left-item">
						<div id="ltrhao-body-left11-div11">社区服刑人员</div>
					</div>
				</a>
				<div id="ltrhao-body-left11-div2">
					<div id="ltrhao-body-left11-div24"></div>
				</div>
			</div>
		</div>
		<div id="ltrhao-body-left10">
			<div class="ltrhao-spsSqjz-body-rightSel-opacity"></div>
			<div class="ltrhao-body-left2-hoveraa">
				<a href="#">
					<div id="ltrhao-body-left10-div1" class="left-item">
						<div id="ltrhao-body-left10-div11">安置帮教人员</div>
					</div>
				</a>
				<div id="ltrhao-body-left10-div2">
					<div id="ltrhao-body-left10-div24"></div>
				</div>
			</div>
		</div>
		<div id="ltrhao-body-left5" style="width:99%;">
			<div class="ltrhao-spsSqjz-body-rightSel-opacity"></div>
			<div>
				<div id="ltrhao-body-left5-div1">
					<a href="../rep/viewZyqk.jsp"><div id="ltrhao-body-left5-div11">法律服务机构人员数据</div></a>
				</div>
				<div class="row" id="ltrhao-body-left5-div125" style="margin-left:0px;margin-right:0px;position:absolute;">
					<ul style="width:100%;float:left;padding-left:44px;">
						<li><a href="#">
							<span>律师事务所<span id="li1">0</span></span>
							</a>
							<a href="#">
							<p>律师<span id="li2">0</span></p>
							</a>
						</li>
						<li><a href="#"><span>公证处<span id="li3">0</span></span></a><a href="#"><p>公证员<span id="li4">0</span></p></a></li>
						<li><a href="#"><span>司法鉴定机构<span id="li5">0</span></span></a><a href="#"><p>司法鉴定人员<span id="li6">0</span></p></a></li>
						<li><a href="#"><span>人民调解委员会<span id="li7">0</span></span></a><a href="#"><p>人民调解员<span id="li8">0</span></p></a></li>
						<li><a href="#"><span>法律援助中心<span id="li9">0</span></span></a><a href="#"><p>法律援助律师<span id="li10">0</span></p></a></li>
						<li><a href="#">司法所<span id="li11">0</span></span></a><a href="#"><p>司法所工作人员<span id="li12">0</span></p></a></li>
						<li><a href="#">基层法律服务所<span id="li13">0</span></span></a><a href="#"><p>基层法律服务工作者<span id="li14">0</span></p></a></li>
					</ul>
				</div>
			</div>
		</div>
	</div>
	<div id="sdfsdfgsd"></div>
	<div id="sdfsdfgsd2"></div>
	<div id="sdfsdfgsd3"></div>
	<div id="sdfsdfgsd4"></div>
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
			<div id="ltrhao-body-right1-div1321" style="color: #fff; font-size: 28px; padding: 8px 20px; position: absolute;padding-left:59px;">
			        <span id="Date"></span>
					<span id="hours"></span>
					<span id="point">:</span>
					<span id="min"></span>
					<span id="point">:</span>
					<span id="sec"></span>
			</div>
		</div>
	</div>
		 <div id="ltrhao-body-sssj" style="height:59%;">
			<div class="ltrhao-spsSqjz-body-rightSel-opacity"></div>
			<div>
				<div id="ltrhao-body-right1-div1321" style="color:#fff;font-size:28px;padding-left:110px;padding-top:12px;position:absolute;height:40px;">主要业务实时大数据</div>
				<div id="ltrhao-body-right1-div1322" style="top: 58px;position: absolute;">
					<div style="margin-left:30px;">
						<div class = "ltrhao-body-right1-div21">
							<span>公证案件办证量</span><div class="ltrhao-body-right1-div222"><sapn class='jczl_gz' id="gz1">73250</span><span>件</sapn></div>
						</div>
						<div class = "ltrhao-body-right1-div21">
							<span>律师办理案件数</span><div class="ltrhao-body-right1-div222"><sapn class='jczl_gz' id="gz2">93556</span><span>件</sapn></div>
						</div>
						<div class = "ltrhao-body-right1-div21">
							<span>司法鉴定案件数</span><div class="ltrhao-body-right1-div222"><sapn class='jczl_gz' id="gz3">38906</span><span>件</sapn></div>
						</div>
						<div class = "ltrhao-body-right1-div21">
							<span>法律援助案件数</span><div class="ltrhao-body-right1-div222"><sapn class='jczl_gz' id="gz4">32647</span><span>件</sapn></div>
						</div>
						<div class = "ltrhao-body-right1-div21">
							<span>人民调解案件数</span><div class="ltrhao-body-right1-div222"><sapn class='jczl_gz' id="gz5">105942</span><span>件</sapn></div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<script type="text/javascript">
					$(function(){
					
						$(".jczl_gz").each(function(){
							var s = $(this).text();
							var n = parseInt(s);
							var vs = {};
							vs.combo = $(this);
							vs.value = n;
							vs.pv = 0;
							new AnimateValue(vs).play();
						});
						function AnimateValue(obj){
							var self = this;
							this.vs = obj;
							randoms(this.vs);
							function randoms(vs){
								setTimeout(function(){
									if(vs.pv<=vs.value){
										vs.combo.text(vs.pv);
										vs.pv+=Math.ceil(vs.value/60);
									}else{
										vs.combo.text(vs.value);
										vs.pv = 0;
										return;
									}
									randoms(vs);
								},6);
							}
							
							this.play=function(){
								var vs = this.vs;
								var t = Math.random() * 20000 + 5500;  //时间处理 50000毫秒 
								setTimeout(function(){
									randoms(vs);
									self.play();
								},t);
							}
						}
					});
				</script>
</body>
</html>
