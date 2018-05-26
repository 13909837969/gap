<%@ page pageEncoding="utf-8" contentType="text/html;charset=utf-8" %>
<html>
	<head>
		<title>签到信息分析</title>
		<jsp:include page="../ltrhao-common.jsp"></jsp:include>
		<link href="${localCtx}/resources/css/ltrhao-dasOrg.css" rel="stylesheet">

        <script type="text/javascript" src="http://echarts.baidu.com/gallery/vendors/echarts/extension/bmap.min.js"></script>
        <script type="text/javascript" src="${localCtx}/json/BoundaryService.js"></script>
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
        	        },/* 
        	        visualMap: {
        	            show: false,
        	            min: 0,
        	            max: 500,
        	            left: 'left',
        	            top: 'bottom',
        	            text: ['高', '低'], // 文本，默认为数值文本
        	            calculable: true,
        	            seriesIndex: [1],
        	            inRange: {
        	                // color: ['#3B5077', '#031525'] // 蓝黑
        	                // color: ['#ffc0cb', '#800080'] // 红紫
        	                // color: ['#3C3B3F', '#605C3C'] // 黑绿
        	                //  color: ['#0f0c29', '#302b63', '#24243e'] // 黑紫黑
        	                // color: ['#23074d', '#cc5333'] // 紫红
        	                // color: ['#00467F', '#A5CC82'] // 蓝绿
        	                // color: ['#1488CC', '#2B32B2'] // 浅蓝
        	                // color: ['#00467F', '#A5CC82'] // 蓝绿
        	               color: ['#00467F', '#A5CC82'] // 蓝绿
        	                // color: ['#00467F', '#A5CC82'] // 蓝绿
        	                // color: ['#00467F', '#A5CC82'] // 蓝绿

        	            }
        	        }, */
        	        // toolbox: {
        	        //     show: true,
        	        //     orient: 'vertical',
        	        //     left: 'right',
        	        //     top: 'center',
        	        //     feature: {
        	        //             dataView: {readOnly: false},
        	        //             restore: {},
        	        //             saveAsImage: {}
        	        //             }
        	        // },
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
        	    console.log(myChart.getModel().getComponent('bmap'));
        	    // 获取百度地图实例，使用百度地图自带的控件
        	    var map = myChart.getModel().getComponent('bmap').getBMap();
        	    map.addControl(new BMap.MapTypeControl()); 
        	var  mapStyle ={ 
        	        features: ["road", "building","water","land"],//隐藏地图上的poi
        	        style : "water"  //设置地图风格为高端黑
        	    } ;
        	map.setMapStyle(mapStyle);
        	
        	
        	var opts = {type: BMAP_NAVIGATION_CONTROL_ZOOM}    
        	map.addControl(new BMap.NavigationControl(opts));
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
       
        });
        </script>
</head>
<body>
<div style="position:absolute;top:0px;bottom:0px;right:0px;left:0px;background-color:#08304B">
    <div id="container-fiuled" style="background-color:#08304B">
				<div >
				
					<div class="row"  style="margin-right: 0px;margin-left: 0px;">
								<!--全区矫正人员分布情况  -->
							<div >
								<div id="das_mapID" style="height:570px"></div>
							</div>
							<div style="position:absolute;top:220px;right:20px;height:120px;width:350px;background:#004881;">
			<div class="bjys">越界报警人数 <font color="red"  style="font-weight:bold;font-size:18pt;">30</font> 申请外出  <font color="red" style="font-weight:bold;font-size:18pt;">6</font></div>
			<div class="bjys">进禁区报警数 <font color="red"  style="font-weight:bold;font-size:18pt;">18</font></div>
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
</body>
</html>