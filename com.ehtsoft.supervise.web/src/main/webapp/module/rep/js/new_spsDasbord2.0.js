//初始化界面
$(function() {
	init();
});
function init() {
	$(".left-item").click(function() {
		$(".left-item").each(function(){
			$(this).css('background-color', '');
		});
		$(this).css('background-color', '#ccc');
	});
	var r = new Rep_Rmtj_Test(); //定义使用的service
	//初始化左边的数据、加载底部数据 
	r.findAllsl(new Eht.Responder({success:function(data){
		 $("#li1").html(data[0].sl);// 律师事务所 1
		 $("#li2").html(data[1].sl);//律师 2
		 $("#li3").html(data[2].sl);//公证处   
		 $("#li4").html(data[3].sl);//公证员 
		 $("#li5").html(data[4].sl);//司法鉴定机构 	
		 $("#li6").html(data[5].sl);//司法鉴定人员
		 $("#li7").html(data[6].sl);//人民调解委员会
		 $("#li8").html(data[7].sl);//人民调解员
		 $("#li9").html(data[8].sl);//法律援助中心
		 $("#li10").html(data[9].sl);//法律援助律师
		 $("#li11").html(data[10].sl);//司法所
		 $("#li12").html(data[11].sl);//司法所工作人员
		 $("#li13").html(data[12].sl);//基层法律服务所
		 $("#li14").html(data[13].sl);//基层法律服务工作者
		
		 //对接 右侧数据 
		 $("#gz1").html(data[16].sl);//公证案件办证量
		 $("#gz2").html(data[17].sl);//律师办理案件数
		 $("#gz3").html(data[18].sl);//司法鉴定案件数
		 $("#gz4").html(data[19].sl);//法律援助案件数
		 $("#gz5").html(data[20].sl);//人民调解案件数

		 var sum_jy=data[14].sl;
		 var sum1_jd=data[15].sl;
		 var sum2_fx= data[22].sl;
		 var sum3_azbj=data[21].sl;
		 zs(sum_jy,sum1_jd,sum2_fx,sum3_azbj);
		//加载地图数据
		//地图盟市的定位信息
		 var type = '15';//默认加载【监狱服刑人员数】
		 var falg = true;
		 Map_data(type,falg);
		
}}));

	var r = new Rep_Rmtj_Test(); //定义使用的service
	 //监狱服刑人员
	 $("#ltrhao-body-left2-div1").click(function() {
		 var type = "15";
		 var falg = false;
		 Map_data(type,falg);
	});
	//强制隔离戒毒所
	 $("#ltrhao-body-left3-div1").click(function() {
		 var type = "16";
		 var falg = false;
		 Map_data(type,falg);
	});
	 
	 
	//社区服刑人员
	 $("#ltrhao-body-left11-div1").click(function() {
		 var type = "23";
		 var falg = false;
		 Map_data(type,falg);
	});
	//安置帮教人员
	 $("#ltrhao-body-left10-div1").click(function() {
		 var type = "22";
		 var falg = false;
		 Map_data(type,falg);
	});
	 
	 $("#ltrhao-body-left2-div1").css('background-color', '#ccc');
		//矫正人员软件
    	var  jzChart = echarts.init(document.getElementById('dasbord-jz-chart'));
    	var  azChart = echarts.init(document.getElementById('dasbord_az_chart'));
    	var  rmChart = echarts.init(document.getElementById('dasbord_rm_chart'));
    	var  fxChart = echarts.init(document.getElementById('dasbord_fx_chart'));
        var option_aa = {
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
        jzChart.setOption(option_aa);
        azChart.setOption(option_aa);
        rmChart.setOption(option_aa);
        fxChart.setOption(option_aa);
      //默认隐藏的区域选择
    	//区域选择div
    	
    	$('#spsSqjz-hidenDiv').hide();
    	
    	//显示隐藏的区域选择
    	$("#inputQyDiv").click(function(){
    			$("#spssjfx-hidenDiv").css("height","0").show().animate({height:400});
    			$("[type='checkbox']").prop("checked",false); //
    		return false;
    	});
    	//点击其他地方区域隐藏
    	$(window).click(function(){
    		$("#spssjfx-hidenDiv").animate({height:0},function(){$(this).hide()});
    	});
    	
    	$("#spssjfx-hidenDiv").click(function(){return false;});
    	
    	//关闭按钮
    	$("#spsSqjz-hidenDivBtn").click(function(){
    		$("#spssjfx-hidenDiv").animate({height:0},function(){$(this).hide()});
    	});
       
		//rangCity的关闭按钮
		$("#rangCity-close").unbind("click").bind("click",function(){
			$("#rangCity").css("right","2px").hide().animate({right:0});
			$("#rangDitail").hide();//隐藏详细情况分析
			$("#ltrhao-body-left1").css("left","-300px").show().animate({left:10});
			$("#ltrhao-body-left2").css("left","-300px").show().animate({left:10});
			$("#ltrhao-body-left3").css("left","-300px").show().animate({left:10});
			$("#ltrhao-body-left4").css("left","-300px").show().animate({left:10});
			$("#ltrhao-body-left5").css("left","-300px").show().animate({left:10});
			$("#ltrhao-body-right1").css("top","-300px").show().animate({top:20});
			$("#ltrhao-body-right2").css("right","-300px").show().animate({right:10});
			$("#ltrhao-body-right3").css("right","-300px").show().animate({right:172});
			$("#container-right4").show();
		})
		//点击相关城市的时候显示详细情况分析
		$("#city-name").unbind("click").bind("click",function(){
			$("#rangDitail").css("right",$(window).outerWidth(true)).show().animate({right:685});
		})
		$("#city-name").hover(function(){
			$("#city-name").css("color","#ff0");
		},function(){
			$("#city-name").css("color","#fff");
		});

}
//加载地图数据  
function Map_data(type,falg) {
	var r = new Rep_Rmtj_Test(); //定义使用的service
	r.findMapInitialization(type,new Eht.Responder({success:function(datadw){
		//地图的定位坐标及城市名称及气球数据
		 refresh(datadw,falg);
}}));
}


//刷新界面
function refresh(data,falg) {
	 //随机数处理
		var myChart = echarts.init(document.getElementById('das_mapID'));
		//地图经纬度数据【未对接】
			var max = 13155, min = 1040; // todo 
			var maxSize4Pin =80, minSize4Pin = 20;
			function convertData(data) {
				var res = [];
				res = data; //data  有数据的地区的名称和value值
				return res;
			};
		var option = {
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
					// 百度地图中心经纬度 113.253013,43.820396
					//center : [ 118.012963, 45.068573 ],
					center : [113.253013,43.820396],
					// 百度地图缩放
					zoom : 6,
					// 是否开启拖拽缩放，可以只设置 'scale' 或者 'move'
					//roam : true,
					//scale:false,	
					move:true,
					//enableDragging(),
					// 百度地图的自定义样式，见 http://developer.baidu.com/map/jsdevelop-11.htm
					mapStyle : "midnight"
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
							color : '#00fbff'//盟市字体颜色
						}
					}
				},
				{
					name : '点',
					type : 'scatter',
					coordinateSystem : 'bmap',
					symbol : 'pin',
					symbolSize : function(val) {
						var a = 0.004952538175815105;//(maxSize4Pin - minSize4Pin) / (max - min);
						var b = minSize4Pin - a * min;
						b = 14.849360297152302;//maxSize4Pin - a * max;
						//返回气球的大小
						return a * 7765 + b;
					},
					label : {//控制显示数量
						normal : {
							show : true,
							textStyle : {
								color : '#fff',
								fontSize :14,
							}
						}
					},
					itemStyle : {
						normal : {
							color : '#F62157', //地图上红标识的颜色
						}
					},
					//zlevel : 6,
					data : convertData(data),
				}, 
				{
					name : '',
					type : 'effectScatter',
					coordinateSystem : 'bmap',
					data : convertData(data.sort(function(a, b) {
						return b.value - a.value;
					}).slice(0, 5)),
					/*symbolSize : function(val) {
						var r = val[2]*maxSize4Pin/max/2;
						if(r<minSize4Pin/2){
							r = minSize4Pin/2;
						}
						r = 16;
						return r;
					},*/
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
					itemStyle : {//控制蓝颜色点颜色
						normal : {
							color : '#00fbff',
							shadowBlur : 10,
							shadowColor : '#00fbff'
						}
					},
					zlevel : 6
				}
				]
			};
	
	myChart.setOption(option);
	//气球单击事件选择 【弹框】
	myChart.on('click', function (params) {
	});
		
	// console.log(myChart.getModel().getComponent('bmap'));
	// 获取百度地图实例，使用百度地图自带的控件
	var map = myChart.getModel().getComponent('bmap').getBMap();
	//map.addControl(new BMap.MapTypeControl());
	map.enableDragging();//设置地图的拖拽属性
	var mapStyle = {
		features : [ "road", "building", "water", "land" ],//隐藏地图上的poi
		style : "water" //设置地图风格为高端黑  midnight
	};
	map.setMapStyle(mapStyle);
	
	//设置地图的铺色
	var strokeColor;
	var fillColor;
	if (falg) {
		 fillColor = "#292557";
	}else{
		 fillColor = "";
	}
	
	var opts = {type: BMAP_NAVIGATION_CONTROL_ZOOM} //显示缩放部分功能 
	map.addControl(new BMap.NavigationControl(opts)); 
	
	//区域划分
	var bs = new BoundaryService();
	bs.findBoundary(2, new Eht.Responder({
		success : function(data) {
			var pointArray = [];
			for (var i = 0; i < data.length; i++) {
				var bounds = data[i].boundary;
				for (var j = 0; j < bounds.length; j++) {
					if (j == 2) {
						return;
					}
					var ply = new BMap.Polygon(bounds[j], {
						strokeWeight : 1,
						strokeColor : "#212121",
						fillColor : fillColor
					}); //建立多边形覆盖物 81bbec
					map.addOverlay(ply);
					pointArray = pointArray.concat(ply.getPath());
				}
			}
		}
	}));
}

