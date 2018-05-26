<%@ page pageEncoding="utf-8" contentType="text/html;charset=utf-8" %>
<html>
	<head>
		<title>签到信息分析</title>
		<jsp:include page="../ltrhao-common.jsp"></jsp:include>
		<link href="${localCtx}/resources/css/ltrhao-dasOrg.css" rel="stylesheet">
        <script type="text/javascript" src="http://echarts.baidu.com/gallery/vendors/echarts/extension/bmap.min.js"></script>
        <script type="text/javascript" src="${localCtx}/json/BoundaryService.js"></script>
        <script type="text/javascript" src="${localCtx}/module/rp/jss/rangSelect.js"></script>
        <script>
        $(function(){
          var  myChart = echarts.init(document.getElementById('das_mapID'));
          var geoCoordMap = {
        			'呼和浩特' : [ 111.66035052,40.82831887 ],
        			'包头' : [ 109.844819, 40.661834 ],
        			'乌海' : [ 106.797229, 39.663228 ],
        			'赤峰' : [ 118.889196, 42.264889 ],
        			'通辽' : [ 122.244198,43.660276 ],
        			'鄂尔多斯' : [109.781694,39.614704],
        			'呼伦贝尔' : [119.766046,49.219764 ],
        			'乌兰察布' : [113.134294,41.000966 ],
        			'巴彦淖尔' : [107.390374, 40.748703 ],
        			'兴安盟' : [ 122.040915, 46.089263 ],
        			'阿拉善盟' : [ 105.735018,38.858529 ],
        			'锡林郭勒盟' : [ 116.051804,43.940046 ]
        		};
          // 每个盟市机构总数和报警总数
          var data = [{
              name: '呼和浩特',
              value:200,
              alarm_num: 200
          }, {
              name: '包头',
              value: 119
          },{
              name: '乌海',
              value: 119
          },{
              name: '赤峰',
              value: 119
          },{
              name: '通辽',
              value: 119
          },{
              name: '鄂尔多斯',
              value: 119
          },{
              name: '呼伦贝尔',
              value: 119
          },{
              name: '乌兰察布',
              value: 119
          },{
              name: '巴彦淖尔',
              value: 119
          },{
              name: '兴安盟',
              value: 119
          },{
              name: '阿拉善盟',
              value: 119
          },{
              name: '锡林郭勒盟',
              value: 119
          }];
          var max = 480, min = 9; // todo 
          var maxSize4Pin = 100, minSize4Pin = 20;
          var convertData = function(data) {
              var res = [];
              for (var i = 0; i < data.length; i++) {
                  var geoCoord = geoCoordMap[data[i].name];
                  if (geoCoord) {
                      res.push({
                          name: data[i].name,
                          value: geoCoord.concat(data[i].value),
                      });
                  }
              }
              // 有数据的地区的名称和value值
              return res;
          };
          option = {
        	        title: {
        	            subtext: '',
        	            x: 'center',
        	            textStyle: {
        	                color: '#ccc'
        	            }
        	        },
        	        tooltip: {
        	            trigger: 'item',
        	            formatter: function (params) {
        	              if(typeof(params.value)[2] == "undefined"){
        	              	return params.name + ' : ' + params.value;
        	              }else{
        	              	return params.name + ' : ' + params.value[2];
        	              }
        	            }
        	        },
                     // 加载 bmap 组件
                    bmap: {
                        // 百度地图中心经纬度
                       center: [128.012963,45.068573],
                        // 百度地图缩放
                       zoom: 6,
                        // 是否开启拖拽缩放，可以只设置 'scale' 或者 'move'
                        roam: true,
                        // 百度地图的自定义样式，见 http://developer.baidu.com/map/jsdevelop-11.htm
                        mapStyle: {}
                    },
        	        legend: {
        	            orient: 'vertical',
        	            y: 'bottom',
        	            x: 'right',
        	            data: ['credit_pm2.5'],
        	            textStyle: {
        	                color: '#fff'
        	            }
        	        },
        	        geo: {
        	            show: true,
        	            label: {
        	                normal: {
        	                    show: false
        	                },
        	                emphasis: {
        	                    show: false,
        	                }
        	            },
        	            roam: true,
        	            itemStyle: {
        	                normal: {
        	                    areaColor: '#031525',
        	                    borderColor: '#3B5077',
        	                },
        	                emphasis: {
        	                    areaColor: '#2B91B7',
        	                }
        	            }
        	        },
        	        series : [
        	      {
        	            name: '游客',
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
        	                    show: true
        	                },
        	                emphasis: {
        	                    show: true
        	                }
        	            },
        	            itemStyle: {
        	                normal: {
        	                    color: '#05C3F9'
        	                }
        	            }
        	        },
        	         {
        	            type: 'map',
        	            map: 'jiangxi',
        	            geoIndex: 0,
        	            aspectScale: 0.75, //长宽比
        	            showLegendSymbol: false, // 存在legend时显示
        	            label: {
        	                normal: {
        	                    show: false
        	                },
        	                emphasis: {
        	                    show: false,
        	                    textStyle: {
        	                        color: '#fff'
        	                    }
        	                }
        	            },
        	            roam: true,
        	            itemStyle: {
        	                normal: {
        	                    areaColor: '#031525',
        	                    borderColor: '#3B5077',
        	                },
        	                emphasis: {
        	                    areaColor: '#2B91B7'
        	                }
        	            },
        	            animation: false,
        	            data: data
        	        },
        	        {
        	            name: '点',
        	            type: 'scatter',
        	            coordinateSystem: 'bmap',
        	            symbol: 'pin',
        	            symbolSize: function (val) {
        	                var a = (maxSize4Pin - minSize4Pin) / (max - min);
        	                var b = minSize4Pin - a*min;
        	                b = maxSize4Pin - a*max;
        	                return a*val[2]+b;
        	            },
        	            label: {
        	                normal: {
        	                    show: true,
        	                    textStyle: {
        	                        color: '#fff',
        	                        fontSize: 9,
        	                    }
        	                }
        	            },
        	            itemStyle: {
        	                normal: {
        	                    color: '#F62157', //标志颜色
        	                }
        	            },
        	            zlevel: 6,
        	            data: convertData(data),
        	        },
        	        {
        	            name: 'Top 5',
        	            type: 'effectScatter',
        	            coordinateSystem: 'bmap',
        	            data: convertData(data.sort(function (a, b) {
        	                return b.value - a.value;
        	            }).slice(0, 5)),
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
        	                    color: '#05C3F9',
        	                    shadowBlur: 10,
        	                    shadowColor: '#05C3F9'
        	                }
        	            },
        	            zlevel: 1
        	        },
        	         
        	    ]
        	    };
        	    myChart.setOption(option);
        	   // console.log(myChart.getModel().getComponent('bmap'));
        	    // 获取百度地图实例，使用百度地图自带的控件
        	    var map = myChart.getModel().getComponent('bmap').getBMap();
        	    map.addControl(new BMap.MapTypeControl()); 
        	var  mapStyle ={ 
        	        features: ["road", "building","water","land"],//隐藏地图上的poi
        	        style : "water"  //设置地图风格为高端黑
        	    } ;
        	map.setMapStyle(mapStyle);

        	/* var opts = {type: BMAP_NAVIGATION_CONTROL_ZOOM}    
        	map.addControl(new BMap.NavigationControl(opts)); */
            var bs = new BoundaryService();
        	bs.findBoundary(2,new Eht.Responder({
        				success:function(data){
        					var pointArray = [];
        					for(var i=0;i<data.length;i++){
        						var bounds = data[i].boundary;
        						for(var j=0;j<bounds.length;j++){
        							var ply = new BMap.Polygon(bounds[j], {strokeWeight: 2, strokeColor: "#212121",fillColor:"#292557"}); //建立多边形覆盖物 81bbec
        							map.addOverlay(ply); 
        							pointArray = pointArray.concat(ply.getPath());
        						}
        					}
        					/* map.setViewport(pointArray);    //调整视野   */
        					//map.centerAndZoom( "137.873914,36.769264", "6");    //调整视野  
        					
        				}
        			}));
        	//矫正人员软件
        	var  jzChart = echarts.init(document.getElementById('dasbord_jz_chart'));
        	var  azChart = echarts.init(document.getElementById('dasbord_az_chart'));
        	var  rmChart = echarts.init(document.getElementById('dasbord_rm_chart'));
        	var  fxChart = echarts.init(document.getElementById('dasbord_fx_chart'));
            var option = {
            	title:{
            		textStyle: {
            			fontSize:8
            		},
            		padding:2,
            		left:20
            	},
            	legend: {
                	x:230,
                    data: ['1','2','3']
                },
            	 grid: {
            	        left: '3%',
            	        right: '4%',
            	        bottom: '13%',
            	        containLabel: true
            	  },
            	center: ['50%', '50%'],
                tooltip : {
                    formatter: "{a} <br/>{b} : {c}%"
                },
                textStyle:{
                	fontSize:8,
                	height:10,
                	fontWeight:'bold'
                },
                series: [
                    { 
                    	 radius: '100%',
                    	axisLine: {            // 坐标轴线
                            lineStyle: {       // 属性lineStyle控制线条样式
                            width: 12,
                        color: [[0.2, '#AD1457'], [0.8, '#7B1FA2'], [1, '#388E3C']],
                        },
                        splitLine: {           // 分隔线
                            length: 8,         // 属性length控制线长
                            lineStyle: {       // 属性lineStyle（详见lineStyle）控制线条样式
                                color: 'auto'
                            }
                        },
                    },
                        name: '业务指标',
                        type: 'gauge',
                        detail: {formatter:'{value}%'},
                        data: [{value: 90}]
                    }
                ]
            };
            jzChart.setOption(option);
            azChart.setOption(option);
            rmChart.setOption(option);
            fxChart.setOption(option);
        });
        </script>
