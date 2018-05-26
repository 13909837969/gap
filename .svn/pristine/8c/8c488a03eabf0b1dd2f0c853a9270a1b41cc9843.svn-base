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
	
	<link rel="stylesheet" type="text/css" href="/user/resources/css/core/default/eht.ui.core.css"/>
	<script type="text/javascript" src="/user/resources/script/jquery/eht.rmi.json.js"></script>
	<script type="text/javascript" src="/user/resources/script/jquery/jquery-1.11.0.min.js"></script>
	<script type="text/javascript" src="/user/resources/script/core/eht.ui.utils.js"></script>
	<script type="text/javascript" src="/user/resources/script/core/eht.rmi.responder.js"></script>
	<script type="text/javascript" src="/user/resources/script/core/eht.rmi.paginate.js"></script>
	<script type="text/javascript" src="../eht.ui.tableview.querycss.js"></script>
	
	<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=rlBfGG2RtC3vgylVySAenO30Ihk31FZO"></script>
	<script type="text/javascript" src="../../../json/CAAAService.js"></script>
    <script type="text/javascript" src="../../../json/SSO.js"></script>
	<script type="text/javascript" src="/user/json/LoginService.js"></script>
	
	<script type="text/javascript">
	
	$(function(){
		var zy= new CAAAService();
		var paginate = new Eht.Paginate();
		var res = new Eht.Responder();
		var p = new Eht.Paginate();
		p.pageCount = 10;
		var tv = new Eht.TableView({selector:"#dg",paginate:p});
		tv.transColumn("map",function(data){
			var map = $('<span class="label label-success"><i class="fa fa-map-marker fa-lg"></i></span>');
			map.data(data);
			map.click(function(){
				var ds = $(this).data();
				modalShow('#smallModal', '', function(){
					modalDataInit(ds);
					}
				);
			});
			return map;
		});
		tv.loadData(function(page,res){
			zy.find({ "CAAA02[like]" :$("#txtName").val().trim()},page,res);
		});
		
		$("#qryBtn").click(function(){
			tv.refresh();
		})
		
		
		/* var sso = new SSO();
		sso.async = false;
		var user = sso.getUser();
		var name=user.name; */
		var sso = new SSO();
		sso.getUser(new Eht.Responder({success:function(data){
			var name=data.name;
			$("#topName").html(name);
			$("#listName").html(name);
			$("#userEmail").html(data.orgname);
		}}));
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
	<!-- Overlay Div -->
	<div id="overlay" class="transparent"></div>

	<div id="wrapper" class="sidebar-mini">
		<div id="top-nav" class="skin-6 fixed">
			<div class="brand">
				<span>智慧社区</span>
				<span class="text-toggle"> Admin</span>
			</div><!-- /brand -->
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
		</div><!-- /top-nav-->
		
		<aside class="fixed skin-6">			
			<div class="sidebar-inner scrollable-sidebar">
				<div class="search-block">
					<div class="input-group">
						<input type="text" class="form-control input-sm" placeholder="查询...">
						<span class="input-group-btn">
							<button class="btn btn-default btn-sm" type="button"><i class="fa fa-search"></i></button>
						</span>
					</div><!-- /input-group -->
				</div><!-- /search-block -->
				<div class="main-menu">
					<ul>
						<li >
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
						<li class="active openable open">
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
						<li >
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
						<li>
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
					
				</div><!-- /main-menu -->
			</div><!-- /sidebar-inner scrollable-sidebar -->
		</aside>
		<div id="main-container">
			<div class="padding-md">
				<div class="panel panel-default table-responsive">
					<div class="panel-heading">
						<i class="fa fa-flag fa-lg"></i> 社区资源查询
						<span class="label label-info pull-right" onclick="modalShow('#bigModal', '', function(){allModalDataInit()});"><i class="fa fa-map-marker fa-lg"></i></span>
					</div>
					<div class="padding-md crfix">
					<div class="fg-toolbar ui-toolbar ui-widget-header ui-corner-tl ui-corner-tr ui-helper-clearfix">
					<div class="dataTables_filter"  id="dataTable_filter"><label><div class="input-group pull-right" style="width:200px;"><input type="text"  id="txtName"class="form-control input-sm" placeholder="请输入资源名称" aria-controls="dataTable"><span class="input-group-btn"><button id="qryBtn" class="btn btn-default btn-sm" type="button"><i class="fa fa-search"></i></button></span></div></label></div>
					</div>
					<div id="dg">
						<div field="caaa02" label="名称"></div>
						<div field="caaa03" label="地址"   align="left"  width="350"></div>
						<div field="caaa04" label="场所类型"   code = "[{v:1,d:'活动场地'},{v:2,d:'广场'},{v:3,d:'健身馆'}]"></div>
						<div field="caaa05" label="建立时间"></div>
						<div field="caaa06" label="主管单位"></div>
						<!-- <div field="cts" label="创建时间"></div> -->
						<div field="map"  align="center"  label="在地图上显示"  width="100"></div>
					</div>
					</div><!-- /.padding-md -->
				</div><!-- /panel -->
			</div><!-- /.padding-md -->
		</div><!-- /main-container -->
	</div><!-- /wrapper -->
	<a href="" id="scroll-to-top" class="hidden-print"><i class="fa fa-chevron-up"></i></a>
	
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
	
	<script src="js/jquery-1.10.2.min.js"></script>
    <script src="bootstrap/js/bootstrap.min.js"></script>
	<script src='js/jquery.dataTables.min.js'></script>	
	<script src='js/modernizr.min.js'></script>
	<script src='js/pace.min.js'></script>
	<script src='js/jquery.popupoverlay.min.js'></script>
	<script src='js/jquery.slimscroll.min.js'></script>
	<script src='js/jquery.cookie.min.js'></script>
	<script src="js/endless/endless.js"></script>
	
	<script>
        //animate.css动画触动一次方法
        $.fn.extend({
            animateCss: function (animationName) {
                var animationEnd = 'webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend';
                this.addClass('animated ' + animationName).one(animationEnd, function() {
                    $(this).removeClass('animated ' + animationName);
                });
            }
        });
        /**
         * 显示模态框方法
         * @param targetModel 模态框选择器，jquery选择器
         * @param animateName 弹出动作
         * @ callback 回调方法
         */
        
        var modalShow = function(targetModel, animateName, callback){
            animateName = 'fadeOutUp';
            console.log(targetModel + " " + animateName);
            $(targetModel).show(function(){
            	
            }).animateCss(animateName);
            //callback.call(this);
            callback();
        }
        var map;
        function addMarker(item) {
        	 map = new BMap.Map("container");          // 创建地图实例  
        	var point1 = new BMap.Point(item.lat, item.lng);  // 创建点坐标  
			map.centerAndZoom(point1, 15);   
			map.enableScrollWheelZoom(); //启用滚轮放大缩小
    		var point = new BMap.Point(item.lat, item.lng)
    		var myIcon = new BMap.Icon("iocn_red.png", new BMap.Size(29, 36));  
    		var marker = new BMap.Marker(point, {icon: myIcon});  
    		map.addOverlay(marker);
    		var opts = {
    			width : 100, // 信息窗口宽度
    			height : 20, // 信息窗口高度
    			title : "资源基本信息", // 信息窗口标题
    			enableMessage : true
    		}
    		var infoWindow = new BMap.InfoWindow("名称："+item.caaa02+"</br>地址："+item.caaa03,opts); 
    		marker.addEventListener("click", function() {
    			map.openInfoWindow(infoWindow, point); //开启信息窗口
    		});
    	}
        /**
         * 隐藏模态框方法
         * @param targetModel 模态框选择器，jquery选择器
         * @param animateName 隐藏动作
         * @ callback 回调方法
         */
        var modalHide = function(targetModel, animateName, callback){
            animateName='bounceOutUp';
            $(targetModel).children().click(function(e){e.stopPropagation()});
            $(targetModel).animateCss(animateName);
            $(targetModel).delay(0).hide(1,function(){
                $(this).removeClass('animated ' + animateName);
            });
            if(callback){
            	callback.call(this);
            }
        }
        var modalDataInit = function(info){
        	addMarker(info);
        }
        
        var allMap;
        var allModalDataInit=function(){
        	allMap = new BMap.Map("allcontainer");          // 创建地图实例  
        	allMap.centerAndZoom(new BMap.Point(118.998103, 42.286232), 16);
        	allMap.addControl(new BMap.ScaleControl()); // 添加比例尺控件
        	allMap.enableScrollWheelZoom(); //启用滚轮放大缩小
    		var mapStyle = {
    			features : [ "road", "building", "water", "land" ],//隐藏地图上的poi
    			style : "road" //设置地图风格为高端黑
    		}
    		allMap.setMapStyle(mapStyle);
    		var zy= new CAAAService();
    		//获取居民位置信息
    		zy.find({}, null, new Eht.Responder({
    			success : function(data) {
    				debugger;
    				//从后台返回的数据 data
    				if (data.rows != null) {
    					var items = data.rows;
    					for (var i = 0; i < items.length; i++) {
    						addResourceMarker(items[i]);
    					}
    				}
    			}
    		}));
         	
        	
        }
    	
    	function addResourceMarker(item) {
    		var point1 = new BMap.Point(item.lat, item.lng);  // 创建点坐标  
         	allMap.centerAndZoom(point1, 15);   
         	allMap.enableScrollWheelZoom(); //启用滚轮放大缩小
     		var point = new BMap.Point(item.lat, item.lng)
     		var myIcon = new BMap.Icon("iocn_red.png", new BMap.Size(29, 36));  
     		var marker = new BMap.Marker(point, {icon: myIcon});  
     		allMap.addOverlay(marker);
     		var opts = {
     			width : 100, // 信息窗口宽度
     			height : 20, // 信息窗口高度
     			title : "资源基本信息", // 信息窗口标题
     			enableMessage : true
     		}
     		var infoWindow = new BMap.InfoWindow("名称："+item.caaa02+"</br>地址："+item.caaa03,opts); 
     		marker.addEventListener("click", function() {
     			allMap.openInfoWindow(infoWindow, point); //开启信息窗口
     		});
    	}
    </script>
 <div class="modal bs-example-modal-lg"   id="smallModal">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
					<button type="button" onclick="modalHide('#smallModal', '');"
						class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span><span class="sr-only">Close</span>
					</button>
					<h4 class="modal-title"><i class="fa fa-map-marker fa-lg"></i>资源位置 </h4>
            </div>
			 <div id="container" style="height:500px;"></div> 
          
        </div>
    </div>
</div>
<div class="modal bs-example-modal-lg"   id="bigModal">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
					<button type="button" onclick="modalHide('#bigModal', '');"
						class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span><span class="sr-only">Close</span>
					</button>
					<h4 class="modal-title"><i class="fa fa-map-marker fa-lg"></i>社区资源分布情况</h4>
            </div>
			 <div id="allcontainer" style="height:500px;"></div> 
        </div>
    </div>
</div>
	
  </body>
</html>
