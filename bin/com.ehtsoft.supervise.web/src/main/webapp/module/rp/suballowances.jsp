<%@ page language="java" contentType="text/html; charset=UTF-8"  	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>矫正人员综合管理系统</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="">
<meta name="author" content="">

<!-- Bootstrap core CSS -->
<link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">
<!-- Font Awesome-->
<link href="css/font-awesome.min.css" rel="stylesheet">
<!-- Pace -->
<link href="css/pace.css" rel="stylesheet">
<!-- Datatable -->
<link href="css/jquery.dataTables_themeroller.css" rel="stylesheet">
<!-- Endless -->
<link href="css/endless.css" rel="stylesheet">
<link href="css/endless-skin.css" rel="stylesheet">
	<!-- Jquery -->
<script src="js/jquery-1.10.2.min.js"></script>
<script type="text/javascript" src="js/echarts.min.js"></script>
<script type="text/javascript" src="js/myEchart/suballowances.js"></script>
<link rel="stylesheet" type="text/css" href="/user/resources/css/core/default/eht.ui.core.css"/>
	<script type="text/javascript" src="/user/resources/script/jquery/eht.rmi.json.js"></script>
	<script type="text/javascript" src="/user/resources/script/jquery/jquery-1.11.0.min.js"></script>
	<script type="text/javascript" src="/user/resources/script/core/eht.ui.utils.js"></script>
	<script type="text/javascript" src="/user/resources/script/core/eht.rmi.responder.js"></script>
	<script type="text/javascript" src="/user/resources/script/core/eht.rmi.paginate.js"></script>
	<script type="text/javascript" src="../eht.ui.tableview.querycss.js"></script>
	<script type="text/javascript" src="../../../json/BAAADBService.js"></script>
		<script type="text/javascript" src="../../../json/SSO.js"></script>
	<script type="text/javascript" src="/user/json/LoginService.js"></script>
	
	<script type="text/javascript">
	
	$(function(){
		//从后台获取列表数据
		var db = new BAAADBService();
		var paginate = new Eht.Paginate();
		var res = new Eht.Responder();
		var p = new Eht.Paginate();
		p.pageCount = 10;
		var tv = new Eht.TableView({selector:"#dg",paginate:p});
		tv.loadData(function(page,res){
			db.find({ "BAAA_DB04[like]" :$("#txtName").val().trim()},page,res);
		});
		//查询按钮事件
		$("#qryBtn").click(function(){
			p.indexPage=1;
			tv.refresh();
		})
		
		var sso = new SSO();
		sso.async = false;
		var user = sso.getUser();
		var name=user.name;
		$("#topName").html(name);
		$("#listName").html(name);
		$("#userEmail").html(user.orgname);
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

<body>
	<div id="wrapper" class="sidebar-mini">
		<div id="top-nav" class="skin-6 fixed">
			<div class="brand">
				<span>智慧社区</span> <span class="text-toggle"> Admin</span>
			</div>
			<!-- /brand -->
			<button type="button" class="navbar-toggle pull-left"
				id="sidebarToggle">
				<span class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<button type="button" class="navbar-toggle pull-left hide-menu"
				id="menuToggle">
				<span class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<ul class="nav-notification clearfix">
			<li class="角色 dropdown"><a class="dropdown-toggle"
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
				<!-- /size-toggle -->
				<div class="search-block">
					<div class="input-group">
						<input type="text" class="form-control input-sm"
							placeholder="查询..."> <span class="input-group-btn">
							<button class="btn btn-default btn-sm" type="button">
								<i class="fa fa-search"></i>
							</button>
						</span>
					</div>
					<!-- /input-group -->
				</div>
				<!-- /search-block -->
				<div class="main-menu">
					<ul>
						<li><a href="screen.jsp"> <span class="menu-icon">
									<i class="fa fa-desktop fa-lg"></i>
							</span> <span class="text"> 决策剧场 </span> <span class="menu-hover"></span>
						</a></li>
						<li><a href="resources.jsp"> <span class="menu-icon">
									<i class="fa fa-flag fa-lg"></i>
							</span> <span class="text"> 社区资源 </span> <span class="menu-hover"></span>
						</a></li>
						<li><a href="tinformation.jsp"> <span class="menu-icon">
									<i class="fa fa-group fa-lg"></i>
							</span> <span class="text"> 人才资源 </span> <span
								class="badge badge-success bounceIn animation-delay5">9</span> <span
								class="menu-hover"></span>
						</a></li>
						<li class="active openable open"><a href="suballowances.jsp">
								<span class="menu-icon"> <i class="fa fa-star fa-lg"></i>
							</span> <span class="text"> 低保人群 </span> <span class="menu-hover"></span>
						</a></li>
						<li><a href="unemploypeople.jsp"> <span
								class="menu-icon"> <i class="fa fa-umbrella fa-lg"></i>
							</span> <span class="text"> 失业人员 </span> <span class="menu-hover"></span>
						</a></li>
						<li><a href="childManager.jsp"> <span class="menu-icon">
									<i class="fa fa-bookmark fa-lg"></i>
							</span> <span class="text"> 儿童信息 </span> <span
								class="badge badge-danger bounceIn animation-delay6">4</span> <span
								class="menu-hover"></span>
						</a></li>
						<li><a href="disabled.jsp"> <span class="menu-icon">
									<i class="fa fa-tasks fa-lg"></i>
							</span> <span class="text"> 残疾人员 </span> <small
								class="badge badge-warning bounceIn animation-delay7">New</small>
								<span class="menu-hover"></span>
						</a></li>
						<li>
							<a href="oldPeople.jsp">
								<span class="menu-icon">
									<i class="fa fa-user fa-lg"></i>
								</span>
								<span class="text">
									老年人信息
								</span>
								<small class="badge badge-warning bounceIn animation-delay7">New</small>
								<span class="menu-hover"></span>
							</a>
						</li>
						<li>
							<a href="safeReport.jsp">
								<span class="menu-icon">
									<i class="fa fa-dashboard fa-lg"></i>
								</span>
								<span class="text">
									安全隐患
								</span>
								<small class="badge badge-warning bounceIn animation-delay7">New</small>
								<span class="menu-hover"></span>
							</a>
						</li>
						<li>
							<a href="appealReport.jsp">
								<span class="menu-icon">
									<i class="fa fa-edit fa-lg"></i>
								</span>
								<span class="text">
									居民诉求
								</span>
								<small class="badge badge-warning bounceIn animation-delay7">New</small>
								<span class="menu-hover"></span>
							</a>
						</li>
						<li>
							<a href="../peoplePosition.jsp">
								<span class="menu-icon">
									<i class="fa fa-th fa-lg"></i>
								</span>
								<span class="text">
									地图监控
								</span>
								<small class="badge badge-warning bounceIn animation-delay7">New</small>
								<span class="menu-hover"></span>
							</a>
						</li>
					</ul>

					<div class="alert alert-info">Welcome to 智慧社区综合管理系统. Do not
						forget to check all my 社区资源管理s.</div>
				</div>
				<!-- /main-menu -->
			</div>
			<!-- /sidebar-inner scrollable-sidebar -->
		</aside>
		<div id="main-container">
			<div class="padding-md">
				<div class="panel panel-default table-responsive">
					<div class="panel-heading">
						<i class="fa fa-star fa-lg"></i> 低保人员查询 <!-- <span
							class="label label-info pull-right">790 项目</span> -->
					</div>
					<!--性别分布 -->
					<div class="col-md-4 col-sm-4">
							<div id="sxbChart" style="height: 200px; width: 100%"></div>
						<!-- /panel -->
					</div>
				
					<!--年龄性别分布图 -->
					<div class="col-md-4 col-sm-4">
							<div id="snlChart" style="height: 200px; width: 100%"></div>
					</div>
						<!--是否单身 -->
					<div class="col-md-4 col-sm-4">
							<div id="sdsChart" style="height: 200px; width: 100%"></div>
					</div>
					<div class="padding-md crfix">
					<div class="fg-toolbar ui-toolbar ui-widget-header ui-corner-tl ui-corner-tr ui-helper-clearfix">
					<div class="dataTables_filter"  id="dataTable_filter"><label><div class="input-group pull-right" style="width:200px;"><input type="text"  id="txtName"class="form-control input-sm" placeholder="请输入姓名" aria-controls="dataTable"><span class="input-group-btn"><button id="qryBtn" class="btn btn-default btn-sm" type="button"><i class="fa fa-search"></i></button></span></div></label></div>
					</div>
					<div id="dg">
							<div field="baaa_db04" label="姓名"></div>
							<div field="baaa_db13" label="性别"  width="60"></div>
							<!-- <div field="baaa_db05" label="家庭成员姓名"></div> -->
							<div field="baaa_db06" label="身份证号码"></div>
							<!-- <div field="baaa_db07" label="与户主关系"></div> -->
							<div field="baaa_db08" label="申请原因"  width="200"></div>
							<div field="baaa_db09" label="家庭人口"></div>
							<div field="baaa_db10" label="家庭类别"></div>
							<div field="baaa_db11" label="补助金额（元）"></div>
							<div field="orgname" label="所属社区"  width="100"></div>
					</div>
					</div>
					<!-- /.padding-md -->
				</div>
				<!-- /panel -->
			</div>
			<!-- /.padding-md -->
		</div>
		<!-- /main-container -->
	</div>
	<!-- /wrapper -->
	<!-- Logout confirmation -->
	<div class="custom-popup width-100"  id="logoutConfirm">
			<div class="padding-md">
				<h4 class="m-top-none">确认退出吗？</h4>
			</div>
			<div class="text-center">
				<a class="btn btn-success m-right-sm"   onclick="logout()">确定</a>
				<a class="btn btn-danger logoutConfirm_close">取消</a>
			</div>
		</div>
	<!-- Bootstrap -->
	<script src="bootstrap/js/bootstrap.min.js"></script>
	<!-- Modernizr -->
	<script src='js/modernizr.min.js'></script>
	<!-- Pace -->
	<script src='js/pace.min.js'></script>
	<!-- Popup Overlay -->
	<script src='js/jquery.popupoverlay.min.js'></script>
	<!-- Slimscroll -->
	<script src='js/jquery.slimscroll.min.js'></script>
	<!-- Cookie -->
	<script src='js/jquery.cookie.min.js'></script>
	<script src="js/endless/endless.js"></script>
</body>
</html>