</head>
<body>
	<div
		style="position: absolute; top: 0px; bottom: 0px; right: 0px; left: 0px; background-color: #08304B">
		<div id="container-fiuled" style="background-color: #08304B">
			<div>
				<div class="row" style="margin-right: 0px; margin-left: 0px;">
					<!--全区矫正人员分布情况  -->
					<div>
						<div id="das_mapID" style="height: 100%"></div>
					</div>
					<div class="rangCity">
						<div class="panel panel-default" style="border-radius: 0;">
							<!-- Default panel contents -->
							<div class="row" style="margin: 5px 0 5px 0px;">
								<div class="col-xs-4"
									style="margin-left: 0px; margin-right: 0px;">
									<div class="input-group input-group-sm">
                                      <input type="text" class="form-control input-group-sm" placeholder="开始时间">
                                  </div>
								</div>
								<div class="col-xs-4"
									style="margin-left: -45px; margin-right: 0px;">
									<div class="input-group input-group-sm">
                                      <input type="text" class="form-control input-group-sm" placeholder="开始时间">
                                  </div>
								</div>
								<div class="col-xs-4"  style="margin-left: -40px;margin-right: 0px;">
									<div class="input-group btn-group-sm">
                                      <button class="btn btn-default" type="button">查询</button>
                                  </div>
								</div>
							</div>
						</div>
						<div class="panel  borderCity col-xs-3 pLR2em"  style=" border-left:0px;">
							<div class="panel-heading" >综合排名</div>
							<div class="panel-body">
							    <div class="cityContent " smark="00001"><p class="col-xs-2 pLeftAndRghit">01</p><p class="col-xs-6 pLeftAndRghit">呼和浩特市</p><p class="col-xs-4 pLeftAndRghit panel-zhcount">1902</p></div>
								<div class="cityContent"  smark="00002"><p class="col-xs-2 pLeftAndRghit">02</p><p class="col-xs-6 pLeftAndRghit">巴彦诺尔市</p><p class="col-xs-4 pLeftAndRghit panel-zhcount">3243</p></div>
								<div class="cityContent"  smark="00003"><p class="col-xs-2 pLeftAndRghit">03</p><p class="col-xs-6 pLeftAndRghit">兴安盟市</p><p class="col-xs-4 pLeftAndRghit panel-zhcount">200000</p></div>
								<div class="cityContent"  smark="00004"><p class="col-xs-2 pLeftAndRghit">04</p><p class="col-xs-6 pLeftAndRghit">鄂尔多斯市</p><p class="col-xs-4 pLeftAndRghit panel-zhcount" >5234</p></div>
								<div class="cityContent"  smark="00005"><p class="col-xs-2 pLeftAndRghit">12</p><p class="col-xs-6 pLeftAndRghit">鄂尔多斯市</p><p class="col-xs-4 pLeftAndRghit panel-zhcount">12343</p></div>
								<div class="cityContent"  smark="00006"><p class="col-xs-2 pLeftAndRghit">12</p><p class="col-xs-6 pLeftAndRghit">鄂尔多斯市</p><p class="col-xs-4 pLeftAndRghit panel-zhcount" >433</p></div>
								<div class="cityContent" smark="00007"><p class="col-xs-2 pLeftAndRghit">12</p><p class="col-xs-6 pLeftAndRghit">鄂尔多斯市</p><p class="col-xs-4 pLeftAndRghit panel-zhcount">6542</p></div>
								<div class="cityContent" smark="00008"><p class="col-xs-2 pLeftAndRghit">12</p><p class="col-xs-6 pLeftAndRghit">鄂尔多斯市</p><p class="col-xs-4 pLeftAndRghit panel-zhcount">23233</p></div>
								<div class="cityContent" smark="00009"><p class="col-xs-2 pLeftAndRghit">12</p><p class="col-xs-6 pLeftAndRghit">鄂尔多斯市</p><p class="col-xs-4 pLeftAndRghit panel-zhcount">987965</p></div>
								<div class="cityContent" smark="00010"><p class="col-xs-2 pLeftAndRghit">12</p><p class="col-xs-6 pLeftAndRghit">鄂尔多斯市</p><p class="col-xs-4 pLeftAndRghit panel-zhcount">34333</p></div>
								<div class="cityContent" smark="00011"><p class="col-xs-2 pLeftAndRghit">12</p><p class="col-xs-6 pLeftAndRghit">鄂尔多斯市</p><p class="col-xs-4 pLeftAndRghit panel-zhcount">74455</p></div>
								<div class="cityContent" smark="00012"><p class="col-xs-2 pLeftAndRghit">12</p><p class="col-xs-6 pLeftAndRghit">鄂尔多斯市</p><p class="col-xs-4 pLeftAndRghit panel-zhcount">22334</p></div>
							</div>
						</div>
						<div class="panel  borderCity col-xs-3 pLR2em">
							<div class="panel-heading">矫正管理情况排名</div>
						<div class="panel-body">
								<div class="cityContent " smark="00007"><p class="col-xs-2 pLeftAndRghit">01</p><p class="col-xs-6 pLeftAndRghit">呼和浩特市</p><p class="col-xs-4 pLeftAndRghit panel-jzcount">1902</p></div>
								<div class="cityContent"  smark="00002"><p class="col-xs-2 pLeftAndRghit">02</p><p class="col-xs-6 pLeftAndRghit">巴彦诺尔市</p><p class="col-xs-4 pLeftAndRghit panel-jzcount">3243</p></div>
								<div class="cityContent"  smark="00003"><p class="col-xs-2 pLeftAndRghit">03</p><p class="col-xs-6 pLeftAndRghit">兴安盟市</p><p class="col-xs-4 pLeftAndRghit panel-jzcount">200000</p></div>
								<div class="cityContent"  smark="00004"><p class="col-xs-2 pLeftAndRghit">04</p><p class="col-xs-6 pLeftAndRghit">鄂尔多斯市</p><p class="col-xs-4 pLeftAndRghit panel-jzcount" >5234</p></div>
								<div class="cityContent"  smark="00005"><p class="col-xs-2 pLeftAndRghit">12</p><p class="col-xs-6 pLeftAndRghit">鄂尔多斯市</p><p class="col-xs-4 pLeftAndRghit panel-jzcount">12343</p></div>
								<div class="cityContent"  smark="00006"><p class="col-xs-2 pLeftAndRghit">12</p><p class="col-xs-6 pLeftAndRghit">鄂尔多斯市</p><p class="col-xs-4 pLeftAndRghit panel-jzcount" >433</p></div>
								<div class="cityContent"  smark="00008"><p class="col-xs-2 pLeftAndRghit">12</p><p class="col-xs-6 pLeftAndRghit">鄂尔多斯市</p><p class="col-xs-4 pLeftAndRghit panel-jzcount">6542</p></div>
								<div class="cityContent"  smark="00011"><p class="col-xs-2 pLeftAndRghit">12</p><p class="col-xs-6 pLeftAndRghit">鄂尔多斯市</p><p class="col-xs-4 pLeftAndRghit panel-jzcount">23233</p></div>
								<div class="cityContent"  smark="00001"><p class="col-xs-2 pLeftAndRghit">12</p><p class="col-xs-6 pLeftAndRghit">鄂尔多斯市</p><p class="col-xs-4 pLeftAndRghit panel-jzcount">987965</p></div>
								<div class="cityContent"  smark="00009"><p class="col-xs-2 pLeftAndRghit">12</p><p class="col-xs-6 pLeftAndRghit">鄂尔多斯市</p><p class="col-xs-4 pLeftAndRghit panel-jzcount">74455</p></div>
								<div class="cityContent"  smark="00010"><p class="col-xs-2 pLeftAndRghit">12</p><p class="col-xs-6 pLeftAndRghit">鄂尔多斯市</p><p class="col-xs-4 pLeftAndRghit panel-jzcount">22334</p></div>
								<div class="cityContent"  smark="00012"><p class="col-xs-2 pLeftAndRghit">12</p><p class="col-xs-6 pLeftAndRghit">鄂尔多斯市</p><p class="col-xs-4 pLeftAndRghit panel-jzcount">19087</p></div></div>
						</div>
						<div class="panel borderCity col-xs-3 pLR2em">
							<div class="panel-heading">人民调解情况排名</div>
							<div class="panel-body">
							<div class="cityContent " smark="00007"><p class="col-xs-2 pLeftAndRghit">01</p><p class="col-xs-6 pLeftAndRghit">呼和浩特市</p><p class="col-xs-4 pLeftAndRghit panel-jzcount">1902</p></div>
								<div class="cityContent"  smark="00002"><p class="col-xs-2 pLeftAndRghit">02</p><p class="col-xs-6 pLeftAndRghit">巴彦诺尔市</p><p class="col-xs-4 pLeftAndRghit panel-jzcount">3243</p></div>
								<div class="cityContent"  smark="00003"><p class="col-xs-2 pLeftAndRghit">03</p><p class="col-xs-6 pLeftAndRghit">兴安盟市</p><p class="col-xs-4 pLeftAndRghit panel-jzcount">200000</p></div>
								<div class="cityContent"  smark="00004"><p class="col-xs-2 pLeftAndRghit">04</p><p class="col-xs-6 pLeftAndRghit">鄂尔多斯市</p><p class="col-xs-4 pLeftAndRghit panel-jzcount" >5234</p></div>
								<div class="cityContent"  smark="00005"><p class="col-xs-2 pLeftAndRghit">12</p><p class="col-xs-6 pLeftAndRghit">鄂尔多斯市</p><p class="col-xs-4 pLeftAndRghit panel-jzcount">12343</p></div>
								<div class="cityContent"  smark="00006"><p class="col-xs-2 pLeftAndRghit">12</p><p class="col-xs-6 pLeftAndRghit">鄂尔多斯市</p><p class="col-xs-4 pLeftAndRghit panel-jzcount" >433</p></div>
								<div class="cityContent"  smark="00008"><p class="col-xs-2 pLeftAndRghit">12</p><p class="col-xs-6 pLeftAndRghit">鄂尔多斯市</p><p class="col-xs-4 pLeftAndRghit panel-jzcount">6542</p></div>
								<div class="cityContent"  smark="00011"><p class="col-xs-2 pLeftAndRghit">12</p><p class="col-xs-6 pLeftAndRghit">鄂尔多斯市</p><p class="col-xs-4 pLeftAndRghit panel-jzcount">23233</p></div>
								<div class="cityContent"  smark="00001"><p class="col-xs-2 pLeftAndRghit">12</p><p class="col-xs-6 pLeftAndRghit">鄂尔多斯市</p><p class="col-xs-4 pLeftAndRghit panel-jzcount">987965</p></div>
								<div class="cityContent"  smark="00009"><p class="col-xs-2 pLeftAndRghit">12</p><p class="col-xs-6 pLeftAndRghit">鄂尔多斯市</p><p class="col-xs-4 pLeftAndRghit panel-jzcount">74455</p></div>
								<div class="cityContent"  smark="00010"><p class="col-xs-2 pLeftAndRghit">12</p><p class="col-xs-6 pLeftAndRghit">鄂尔多斯市</p><p class="col-xs-4 pLeftAndRghit panel-jzcount">22334</p></div>
								<div class="cityContent"  smark="00012"><p class="col-xs-2 pLeftAndRghit">12</p><p class="col-xs-6 pLeftAndRghit">鄂尔多斯市</p><p class="col-xs-4 pLeftAndRghit panel-jzcount">19087</p></div></div>
						
								</div>
						<div class="panel borderCity col-xs-3 pLR2em">
							<div class="panel-heading">安置帮教情况排名</div>
							<div class="panel-body">
								<div class="cityContent " smark="00007"><p class="col-xs-2 pLeftAndRghit">01</p><p class="col-xs-6 pLeftAndRghit">呼和浩特市</p><p class="col-xs-4 pLeftAndRghit panel-jzcount">1902</p></div>
								<div class="cityContent"  smark="00002"><p class="col-xs-2 pLeftAndRghit">02</p><p class="col-xs-6 pLeftAndRghit">巴彦诺尔市</p><p class="col-xs-4 pLeftAndRghit panel-jzcount">3243</p></div>
								<div class="cityContent"  smark="00003"><p class="col-xs-2 pLeftAndRghit">03</p><p class="col-xs-6 pLeftAndRghit">兴安盟市</p><p class="col-xs-4 pLeftAndRghit panel-jzcount">200000</p></div>
								<div class="cityContent"  smark="00004"><p class="col-xs-2 pLeftAndRghit">04</p><p class="col-xs-6 pLeftAndRghit">鄂尔多斯市</p><p class="col-xs-4 pLeftAndRghit panel-jzcount" >5234</p></div>
								<div class="cityContent"  smark="00005"><p class="col-xs-2 pLeftAndRghit">12</p><p class="col-xs-6 pLeftAndRghit">鄂尔多斯市</p><p class="col-xs-4 pLeftAndRghit panel-jzcount">12343</p></div>
								<div class="cityContent"  smark="00006"><p class="col-xs-2 pLeftAndRghit">12</p><p class="col-xs-6 pLeftAndRghit">鄂尔多斯市</p><p class="col-xs-4 pLeftAndRghit panel-jzcount" >433</p></div>
								<div class="cityContent"  smark="00008"><p class="col-xs-2 pLeftAndRghit">12</p><p class="col-xs-6 pLeftAndRghit">鄂尔多斯市</p><p class="col-xs-4 pLeftAndRghit panel-jzcount">6542</p></div>
								<div class="cityContent"  smark="00011"><p class="col-xs-2 pLeftAndRghit">12</p><p class="col-xs-6 pLeftAndRghit">鄂尔多斯市</p><p class="col-xs-4 pLeftAndRghit panel-jzcount">23233</p></div>
								<div class="cityContent"  smark="00001"><p class="col-xs-2 pLeftAndRghit">12</p><p class="col-xs-6 pLeftAndRghit">鄂尔多斯市</p><p class="col-xs-4 pLeftAndRghit panel-jzcount">987965</p></div>
								<div class="cityContent"  smark="00009"><p class="col-xs-2 pLeftAndRghit">12</p><p class="col-xs-6 pLeftAndRghit">鄂尔多斯市</p><p class="col-xs-4 pLeftAndRghit panel-jzcount">74455</p></div>
								<div class="cityContent"  smark="00010"><p class="col-xs-2 pLeftAndRghit">12</p><p class="col-xs-6 pLeftAndRghit">鄂尔多斯市</p><p class="col-xs-4 pLeftAndRghit panel-jzcount">22334</p></div>
								<div class="cityContent"  smark="00012"><p class="col-xs-2 pLeftAndRghit">12</p><p class="col-xs-6 pLeftAndRghit">鄂尔多斯市</p><p class="col-xs-4 pLeftAndRghit panel-jzcount">19087</p></div></div>
						</div>
					</div>
					<div class="rangDitail ">
						<div class="panel panelDitail">
							<!-- Default panel contents -->
							<div style=" background:#f0f3f5;"><span class="city-name" style="margin-top:5px;">呼和浩特市</span><span class="province-name">综合排名</span></div>
							<div class="panel-body ditail-body">
								<div class="col-xs-6 " >
									<div class="card">
										<div class="card-title">
											<span class="text">矫正人员管理比例</span><span class="detail-icon"></span>
										</div>
										   <div id="dasbord_jz_chart" style="margin: 20px 0px;height:200px;"></div>
									</div>
								</div>
								<div class="col-xs-6 ">
								<div class="card">
										<div class="card-title">
											<span class="text">报警情况处理情况</span><span class="detail-icon"></span>
										</div>
										<div id="dasbord_az_chart" style="margin: 20px 0px;height:200px;"></div>
									</div>
                                </div>
                                <div class="col-xs-6 " >
									<div class="card">
										<div class="card-title">
											<span class="text">人民调解处理情况</span><span class="detail-icon"></span>
										</div>
										<div id="dasbord_rm_chart" style="margin: 20px 0px;height:200px;"></div>
									</div>
								</div>
								<div class="col-xs-6 ">
								<div class="card">
										<div class="card-title">
											<span class="text">安置帮教情况</span><span class="detail-icon"></span>
										</div>
										<div id="dasbord_fx_chart" style="margin: 20px 0px;height:200px;"></div>
									</div>
                                </div>
							</div>
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