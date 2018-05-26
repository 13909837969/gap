$(function(){
		var myChart = echarts.init(document.getElementById('das_mapID'));
		var geoCoordMap = {
			'呼和浩特市' : [ 111.66035052, 40.82831887 ],
			'包头市' : [ 109.844819, 40.661834 ],
			'乌海市' : [ 106.797229, 39.663228 ],
			'赤峰市' : [ 118.889196, 42.264889 ],
			'通辽市' : [ 122.244198, 43.660276 ],
			'鄂尔多斯市' : [ 109.781694, 39.614704 ],
			'呼伦贝尔市' : [ 119.766046, 49.219764 ],
			'乌兰察布市' : [ 113.134294, 41.000966 ],
			'巴彦淖尔市' : [ 107.390374, 40.748703 ],
			'兴安盟' : [ 122.040915, 46.089263 ],
			'阿拉善盟' : [ 105.735018, 38.858529 ],
			'锡林郭勒盟' : [ 116.051804, 43.940046 ]
		};
		// 每个盟市机构总数和报警总数
		var data = [ {
			name : '呼和浩特市',
			value : 23448,
		}, {
			name : '包头市',
			value : 3515
		}, {
			name : '乌海市',
			value : 5024
		}, {
			name : '赤峰市',
			value : 13155
		}, {
			name : '通辽市',
			value : 6820
		}, {
			name : '鄂尔多斯市',
			value : 6381
		}, {
			name : '呼伦贝尔市',
			value : 11119
		}, {
			name : '乌兰察布市',
			value : 9355
		}, {
			name : '巴彦淖尔市',
			value : 10856
		}, {
			name : '兴安盟',
			value : 8533
		}, {
			name : '阿拉善盟',
			value : 1040
		}, {
			name : '锡林郭勒盟',
			value : 6696
		} ];
		var max = 13155, min = 1040; // todo 
		var maxSize4Pin =80, minSize4Pin = 20;
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
				center : [ 116.757124,43.340579 ],
				// 百度地图缩放
				zoom : 6,
				// 是否开启拖拽缩放，可以只设置 'scale' 或者 'move'
				roam : false,
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
						borderColor : '#f00',
					},
					emphasis : {
						areaColor : '#2B91B7',
					}
				}
			},
			series : [ {
				name : '',
				type : 'scatter',
				coordinateSystem : 'bmap',
				data : convertData(data),
				/*symbolSize : function(val) {
					var r = val[2]*maxSize4Pin/max/2;
					if(r<minSize4Pin/2){
						r = minSize4Pin/2;
					}
					return r;
				},*/label : {
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
						color : '#00fbff',//盟市字体颜色
						fontSize : 14,
					}
				}
			},
			{
				name : '点',
				type : 'scatter',
				coordinateSystem : 'bmap',
				symbol : 'pin',
				symbolSize : function(val) {
					var a = (maxSize4Pin - minSize4Pin) / (max - min);
					var b = minSize4Pin - a * min;

					
					
					
					
					
					
					return a * val[2] + b;
				},
				label : {//控制显示数量
					normal : {
						show : true,
						textStyle : {
							color : '#fff',
							fontSize : 16,
						}
					}
				},
				itemStyle : {
					normal : {
						color : '#F62157', //地图上红标识的颜色
					}
				},
				zlevel : 6,
				data : convertData(data),
			}
			]
		};
		myChart.setOption(option);
		// console.log(myChart.getModel().getComponent('bmap'));
		// 获取百度地图实例，使用百度地图自带的控件
		var map = myChart.getModel().getComponent('bmap').getBMap();
		//map.addControl(new BMap.MapTypeControl());
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
		/*$("#glyphicon-user").click(function(){
			$("#container-right2").show(1000);
			$("#container-right1").hide(200);
		});*/
		///
		$("#container-right2").hide();
		$("#glyphicon-random").click(function(){
			$("#container-right1").show(1000);
			$("#container-right2").hide(200);
		});
		//默认隐藏的区域选择
		//区域选择div
		$('#spsSqjz-hidenDiv').hide();
		var service = new RegionService();
		service.find({},new Eht.Responder({
			success:function(data){
				for(var i=0;i<data[0].nodes.length;i++){
					var city = $('<ul></ul>');
					var root = $('<li><div><input type="checkbox" style="margin-left:10px; margin-right:3px;"><span>'+data[0].nodes[i].region_name+'</span></div></li>')
					city.append(root);
					$('#spsSqjz-hidenDivSS').append(city);
					city.addClass("hidden-div-ul");
					var child = $('<ul style="margin-top:10px;padding-left:0px;"></ul>');
					for(var j=0;j<data[0].nodes[i].nodes.length;j++){
						var li = $('<li><input type="checkbox" style="margin-left:10px; margin-right:3px;">'+data[0].nodes[i].nodes[j].region_name+'</li>');
						child.append(li);
						li.addClass("hidden-div-li");
					}
					root.append(child);
				}
			}
		}));
		//显示隐藏的区域选择
		$("#container-left1-div1").click(function(){
				$("#spssqjz-hidenDiv").css("height","0").show().animate({height:400});
			return false;
		});
		//点击其他地方区域隐藏
		$(window).click(function(){
			$("#spssqjz-hidenDiv").animate({height:0},function(){$(this).hide()});
		});
		
		$("#spssqjz-hidenDiv").click(function(){return false;});
		
		//点击确定按钮的时候关闭区域并且提交选择的数据
		$("#spsSqjz-hidenDiv-qd").click(function(){
			$("#spssqjz-hidenDiv").animate({height:0},function(){$(this).hide()});
		});
		//关闭按钮
		$("#spsSqjz-hidenDivBtn").click(function(){
			$("#spssqjz-hidenDiv").animate({height:0},function(){$(this).hide()});
		});		
		var tempdata = {
				"呼和浩特市":23448,
				"包头市":3515,
				"呼伦贝尔市":11119,
				"兴安盟":8533,
				"通辽市":6820,
				"赤峰市":13155,
				"锡林郭勒盟":6696,
				"乌兰察布市":9355,
				"鄂尔多斯市":6381,
				"巴彦淖尔市":10856,
				"乌海市":	5024,
				"阿拉善盟":1040};
		
		var tempdata1 = {
				"呼和浩特市":22.13, 
				"包头市":3.31, 
				"呼伦贝尔市":10.49, 
				"兴安盟":8.05, 
				"通辽市":6.43, 
				"赤峰市":12.41, 
				"锡林郭勒盟":6.32,  
				"乌兰察布市":8.83,  
				"鄂尔多斯市":6.02,  
				"巴彦淖尔市":10.24, 
				"乌海市":	4.74,
				"阿拉善盟":0.98};
		
		var tempdata2 = {
				"呼和浩特市":9.83,
				"包头市":-12.38,
				"呼伦贝尔市":39.23,
				"兴安盟":-50.91,
				"通辽市":-41.74,
				"赤峰市":0.06,
				"锡林郭勒盟":70.16,
				"乌兰察布市":66.87,
				"鄂尔多斯市":-61.92,
				"巴彦淖尔市":-31.12,
				"乌海市":	-60.19,
				"阿拉善盟":-73.71};
		//默认显示各市区矫正人员总数
		service.find({},new Eht.Responder({
			success:function(data){
				var table = $("#rmtjTable"); 
				for(var i=0;i<data[0].nodes.length;i++){
				   var  tr = $('<tr height="20px" id="'+i+'"class="city-hight" style="color:#fff;">'
							+	'<td width="30px;" class="city-hight"><span id="spanId" class="badge" style="width:35px;(i<=3 ? "background:#f00;" : "background:#333;")">'+(i+1)+'</span></td>'
				      		+	'<td align="center"  width="100px;" class="city-hight">'+data[0].nodes[i].region_name+'</td>'
				      		+	'<td align="center"  width="100px;" class="city-hight">'+tempdata[data[0].nodes[i].region_name]+'件</td>'
				      		+   '<td align="center"  width="50px;" class="city-hight">'+tempdata1[data[0].nodes[i].region_name]+'%</td>'
				      		+	'<td width="50px;" style="padding-left:50px;" class="city-hight"><span class="badge" style="width:70px;">'+tempdata2[data[0].nodes[i].region_name]+'%</span></td>'
				      		+	'</tr><hr/>');
					table.append(tr);
				}
			}
		}));
		//默认显示个区域工作人员的排名
		service.find({},new Eht.Responder({
			success:function(data){
				for(var i=0;i<data[0].nodes.length;i++){
					var table = $("#container-right2-div4"); 
					var tr = $('<tr height="42px" style="margin-left:10px;border-bottom:1px solid #f00; border-top:0px;line-height:42px;" id="'+i+'" class="city-hight">'
							+	'<td width="30px;"><span class="badge"   style="width:35px;height:26px;(i<=3 ? "background:#f00;" : "background:#333;")">'+(i+1)+'</span></td>'
							+	'<td align="center" width="80px">张明</td>'
				      		+	'<td align="center"  width="90px;">'+data[0].nodes[i].region_name+'</td>'
				      		+   '<td align="center"  width="90px;">'+data[0].nodes[i].region_name+'</td>'
				      		+	'<td align="center"  width="80px;">2330人</td>'
				      		+	'<td align="center" width="80px;" ><span class="badge">90%</span></td>'
			      		+	'</tr>');
					table.append(tr);
				}
			}
		}));		
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
		
		//气球点击事件
		myChart.on('click', function (params) {
			liandong(params.name);
		});
		//调解案件总数分析默认状态下是隐藏的
		$("#spsRmtj-ajfx-div").hide();
		$("#spsRmtj-ajfx-header3").unbind("click").bind("click",function(){
			$("#spsRmtj-ajfx-div").hide();
		});
		
	//页面地端的联动
		//
		function liandong(name) {
			var r = new Rep_Rmtj_Test();
			r.findDateByName(name,new Eht.Responder({success:function(data){
				//调解案件总数
				$("#container-left2 #container-left2-div13").html(data.ajzs);
				$("#container-left2 #anjian").html(data.ajzs);
				//人民调节员总数
				$("#renyuan").html(data.renyuan);
				//口头调解总数
				$("#koutou").html(data.koutou);
				//主动调节
				$("#zhudong").html(data.zhudong);
				//协议涉及金额
				$("#jine").html(data.jine);
				//调解机构总数
				$("#jigou").html(data.jigou);
				//调解成功总数
				$("#chenggong").html(data.chenggong);
				//书面调解总数
				$("#shumian").html(data.shumian);
				//依审请调节
				$("#yishen").html(data.yishen);
			
			}}));
			
			//进行数据的动态加载【判断名字】
		}
		
	})	