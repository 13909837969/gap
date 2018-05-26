<%@ page language="java" contentType="text/html; charset=UTF-8"  	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>内蒙古公共法律服务智能一体化平台</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="">
<meta name="author" content="">
<script src="js/jquery-1.10.2.min.js"></script>
<script src="bootstrap/js/bootstrap.js"></script>
<script src='js/jquery.dataTables.min.js'></script>	
<script src='js/modernizr.min.js'></script>
<script src='js/pace.min.js'></script>
<script src='js/jquery.popupoverlay.min.js'></script>
<script src='js/jquery.slimscroll.min.js'></script>
<script src='js/jquery.cookie.min.js'></script>
<script src="js/endless/endless.js"></script>
<link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">
<link href="css/font-awesome.min.css" rel="stylesheet">
<link href="css/pace.css" rel="stylesheet">
<link href="css/colorbox/colorbox.css" rel="stylesheet">
<link href="css/morris.css" rel="stylesheet" />
<link href="css/endless.css" rel="stylesheet">
<link href="css/endless-skin.css" rel="stylesheet">
<script type="text/javascript" src="js/echarts.min.js"></script>
<script type="text/javascript" src="js/myEchart/screen_cang.js"></script>
<link rel="stylesheet" type="text/css" href="/user/resources/css/core/default/eht.ui.core.css"/>
	<script type="text/javascript" src="/user/resources/script/jquery/eht.rmi.json.js"></script>
	<script type="text/javascript" src="/user/resources/script/core/eht.ui.utils.js"></script>
	<script type="text/javascript" src="/user/resources/script/core/eht.rmi.responder.js"></script>
	<script type="text/javascript" src="/user/resources/script/core/eht.rmi.paginate.js"></script>
	<script type="text/javascript" src="../../json/JzJzryjbxxService.js"></script>
	
	<script type="text/javascript">
	
	$(function(){
		
		$('#wrapper').toggleClass('sidebar-hide');
		$('.main-menu').find('.openable').removeClass('open');
		$('.main-menu').find('.submenu').removeAttr('style');
		
		var a= new JzJzryjbxxService();
		a.findCount({},new Eht.Responder({
			success : function(data) {
				//从后台返回的数据 data
			   if (data!= null&&data.length>0) {
					for (var i = 0; i < data.length; i++) {
						$("#bdrs").html(data[i].bdrs);
					}
				} 
			}
		})); 
		
		/* var sso = new SSO();
		sso.async = false;
		var user = sso.getUser();
		var name=user.name;
		debugger;
		$("#topName").html(name);
		$("#listName").html(name);
		$("#userEmail").html(user.orgname); */
		
		
	});
	
	function logout(){
		var ls = new LoginService();
		ls.logout(new Eht.Responder({success:function(data){
			//removeChatListen();
			window.top.location.href = data.value;
		}}));
	}
	</script>
</head>

