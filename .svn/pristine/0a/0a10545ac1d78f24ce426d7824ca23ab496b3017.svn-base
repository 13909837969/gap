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
<script type="text/javascript" src="http://echarts.baidu.com/gallery/vendors/echarts/echarts-all-3.js"></script>
<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=rlBfGG2RtC3vgylVySAenO30Ihk31FZO"></script>
<script type="text/javascript" src="http://echarts.baidu.com/gallery/vendors/echarts/extension/bmap.min.js"></script>



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
	
	var convertData = function (data) {
	    var res = [];
	    for (var i = 0; i < data.length; i++) {
	        var geoCoord = geoCoordMap[data[i].name];
	        if (geoCoord) {
	            res.push({
	                name: data[i].name,
	                value: geoCoord.concat(data[i].value)
	            });
	        }
	    }
	    return res;
	};

 	var option = { 
		   baseOption: {
         backgroundColor: '#404a59',
         title: {
            // text: '全区矫正人员分布情况',
             //subtext: 'data from PM25.in',
             //sublink: 'http://www.pm25.in',
             y:10,
             left: 'center',
             textStyle: {
                 color: '#fff',
                 fontSize:25
             }
         },
         tooltip : {
             trigger: 'item'
         },
         bmap: {
             center: [118.078707,44.20227],
             zoom: 6,
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
             //data:['全区矫正人员分布情况'],
             textStyle: {
                 color: '#fff',
                 fontSize:16
             }
         },
         series : [
	               {
	                   name: '矫正人员数量',
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
	                   name: '矫正人员数量',
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
     },
     options:[]
     };
 $(function(){
   		
      	 var  syrChart = echarts.init(document.getElementById('syrChart'));
       	 syrChart.setOption(option);
       	 
       	 var i=2;
		 function hello(){
			 i++;
			 $("#online").html(1100-i);
		 	 $("#offline").html(100+i);
		 }
		 //使用方法名字执行方法 
		 var t1 = window.setInterval(hello,1000); 
 });
</script>
</head>
<body class="overflow-hidden" style="background: #202a32">
	<div id="wrapper" class="sidebar-mini"  style="background: #202a32">
			<div id="top-nav" class="fixed skin-6"  style="vertical-align: middle;display:table-cell;">
				<a href="#" class="brand"> <span  style="margin-left:20px;font-size:20pt;">内蒙古公共法律服务智能一体化平台</span> 
				</a>
			    <a href="jcfx_index.jsp"   style="margin-left:410px;" class="brand"> <span  style="font-size:14pt;">工作总揽</span> 
				</a>
				<a href="jcfx_index2.jsp" style="margin-left:10px;" class="brand"> <span  style="font-size:14pt;">社区矫正</span> 
				</a>
				<a href="jcfx_index4.jsp" style="margin-left:10px;" class="brand"> <span  style="font-size:14pt;color:#61a0a8;">人民调解</span> 
				</a>
				<a href="#"   style="margin-left:10px;"  class="brand"> <span  style="font-size:14pt;">法律援助</span> 
				</a>
				<a href="#"   style="margin-left:10px;"  class="brand"> <span  style="font-size:14pt;">法制宣传</span> 
				</a>
				<a href="#"    style="margin-left:10px;" class="brand"> <span  style="font-size:14pt;">法律服务</span> 
				</a> 
				<a href="#"    style="margin-left:10px;" class="brand"> <span  style="font-size:14pt;">安装帮教</span> 
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
					<div class="row"  style="margin-top:10px;">
								<!--全区矫正人员分布情况  -->
								<div class="panel bg-info fadeInDown animation-delay4" >
										<div id="ztChart"  style="margin-left:15px;margin-top:10px;height:500px;width:600px;position:absolute;z-index:9999"></div>
										<div id="syrChart" style="height:800px;">
										</div>
							</div>
					</div>
				</div>
			</div>
		</div>
		<div style="position:absolute;top:80px;left:20px;height:120px;width:350px;background:#202a32;">
			<div class="shijianpanel"  style="align:center;"><font  style="font-weight:bold;font-size:18pt;">1200 </font></div><div class="shijianpanel"  style="margin-left:70px;">在线人数 <font  style="font-weight:bold;font-size:18pt;"><span id="online">1022</span></font></div>
			<div class="shijianpanel">矫正人员总数</div><div class="shijianpanel"  style="margin-left:5px;"> 掉线人数 <font  style="font-weight:bold;font-size:18pt;"><span id="offline">178</span></font></div>
		</div>
		
		<div style="position:absolute;top:220px;left:20px;height:120px;width:350px;background:#202a32;">
			<div  class="shijianpanel"   style="width:100%;text-algin:center;padding-left: 65px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;今日签到情况</div>
		 	<div  class="shijianpanel"  style="width:100%;text-algin:center;">签到百分比  90%   &nbsp;&nbsp;&nbsp;      未签到人数     530</div>
		</div>
		<div style="position:absolute;top:360px;left:20px;height:120px;width:350px;background:#202a32;">
			<div class="shijianpanel">越界报警人数 <font color="red"  style="font-weight:bold;font-size:18pt;">30</font>申请外出  <font color="red" style="font-weight:bold;font-size:18pt;">6</font></div>
			<div class="shijianpanel">进禁区报警数 <font color="red"  style="font-weight:bold;font-size:18pt;">18</font></div>
		</div>
		
		<div style="position:absolute;top:500px;left:20px;height:120px;width:350px;background:#202a32;">
			<div  class="shijianpanel"   style="width:100%;text-algin:center;padding-left: 95px;">司法机构情况</div>
		 	<div  class="shijianpanel"  style="width:100%;text-algin:center;">机构总数  1500     &nbsp;&nbsp;&nbsp;      工作人员总数     530</div>
		</div>
		
		<div style="position:absolute;top:80px;right:20px;height:560px;width:350px;background:#202a32;opacity:0.8">
				<div class="shijianpanel"   style="font-size:24px;">各盟市矫正人员在线人数排名</div>
			   <div class="shijianpanel" >呼和浩特市</div><div  style="margin-left:2px;" class="shijianpanel2"><font color="red"  style="font-weight:bold;font-size:18pt;">  2134人    </font><font color="red"  style="font-weight:bold;font-size:18pt;">1500</font>    在线</div>
			   	<div class="shijianpanel">包头</div><div  style="margin-left:2px;" class="shijianpanel2"><font color="red"  style="font-weight:bold;font-size:18pt;">  2134人    </font><font color="red"  style="font-weight:bold;font-size:18pt;">1500</font>    在线</div>
			    <div class="shijianpanel">乌海</div><div  style="margin-right:2px;" class="shijianpanel2"><font color="red"  style="font-weight:bold;font-size:18pt;">  2134人    </font><font color="red"  style="font-weight:bold;font-size:18pt;">1500</font>    在线</div>
			   	<div class="shijianpanel">巴盟</div><div  style="text-align:left;" class="shijianpanel2"><font color="red"  style="font-weight:bold;font-size:18pt;">  2134人    </font><font color="red"  style="font-weight:bold;font-size:18pt;">1500</font>    在线</div>
				<div class="shijianpanel">阿拉善盟</div><div  style="margin-right:2px;" class="shijianpanel2"><font color="red"  style="font-weight:bold;font-size:18pt;">  2134人    </font><font color="red"  style="font-weight:bold;font-size:18pt;">1500</font>    在线</div>
			   	<div class="shijianpanel">鄂尔多斯市</div><div  style="text-align:left;" class="shijianpanel2"><font color="red"  style="font-weight:bold;font-size:18pt;">  2134人    </font><font color="red"  style="font-weight:bold;font-size:18pt;">1500</font>    在线</div>
			    <div class="shijianpanel">锡林郭勒盟</div><div  style="margin-right:2px;" class="shijianpanel2"><font color="red"  style="font-weight:bold;font-size:18pt;">  2134人    </font><font color="red"  style="font-weight:bold;font-size:18pt;">1500</font>    在线</div>
			   	<div class="shijianpanel">通辽市</div><div  style="text-align:left;" class="shijianpanel2"><font color="red"  style="font-weight:bold;font-size:18pt;">  2134人    </font><font color="red"  style="font-weight:bold;font-size:18pt;">1500</font>    在线</div>
				<div class="shijianpanel">赤峰市</div><div  style="margin-right:2px;" class="shijianpanel2"><font color="red"  style="font-weight:bold;font-size:18pt;">  2134人    </font><font color="red"  style="font-weight:bold;font-size:18pt;">1500</font>    在线</div>
			   	<div class="shijianpanel">乌兰察布市</div><div  style="text-align:left;" class="shijianpanel2"><font color="red"  style="font-weight:bold;font-size:18pt;">  2134人    </font><font color="red"  style="font-weight:bold;font-size:18pt;">1500</font>    在线</div>
			    <div class="shijianpanel">兴安盟</div><div  style="margin-right:2px;" class="shijianpanel2"><font color="red"  style="font-weight:bold;font-size:18pt;">  2134人    </font><font color="red"  style="font-weight:bold;font-size:18pt;">1500</font>    在线</div>
			   	<div class="shijianpanel">呼伦贝尔市</div>
		</div>
		<style>
		.shijianpanel{
			color:#fff;
			font-size:20px;
			weight:blob;
			display:inline-block;
			float:left;
			margin-top:3px;
			background:#202a32;
			padding:0px 12px 8px 12px;
			border:2px solid #202a32;
		}
		.shijianpanel2{
			color:#fff;
			font-size:20px;
			weight:blob;
			display:inline-block;
			float:right;
			margin-top:3px;
			background:#202a32;
			padding:0px 12px 8px 12px;
			border:2px solid #202a32;
		}
		.shijianpanel1{
			color:#fff;
			font-size:20px;
			weight:blob;
			display:inline-block;
			margin:1px;
			background:#202a32;
			padding:8px 12px 8px 12px;
		}
		</style>
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
