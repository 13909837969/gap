<%@ page language="java" contentType="text/html; charset=UTF-8"  	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>内蒙古公共法律服务智能一体化平台</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="">
<meta name="author" content="">
<script type="text/javascript" src="/supervise/module/rp/js/data/mapdata.js"></script>
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
<script type="text/javascript" src="js/china.js"></script>
<script type="text/javascript" src="js/data.js"></script>
<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=rlBfGG2RtC3vgylVySAenO30Ihk31FZO"></script>


<link rel="stylesheet" type="text/css" href="/user/resources/css/core/default/eht.ui.core.css"/>
	<script type="text/javascript" src="/user/resources/script/jquery/eht.rmi.json.js"></script>
	<script type="text/javascript" src="/user/resources/script/core/eht.ui.utils.js"></script>
	<script type="text/javascript" src="/user/resources/script/core/eht.rmi.responder.js"></script>
	<script type="text/javascript" src="/user/resources/script/core/eht.rmi.paginate.js"></script>
	<script type="text/javascript" src="../../json/JzJzryjbxxService.js"></script>
	
	<script type="text/javascript">
	
	
	
	function logout(){
		var ls = new LoginService();
		ls.logout(new Eht.Responder({success:function(data){
			//removeChatListen();
			window.top.location.href = data.value;
		}}));
	}
	
	

	 var convertData = function (datatemp) {
	           var res = [];
	           for (var i = 0; i < datatemp.length; i++) {
	               var geoCoord = geoCoordMap[datatemp[i].name];
	               if (geoCoord) {
	                   res.push({
	                       name: datatemp[i].name,
	                       value: geoCoord.concat(datatemp[i].value)
	                   });
	               }
	           }
	           return res;
	       };

	       var option = { 
	    		   baseOption: {
		    		 timeline: {
		                   axisType: 'category',
		                   orient: 'vertical',
		                   autoPlay: true,
		                   inverse: true,
		                   playInterval: 1000,
		                   left: null,
		                   right: 10,
		                   top: 20,
		                   bottom: 20,
		                   width: 55,
		                   height: null,
		                   label: {
		                       normal: {
		                           textStyle: {
		                               color: '#ddd'
		                           }
		                       },
		                       emphasis: {
		                           textStyle: {
		                               color: '#fff'
		                           }
		                       }
		                   },
		                   symbol: 'none',
		                   lineStyle: {
		                       color: '#555'
		                   },
		                   checkpointStyle: {
		                       color: '#bbb',
		                       borderColor: '#777',
		                       borderWidth: 2
		                   },
		                   controlStyle: {
		                       showNextBtn: false,
		                       showPrevBtn: false,
		                       normal: {
		                           color: '#666',
		                           borderColor: '#666'
		                       },
		                       emphasis: {
		                           color: '#aaa',
		                           borderColor: '#aaa'
		                       }
		                   },
		                   data: []
		               },
	           backgroundColor: '#404a59',
	           title: {
	               text: '全区矫正人员分布情况',
	               //subtext: 'data from PM25.in',
	               //sublink: 'http://www.pm25.in',
	               left: 'center',
	               textStyle: {
	                   color: '#fff'
	               }
	           },
	           tooltip : {
	               trigger: 'item'
	           },
	           bmap: {
	               center: [104.114129, 37.550339],
	               zoom: 5,
	               roam: true,
	               mapStyle: {
	                   styleJson: [
	                           {
	                               "featureType": "water",
	                               "elementType": "all",
	                               "stylers": {
	                                   "color": "#044161"
	                               }
	                           },
	                           {
	                               "featureType": "land",
	                               "elementType": "all",
	                               "stylers": {
	                                   "color": "#004981"
	                               }
	                           },
	                           {
	                               "featureType": "boundary",
	                               "elementType": "geometry",
	                               "stylers": {
	                                   "color": "#064f85"
	                               }
	                           },
	                           {
	                               "featureType": "railway",
	                               "elementType": "all",
	                               "stylers": {
	                                   "visibility": "off"
	                               }
	                           },
	                           {
	                               "featureType": "highway",
	                               "elementType": "geometry",
	                               "stylers": {
	                                   "color": "#004981"
	                               }
	                           },
	                           {
	                               "featureType": "highway",
	                               "elementType": "geometry.fill",
	                               "stylers": {
	                                   "color": "#005b96",
	                                   "lightness": 1
	                               }
	                           },
	                           {
	                               "featureType": "highway",
	                               "elementType": "labels",
	                               "stylers": {
	                                   "visibility": "off"
	                               }
	                           },
	                           {
	                               "featureType": "arterial",
	                               "elementType": "geometry",
	                               "stylers": {
	                                   "color": "#004981"
	                               }
	                           },
	                           {
	                               "featureType": "arterial",
	                               "elementType": "geometry.fill",
	                               "stylers": {
	                                   "color": "#00508b"
	                               }
	                           },
	                           {
	                               "featureType": "poi",
	                               "elementType": "all",
	                               "stylers": {
	                                   "visibility": "off"
	                               }
	                           },
	                           {
	                               "featureType": "green",
	                               "elementType": "all",
	                               "stylers": {
	                                   "color": "#056197",
	                                   "visibility": "off"
	                               }
	                           },
	                           {
	                               "featureType": "subway",
	                               "elementType": "all",
	                               "stylers": {
	                                   "visibility": "off"
	                               }
	                           },
	                           {
	                               "featureType": "manmade",
	                               "elementType": "all",
	                               "stylers": {
	                                   "visibility": "off"
	                               }
	                           },
	                           {
	                               "featureType": "local",
	                               "elementType": "all",
	                               "stylers": {
	                                   "visibility": "off"
	                               }
	                           },
	                           {
	                               "featureType": "arterial",
	                               "elementType": "labels",
	                               "stylers": {
	                                   "visibility": "off"
	                               }
	                           },
	                           {
	                               "featureType": "boundary",
	                               "elementType": "geometry.fill",
	                               "stylers": {
	                                   "color": "#029fd4"
	                               }
	                           },
	                           {
	                               "featureType": "building",
	                               "elementType": "all",
	                               "stylers": {
	                                   "color": "#1a5787"
	                               }
	                           },
	                           {
	                               "featureType": "label",
	                               "elementType": "all",
	                               "stylers": {
	                                   "visibility": "off"
	                               }
	                           }
	                   ]
	               }
	           },
	           legend: {
	               orient: 'vertical',
	               y: 'bottom',
	               x:'right',
	               data:['全区矫正人员分布情况'],
	               textStyle: {
	                   color: '#fff'
	               }
	           },
	           series : [
	  	               {
	  	                   name: 'pm2.5',
	  	                   type: 'scatter',
	  	                   coordinateSystem: 'bmap',
	  	                   data: convertData(data[0]),
	  	                   symbolSize: function (val) {
	  	                       return val[2] / 10;
	  	                   },
	  	                   label: {
	  	                       normal: {
	  	                           formatter: '{b}',
	  	                           position: 'right',
	  	                           show: false
	  	                       },
	  	                       emphasis: {
	  	                           show: true
	  	                       }
	  	                   },
	  	                   itemStyle: {
	  	                       normal: {
	  	                           color: '#ddb926'
	  	                       }
	  	                   }
	  	               },
	  	               {
	  	                   name: 'Top 5',
	  	                   type: 'effectScatter',
	  	                   coordinateSystem: 'bmap', 
	  	                   data: convertData(data[0].sort(function (a, b) {
	  	                       return b.value - a.value;
	  	                   }).slice(0, 6)),
	  	                   symbolSize: function (val) {
	  	                       return val[2] / 10;
	  	                   },
	  	                   showEffectOn: 'render',
	  	                   rippleEffect: {
	  	                       brushType: 'stroke'
	  	                   },
	  	                   hoverAnimation: true,
	  	                   label: {
	  	                       normal: {
	  	                           formatter: '{b}',
	  	                           position: 'right',
	  	                           show: true
	  	                       }
	  	                   },
	  	                   itemStyle: {
	  	                       normal: {
	  	                           color: '#f4e925',
	  	                           shadowBlur: 10,
	  	                           shadowColor: '#333'
	  	                       }
	  	                   },
	  	                   zlevel: 1
	  	               }
	  	           ]
	       }/* ,
	       options:[] */
	       };
	       
	       $(function(){
	    	   
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
	   		
	   		     var  syrChart = echarts.init(document.getElementById('syrChart'));

		   		/*  for (var n = 0; n < data1.timeline.length; n++) {
		   	           option.baseOption.timeline.data.push(data1.timeline[n]);
		   	           option.options.push({
		   	               title: {
		   	                   show: true,
		   	                   'text': data1.timeline[n] + '全区矫正人员分布情况统计'
		   	               },
		   	               series: [
		   	  	               {
		   		                   name: 'pm2.5',
		   		                   type: 'scatter',
		   		                   coordinateSystem: 'bmap',
		   		                   data: convertData(data[n]),
		   		                   symbolSize: function (val) {
		   		                       return val[2] / 10;
		   		                   },
		   		                   label: {
		   		                       normal: {
		   		                           formatter: '{b}',
		   		                           position: 'right',
		   		                           show: false
		   		                       },
		   		                       emphasis: {
		   		                           show: true
		   		                       }
		   		                   },
		   		                   itemStyle: {
		   		                       normal: {
		   		                           color: '#ddb926'
		   		                       }
		   		                   }
		   		               },
		   		               {
		   		                   name: 'Top 5',
		   		                   type: 'effectScatter',
		   		                   coordinateSystem: 'bmap',
		   		                   data: convertData(data[n].sort(function (a, b) {
		   		                       return b.value - a.value;
		   		                   }).slice(0, 6)),
		   		                   symbolSize: function (val) {
		   		                       return val[2] / 10;
		   		                   },
		   		                   showEffectOn: 'render',
		   		                   rippleEffect: {
		   		                       brushType: 'stroke'
		   		                   },
		   		                   hoverAnimation: true,
		   		                   label: {
		   		                       normal: {
		   		                           formatter: '{b}',
		   		                           position: 'right',
		   		                           show: true
		   		                       }
		   		                   },
		   		                   itemStyle: {
		   		                       normal: {
		   		                           color: '#f4e925',
		   		                           shadowBlur: 10,
		   		                           shadowColor: '#333'
		   		                       }
		   		                   },
		   		                   zlevel: 0
		   		               }
		   		           ]
		   	           });
		   	       } */
		   		 debugger;
	   		     syrChart.setOption(option);
	   		
	   	});	       
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
			<div id="main-container">
				<div class="padding-md">
					<div class="row"  style="margin-top:5px;">
								<!--全区矫正人员分布情况  -->
								<div class="panel bg-info fadeInDown animation-delay4"  >
										<div id="syrChart" style="height:500px;"></div>
							</div>
					</div>
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
									<div class="value"  id="bdrs">3</div>
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