//左上
function zs(sum_jy,sum1_jd,sum2_fx,sum3_azbj) {
	/*动态效果*/
	var dom = document.getElementById("sdfsdfgsd");
	var myChart = echarts.init(dom);
	var app = {};
	option = null;
	option = {
	    grid: {
	        top: '90%',
	        left: "1%",
	        right: "1%",
	        bottom: '10%'
	    },
	    xAxis: {
	        splitLine: {
	            show: false
	        },
	        axisLine: {
	            show: false
	        },
	        axisTick: {
	            show: false
	        },
	        axisLabel: {
	            show: false
	        },
	        max: 1000,
	        min: 0
	    },
	    yAxis: {
	        silent: true,
	        splitLine: {
	            show: false
	        },
	        axisLine: {
	            show: false
	        },
	        axisTick: {
	            show: false
	        },
	        axisLabel: {
	            show: false
	        },
	        max: 1000,
	        min: 0
	    },
	    series: [ {
	        coordinateSystem: 'cartesian2d',
	        type: 'lines',
	        polyline: true,
	        zlevel: 2,
	        effect: {
	            show: true,
	            constantSpeed: 200,
	            trailLength: 0.05,
	            symbolSize: 5,
	            symbol: 'circle',
	            loop: true
	        },
	        lineStyle: {
	            normal: {
	                color:'#f00',
	                opacity: 0,
	                curveness: 0.3
	            }
	        },
	        data: [{
	            coords: [
	                [0, 0],
	                [2000, 2000]
	            ]
	        }, {
	            coords: [
	                [2000, 2000],
	                [0, 0]
	            ]
	        }]
	    }]
	};
	if (option && typeof option === "object") {
	    myChart.setOption(option, true);
	};
	/**/
	var dom = document.getElementById("sdfsdfgsd2");
	var myChart = echarts.init(dom);
	var app = {};
	option = null;
	option = {
	    grid: {
	        top: '90%',
	        left: "1%",
	        right: "1%",
	        bottom: '10%'
	    },
	    xAxis: {
	        splitLine: {
	            show: false
	        },
	        axisLine: {
	            show: false
	        },
	        axisTick: {
	            show: false
	        },
	        axisLabel: {
	            show: false
	        },
	        max: 1000,
	        min: 0
	    },
	    yAxis: {
	        silent: true,
	        splitLine: {
	            show: false
	        },
	        axisLine: {
	            show: false
	        },
	        axisTick: {
	            show: false
	        },
	        axisLabel: {
	            show: false
	        },
	        max: 1000,
	        min: 0
	    },
	    series: [ {
	        coordinateSystem: 'cartesian2d',
	        type: 'lines',
	        polyline: true,
	        zlevel: 2,
	        effect: {
	            show: true,
	            constantSpeed: 200,
	            trailLength: 0.05,
	            symbolSize: 5,
	            symbol: 'circle',
	            loop: true
	        },
	        lineStyle: {
	            normal: {
	                color:'#f00',
	                opacity: 0,
	                curveness: 0.3
	            }
	        },
	        data: [{
	            coords: [
	                [0, 0],
	                [2000, 2000]
	            ]
	        }, {
	            coords: [
	                [2000, 2000],
	                [0, 0]
	            ]
	        }]
	    }]
	};
	if (option && typeof option === "object") {
	    myChart.setOption(option, true);
	};
	/**/
	var dom = document.getElementById("sdfsdfgsd3");
	var myChart = echarts.init(dom);
	var app = {};
	option = null;
	option = {
	    grid: {
	        top: '90%',
	        left: "1%",
	        right: "1%",
	        bottom: '10%'
	    },
	    xAxis: {
	        splitLine: {
	            show: false
	        },
	        axisLine: {
	            show: false
	        },
	        axisTick: {
	            show: false
	        },
	        axisLabel: {
	            show: false
	        },
	        max: 1000,
	        min: 0
	    },
	    yAxis: {
	        silent: true,
	        splitLine: {
	            show: false
	        },
	        axisLine: {
	            show: false
	        },
	        axisTick: {
	            show: false
	        },
	        axisLabel: {
	            show: false
	        },
	        max: 1000,
	        min: 0
	    },
	    series: [ {
	        coordinateSystem: 'cartesian2d',
	        type: 'lines',
	        polyline: true,
	        zlevel: 2,
	        effect: {
	            show: true,
	            constantSpeed: 200,
	            trailLength: 0.05,
	            symbolSize: 5,
	            symbol: 'circle',
	            loop: true
	        },
	        lineStyle: {
	            normal: {
	                color:'#f00',
	                opacity: 0,
	                curveness: 0.3
	            }
	        },
	        data: [{
	            coords: [
	                [0, 0],
	                [2000, 2000]
	            ]
	        }, {
	            coords: [
	                [2000, 2000],
	                [0, 0]
	            ]
	        }]
	    }]
	};
	if (option && typeof option === "object") {
	    myChart.setOption(option, true);
	};
	/*动态效果*/
	var dom = document.getElementById("sdfsdfgsd4");
	var myChart = echarts.init(dom);
	var app = {};
	option = null;
	option = {
	    grid: {
	        top: '90%',
	        left: "1%",
	        right: "1%",
	        bottom: '10%'
	    },
	    xAxis: {
	        splitLine: {
	            show: false
	        },
	        axisLine: {
	            show: false
	        },
	        axisTick: {
	            show: false
	        },
	        axisLabel: {
	            show: false
	        },
	        max: 1000,
	        min: 0
	    },
	    yAxis: {
	        silent: true,
	        splitLine: {
	            show: false
	        },
	        axisLine: {
	            show: false
	        },
	        axisTick: {
	            show: false
	        },
	        axisLabel: {
	            show: false
	        },
	        max: 1000,
	        min: 0
	    },
	    series: [ {
	        coordinateSystem: 'cartesian2d',
	        type: 'lines',
	        polyline: true,
	        zlevel: 2,
	        effect: {
	            show: true,
	            constantSpeed: 200,
	            trailLength: 0.05,
	            symbolSize: 5,
	            symbol: 'circle',
	            loop: true
	        },
	        lineStyle: {
	            normal: {
	                color:'#f00',
	                opacity: 0,
	                curveness: 0.3
	            }
	        },
	        data: [{
	            coords: [
	                [0, 0],
	                [2000, 2000]
	            ]
	        }, {
	            coords: [
	                [2000, 2000],
	                [0, 0]
	            ]
	        }]
	    }]
	};
	if (option && typeof option === "object") {
	    myChart.setOption(option, true);
	};
	
	
	/**/
	var dom = document.getElementById("ltrhao-body-left2-div24");
	var myChart = echarts.init(dom);
	var app = {};
	option = null;
	 var count = 360;
	    var data = [sum_jy];
	    for (var i = 0; i < count; i++) {
	        data.push([1, i]);
	    }
	    option = {
	        color: ['#0f0'],
	        title: {
	            text: sum_jy,
	            textStyle:{
	            	color:'#ffffff',
	            	fontSize:20,
	            	fontWeight:'normal',
	            	fontFamily:'华文细黑',
	            },
	            x: 'center',
	            y: 'center'
	       },
	        visualMap: [{
	            show: false,
	            dimension: 1,
	            min: 0,
	            max: count
	        }],
	        series: [{
	            type: 'pie',
	            radius : ['50%', '85%'],
	            center: ['50%', '50%'],
	            silent: true,
	            labelLine: {
	                normal: {
	                    show: false
	                }
	            },
	            data:data
	        }]
	    };
	if (option && typeof option === "object") {
	    myChart.setOption(option, true);
	};
/*----------------------------------*/
	var dom = document.getElementById("ltrhao-body-left3-div24");
	var myChart = echarts.init(dom);
	var app = {};
	option = null;
	 var count = 360;
	    var data = [sum1_jd];
	    for (var i = 0; i < count; i++) {
	        data.push([1, i]);
	    }
	    option = {
	        color: ['#0f0'],
	        title: {
	            text: sum1_jd,
	            textStyle:{
	            	color:'#ffffff',
	            	fontSize:20,
	            	fontWeight:'normal',
	            	fontFamily:'华文细黑',
	            },
	            x: 'center',
	            y: 'center'
	       },
	        visualMap: [{
	            show: false,
	            dimension: 1,
	            min: 0,
	            max: count
	           
	        }],
	        series: [{
	            type: 'pie',
	            radius : ['50%', '85%'],
	            center: ['50%', '50%'],
	            silent: true,
	            labelLine: {
	                normal: {
	                    show: false
	                }
	            },
	            data: data
	        }]
	    };
	if (option && typeof option === "object") {
	    myChart.setOption(option, true);
	};
	/**************************************/
	var dom = document.getElementById("ltrhao-body-left11-div24");
	var myChart = echarts.init(dom);
	var app = {};
	option = null;
	 var count = 360;
	    var data = [sum2_fx];
	    for (var i = 0; i < count; i++) {
	        data.push([1, i]);
	    }
	    option = {
	    		 color: ['#0f0'],
	        title: {
	            text: sum2_fx,
	            textStyle:{
	            	color:'#ffffff',
	            	fontSize:20,
	            	fontWeight:'normal',
	            	fontFamily:'华文细黑',
	            },
	            x: 'center',
	            y: 'center'
	       },
	        visualMap: [{
	            show: false,
	            dimension: 1,
	            min: 0,
	            max: count
	        }],
	        series: [{
	            type: 'pie',
	            radius : ['50%', '85%'],
	            center: ['50%', '50%'],
	            silent: true,
	            labelLine: {
	                normal: {
	                    show: false
	                }
	            },
	            data: data
	        }]
	    };
	if (option && typeof option === "object") {
	    myChart.setOption(option, true);
	};
	/***************************************/
	var dom = document.getElementById("ltrhao-body-left10-div24");
	var myChart = echarts.init(dom);
	var app = {};
	option = null;
	 var count = 360;
	    var data = [sum3_azbj];
	    for (var i = 0; i < count; i++) {
	        data.push([1, i]);
	    }
	    option = {
	    		 color: ['#0f0'],
	        title: {
	            text: sum3_azbj,
	            textStyle:{
	            	color:'#ffffff',
	            	fontSize:20,
	            	fontWeight:'normal',
	            	fontFamily:'华文细黑',
	            },
	            x: 'center',
	            y: 'center'
	       },
	       label: {normal: {

               show: true

           }},
	        visualMap: [{
	            show: false,
	            dimension: 1,
	            min: 0,
	            max: count
	        }],
	        series: [{
	            type: 'pie',
	            radius : ['50%', '85%'],
	            center: ['50%', '50%'],
	            silent: true,
	            labelLine: {
	                normal: {
	                    show: false
	                }
	            },
	            data: data,
	            itemStyle : { normal: {label : {show: true}}},
	        }]
	    };
	if (option && typeof option === "object") {
	    myChart.setOption(option, true);
	};
}