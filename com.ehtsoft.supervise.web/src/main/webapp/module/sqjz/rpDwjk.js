$(function() {
	var xvalue_24h = [ '00', '01', '02', '03', '04', '05', '06', '07', '08','09', '10', '11', '12', '13', '14', '15', '16', '17', '18', '19','20', '21', '22', '23', '24h' ];
	var yarn_data_obj = {
		"xValueList" : xvalue_24h,
		"queueNameList" : [ "billqueue", "default", "dzqd" ],
		"data" : {
			"smsd" : [ 0.38, 0.31, 0.32, 0.32, 0.64, 0.66, 0.86, 0, 0, 0, 0, 0, 0,  0.56,0.45, 0,  0, 0, 0,0, 0, 0.60, 0.45, 0.36, 0.67 ],
			"smsy" : [ 0.60, 0.51, 0.52, 0.53, 0.64, 0.84, 0.65, 0,  0, 0, 0, 0, 0,  0.56,0.45, 0,  0, 0, 0,0, 0, 0.53, 0.58, 0.53,0.56 ],
		}
	};
	var colorConsArr_hdfs = [  "#ff60a2", "#bf64ff" ];
	//睡眠深度
	var optionSmsd = {
		backgroundColor : '#fff', // 设置背景色
		tooltip : {
			trigger : 'axis'
		},
		color : [ "#bf64ff" ],
		legend : {
			itemGap : 14,
			right : '16%',
			top : '2%',
			 padding:[40,10,0,10],
			data : [ "billqueue" ]
		},
		grid : {
			left : '1.5%',
			right : '3%',
			bottom : '0%',
			top:'0%',
			containLabel : true
		},
		xAxis : [ {
			type : 'category',
			boundaryGap : true,
			data : xvalue_24h,
			axisLine : {
				show : false
			},
			axisTick : {
				show : false
			},
			axisLabel : {
				textStyle : {
					color : "#454e72"
				},
				margin : 15
			},
			splitLine : {
				lineStyle : {
					color : "#1d203b"
				}
			}
		} ],
		yAxis : [ {
			name : '睡眠深度',
			nameGap : 20,
			nameTextStyle : {
				color : '#454e72',
				fontSize : 12,
			},
			type : 'value',

			axisLine : {
				show : false
			},
			axisTick : {
				show : false
			},
			axisLabel : {
				textStyle : {
					color : '#303765'
				},
				margin : 20
			},
			splitLine : {
				lineStyle : {
					color : "#1d203b"
				}
			}
		} ],
		series : [ {
			name : "睡眠深度",
			type : 'line',
			stack : '总量',
			areaStyle : {
				normal : {
					color : colorConsArr_hdfs[0],
					opacity : 1
				}
			},
			lineStyle : {
				normal : {
					color : colorConsArr_hdfs[0],
					width : 0
				}
			},
			symbol : 'none',
			smooth : true,
			data : yarn_data_obj.data.smsd
		}]
	};
	var smsdChar = echarts.init(document.getElementById('smsdChar'));
	smsdChar.setOption(optionSmsd);
	
	//睡眠声音
	var optionSmsy = {
			backgroundColor : '#fff', // 设置背景色
			tooltip : {
				trigger : 'axis'
			},
			color : [ "#bf64ff" ],
			legend : {
				itemGap : 14,
				right : '16%',
				top : '2%',
				 padding:[40,10,0,10],
				data : [ "声音" ]
			},
			grid : {
				left : '1.5%',
				right : '3%',
				bottom : '0%',
				top:'0%',
				containLabel : true
			},
			xAxis : [ {
				type : 'category',
				boundaryGap : true,
				data : xvalue_24h,
				axisLine : {
					show : false
				},
				axisTick : {
					show : false
				},
				axisLabel : {
					textStyle : {
						color : "#454e72"
					},
					margin : 15
				},
				splitLine : {
					lineStyle : {
						color : "#1d203b"
					}
				}
			} ],
			yAxis : [ {
				name : '睡眠声音',
				nameGap : 20,
				nameTextStyle : {
					color : '#454e72',
					fontSize : 12,
				},
				type : 'value',

				axisLine : {
					show : false
				},
				axisTick : {
					show : false
				},
				axisLabel : {
					textStyle : {
						color : '#303765'
					},
					margin : 20
				},
				splitLine : {
					lineStyle : {
						color : "#1d203b"
					}
				}
			} ],
			series : [ {
				name : "睡眠声音",
				type : 'line',
				stack : '总量',
				areaStyle : {
					normal : {
						color : colorConsArr_hdfs[1],
						opacity : 1
					}
				},
				lineStyle : {
					normal : {
						color : colorConsArr_hdfs[1],
						width : 0
					}
				},
				symbol : 'none',
				smooth : true,
				data : yarn_data_obj.data.smsy
			}]
		};
		var smsyChar = echarts.init(document.getElementById('smsyChar'));
		smsyChar.setOption(optionSmsy);
		
		
})