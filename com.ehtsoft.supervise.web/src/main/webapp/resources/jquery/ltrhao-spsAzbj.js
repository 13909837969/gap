	$(function(){
		var myChart = echarts.init(document.getElementById('das_mapID'));
		var geoCoordMap = {
			'呼和浩特' : [ 111.66035052, 40.82831887 ],
			'包头' : [ 109.844819, 40.661834 ],
			'乌海' : [ 106.797229, 39.663228 ],
			'赤峰' : [ 118.889196, 42.264889 ],
			'通辽' : [ 122.244198, 43.660276 ],
			'鄂尔多斯' : [ 109.781694, 39.614704 ],
			'呼伦贝尔' : [ 119.766046, 49.219764 ],
			'乌兰察布' : [ 113.134294, 41.000966 ],
			'巴彦淖尔' : [ 107.390374, 40.748703 ],
			'兴安盟' : [ 122.040915, 46.089263 ],
			'阿拉善盟' : [ 105.735018, 38.858529 ],
			'锡林郭勒盟' : [ 116.051804, 43.940046 ]
		};
		// 每个盟市机构总数和报警总数
		var data = [ {
			name : '呼和浩特',
			value : 200,
			alarm_num : 200
		}, {
			name : '包头',
			value : 119
		}, {
			name : '乌海',
			value : 119
		}, {
			name : '赤峰',
			value : 119
		}, {
			name : '通辽',
			value : 119
		}, {
			name : '鄂尔多斯',
			value : 119
		}, {
			name : '呼伦贝尔',
			value : 119
		}, {
			name : '乌兰察布',
			value : 119
		}, {
			name : '巴彦淖尔',
			value : 119
		}, {
			name : '兴安盟',
			value : 119
		}, {
			name : '阿拉善盟',
			value : 119
		}, {
			name : '锡林郭勒盟',
			value : 119
		} ];
		var max = 480, min = 9; // todo 
		var maxSize4Pin = 100, minSize4Pin = 20;
		var convertData = function(data) {
			var res = [];
			for (var i = 0; i < data.length; i++) {
				var geoCoord = geoCoordMap[data[i].name];
				if (geoCoord) {
					res.push({
						name : data[i].name,
						value : geoCoord.concat(data[i].value),
					});
				}
			}
			// 有数据的地区的名称和value值
			return res;
		};
		var option = {
			title : {
				subtext : '',
				x : 'center',
				textStyle : {
					color : '#ccc'
				}
			},
			tooltip : {
				trigger : 'item',
				formatter : function(params) {
					if (typeof (params.value)[2] == "undefined") {
						return params.name + ' : ' + params.value;
					} else {
						return params.name + ' : ' + params.value[2];
					}
				}
			},
			// 加载 bmap 组件
			bmap : {
				// 百度地图中心经纬度
				center : [ 128.012963, 45.068573 ],
				// 百度地图缩放
				zoom : 6,
				// 是否开启拖拽缩放，可以只设置 'scale' 或者 'move'
				roam : true,
				// 百度地图的自定义样式，见 http://developer.baidu.com/map/jsdevelop-11.htm
				mapStyle : {}
			},
			legend : {
				orient : 'vertical',
				y : 'bottom',
				x : 'right',
				data : [ 'credit_pm2.5' ],
				textStyle : {
					color : '#fff'
				}
			},
			geo : {
				show : true,
				label : {
					normal : {
						show : false
					},
					emphasis : {
						show : false,
					}
				},
				roam : true,
				itemStyle : {
					normal : {
						areaColor : '#031525',
						borderColor : '#3B5077',
					},
					emphasis : {
						areaColor : '#2B91B7',
					}
				}
			},
			series : [ {
				name : '游客',
				type : 'scatter',
				coordinateSystem : 'bmap',
				data : convertData(data),
				symbolSize : function(val) {
					return val[2] / 10;
				},
				label : {
					normal : {
						formatter : '{b}',
						position : 'right',
						show : true
					},
					emphasis : {
						show : true
					}
				},
				itemStyle : {
					normal : {
						color : '#05C3F9'
					}
				}
			}, {
				type : 'map',
				map : 'jiangxi',
				geoIndex : 0,
				aspectScale : 0.75, //长宽比
				showLegendSymbol : false, // 存在legend时显示
				label : {
					normal : {
						show : false
					},
					emphasis : {
						show : false,
						textStyle : {
							color : '#fff'
						}
					}
				},
				roam : true,
				itemStyle : {
					normal : {
						areaColor : '#031525',
						borderColor : '#3B5077',
					},
					emphasis : {
						areaColor : '#2B91B7'
					}
				},
				animation : false,
				data : data
			}, {
				name : '点',
				type : 'scatter',
				coordinateSystem : 'bmap',
				symbol : 'pin',
				symbolSize : function(val) {
					var a = (maxSize4Pin - minSize4Pin) / (max - min);
					var b = minSize4Pin - a * min;
					b = maxSize4Pin - a * max;
					return a * val[2] + b;
				},
				label : {
					normal : {
						show : true,
						textStyle : {
							color : '#fff',
							fontSize : 9,
						}
					}
				},
				itemStyle : {
					normal : {
						color : '#F62157', //标志颜色
					}
				},
				zlevel : 6,
				data : convertData(data),
			}, {
				name : 'Top 5',
				type : 'effectScatter',
				coordinateSystem : 'bmap',
				data : convertData(data.sort(function(a, b) {
					return b.value - a.value;
				}).slice(0, 5)),
				symbolSize : function(val) {
					return val[2] / 10;
				},
				showEffectOn : 'render',
				rippleEffect : {
					brushType : 'stroke'
				},
				hoverAnimation : true,
				label : {
					normal : {
						formatter : '{b}',
						position : 'right',
						show : true
					}
				},
				itemStyle : {
					normal : {
						color : '#05C3F9',
						shadowBlur : 10,
						shadowColor : '#05C3F9'
					}
				},
				zlevel : 1
			},

			]
		};
		myChart.setOption(option);
		// console.log(myChart.getModel().getComponent('bmap'));
		// 获取百度地图实例，使用百度地图自带的控件
		var map = myChart.getModel().getComponent('bmap').getBMap();
		map.addControl(new BMap.MapTypeControl());
		var mapStyle = {
			features : [ "road", "building", "water", "land" ],//隐藏地图上的poi
			style : "water" //设置地图风格为高端黑
		};
		map.setMapStyle(mapStyle);

		var opts = {type: BMAP_NAVIGATION_CONTROL_ZOOM}    
		map.addControl(new BMap.NavigationControl(opts)); 
		var bs = new BoundaryService();
		bs.findBoundary(2, new Eht.Responder({
			success : function(data) {
				var pointArray = [];
				for (var i = 0; i < data.length; i++) {
					var bounds = data[i].boundary;
					for (var j = 0; j < bounds.length; j++) {
						var ply = new BMap.Polygon(bounds[j], {
							strokeWeight : 2,
							strokeColor : "#212121",
							fillColor : "#292557"
						}); //建立多边形覆盖物 81bbec
						map.addOverlay(ply);
						pointArray = pointArray.concat(ply.getPath());
					}
				}
			}
		})); 
		
		//安置帮教人员数量排名
		var optionAzbj = {
		    tooltip : {
		        trigger: 'axis',
		        axisPointer : {            // 坐标轴指示器，坐标轴触发有效
		            type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
		        }
		    },
		    legend: {
		        data: ['重点对象', '一般对象']
		    },
		    grid: {
		        left: '3%',
		        right: '4%',
		        bottom: '3%',
		        containLabel: true
		    },
		    xAxis:  {
		        type: 'value'
		    },
		    yAxis: {
		        type: 'category',
		        data: ['阿拉善','兴安盟','锡林浩特','乌兰察布','巴彦淖尔','呼伦贝尔','鄂尔多斯','通辽','赤峰','乌海','包头','呼和浩特']
		    },
		    series: [
		        {
		            name: '重点对象',
		            type: 'bar',
		            stack: '总量',
		            label: {
		                normal: {
		                    show: true,
		                    position: 'insideRight'
		                }
		            },
		            data: [320, 302, 301, 334, 390, 330, 320,333,230,110,120,150]
		        },
		        {
		            name: '一般对象',
		            type: 'bar',
		            stack: '总量',
		            label: {
		                normal: {
		                    show: true,
		                    position: 'insideRight'
		                }
		            },
		            data: [120, 132, 101, 134, 90, 230, 210,222,110,80,120,200]
		        },
		       
		    ]
		};
		var myChartAzbj = echarts.init(document.getElementById('spsAzbj-container-right2-div3'));
		myChartAzbj.setOption(optionAzbj);
		
		//container-right2默认情况下是隐藏状态点击切换按钮
		$("#spsAzbj-glyphicon-list").click(function(){
			$("#spsAzbj-container-right2").show(500);
			$("#spsAzbj-container-right1").hide(500);
		})
		///
		$("#spsAzbj-container-right2").hide();
		$("#spsAzbj-by-attributes-alt").click(function(){
			$("#spsAzbj-container-right1").show(500);
			$("#spsAzbj-container-right2").hide(500);
		})
		///默认隐藏的区域选择
		//区域选择div
		$('#spsAzbj-hidenDiv').hide();
		var service = new RegionService();
		$("#spsAzbj-container-left1-div1").click(function(){
			service.find({},new Eht.Responder({
				success:function(data){
					for(var i=0;i<data[0].nodes.length;i++){
						var city = $('<ul></ul>');
						var root = $('<li><div><input type="checkbox">'+data[0].nodes[i].region_name+'</div></li>')
						city.append(root);
						$('#spsAzbj-hidenDivSS').append(city);
						city.addClass("hidden-div-ul");
						var child = $('<ul></ul>');;
						for(var j=0;j<data[0].nodes[i].nodes.length;j++){
							var li = $('<li><input type="checkbox">'+data[0].nodes[i].nodes[j].region_name+'</li>');
							child.append(li);
							li.addClass("hidden-div-li");
						}
						root.append(child);
					}
				}
			}))
			$("#spsAzbj-hidenDiv").show();
		})
		//关闭按钮
		$("#spsAzbj-hidenDivBtn").click(function(){
			$("#spsAzbj-hidenDiv").hide();
		})
		//日历
		 $(".form_datetime").datetimepicker({
		        format: "yyyy-mm-dd",
		        language:  'zh-CN',
		        autoclose: true,
		        todayBtn: true,
		        minView: 2,
		        pickerPosition: "bottom-right"
		    });
	})	