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
<script type="text/javascript" src="http://api.map.baidu.com/getscript?v=2.0&ak=rlBfGG2RtC3vgylVySAenO30Ihk31FZO"></script>
<script type="text/javascript" src="http://echarts.baidu.com/gallery/vendors/echarts/extension/bmap.min.js"></script>
<script type="text/javascript" src="/supervise/module/rp/js/data/jcfx2data.js"></script>
<script type="text/javascript">
	var busLines = [];
	var data = szRoad.data;
	var hStep = 300 / (data.length - 1);
	var i = 0;
	for (var x in data) {
	    var line = data[x];
	    var pointString = line.ROAD_LINE;
	    var pointArr = pointString.split(';');
	    var lnglats = [];
	    for (var j in pointArr) {
	        lnglats.push(pointArr[j].split(','))
	    }
	    busLines.push({
	        coords: lnglats,
	        lineStyle: {
	            normal: {
	                color: echarts.color.modifyHSL('#5A94DF', Math.round(hStep * x))
	            }
	        }
	    })
	}
	option = {
	    bmap: {
	        center: [104.091, 30.639],
	        zoom: 15,
	        roam: true,
	        mapStyle: {
	            'styleJson': [{
	                'featureType': 'water',
	                'elementType': 'all',
	                'stylers': {
	                    'color': '#031628'
	                }
	            }, {
	                'featureType': 'land',
	                'elementType': 'geometry',
	                'stylers': {
	                    'color': '#000102'
	                }
	            }, {
	                'featureType': 'highway',
	                'elementType': 'all',
	                'stylers': {
	                    'visibility': 'off'
	                }
	            }, {
	                'featureType': 'arterial',
	                'elementType': 'geometry.fill',
	                'stylers': {
	                    'color': '#000000'
	                }
	            }, {
	                'featureType': 'arterial',
	                'elementType': 'geometry.stroke',
	                'stylers': {
	                    'color': '#0b3d51'
	                }
	            }, {
	                'featureType': 'local',
	                'elementType': 'geometry',
	                'stylers': {
	                    'color': '#000000'
	                }
	            }, {
	                'featureType': 'railway',
	                'elementType': 'geometry.fill',
	                'stylers': {
	                    'color': '#000000'
	                }
	            }, {
	                'featureType': 'railway',
	                'elementType': 'geometry.stroke',
	                'stylers': {
	                    'color': '#08304b'
	                }
	            }, {
	                'featureType': 'subway',
	                'elementType': 'geometry',
	                'stylers': {
	                    'lightness': -70
	                }
	            }, {
	                'featureType': 'building',
	                'elementType': 'geometry.fill',
	                'stylers': {
	                    'color': '#000000'
	                }
	            }, {
	                'featureType': 'all',
	                'elementType': 'labels.text.fill',
	                'stylers': {
	                    'color': '#857f7f'
	                }
	            }, {
	                'featureType': 'all',
	                'elementType': 'labels.text.stroke',
	                'stylers': {
	                    'color': '#000000'
	                }
	            }, {
	                'featureType': 'building',
	                'elementType': 'geometry',
	                'stylers': {
	                    'color': '#022338'
	                }
	            }, {
	                'featureType': 'green',
	                'elementType': 'geometry',
	                'stylers': {
	                    'color': '#062032'
	                }
	            }, {
	                'featureType': 'boundary',
	                'elementType': 'all',
	                'stylers': {
	                    'color': '#465b6c'
	                }
	            }, {
	                'featureType': 'manmade',
	                'elementType': 'all',
	                'stylers': {
	                    'color': '#022338'
	                }
	            }, {
	                'featureType': 'label',
	                'elementType': 'all',
	                'stylers': {
	                    'visibility': 'off'
	                }
	            }]
	        }
	    },
	    series: [{
	        type: 'lines',
	        coordinateSystem: 'bmap',
	        polyline: true,
	        data: busLines,
	        silent: true,
	        lineStyle: {
	            normal: {
	                // color: '#c23531',
	                // color: 'rgb(200, 35, 45)',
	                opacity: 0.2,
	                width: 1
	            }
	        },
	        progressiveThreshold: 500,
	        progressive: 200
	    }, {
	        type: 'lines',
	        coordinateSystem: 'bmap',
	        polyline: true,
	        data: busLines,
	        lineStyle: {
	            normal: {
	                width: 0
	            }
	        },
	        effect: {
	            constantSpeed: 50,
	            show: true,
	            trailLength: 0.5,
	            symbolSize: 1.5
	        },
	        zlevel: 1
	    }]
	};
  var 	dcjdjOption =    {
			title : {
				textStyle:{
					color: '#fff',
		   			fontSize: '18',
				},
				text: '分布情况',
				x:'center'
			},
			tooltip : {
		        trigger: 'item',
		        formatter: "{a} <br/>{b} : {c} ({d}%)"
		    },
			legend: {
				orient: 'vertical',
				left: 'left',
				textStyle:{
					color: '#fff',
		   			fontSize: '12',
				},
				//回民区、玉泉区、新城区、赛罕区
				data: ['赛罕区','玉泉区','新城区','赛罕区']
			},
			series : [
			          {
			        	  name:'区域分布情况',
			        	  type: 'pie',
			        	  radius : '50%',
			        	  center: ['50%', '50%'],
			        	  label: {
			                  normal: {
			                      textStyle: {
			                          color: '#fff'
			                      }
			                  }
			              },
			        	  data:[{value:135, name:'赛罕区'},
			                    {value:310, name:'玉泉区'},
			                    {value:234, name:'新城区'},
			                    {value:335, name:'赛罕区'}],
			        	        itemStyle: {
			        	        	emphasis: {
			        	        		shadowBlur: 10,
			        	        		shadowOffsetX: 0,
			        	        		shadowColor: 'rgba(0, 0, 0, 0.5)'
			        	        	}
			        	        }
			          }
			          ]
	};
	$(function(){
	 	 var  syrChart = echarts.init(document.getElementById('syrChart'));
		 syrChart.setOption(option);
		 var  dcjdjChart = echarts.init(document.getElementById('cjChart'));
		    var bmap = myChart.getModel().getComponent('bmap').getBMap();
		 dcjdjChart.setOption(dcjdjOption);
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
<body class="overflow-hidden" style="background: #004881">
	<div id="wrapper" class="sidebar-mini"  style="background: #004881">
			<div id="top-nav" class="fixed skin-6"  style="vertical-align: middle;display:table-cell;">
				<a href="#" class="brand"> <span  style="margin-left:20px;font-size:20pt;">内蒙古公共法律服务智能一体化平台</span> 
				</a>
				 <a href="jcfx_index.jsp"   style="margin-left:410px;"   class="brand"> <span  style="font-size:14pt;">工作总揽</span> 
				</a>
				<a href="jcfx_index2.jsp"  style="margin-left:10px;"  class="brand"> <span  style="font-size:14pt;color:#61a0a8;">社区矫正</span> 
				</a>
				<a href="jcfx_index4.jsp"  style="margin-left:10px;"  class="brand"> <span  style="font-size:14pt;">人民调解</span> 
				</a>
				<a href="#"    style="margin-left:10px;" class="brand"> <span  style="font-size:14pt;">法律援助</span> 
				</a>
				<a href="#"    style="margin-left:10px;" class="brand"> <span  style="font-size:14pt;">法制宣传</span> 
				</a>
				<a href="#"    style="margin-left:10px;" class="brand"> <span  style="font-size:14pt;">法律服务</span> 
				</a> 
				<a href="#"    style="margin-left:10px;"  class="brand"> <span  style="font-size:14pt;">安装帮教</span> 
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
		
		<div style="position:absolute;top:80px;left:20px;height:80px;width:300px;">
			<div class="shijianpanel">上午</div>
			<div class="shijianpanel">下午</div>
			<div class="shijianpanel">24小时</div>
		</div>
		<div style="position:absolute;top:80px;right:20px;height:120px;width:350px;background:#004881;">
			<div class="shijianpanel"  style="align:center;"><font  style="font-weight:bold;font-size:18pt;margin-left: 30px;">1200 </font></div><div class="shijianpanel"  style="margin-left:70px;">在线人数  <font  style="font-weight:bold;font-size:18pt;" ><span class="online"><span  id="online">1200</span></span></font></div>
			<div class="shijianpanel" style="margin-left: 30px">矫正人员总数</div><div class="shijianpanel"  style="margin-left:40px;"> 掉线人数 <font  style="font-weight:bold;font-size:18pt;"><span id="offline">178</span></font></div>
		</div>
		
		<div style="position:absolute;top:220px;right:20px;height:120px;width:350px;background:#004881;">
			<div class="bjys">越界报警人数 <font color="red"  style="font-weight:bold;font-size:18pt;">30</font> 申请外出  <font color="red" style="font-weight:bold;font-size:18pt;">6</font></div>
			<div class="bjys">进禁区报警数 <font color="red"  style="font-weight:bold;font-size:18pt;">18</font></div>
		</div>
		
		<div style="position:absolute;top:360px;right:20px;height:320px;width:350px;background:#004881;">
			<div class="panel bg-info fadeInDown animation-delay4"   style="background-color: #004881 ;">
					<div id="cjChart"   style="height:320px;"></div>
			</div>
		</div>
		<style>
		.shijianpanel{
		  	color:#fff;
			font-size:20px;
			display:inline-block;
			margin-top:8px;	
			border:2px solid #004881;
			background:#004881;
			opacity:0.9
		}
		.bjys{
		    margin-left:20px;
		  	color:#fff;
			font-size:20px;
			display:inline-block;
			margin-top:8px;	
			border:2px solid #004881;
			opacity:0.9
		}
		.shijianpanel1{
			color:#fff;
			font-size:20px;
			display:inline-block;
			margin:1px;
			background:#004881;
			opacity:0.9
		}
		</style>
</body>
</html>