<body class="overflow-hidden">
	<div id="wrapper" class="sidebar-mini">
			<div id="top-nav" class="fixed skin-6"  style="vertical-align: middle;display:table-cell;">
				<a href="#" class="brand"> <span  style="margin-left:20px;font-size:14pt;">内蒙古公共法律服务智能一体化平台</span> 
				</a>
				<a href="#" class="brand"> <span  style="margin-left:260px;font-size:10pt;">决策剧场</span> 
				</a>
				<!-- /brand -->
				<button type="button" class="navbar-toggle pull-left" 
					id="sidebarToggle">
					<span class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<button type="button" class="navbar-toggle pull-left hide-menu"  id="menuToggle"   style="margin-left:220px;">
				</button>
				<ul class="nav-notification clearfix">
					<li class="角色 dropdown">
					<a class="dropdown-toggle"
						data-toggle="dropdown" href="#"> <strong id="topName"></strong> <span><i
								class="fa fa-chevron-down"></i></span>
					</a>
						<ul class="dropdown-menu">
							<li><a class="clearfix" href="#"> <img
									src="img/user.jpg" alt="User Avatar">
									<div class="detail">
										<strong  id="listName"></strong>
										<p class="grey"   id="userEmail"></p>
									</div>
							</a></li>
							<li class="divider"></li>
							<li><a tabindex="-1" class="main-link logoutConfirm_open"
								href="#logoutConfirm"><i class="fa fa-lock fa-lg"></i>退出</a></li>
						</ul></li>
				</ul>
			</div>
			<!-- /top-nav-->
			<aside class="fixed skin-6">
				<div class="sidebar-inner scrollable-sidebar">
					<div class="search-block">
						<div class="input-group">
							<input type="text" class="form-control input-sm"
								placeholder="search here..."> <span
								class="input-group-btn">
								<button class="btn btn-default btn-sm" type="button">
									<i class="fa fa-search"></i>
								</button>
							</span>
						</div>
						<!-- /input-group -->
					</div>
					<!-- /search-block -->
			</aside>
			<div id="main-container">
				<div class="padding-md">
					<div class="row">
						<!--常驻人口 -->
						<div class="col-md-2 col-sm-4">
							<div class="panel panel-default panel-stat1 bg-info">
								<div class="panel-body">
									<div class="value"  id="czrk">14500</div>
									<div class="title">
										<span class="m-left-xs">矫正人员总数</span>
									</div>
								</div>
							</div>
						</div>
						<div class="col-md-2 col-sm-4">
							<div class="panel panel-default panel-stat1 bg-success">
								<div class="panel-body">
									<div class="value"  id="cjrzs">1020</div>
									<div class="title">
										<span class="m-left-xs">司法机构总数</span>
									</div>
								</div>
							</div>
						</div>
						<div class="col-md-2 col-sm-4">
							<div class="panel panel-default panel-stat1 bg-warning">
								<div class="panel-body">
									<div class="value"  id="dbrzs">2130</div>
									<div class="title">
										<span class="m-left-xs">工作人员总数</span>
									</div>
								</div>
							</div>
							<!-- /panel -->
						</div>
						<div class="col-md-2 col-sm-4">
							<div class="panel panel-default panel-stat1 bg-danger">
								<div class="panel-body">
									<div class="value"   id="lnrzs">82%</div>
									<div class="title">
										<span class="m-left-xs">帮扶百分比</span>
									</div>
								</div>
							</div>
						</div>
						<div class="col-md-2 col-sm-4">
							<div class="panel panel-default panel-stat1 bg-primary">
								<div class="panel-body">
									<div class="value"  id="bdrs"></div>
									<div class="title">
										<span class="m-left-xs">报到总人数</span>
									</div>
								</div>
							</div>
						</div>
						<div class="col-md-2 col-sm-4">
							<div class="panel panel-default panel-stat1 bg-success">
								<div class="panel-body">
									<div class="value"   id="syzrs">8600</div>
									<div class="title">
										<span class="m-left-xs">奖惩情况总人数</span>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-lg-4">
							<!--panel 管理等级  -->
							<div class="panel bg-info fadeInDown animation-delay4"   style="background-color: #202a32 ;">
								<div class="panel-body">
									<div id="cjChart" style="height:228px;"></div>
								</div>
							</div>
							<!--panel  教育矫正  -->
							<div class="panel bg-success fadeInDown animation-delay5"  style="background-color: #202a32 ;">
								<div class="panel-body">
									<div id="dbChart" style="height:228px;"></div>
								</div>
							</div>
						</div>

						<div class="col-lg-4">
							<!--panel  帮困扶贫 -->
							<div class="panel bg-info fadeInDown animation-delay4" style="background-color: #202a32 ;" >
								<div class="panel-body">
									<div id="lxChart" style="height:228px;"></div>
								</div>
							</div>
							<!-- /panel  惩戒情况-->
							<div class="panel bg-success fadeInDown animation-delay5"  style="background-color: #202a32 ;">
								<div class="panel-body">
									<div id="etChart" style="height:228px;"></div>
								</div>
							</div>
							<!-- /panel -->
						</div>
						<div class="col-lg-4">
							<!--panel 队伍建设  -->
							<div class="panel bg-info fadeInDown animation-delay4"  style="background-color: #202a32 ;">
								<div class="panel-body">
									<div id="syrChart" style="height:228px;"></div>
								</div>
							</div>
							<!--panel 基地建设-->
							<div class="panel bg-success fadeInDown animation-delay5" style="background-color: #202a32 ;">
								<div class="panel-body">
									<div id="etnbChart" style="height:228px;"></div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="custom-popup width-100"  id="logoutConfirm">
			<div class="padding-md">
				<h4 class="m-top-none">确认退出吗？</h4>
			</div>
			<div class="text-center">
				<a class="btn btn-success m-right-sm"   onclick="logout()">确定</a>
				<a class="btn btn-danger logoutConfirm_close">取消</a>
			</div>
		</div>

</body>
</html>
