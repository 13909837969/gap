<%@ page language="java" contentType="text/html; charset=UTF-8"  	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>矫正人员综合管理系统</title>
<jsp:include page="../rpcomm.jsp"></jsp:include>
<link rel="stylesheet" type="text/css" href="largeScree.css" />
<link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="css/iCheck/all.css">
<link href="css/font-awesome.min.css" rel="stylesheet">
<link href="css/pace.css" rel="stylesheet">
<link href="css/jquery.dataTables_themeroller.css" rel="stylesheet">
<link href="css/endless.css" rel="stylesheet">
<link href="css/endless-skin.css" rel="stylesheet">
<script src="js/jquery-1.10.2.min.js"></script>
 <script type="text/javascript" src="../../json/RptLargeScreenService.js"></script>
<script type="text/javascript" src="../../json/EAAAService.js"></script>
<script type="text/javascript" src="../../json/SSO.js"></script>
<script type="text/javascript" src="/user/json/LoginService.js"></script>
<script type="text/javascript" src="http://api.map.baidu.com/library/TextIconOverlay/1.2/src/TextIconOverlay_min.js"></script>
<script type="text/javascript" src="http://api.map.baidu.com/library/MarkerClusterer/1.2/src/MarkerClusterer.js"></script>
<script type="text/javascript">
	var bmap,num=0,markers = [],markerClusterer;
	$(function() {
		bmap = new BMap.Map("container"); // 创建地图实例  
		bmap.centerAndZoom(new BMap.Point(118.999803, 42.286032), 15);
		//map.centerAndZoom("赤峰市红山区", 15);                 // 初始化地图，设置中心点坐标和地图级别  
		bmap.addControl(new BMap.NavigationControl()); // 添加平移缩放控件
		bmap.addControl(new BMap.ScaleControl()); // 添加比例尺控件
		bmap.addControl(new BMap.OverviewMapControl()); //添加缩略地图控件
		bmap.enableScrollWheelZoom(); //启用滚轮放大缩小
		bmap.addControl(new BMap.MapTypeControl()); //添加地图类型控件
		var mapStyle = {
			features : [ "road", "building", "water", "land" ],//隐藏地图上的poi
			style : "road" //设置地图风格为高端黑
		}
		bmap.setMapStyle(mapStyle);
		showMarker();
		//添加百度地图
		loadJm();
		
		//setInterval('loadJm()', 10000); //指定60秒刷新一次 
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

	function loadJm() {
		//清空当前地图信息
		var rptLargeScreenService = new RptLargeScreenService();
		//在地图上加载所有的在线居民位置信息
		var rptLargeScreenService = new RptLargeScreenService();
		var paginate = new Eht.Paginate();
		num=0;
		if(num<10){
			num=num+1;
		}else{
			num=0;
		}
		//获取居民位置信息
		rptLargeScreenService.findJmdl({pageNum:num}, paginate, new Eht.Responder({
			success : function(data) {
				markers = [];
				//从后台返回的数据 data
				if (data.rows != null) {
					var items = data.rows;
					for (var i = 0; i < items.length; i++) {
						addMarker(items[i]);
					}
					 markerClusterer = new BMapLib.MarkerClusterer(bmap, {markers:markers});
				}
			}
		}));
	}
	
	//添加居民位置
	function addMarker(item) {
		var point = new BMap.Point(item.lat, item.lng)
		var myIcon = new BMap.Icon("people.png", new BMap.Size(29, 36));  
		var marker = new BMap.Marker(point, {icon: myIcon});  
		//map.addOverlay(marker);
		markers.push(marker);
		/* var opts = {
			width : 200, // 信息窗口宽度
			height : 60, // 信息窗口高度
			title : "居民基本信息", // 信息窗口标题
			enableMessage : true
		//设置允许信息窗发送短息
		}
		var tel=item.aaab03;
		if(tel==undefined){
			tel="";
		}
		var infoWindow = new BMap.InfoWindow("姓名：" + item.aaab07
				+ "</br>联系电话：" +tel ,opts); 
		marker.addEventListener("click", function() {
			bmap.openInfoWindow(infoWindow, point); //开启信息窗口
		}); */
	}
	
	function showMarker()
	{
		bmap.clearOverlays();
		if(markerClusterer!=null)
			markerClusterer.clearMarkers();
		var jmxx=$("#jmxx").children("div").eq(0).attr('aria-checked');
		var safexx=$("#safexx").children("div").eq(0).attr("aria-checked");
		var sgdl=$("#sgdl").children("div").eq(0).attr("aria-checked");
		var trqxl=$("#trqxl").children("div").eq(0).attr("aria-checked");
		var tcckdw=$("#tcckdw").children("div").eq(0).attr("aria-checked");
		var other=$("#other").children("div").eq(0).attr("aria-checked");
		if(jmxx=="true"){
			loadJm();
		}
		if(sgdl=="true"){
			loadSafe('01')//路政施工
		}
		if(zlssg=="true"){
			loadSafe('02');//自来水施工
		}
		if(trqxl=="true"){
			loadSafe('03');//天然气泄露
		}
		if(tcckdw=="true"){
			loadSafe('04');//停产的厂矿或单位
		}
		if(other=="true"){
			loadSafe('99');//停产的厂矿或单位
		}
	}
	
	function loadSafe(type) {
		//清空当前地图信息
		var ea= new EAAAService();
		var p = new Eht.Paginate();
		p.pageCount = 10000;
		//获取居民位置信息
		ea.findAll({ "EAAA05[eq]" :type},p, new Eht.Responder({
			success : function(data) {
				//从后台返回的数据 data
				if (data.rows != null) {
					debugger;
					var items = data.rows;
					for (var i = 0; i < items.length; i++) {
						addSafeMarker(items[i],type);
					}
				}
			}
		}));
	}
	
	//增加安全隐患数据
	function addSafeMarker(item,type) {
		debugger;
		var point = new BMap.Point(item.lng,item.lat)
		var marker = new BMap.Marker(point);
		var url="warn.jpg";
		if(type=="01"){
			url="2.png";//施工道路
		}
		if(type=="02"){
			url="1.png";//自来水施工
		}
		if(type=="03"){
			url="3.png";//天然气泄露
		}
		if(type=="04"){
			url="4.png";//停产的厂矿或单位
		}
		if(type=="99"){
			url="1.png";//其他安全隐患
		}
		var myIcon = new BMap.Icon(url, new BMap.Size(35, 35));  
		var marker = new BMap.Marker(point, {icon: myIcon});  
		marker.setAnimation(BMAP_ANIMATION_BOUNCE);
		bmap.addOverlay(marker);
		var opts = {
			width : 230, // 信息窗口宽度
			height : 100, // 信息窗口高度
			title : "安全隐患信息", // 信息窗口标题
			enableMessage : true
		//设置允许信息窗发送短息
		}
		var tel= item.aaab03;
		if(tel==undefined){
			tel="";
		}
		var infoWindow = new BMap.InfoWindow("标题：" + item.eaaa02
				+ "</br>上报人电话:" +tel + "</br>位置:" + item.eaaa03 ,opts); 
		marker.addEventListener("click", function() {
			bmap.openInfoWindow(infoWindow, point); //开启信息窗口
		});
	}
	
</script>
<style type="text/css">
#container {
	width: 100%;
	height: 100%;
}
</style>
</head>
<body>
	<div id="wrapper" class="sidebar-mini">
		<div id="top-nav" class="skin-6 fixed">
			<div class="brand">
				<span>矫正人员</span>
			</div>
			<button type="button" class="navbar-toggle pull-left" id="sidebarToggle">
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
			<button type="button" class="navbar-toggle pull-left hide-menu" id="menuToggle">
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
			<ul class="nav-notification clearfix">
			<li class="dropdown"><a class="dropdown-toggle"
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
		<aside class="fixed skin-6">			
			<div class="sidebar-inner scrollable-sidebar">
				<div class="search-block">
					<div class="input-group">
						<input type="text" class="form-control input-sm" placeholder="查询...">
						<span class="input-group-btn">
							<button class="btn btn-default btn-sm" type="button"><i class="fa fa-search"></i></button>
						</span>
					</div>
				</div>
				<div class="main-menu">
					<ul>
						<li>
							<a href="screen.jsp">
								<span class="menu-icon">
									<i class="fa fa-desktop fa-lg"></i> 
								</span>
								<span class="text">
									决策剧场
								</span>
								<span class="menu-hover"></span>
							</a>
						</li>
						<li >
							<a href="resources.jsp">
								<span class="menu-icon">
									<i class="fa fa-flag fa-lg"></i>
								</span>
								<span class="text">
									社区资源
								</span>
								<span class="menu-hover"></span>
							</a>
						</li>
						<li>
							<a href="tinformation.jsp">
								<span class="menu-icon">
									<i class="fa fa-group fa-lg"></i>
								</span>
								<span class="text">
									人才资源
								</span>
								<span class="badge badge-success bounceIn animation-delay5">9</span>
								<span class="menu-hover"></span>
							</a>
						</li>
						<li>
							<a href="suballowances.jsp">
								<span class="menu-icon">
									<i class="fa fa-star fa-lg"></i>
								</span>
								<span class="text">
									低保人群
								</span>
								<span class="menu-hover"></span>
							</a>
						</li>
						<li>
							<a href="unemploypeople.jsp">
								<span class="menu-icon">
									<i class="fa fa-umbrella fa-lg"></i>
								</span>
								<span class="text">
									失业人员
								</span>
								<span class="menu-hover"></span>
							</a>
						</li>
						<li >
							<a href="childManager.jsp">
								<span class="menu-icon">
									<i class="fa fa-bookmark fa-lg"></i>
								</span>
								<span class="text">
									儿童信息
								</span>
								<span class="badge badge-danger bounceIn animation-delay6">4</span>
								<span class="menu-hover"></span>
							</a>
						</li>
						<li>
							<a href="disabled.jsp">
								<span class="menu-icon">
									<i class="fa fa-tasks fa-lg"></i> 
								</span>
								<span class="text">
									残疾人员
								</span>
								<small class="badge badge-warning bounceIn animation-delay7">New</small>
								<span class="menu-hover"></span>
							</a>
						</li>
						<li >
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
						<li class="active openable open">
							<a href="peoplePosition.jsp">
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
				</div>
			</div>
		</aside>
		<div id="main-container" >
			<div class="padding-md" >
				<div class="panel panel-default table-responsive">
					<div class="panel-heading">
						<i class="fa fa-th fa-lg"></i> 地图监控
					</div>
					<div class="padding-md crfix">
					<div class="fg-toolbar ui-toolbar ui-widget-header ui-corner-tl ui-corner-tr ui-helper-clearfix"   style="margin-top:1px;margin-bottom:-5px;">
							<label  style="display: inline-block;max-width: 100%;margin-bottom:10px;font-weight: 600"    id="jmxx"  >
			                  <input type="checkbox"     class="flat-red"  checked="checked" />   社区居民分布&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			                </label>
			                <label   id="zlssg" >
			                  <input type="checkbox"   class="flat-red"     />   自来水施工&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			                </label>
			                <label   id="sgdl" >
			                  <input type="checkbox"   class="flat-red"     />   施工道路&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			                </label>
			                <label   id="trqxl" >
			                  <input type="checkbox"   class="flat-red"     />   天然气泄露&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			                </label>
			                <label   id="tcckdw" >
			                  <input type="checkbox"   class="flat-red"     />   停产的厂矿或单位&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			                </label>
			                <label   id="other" >
			                  <input type="checkbox"   class="flat-red"     />   其他隐患&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			                </label>
					<div  style="margin-top:-16px;margin-bottom:-10px;" class="dataTables_filter"  id="dataTable_filter"><label><div class="input-group pull-right" style="width:200px;"><input type="text"  id="txtName"class="form-control input-sm" placeholder="请输入地址进行定位" aria-controls="dataTable"><span class="input-group-btn"><button id="qryBtn" class="btn btn-default btn-sm" type="button"><i class="fa fa-search"></i></button></span></div></label></div>
					</div>
					<div id="container"   style="width:100%;height:600px;"></div>
					</div>
				</div>
			</div>
		</div>
	</div>
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
   <!-- Jquery -->
	<script src="js/jquery-1.10.2.min.js"></script>
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
	<script src="css/iCheck/icheck.js"></script>
	<script>
	  $(function () {
		    $('input[type="checkbox"].flat-red, input[type="radio"].flat-red').iCheck({
		      checkboxClass: 'icheckbox_flat-green',
		      radioClass: 'iradio_flat-green'
		    });
		    $("#jmxx").children("div").eq(0).attr('aria-checked','true');
		    $("#jmxx").children("div").eq(0).children("ins").eq(0).click(function(){
		    	showMarker();
		    });
		    $("#jmxx").click(function(){
		    	showMarker();
		    });
		    $("#zlssg").children("div").eq(0).children("ins").eq(0).click(function(){
		    	showMarker();
		    });
		    $("#zlssg").click(function(){
		    	showMarker();
		    });
		    
		    $("#sgdl").children("div").eq(0).children("ins").eq(0).click(function(){
		    	showMarker();
		    });
		    $("#sgdl").click(function(){
		    	showMarker();
		    });
		    
		    $("#trqxl").children("div").eq(0).children("ins").eq(0).click(function(){
		    	showMarker();
		    });
		    $("#trqxl").click(function(){
		    	showMarker();
		    });
		    
		    $("#tcckdw").children("div").eq(0).children("ins").eq(0).click(function(){
		    	showMarker();
		    });
		    $("#tcckdw").click(function(){
		    	showMarker();
		    });
		    
		    
		    $("#other").children("div").eq(0).children("ins").eq(0).click(function(){
		    	showMarker();
		    });
		    $("#other").click(function(){
		    	showMarker();
		    });
		   
    	});
	  </script>
  </body>
</html>