<%@ page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>
<html>
<head>
<title>pad综合统计页面</title>
<jsp:include  page="../ltrhao-common.jsp"></jsp:include>
<link rel="stylesheet" 	href="../../resources/css/ltrhao-AdminLTE.min.css">
<script type="text/javascript" src="js/padReportQB.js"></script><!-- 后加的js（rmtj、flyz） -->
<script type="text/javascript" src="${localCtx}/json/PadZhtjService.js"></script>
<script type="text/javascript">
	$(function () {
		var pad = new PadZhtjService();
		pad.findZhtjCount({"aid":''},new Eht.Responder({success:function(data){
			if (data.length > 0) {
				//矫正人员
				$("#jzryCount div").html(data.jzrycount);
				//指纹签到
				$("#zwqdCount div").html(data.zwqdcount);
				//声纹签到
				$("#swqdCount div").html(data.swqdcount);
				//人脸
				$("#rlqdCount div").html(data.rlqdcount);
				//矫正接收
				$("#caseNum div").html(data.jzrycount_js);
				//心跳
				$("#xtjcCount div").html(data.xtjccount);
				//会面
				$("#hmCount div").html(data.hmcount);
				//警报
				$("#alarmCount div").html(data.alarmcount);
				//
			}
		}}));
		
		//第二个图表、
		var data_lx = new Array(); //数组对象
		var data_nl = new Array(); //数组对象 
		pad.findJzTwo(new Eht.Responder({success:function(datas){
				list_lx = datas.li_lx;
				for (var i = 0; i < datas.li_lx.length; i++) {
					data_lx.push(
							{
							name: datas.li_lx[i].name,
			                value: datas.li_lx[i].value
			                } 
							);
				}
				for (var i = 0; i < datas.li_nl.length; i++) {
					data_nl.push(
							{
							name: datas.li_nl[i].name,
			                value: datas.li_nl[i].value
			                } 
							);
				}
				
		//矫正类别
		var jzlb_day = echarts.init(document.getElementById('jzlb_day'));
		jzlbDayOption={
		        series: [{
		            type: 'pie',
		            radius : '45%',
		            center: ['50%', '50%'],
		            selectedMode:'single',
		            data:data_lx
		        }]
		   };
		jzlb_day.setOption(jzlbDayOption);
		
		//年龄分布
		var nlfb_day = echarts.init(document.getElementById('nlfb_day'));
		nlfbDayOption={
		        series: [{
		            type: 'pie',
		            radius : '45%',
		            center: ['50%', '50%'],
		            selectedMode:'single',
		            data:data_nl,
		            itemStyle: {
		                emphasis: {
		                    shadowBlur:0,
		                    shadowOffsetX:0,
		                    shadowColor: 'rgba(0, 0, 0, 0.5)'
		                }
		            }
		        }]
		 };
		nlfb_day.setOption(nlfbDayOption);
	}}));
		
		
		var data_list_azname = new Array(); //数组对象
		var data_list_azvalue = new Array(); //数组对象
		pad.findAzbj(new Eht.Responder({success:function(datas){
			list = datas;
				for (var i = 0; i < list.length; i++) {
					data_list_azname.push(list[i].name),
					data_list_azvalue.push(list[i].value)
							
				}
		// 安置帮教
		var azbj_day = echarts.init(document.getElementById('azbj_day'));
		azbjDayOption = {
			color : [ '#2b821d' ],
			tooltip : {
				trigger : 'axis',
				axisPointer : { // 坐标轴指示器，坐标轴触发有效
					type : 'shadow' // 默认为直线，可选为：'line' | 'shadow'
				}
			},
			grid : {
				left : '3%',
				right : '4%',
				bottom : '5%',
				top : '10%',
				containLabel : true
			},
			toolbox: {
		        top:-5,
		        feature: {
		            magicType: {
		                type: [ 'bar','line']
		            },
		            restore: {}
		        }
		    },
			xAxis : [ {
				type : 'category',
				data : data_list_azname,
				axisTick : {
					alignWithLabel : true
				}
			} ],
			yAxis : [ {
				type : 'value'
			} ],
			series : [ {
				name : '安置帮教数量',
				type : 'bar',
				barWidth : '60%',
				data : data_list_azvalue
			} ]
		};
		azbj_day.setOption(azbjDayOption);
	}}));
});
</script>
</head>
<body class="hold-transition skin-blue sidebar-mini"   style="background-color: #ecf0f5">
	<div class="wrapper">
		<section class="content"  style="padding:2px;">
			<div class="col-md-12" style="padding-right: 0px; padding-left: 0px;">
				<div class="box box-success" style="width: 100%;">
					<div class="box-header with-border" style="text-align: center;">
						<h3 class="box-title">社区矫正指标综合统计</h3>
					</div>
					<div class="row" style="padding-right: 10px; padding-left: 10px; padding-top: 5px;">
						<div class="col-lg-3 col-xs-3 col-md-3">
							<div class="small-box bg-aqua pad-style-borderpx">
								<div class="inner" onclick="showJzryDetail()">
									<h3  id="jzryCount"><div></div></h3>
									<p>矫正人数</p>
								</div>
							</div>
						</div>
						<div class="col-lg-3 col-xs-3 col-md-3">
							<div class="small-box bg-olive pad-style-borderpx">
								<div class="inner"  onclick="showXtjcList()">
									<h3 id="xtjcCount"><div></div></h3>
									<p>心跳检测次数</p>
								</div>
								<div class="icon">
									<i class="ion ion-person"></i>
								</div>
							</div>
						</div>
						<div class="col-lg-3 col-xs-3 col-md-3">
							<div class="small-box bg-green pad-style-borderpx">
								<div class="inner"  onclick="showHmList()">
									<h3 id="hmCount"><div></div></h3>
									<p>会面次数</p>
								</div>
								<div class="icon">
									<i class="ion ion-ios-plus"></i>
								</div>
							</div>
						</div>
						<div class="col-lg-3 col-xs-3 col-md-3">
							<div class="small-box bg-purple pad-style-borderpx">
								<div class="inner" onclick="showAlarmlList()">
									<h3 id="alarmCount"><div></div></h3>
									<p>报警次数</p>
								</div>
								<div class="icon">
									<i class="ion ion-ios-checkmark"></i>
								</div>
							</div>
						</div>
					</div>
					<div class="row" style="padding-right: 10px; padding-left: 10px;">
						<div class="col-lg-3 col-xs-3 col-md-3">
							<div class="small-box bg-maroon pad-style-borderpx">
								<div class="inner" onclick="showRmtjDetail()">
									<h3 id="caseNum"><div></div></h3>
									<p>接收矫正人数</p>
								</div>
								<div class="icon">
									<i class="ion ion-ios-home"></i>
								</div>
							</div>
						</div>
						<div class="col-lg-3 col-xs-3 col-md-3">
							<div class="small-box bg-green pad-style-borderpx">
								<div class="inner"  onclick="showQdList(1)">
									<h3 id="zwqdCount"><div></div></h3>
									<p>指纹签到人数</p>
								</div>
							</div>
						</div>
						<div class="col-lg-3 col-xs-3 col-md-3">
							<div class="small-box bg-yellow pad-style-borderpx">
								<div class="inner" onclick="showQdList(2)">
									<h3 id="swqdCount"><div></div></h3>
									<p>声纹签到人数</p>
								</div>
								<div class="icon">
									<i class="ion ion-ios-plus"></i>
								</div>
							</div>
						</div>
						<div class="col-lg-3 col-xs-3 col-md-3">
							<div class="small-box bg-red pad-style-borderpx">
								<div class="inner" onclick="showQdList(3)">
									<h3 id="rlqdCount"><div></div></h3>
									<p>人脸签到人数</p>
								</div>
								<div class="icon">
									<i class="ion ion-ios-checkmark"></i>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!--按天、按月、按季度统计-->
			<div class="tabbable"    id="tabs-20180107">
				<!-- <ul class="nav nav-tabs"  style="font-size:16px;">
					<li  class="active"><a rel="nofollow"   href="#panel-1"  data-toggle="tab"  onclick="selectDay();">按天统计情况</a></li>
					<li><a rel="nofollow" href="#panel-2"  data-toggle="tab"    onclick="selectMonth();">按月统计情况</a></li>
					<li><a rel="nofollow" href="#panel-3"  data-toggle="tab"    onclick="selectQuarter();" >按季度统计情况</a></li>
				</ul> -->
				<div class="tab-content">
					<div class="tab-pane active" id="panel-1">
						<div class="row">
							<div class="row"  style="margin-left:1px;">
								<div class="col-sm-12 col-md-12 col-xs-12 form-inline">
									<div class="box box-success col-sm-6 col-md-6 col-xs-6" style="border-top-color:#fff;float:left;">
										<div class="box-header with-border">
											<h3 class="box-title">矫正类别</h3>
										</div>
										<div id="jzlb_day" style="height: 180px;"></div>
									</div>
									<div class="box box-success col-sm-6 col-md-6 col-xs-6" style="border-top-color:#fff;float:left;">
										<div class="box-header with-border">
											<h3 class="box-title">年龄分布</h3>
										</div>
										<div id="nlfb_day" style="height:180px;"></div>
									</div>
								</div>
							</div>
							<!-- 人民调解 -->
							<div class="col-md-12">
								<div class="box box-success">
									<div class="box-header with-border">
										<h3 class="box-title" style="margin-bottom:10px;">人民调解分析</h3>
										<div class="cle"></div>
									</div>
									<div id="rmtj_day" style="height:220px;margin-left:1%;"></div>
								</div>
							</div>
							<!-- 法律援助分析 -->
							<div class="col-md-12">
								<div class="box box-success">
									<div class="box-header with-border">
										<h3 class="box-title" style="margin-bottom:10px;">法律援助分析</h3>
										<div class="cle"></div>
									</div>
									<div id="flyz_day" style="height: 215px;"></div>
								</div>
							</div>
							
							<!-- 法律咨询情况分析 -->
							<div class="col-md-12">
								<div class="box box-success">
									<div class="box-header with-border">
										<h3 class="box-title" style="margin-bottom:10px;">法律咨询情况分析</h3>
										<div class="cle"></div>
									</div>
									<div id="flzxqk_day" style="height: 215px;"></div>
								</div>
							</div>
							<!-- 法律宣传 -->
							<div class="col-md-12">
								<div class="box box-success">
									<div class="box-header with-border">
										<h3 class="box-title" style="margin-bottom:10px;">法治宣传情况分析</h3>
										<div class="cle"></div>
									</div>
									<div id="flxcfx_day" style="height: 215px;"></div>
									<div id="flxcfxa_day" style="height: 215px;"></div>
								</div>
							</div>
							<!-- 基层法律服务等级情况分析 -->
							<div class="col-md-12">
								<div class="box box-success">
									<div class="box-header with-border">
										<h3 class="box-title" style="margin-bottom:10px;">基层法律服务登记情况分析</h3>
										<div class="cle"></div>
									</div>
									<div id="jzflfw_day" style="height: 215px;"></div>
									<div id="jzflfwa_day" style="height: 215px;"></div>
								</div>
							</div>
							<!-- 矫正人员分析 
							<div class="col-md-12">
								<div class="box box-success">
									<div class="box-header with-border">
										<h3 class="box-title">矫正人员分析</h3>
									</div>
									<div id="jzry_day" style="height: 215px;"></div>
								</div>
							</div> -->
							<!-- 安置帮教分析 -->
							<div class="col-md-12">
								<div class="box box-success">
									<div class="box-header with-border">
										<h3 class="box-title" style="margin-bottom:10px;">安置帮教分析</h3>
										<div class="cle"></div>
									</div>
									<div id="azbj_day" style="height: 215px;"></div>
								</div>
							</div>
							<!--  -->
						</div>
					</div>
					<div class="tab-pane"   id="panel-2">
						<div class="row">
							<div class="row"  style="margin-left:1px;">
								<div class="col-sm-12 form-inline">
									<div class="box box-success col-sm-6"   style="/* width:265px; */float:left;">
										<div class="box-header with-border">
											<h3 class="box-title">矫正类别</h3>
										</div>
										<div id="jzlb_month" style="height: 180px;"></div>
									</div>
									<div class="box box-success col-sm-6"   style="/* width:265px; */float:left;">
										<div class="box-header with-border">
											<h3 class="box-title">年龄分布</h3>
										</div>
										<div id="nlfb_month" style="height:180px;"></div>
									</div>
								</div>
							</div>
							<!-- 人民调解分析 -->
							<div class="col-md-12" id="flyz-bar-jflx1">
								<div class="box box-success">
									<div class="box-header with-border">
										<h3 class="box-title" style="margin-bottom:10px;">人民调解分析</h3>
										<div class="cle"></div>
									</div>
									<div id="rmtj_month"   style="height: 215px;"></div>
								</div>
							</div>
							<!-- 法律援助分析 -->
							<div class="col-md-12">
								<div class="box box-success">
									<div class="box-header with-border">
										<h3 class="box-title" style="margin-bottom:10px;">法律援助分析</h3>
										<div class="cle"></div>
									</div>
									<div id="flyz_month" style="height: 215px;"></div>
								</div>
							</div>
							<!-- 法律咨询情况分析 -->
							<div class="col-md-12">
								<div class="box box-success">
									<div class="box-header with-border">
										<h3 class="box-title" style="margin-bottom:10px;">法律咨询情况分析</h3>
										<div class="cle"></div>
									</div>
									<div id="flzx_month" style="height: 215px;"></div>
								</div>
							</div>
							<!-- 法律宣传 -->
							<div class="col-md-12">
								<div class="box box-success">
									<div class="box-header with-border">
										<h3 class="box-title" style="margin-bottom:10px;">法治宣传情况分析</h3>
										<div class="cle"></div>
									</div>
									<div id="flxcfx_month" style="height: 215px;"></div>
								</div>
							</div>
							<!-- 基层法律服务等级情况分析 -->
							<div class="col-md-12">
								<div class="box box-success">
									<div class="box-header with-border">
										<h3 class="box-title" style="margin-bottom:10px;">基层法律服务登记情况分析</h3>
										<div class="cle"></div>
									</div>
									<div id="jzflfw_month" style="height: 215px;"></div>
								</div>
							</div>
							<!-- 矫正人员分析 
							<div class="col-sm-12">
								<div class="box box-success">
									<div class="box-header with-border">
										<h3 class="box-title">矫正人员分析</h3>
									</div>
									<div id="jzry_month" style="height: 215px;"></div>
							    </div>
							</div> -->
							<!-- 安置帮教分析 -->
							<div class="col-md-12">
								<div class="box box-success">
									<div class="box-header with-border">
										<h3 class="box-title" style="margin-bottom:10px;">安置帮教分析</h3>
										<div class="cle"></div>
									</div>
									<div id="azbj_month" style="height: 215px;"></div>
								</div>
							</div>
						</div>
					</div>
					<div class="tab-pane" id="panel-3">
						<div class="row">
							<div class="row"  style="margin-left:1px;">
								<div class="col-sm-12 form-inline">
									<div class="box box-success col-sm-6"   style="/* width:265px; */float:left;">
										<div class="box-header with-border">
											<h3 class="box-title">矫正类别</h3>
										</div>
										<div id="jzlb_quarter" style="height: 180px;"></div>
									</div>
									<div class="box box-success col-sm-6"   style="/* width:265px; */float:left;">
										<div class="box-header with-border">
											<h3 class="box-title">年龄分布</h3>
										</div>
										<div id="nlfb_quarter" style="height:180px;"></div>
									</div>
								</div>
							</div>
							<div class="col-md-12" id="flyz-bar-jflx2">
								<div class="box box-success">
									<div class="box-header with-border">
										<h3 class="box-title" style="margin-bottom:10px;">人民调解分析</h3>
										<div class="cle"></div>
									</div>
									<div id="rmtj_quarter" style="height: 215px;"></div>
								</div>
							</div>
							<!-- 法律援助分析 -->
							<div class="col-md-12">
								<div class="box box-success">
									<div class="box-header with-border">
										<h3 class="box-title" style="margin-bottom:10px;">法律援助分析</h3>
										<div class="cle"></div>
									</div>
									<div id="flzx_quarter" style="height: 215px;"></div>
								</div>
							</div>
							<!-- 法律咨询情况分析 -->
							<div class="col-md-12">
								<div class="box box-success">
									<div class="box-header with-border">
										<h3 class="box-title" style="margin-bottom:10px;">法治咨询情况分析</h3>
										<div class="cle"></div>
									</div>
									<div id="flyz_quarter" style="height: 215px;"></div>
								</div>
							</div>
							<!-- 法律宣传 -->
							<div class="col-md-12">
								<div class="box box-success">
									<div class="box-header with-border">
										<h3 class="box-title" style="margin-bottom:10px;">法律宣传情况分析</h3>
										<div class="cle"></div>
									</div>
									<div id="flxcfx_quarter" style="height: 215px;"></div>
								</div>
							</div>
							<!-- 基层法律服务等级情况分析 -->
							<div class="col-md-12">
								<div class="box box-success">
									<div class="box-header with-border">
										<h3 class="box-title" style="margin-bottom:10px;">基层法律服务登记情况分析</h3>
										<div class="cle"></div>
									</div>
									<div id="jzflfw_quarter" style="height: 215px;"></div>
								</div>
							</div>
							<!-- 矫正人员分析 
							<div class="col-md-12">
								<div class="box box-success">
									<div class="box-header with-border">
										<h3 class="box-title">矫正人员分析</h3>
									</div>
									<div id="jzry_quarter" style="height: 215px;"></div>
								</div>
							</div> -->
							<!-- 安置帮教分析 -->
							<div class="col-md-12">
								<div class="box box-success">
									<div class="box-header with-border">
										<h3 class="box-title" style="margin-bottom:10px;">安置帮教分析</h3>
										<div class="cle"></div>
									</div>
									<div id="azbj_quarter" style="height: 215px;"></div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>

		</section>
	</div>
	<!--报警详细列表 -->
	<div class="modal fade" id="alarmModal"  style="height:600px;">
		<div class="modal-dialog" style="height: 90%; width: 513px;">
			<div class="modal-content" >
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="false">x</button>
					<h4 class="modal-title" id="alarmModalLabel">报警详细列表</h4>
				</div>
				<div class="modal-body" id="alarm-modal-body">
					<div class="list-group" id="alarmId"></div>
				</div>
			</div>
		</div>
	</div>
	<!-- 签到列表-->
	<div class="modal fade" id="qdModal"   style="height:600px;">
		<div class="modal-dialog" style="height:90%; width: 513px;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="false">x</button>
					<h4 class="modal-title" id="qdModalLabel">签到列表</h4>
				</div>
				<div class="modal-body" id="qd-modal-body" >
					<div class="list-group" id="qdId" >   </div>
				</div>
			</div>
		</div>
	</div>
	<!-- 心跳检查列表 -->
	<div class="modal fade" id="xtjcModal"  style="height:600px;">
		<div class="modal-dialog" style="height: 90%; width: 513px;">
			<div class="modal-content" >
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="false">x</button>
					<h4 class="modal-title" id="xtjcModalLabel">心跳检查列表</h4>
				</div>
				<div class="modal-body" id="xtjc-modal-body">
					<div class="list-group" id="xtjcId"></div>
				</div>
			</div>
		</div>
	</div>
	<!-- 会面次数列表 -->
	<div class="modal fade" id="hmModal"  style="height:600px;">
		<div class="modal-dialog" style="height: 90%; width: 513px;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="false">x</button>
					<h4 class="modal-title" id="hmModalLabel">会面次数列表</h4>
				</div>
				<div class="modal-body" id="hm-modal-body">
					<div class="list-group" id="hmId"></div>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript" src="js/padReportQuarter.js"></script><!-- 按季统计 -->
	<script type="text/javascript" src="js/padReportMonth.js"></script><!-- 按月统计 -->
	<script type="text/javascript" src="js/padReportDay.js"></script><!-- 按天统计 -->
</body>
</html>