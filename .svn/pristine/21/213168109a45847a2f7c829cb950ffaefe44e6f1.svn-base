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

option = {
    title: {
        text: '社区矫正人员管理情况',
        left: 'center'
    },
    tooltip : {
        trigger: 'item'
    },
    bmap: {
        center: [108.27712,44.40898],
        zoom: 5,
        roam: true,
        mapStyle: {
            styleJson: [{
                'featureType': 'water',
                'elementType': 'all',
                'stylers': {
                    'color': '#d1d1d1'
                }
            }, {
                'featureType': 'land',
                'elementType': 'all',
                'stylers': {
                    'color': '#f3f3f3'
                }
            }, {
                'featureType': 'railway',
                'elementType': 'all',
                'stylers': {
                    'visibility': 'off'
                }
            }, {
                'featureType': 'highway',
                'elementType': 'all',
                'stylers': {
                    'color': '#fdfdfd'
                }
            }, {
                'featureType': 'highway',
                'elementType': 'labels',
                'stylers': {
                    'visibility': 'off'
                }
            }, {
                'featureType': 'arterial',
                'elementType': 'geometry',
                'stylers': {
                    'color': '#fefefe'
                }
            }, {
                'featureType': 'arterial',
                'elementType': 'geometry.fill',
                'stylers': {
                    'color': '#fefefe'
                }
            }, {
                'featureType': 'poi',
                'elementType': 'all',
                'stylers': {
                    'visibility': 'off'
                }
            }, {
                'featureType': 'green',
                'elementType': 'all',
                'stylers': {
                    'visibility': 'off'
                }
            }, {
                'featureType': 'subway',
                'elementType': 'all',
                'stylers': {
                    'visibility': 'off'
                }
            }, {
                'featureType': 'manmade',
                'elementType': 'all',
                'stylers': {
                    'color': '#d1d1d1'
                }
            }, {
                'featureType': 'local',
                'elementType': 'all',
                'stylers': {
                    'color': '#d1d1d1'
                }
            }, {
                'featureType': 'arterial',
                'elementType': 'labels',
                'stylers': {
                    'visibility': 'off'
                }
            }, {
                'featureType': 'boundary',
                'elementType': 'all',
                'stylers': {
                    'color': '#fefefe'
                }
            }, {
                'featureType': 'building',
                'elementType': 'all',
                'stylers': {
                    'color': '#d1d1d1'
                }
            }, {
                'featureType': 'label',
                'elementType': 'labels.text.fill',
                'stylers': {
                    'color': '#999999'
                }
            }]
        }
    },
    series : [
        {
            name: 'pm2.5',
            type: 'scatter',
            coordinateSystem: 'bmap',
            data: convertData(data),
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
                    color: 'purple'
                }
            }
        },
        {
            name: 'Top 5',
            type: 'effectScatter',
            coordinateSystem: 'bmap',
            data: convertData(data.sort(function (a, b) {
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
                    color: 'purple',
                    shadowBlur: 10,
                    shadowColor: '#333'
                }
            },
            zlevel: 1
        }
    ]
};
	$(function(){
	 	 var  syrChart = echarts.init(document.getElementById('syrChart'));
		 syrChart.setOption(option);
	});
</script>
</head>
<body class="overflow-hidden" style="background: #004881">
	<div id="wrapper" class="sidebar-mini"  style="background: #004881">
			<div id="top-nav" class="fixed skin-6"  style="vertical-align: middle;display:table-cell;">
				<a href="#" class="brand"> <span  style="margin-left:20px;font-size:20pt;">内蒙古公共法律服务智能一体化平台</span> 
				</a>
				<!-- <a href="#" class="brand"> <span  style="margin-left:260px;font-size:10pt;">决策剧场</span> 
				</a> -->
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
		
		<!-- <div style="position:absolute;top:80px;left:20px;height:80px;width:300px;">
			<div class="shijianpanel">上午</div>
			<div class="shijianpanel">下午</div>
			<div class="shijianpanel">24小时</div>
		</div> -->
		<div style="position:absolute;top:80px;left:20px;height:120px;width:350px;background:#aeaeae;">
		 <div>15224</div>
		 <div>矫正总人数</div>
		 <div>在线人数</div><div>13823</div>
		 <div>掉线人数</div><div>1401</div>
		</div>		
		<div style="position:absolute;top:220px;left:20px;height:120px;width:350px;background:#aeaeae;">
		<div>今日签到情况</div>
		 <div>90%</div>
		 <div>签到百分比</div>
		 <div>530</div>
		 <div>未签到人数</div>
		</div>
		
		<div style="position:absolute;top:360px;left:20px;height:120px;width:350px;background:#aeaeae;">
		<div>越界报警人数</div>
		 <div>30</div>
		 <div>进禁区报警数</div>
		 <div>18</div>
		</div>		
		<div style="position:absolute;top:500px;left:20px;height:120px;width:350px;background:#aeaeae;">
			<div>司法机构情况</div>
		 <div>1500</div>
		 <div>机构总数</div>
		 <div>530</div>
		 <div>工作人员总数</div>
		</div>
		<!--各盟市接入情况 -->
		<div style="position:absolute;top:80px;right:20px;height:540px;width:350px;background:#aeaeae;">
			
		</div>
		
		<style>
		.shijianpanel{
			color:#fff;
			font-size:20px;
			weight:blob;
			display:inline-block;
			margin:1px;
			background:#aeaeae;
			padding:8px 12px 8px 12px;
			border:2px solid #efefef;
		}
		</style>
</body>
</html>
