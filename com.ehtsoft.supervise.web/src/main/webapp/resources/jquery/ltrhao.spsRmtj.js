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
		//container-right2默认情况下是隐藏状态点击切换按钮
		$("#glyphicon-user").click(function(){
			$("#container-right2").show(1000);
			$("#container-right1").hide(200);
		})
		///
		$("#container-right2").hide();
		$("#glyphicon-random").click(function(){
			$("#container-right1").show(1000);
			$("#container-right2").hide(200);
		})
		///默认隐藏的区域选择
		//区域选择div
		$('#formRmtj-hidenDiv').hide();
		var service = new RegionService();
		$("#container-left1-div1").click(function(){
			service.find({},new Eht.Responder({
				success:function(data){
					for(var i=0;i<data[0].nodes.length;i++){
						var city = $('<ul></ul>');
						var root = $('<li><div><input type="checkbox">'+data[0].nodes[i].region_name+'</div></li>')
						city.append(root);
						$('#formRmtj-hidenDivSS').append(city);
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
			$("#formRmtj-hidenDiv").show();
		})
		//关闭按钮
		$("#formRmtj-hidenDivBtn").click(function(){
			$("#formRmtj-hidenDiv").hide();
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
		//调解案件总数分析
		var myChart_tjaj = echarts.init(document.getElementById('spsRmtj-ajfx-left'));
				var scale = 1;
				var echartData = [{
				    value: 2154,
				    name: '合同纠纷1'
				}, {
				    value: 3854,
				    name: '合同纠纷3'
				}, {
				    value: 3515,
				    name: '合同纠纷2'
				}, {
				    value: 3515,
				    name: '合同纠纷4'
				}]
				var rich = {
				    yellow: {
				        color: "#ffc72b",
				        fontSize: 30 * scale,
				        padding: [5, 4],
				        align: 'center'
				    },
				    total: {
				        color: "#ffc72b",
				        fontSize: 40 * scale,
				        align: 'center'
				    },
				    white: {
				        color: "#fff",
				        align: 'center',
				        fontSize: 14 * scale,
				        padding: [21, 0]
				    },
				    blue: {
				        color: '#49dff0',
				        fontSize: 16 * scale,
				        align: 'center'
				    },
				    hr: {
				        borderColor: '#0b5263',
				        width: '100%',
				        borderWidth: 1,
				        height: 0,
				    }
				}
				var option_tjaj = {
				    backgroundColor: '#031f2d',
				    title: {
				        text:'案件总数',
				        left:'center',
				        top:'53%',
				        padding:[24,0],
				        textStyle:{
				            color:'#fff',
				            fontSize:18*scale,
				            align:'center'
				        }
				    },
				    legend: {
				        selectedMode:false,
				        formatter: function(name) {
				            var total = 0; //各科正确率总和
				            var averagePercent; //综合正确率
				            echartData.forEach(function(value, index, array) {
				                total += value.value;
				            });
				            return '{total|' + total + '}';
				        },
				        data: [echartData[0].name],
				        // data: ['高等教育学'],
				        // itemGap: 50,
				        left: 'center',
				        top: 'center',
				        icon: 'none',
				        align:'center',
				        textStyle: {
				            color: "#fff",
				            fontSize: 16 * scale,
				            rich: rich
				        },
				    },
				    series: [{
				        name: '总考生数量',
				        type: 'pie',
				        radius: ['42%', '50%'],
				        hoverAnimation: false,
				        color: ['#c487ee', '#deb140', '#49dff0', '#034079', '#6f81da', '#00ffb4'],
				        label: {
				            normal: {
				                formatter: function(params, ticket, callback) {
				                    var total = 0; //考生总数量
				                    var percent = 0; //考生占比
				                    echartData.forEach(function(value, index, array) {
				                        total += value.value;
				                    });
				                    percent = ((params.value / total) * 100).toFixed(1);
				                    return '{white|' + params.name + '}\n{hr|}\n{yellow|' + params.value + '}\n{blue|' + percent + '%}';
				                },
				                rich: rich
				            },
				        },
				        labelLine: {
				            normal: {
				                length: 55 * scale,
				                length2: 0,
				                lineStyle: {
				                    color: '#0b5263'
				                }
				            }
				        },
				        data: echartData
				    }]
				};
		myChart_tjaj.setOption(option_tjaj);
		//调解案件总数分析默认状态下是隐藏的
		$("#spsRmtj-ajfx-div").hide();
		$("#spsRmtj-ajfx-header3").unbind("click").bind("click",function(){
			$("#spsRmtj-ajfx-div").hide();
		})
		//调解案件总数定义单击按钮事件
		$("#container-left2-div11").unbind("click").bind("click",function(){
			$("#spsRmtj-ajfx-div").show();
		})
		
	})	