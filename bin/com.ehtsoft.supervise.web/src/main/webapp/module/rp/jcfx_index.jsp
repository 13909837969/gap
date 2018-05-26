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
<link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">
<link href="css/font-awesome.min.css" rel="stylesheet">
<link href="css/pace.css" rel="stylesheet">
<link href="css/colorbox/colorbox.css" rel="stylesheet">
<link href="css/morris.css" rel="stylesheet" />
<link href="css/endless.css" rel="stylesheet">
<link href="css/endless-skin.css" rel="stylesheet">
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<link href="${localCtx}/resources/css/ltrhao-dasOrg.css" rel="stylesheet">


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
	    		 timeline: {
	                   axisType: 'category',
	                   orient: 'vertical',
	                   autoPlay: true,
	                   inverse: true,
	                   playInterval: 1000,
	                   left: null,
	                   right:30,
	                   top: 20,
	                   bottom: 20,
	                   width:115,
	                   height: null,
	                   label: {
	                       normal: {
	                           textStyle: {
	                               color: '#ddd',
	                               fontSize:20
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
	                       color: '#f4e001'
	                   },
	                   checkpointStyle: {
	                       color: '#bbb',
	                       borderColor: '#777',
	                       borderWidth: 3
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
                 color: '#fff',
                 fontSize:16
             }
         },
         tooltip : {
             trigger: 'item'
         },
         bmap: {
             center: [108.27712,44.40898],
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
             data:['全区矫正人员分布情况'],
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
      	  for (var n = 0; n < data1.timeline.length; n++) {
	           option.baseOption.timeline.data.push(data1.timeline[n]);
	           option.options.push({
	               title: {
	                   show: true,
	                    y:8,
	                   'text': data1.timeline[n] + '全区矫正人员分布情况统计',
	                   textStyle: {
	                       color: '#fff',
	                       fontSize:26
	                   }
	               },
	               series: [
	  	               {
		                   name: '矫正人员数量',
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
		                   name: '矫正人员数量',
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
	       } 
       	 syrChart.setOption(option);
       	 
       	optionzt =  {
       			color: ['#f4e001'],
       		    title: {
       		        //text: '2017年各盟市矫正人员分布情况',
	       		     textStyle: {
	                     color: '#ffffff'
	                 }
       		    
       		    },
       		    tooltip: {
       		        trigger: 'axis',
       		        axisPointer: {
       		            type: 'shadow'
       		        }
       		    },
       		
       		    grid: {
       		        left: '3%',
       		        right: '4%',
       		        bottom: '3%',
       		        containLabel: true
       		    },
       		    xAxis: {
       		        type: 'value',
       		        boundaryGap: [0, 0.01],
	       		     axisLabel: {
	                     show: true,
	                     textStyle: {
	                         color: '#fff'
	                     }
	       		     },
       		     	splitLine:{ 
                     show:false
    				}
       		    },
       		    yAxis: {
       		        type: 'category',
       		        //data: ['呼和浩特','包头','乌海','赤峰','通辽','鄂尔多斯','呼伦贝尔','乌兰察布','巴彦淖尔','兴安盟','阿拉善盟','锡林郭勒盟'],
	       		    data:getCityName(), 
       		        axisLabel: {
	                     show: true,
	                     textStyle: {
	                         color: '#fff',
	                         fontSize:16
	                     }
	       		     }
       		    },
       		    series: [
       		        {
       		            name: '矫正人员数量',
       		            type: 'bar',
       		            //data: [802, 102, 23, 567, 23, 623,102, 1023, 102, 234, 102, 323],
       		            labelLine: {
	       		    	normal: {
	       		    	show: false
	       		    	}
	       		        }
       		        }
       		    ]
       		};
       	
       	function getCityName(){
       		var r = [];
       		for(var i =0 ; i< data[0].length; i++){
       			r[i] = data[0][i].name;
       		}
       		return r;
       	}
    	function getCityValue(index){
       		var r = [];
       		for(var i =0 ; i< data[index].length; i++){
       			r[i] = data[index][i].value;
       		}
       		return r;
       	}
       	
       	var  ztChart = echarts.init(document.getElementById('ztChart'));
       	ztChart.setOption(optionzt);
       	
       	syrChart.on('timelinechanged', function (obj) {  
       		optionzt.series[0].data = getCityValue(obj.currentIndex);
       		//optionzt.title.text=data1.timeline[obj.currentIndex]+"各盟市矫正人员分布情况";
       		ztChart.setOption(optionzt);
       		/*
       	    // 设置 每个series里的xAxis里的值  
       	    var arrIndex = parseInt(timeLineIndex.currentIndex);  
       	  
       	    //$.post("statistics/map/result", {timelineIndex: arrIndex}, function (jsonData) {  
       	    getTimeLinePointOptionData(arrIndex, [{data: dataMap.dataGDP[2002 + arrIndex]}]);  
       	    // 动态修改x轴的值  
       	    //option.options[arrIndex].xAxis.data = xAxisdata[arrIndex];  
       	  
       	    chart.setOption(option);  
       	    //}, "json");  
       	    */
       	}); 
 });

</script>
</head>
<body class="overflow-hidden" style="background: #004881">
	<div id="wrapper" class="sidebar-mini"  style="background: #004881">
			<div id="top-nav" class="fixed skin-6"  style="vertical-align: middle;display:table-cell;">
				<a href="#" class="brand"> <span  style="margin-left:20px;font-size:20pt;">内蒙古公共法律服务智能一体化平台</span> 
				</a>
			    <a href="jcfx_index.jsp"   style="margin-left:410px;"  class="brand"> <span  style="font-size:14pt;color:#61a0a8;">工作总揽</span> 
				</a>
				<a href="jcfx_index2.jsp" style="margin-left:10px;"  class="brand"> <span  style="font-size:14pt;">社区矫正</span> 
				</a>
				<a href="jcfx_index4.jsp" style="margin-left:10px;" class="brand"> <span  style="font-size:14pt;">人民调解</span> 
				</a>
				<a href="#"  style="margin-left:10px;"  class="brand"> <span  style="font-size:14pt;">法律援助</span> 
				</a>
				<a href="#"  style="margin-left:10px;"  class="brand"> <span  style="font-size:14pt;">法制宣传</span> 
				</a>
				<a href="#"   style="margin-left:10px;" class="brand"> <span  style="font-size:14pt;">法律服务</span> 
				</a> 
				<a href="#"  style="margin-left:10px;"  class="brand"> <span  style="font-size:14pt;">安装帮教</span> 
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
					<div class="row"  style="margin-top:10px">
								<!--全区矫正人员分布情况  -->
								<div class="panel bg-info fadeInDown animation-delay4" >
										<div id="ztChart"  style="margin-left:15px;margin-top:10px;height:500px;width:600px;position:absolute;z-index:9999"></div>
										<div id="syrChart" style="height:520px; margin-top:10px;">
										</div>
							</div>
					</div>
					<div class="row"  style="margin:10 0 ;">
						<!--常驻人口 -->
						<div class="col-md-2 col-sm-4">
							<div class="bg-success">
								<div class="panel-body">
									<div class="value"  id="cjrzs">1020</div>
									<div class="title">
										<span class="m-left-xs">司法机构总数</span>
									</div>
								</div>
							</div>
						</div>
						
						<div class="col-md-2 col-sm-4">
							<div class="bg-sqjz">
								<div class="panel-body">
									<div class="value"  id="czrk">14500</div>
									<div class="title">
										<span class="m-left-xs">矫正人员总数</span>
									</div>
								</div>
							</div>
						</div>
						
						<div class="col-md-2 col-sm-4">
							<div class="bg-sqgz">
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
							<div class="bg-anbj">
								<div class="panel-body">
									<div class="value"   id="lnrzs">82%</div>
									<div class="title">
										<span class="m-left-xs">帮扶百分比</span>
									</div>
								</div>
							</div>
						</div>
						<div class="col-md-2 col-sm-4">
							<div class="bg-bfxx">
								<div class="panel-body">
									<div class="value"  id="bdrs">3</div>
									<div class="title">
										<span class="m-left-xs">报到总人数</span>
									</div>
								</div>
							</div>
						</div>
						<div class="col-md-2 col-sm-4">
							<div class="bg-jfqk">
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
</body>
</html>
