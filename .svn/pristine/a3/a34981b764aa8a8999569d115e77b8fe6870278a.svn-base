<%@ page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>
<html>
<head>
<title>pad综合统计页面</title>
<jsp:include  page="../ltrhao-common.jsp"></jsp:include>
<link rel="stylesheet" 	href="../../resources/css/ltrhao-AdminLTE.min.css">
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
		
		//传递的参数 type 0 按天检索  1按月检索 2按季度检索 
		pad.findAdjustment({"type":'2'},new Eht.Responder({success:function(data){
			debugger;
			if (data.length > 0) {
				for (var i = 0; i < data.length; i++) {
					//人民调节【按天】
					
				}
				
				
			}
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
						<h3 class="box-title">社区矫正当日指标综合统计</h3>
					</div>
					<div class="row" style="padding-right: 10px; padding-left: 10px; padding-top: 5px;">
						<div class="col-lg-3 col-xs-3 col-md-3">
							<div class="small-box bg-aqua pad-style-borderpx">
								<div class="inner" onclick="showJzryDetail()">
									<h3  id="jzryCount">0</h3>
									<p>矫正人数</p>
								</div>
							</div>
						</div>
						<div class="col-lg-3 col-xs-3 col-md-3">
							<div class="small-box bg-green pad-style-borderpx">
								<div class="inner"  onclick="showQdList(1)">
									<h3 id="zwqdCount">0</h3>
									<p>指纹签到人数</p>
								</div>
							</div>
						</div>
						<div class="col-lg-3 col-xs-3 col-md-3">
							<div class="small-box bg-yellow pad-style-borderpx">
								<div class="inner" onclick="showQdList(2)">
									<h3 id="swqdCount">0</h3>
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
									<h3 id="rlqdCount">0</h3>
									<p>人脸签到人数</p>
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
									<h3 id="caseNum">0</h3>
									<p>接收矫正人数</p>
								</div>
								<div class="icon">
									<i class="ion ion-ios-home"></i>
								</div>
							</div>
						</div>
						<div class="col-lg-3 col-xs-3 col-md-3">
							<div class="small-box bg-olive pad-style-borderpx">
								<div class="inner"  onclick="showXtjcList()">
									<h3 id="xtjcCount">0</h3>
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
									<h3 id="hmCount">0</h3>
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
									<h3 id="alarmCount">0</h3>
									<p>报警次数</p>
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
				<ul class="nav nav-tabs"  style="font-size:16px;">
					<li  class="active"><a rel="nofollow"   href="#panel-1"  data-toggle="tab"  onclick="selectDay();">按天统计情况</a></li>
					<li><a rel="nofollow" href="#panel-2"  data-toggle="tab"    onclick="selectMonth();">按月统计情况</a></li>
					<li><a rel="nofollow" href="#panel-3"  data-toggle="tab"    onclick="selectQuarter();" >按季度统计情况</a></li>
				</ul>
				<div class="tab-content">
					<div class="tab-pane active" id="panel-1">
						<div class="row">
							<div class="col-md-12"  >
								<div class="box box-success">
									<div class="box-header with-border">
										<h3 class="box-title" style="margin-bottom:10px;">人民调解分析</h3>
										<div class="cle"></div>
										<div class="col-md-6 col-sm-6">
											<span class="col-md-12 col-sm-12" style="background:#3d9970; height:60px;border-radius:5px;text-align:center;line-height:60px;font-size:18px;color:#fff;">口头调解案件总数&nbsp;500</span>
										</div>
										<div class="col-md-6 col-sm-6">
											<span class="col-md-12 col-sm-12" style="background:#605ca8; height:60px;border-radius:5px;text-align:center;line-height:60px;font-size:18px;color:#fff;">书面调解案件总数&nbsp; 600</span>
										</div>
									</div>
									<div id="rmtj_day" style="height: 215px;"></div>
								</div>
							</div>
							<div class="col-md-12">
								<div class="box box-success">
									<div class="box-header with-border">
										<h3 class="box-title" style="margin-bottom:10px;">安置帮教分析</h3>
										<div class="cle"></div>
										<div class="col-md-4 col-sm-4">
											<span class="col-md-12 col-sm-12" style="background:#00c0ef; height:60px;border-radius:5px;text-align:center;line-height:60px;font-size:18px;color:#fff;">安置帮教对象&nbsp;500</span>
										</div>
										<div class="col-md-4 col-sm-4">
											<span class="col-md-12 col-sm-12" style="background:#f39c12; height:60px;border-radius:5px;text-align:center;line-height:60px;font-size:18px;color:#fff;">应衔接人数&nbsp;600</span>
										</div>
										<div class="col-md-4 col-sm-4">
											<span class="col-md-12 col-sm-12" style="background:#dd4b39; height:60px;border-radius:5px;text-align:center;line-height:60px;font-size:18px;color:#fff;">下落不明数&nbsp;600</span>
										</div>
									</div>
									<div id="azbj_day" style="height: 215px;"></div>
								</div>
							</div>
							<div class="col-md-12">
								<div class="box box-success">
									<div class="box-header with-border">
										<h3 class="box-title" style="margin-bottom:10px;">法律援助分析</h3>
										<div class="cle"></div>
										<div class="col-md-6 col-sm-6">
											<span class="col-md-12 col-sm-12" style="background:#dd4b39; height:60px;border-radius:5px;text-align:center;line-height:60px;font-size:18px;color:#fff;">咨询案件&nbsp;500</span>
										</div>
										<div class="col-md-6 col-sm-6">
											<span class="col-md-12 col-sm-12" style="background:#00a65a; height:60px;border-radius:5px;text-align:center;line-height:60px;font-size:18px;color:#fff;">案件总数&nbsp;600</span>
										</div>
									</div>
									<div id="flyz_day" style="height: 215px;"></div>
								</div>
							</div>
							<div class="col-md-12">
								<div class="box box-success">
									<div class="box-header with-border">
										<h3 class="box-title">矫正人员分析</h3>
									</div>
									<div id="jzry_day" style="height: 215px;"></div>
								</div>
							</div>
							<div class="row"  style="margin-left:1px;">
								<div class="col-sm-12 form-inline">
									<div class="box box-success col-sm-6"   style="width:265px;float:left;">
										<div class="box-header with-border">
											<h3 class="box-title">矫正类别</h3>
										</div>
										<div id="jzlb_day" style="height: 180px;"></div>
									</div>
									<div class="box box-success col-sm-6"   style="width:265px;float:left;">
										<div class="box-header with-border">
											<h3 class="box-title">年龄分布</h3>
										</div>
										<div id="nlfb_day" style="height:180px;"></div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="tab-pane"   id="panel-2">
						<div class="row">
							<div class="col-md-12">
								<div class="box box-success">
									<div class="box-header with-border">
										<h3 class="box-title" style="margin-bottom:10px;">人民调解分析</h3>
										<div class="cle"></div>
										<div class="col-md-6 col-sm-6">
											<span class="col-md-12 col-sm-12" style="background:#3d9970; height:60px;border-radius:5px;text-align:center;line-height:60px;font-size:18px;color:#fff;">口头调解案件总数&nbsp;500</span>
										</div>
										<div class="col-md-6 col-sm-6">
											<span class="col-md-12 col-sm-12" style="background:#605ca8; height:60px;border-radius:5px;text-align:center;line-height:60px;font-size:18px;color:#fff;">书面调解案件总数&nbsp; 600</span>
										</div>
									</div>
									<div id="rmtj_month"   style="height: 215px;"></div>
								</div>
							</div>
							<div class="col-md-12">
								<div class="box box-success">
									<div class="box-header with-border">
										<h3 class="box-title" style="margin-bottom:10px;">安置帮教分析</h3>
										<div class="cle"></div>
										<div class="col-md-4 col-sm-4">
											<span class="col-md-12 col-sm-12" style="background:#00c0ef; height:60px;border-radius:5px;text-align:center;line-height:60px;font-size:18px;color:#fff;">安置帮教对象&nbsp;500</span>
										</div>
										<div class="col-md-4 col-sm-4">
											<span class="col-md-12 col-sm-12" style="background:#f39c12; height:60px;border-radius:5px;text-align:center;line-height:60px;font-size:18px;color:#fff;">应衔接人数&nbsp;600</span>
										</div>
										<div class="col-md-4 col-sm-4">
											<span class="col-md-12 col-sm-12" style="background:#dd4b39; height:60px;border-radius:5px;text-align:center;line-height:60px;font-size:18px;color:#fff;">下落不明数&nbsp;600</span>
										</div>
									</div>
									<div id="azbj_month" style="height: 215px;"></div>
								</div>
							</div>
							<div class="col-md-12">
								<div class="box box-success">
									<div class="box-header with-border">
										<h3 class="box-title" style="margin-bottom:10px;">法律援助分析</h3>
										<div class="cle"></div>
										<div class="col-md-6 col-sm-6">
											<span class="col-md-12 col-sm-12" style="background:#dd4b39; height:60px;border-radius:5px;text-align:center;line-height:60px;font-size:18px;color:#fff;">咨询案件&nbsp;500</span>
										</div>
										<div class="col-md-6 col-sm-6">
											<span class="col-md-12 col-sm-12" style="background:#00a65a; height:60px;border-radius:5px;text-align:center;line-height:60px;font-size:18px;color:#fff;">案件总数&nbsp;600</span>
										</div>
									</div>
									<div id="flyz_month" style="height: 215px;"></div>
								</div>
							</div>
							<div class="col-sm-12">
								<div class="box box-success">
									<div class="box-header with-border">
										<h3 class="box-title">矫正人员分析</h3>
									</div>
									<div id="jzry_month" style="height: 215px;"></div>
							    </div>
							</div>
							<div class="row"  style="margin-left:1px;">
								<div class="col-sm-12 form-inline">
									<div class="box box-success col-sm-6"   style="width:265px;float:left;">
										<div class="box-header with-border">
											<h3 class="box-title">矫正类别</h3>
										</div>
										<div id="jzlb_month" style="height: 180px;"></div>
									</div>
									<div class="box box-success col-sm-6"   style="width:265px;float:left;">
										<div class="box-header with-border">
											<h3 class="box-title">年龄分布</h3>
										</div>
										<div id="nlfb_month" style="height:180px;"></div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="tab-pane" id="panel-3">
							<div class="row">
							<div class="col-md-12"  >
								<div class="box box-success">
									<div class="box-header with-border">
										<h3 class="box-title" style="margin-bottom:10px;">人民调解分析</h3>
										<div class="cle"></div>
										<div class="col-md-6 col-sm-6">
											<span class="col-md-12 col-sm-12" style="background:#3d9970; height:60px;border-radius:5px;text-align:center;line-height:60px;font-size:18px;color:#fff;">口头调解案件总数&nbsp;500</span>
										</div>
										<div class="col-md-6 col-sm-6">
											<span class="col-md-12 col-sm-12" style="background:#605ca8; height:60px;border-radius:5px;text-align:center;line-height:60px;font-size:18px;color:#fff;">书面调解案件总数&nbsp; 600</span>
										</div>
									</div>
									<div id="rmtj_quarter" style="height: 215px;"></div>
								</div>
							</div>
							<div class="col-md-12">
								<div class="box box-success">
									<div class="box-header with-border">
										<h3 class="box-title" style="margin-bottom:10px;">安置帮教分析</h3>
										<div class="cle"></div>
										<div class="col-md-4 col-sm-4">
											<span class="col-md-12 col-sm-12" style="background:#00c0ef; height:60px;border-radius:5px;text-align:center;line-height:60px;font-size:18px;color:#fff;">安置帮教对象&nbsp;500</span>
										</div>
										<div class="col-md-4 col-sm-4">
											<span class="col-md-12 col-sm-12" style="background:#f39c12; height:60px;border-radius:5px;text-align:center;line-height:60px;font-size:18px;color:#fff;">应衔接人数&nbsp;600</span>
										</div>
										<div class="col-md-4 col-sm-4">
											<span class="col-md-12 col-sm-12" style="background:#dd4b39; height:60px;border-radius:5px;text-align:center;line-height:60px;font-size:18px;color:#fff;">下落不明数&nbsp;600</span>
										</div>
									</div>
									<div id="azbj_quarter" style="height: 215px;"></div>
								</div>
							</div>
							<div class="col-md-12">
								<div class="box box-success">
									<div class="box-header with-border">
										<h3 class="box-title" style="margin-bottom:10px;">法律援助分析</h3>
										<div class="cle"></div>
										<div class="col-md-6 col-sm-6">
											<span class="col-md-12 col-sm-12" style="background:#dd4b39; height:60px;border-radius:5px;text-align:center;line-height:60px;font-size:18px;color:#fff;">咨询案件&nbsp;500</span>
										</div>
										<div class="col-md-6 col-sm-6">
											<span class="col-md-12 col-sm-12" style="background:#00a65a; height:60px;border-radius:5px;text-align:center;line-height:60px;font-size:18px;color:#fff;">案件总数&nbsp;600</span>
										</div>
									</div>
									<div id="flyz_quarter" style="height: 215px;"></div>
								</div>
							</div>
							<div class="col-md-12">
								<div class="box box-success">
									<div class="box-header with-border">
										<h3 class="box-title">矫正人员分析</h3>
									</div>
									<div id="jzry_quarter" style="height: 215px;"></div>
								</div>
							</div>
							<div class="row"  style="margin-left:1px;">
								<div class="col-sm-12 form-inline">
									<div class="box box-success col-sm-6"   style="width:265px;float:left;">
										<div class="box-header with-border">
											<h3 class="box-title">矫正类别</h3>
										</div>
										<div id="jzlb_quarter" style="height: 180px;"></div>
									</div>
									<div class="box box-success col-sm-6"   style="width:265px;float:left;">
										<div class="box-header with-border">
											<h3 class="box-title">年龄分布</h3>
										</div>
										<div id="nlfb_quarter" style="height:180px;"></div>
									</div>
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
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="false">x</button>
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
	<script type="text/javascript" src="js/padReportQuarter.js"></script>
	<script type="text/javascript" src="js/padReportMonth.js"></script>
	<script type="text/javascript" src="js/padReportDay.js"></script>

</body>
</html>