$(function() {
	//初始化
	init();
});

//初始化方法
function init() {
	//盟市名称
	var city_name = "";
	//加载全区各地人民调解员数量统计
	qy_rmtjzzs();
	//人民调解案件数量走势,人民调解案件统计
	rmtj_tjajslzs(city_name);
	//2018年第一季度各类案件同比增长率
	qy_tbzzl(city_name);
	//地图加载
	var falg = true; 
	Map_data(falg);
	
}

//加载地图数据  
function Map_data(falg) {
	var r = new Rep_Rmtj_Test(); //定义使用的service
	r.findMapInitialization_rmtj(new Eht.Responder({success:function(datadw){
		//地图的定位坐标及城市名称及气球数据
		 refresh(datadw,falg);
}}));
}


function refresh(data,falg) {
	var myChart1 = echarts.init(document.getElementById('das_mapID'));
	var max = 13155, min = 1040; // todo 
	var maxSize4Pin = 85, minSize4Pin = 20;
	var convertData = function(data) {
		var res = [];
		res = data;
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
			center : [111.664796,44.8017],
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
					show : true,
				}
			},
			roam : true,
			itemStyle : {
				normal : {
					areaColor : '#f00',
					borderColor : '#f00',
				},
				emphasis : {
					areaColor : '#f00',
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
					r = 4;//minSize4Pin/2;
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
				var a = (maxSize4Pin - minSize4Pin) / (max - min);
				var b = minSize4Pin - a * min;
				b = maxSize4Pin - a * max;
				//返回气球的大小
				/*return a * val[2] + b;*/
				return a * 9000 + b;
			},
			label : {//控制显示数量
				normal : {
					show : true,
					textStyle : {
						color : '#fff',
						fontSize : 14
					}
				}
			},
			itemStyle : {
				normal : {
					color : '#F62157', //地图上红标识的颜色
					fontSize : 18
				}
			},
			zlevel : 6,
			data : convertData(data),
		}
		]
	};
	myChart1.setOption(option);
	//气球单击事件选择
	myChart1.on('click', function (params) {
		var str1 = params.name +'人民调解案件数量走势';
		var str2 = params.name +'人民调解案件统计';
		var str3 = params.name +'2018年第一季度各类案件同比增长率';
		$("#anjqk-zbqk-tjajqs").html(str1);
		$("#anjqk-anjjf-text").html(str2);
		$("#anjqk-zzl-text").html(str3);
		rmtj_tjajslzs(params.name);
		qy_tbzzl(params.name);
		
	});
	
	// console.log(myChart1.getModel().getComponent('bmap'));
	// 获取百度地图实例，使用百度地图自带的控件
	var map = myChart1.getModel().getComponent('bmap').getBMap();
	map.enableDragging();//设置地图的拖拽属性
	//map.setMapStyle({style:'midnight'});
	// map.addControl(new BMap.MapTypeControl());
	var mapStyle = {
		features : [ "road", "building", "water", "land" ],//隐藏地图上的poi
		style : "road" //设置地图风格为午夜蓝
	};
	map.enableDragging();//设置地图的拖拽属性
	map.setMapStyle(mapStyle);

	//设置地图的铺色
	var strokeColor;
	var fillColor;
	if (falg) {
		 fillColor ="#02335c";
	}else{
		 fillColor = "";
	}
	
	
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
						strokeColor : "#ccc",
						fillColor :fillColor //#84b3fc
					}); //建立多边形覆盖物 81bbec
					ply.setFillOpacity(0.9);
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
	});
	///
	$("#container-right2").hide();
	$("#glyphicon-random").click(function(){
		$("#container-right1").show(1000);
		$("#container-right2").hide(200);
	});
}

//全区各地人民调解员数量统计
function qy_rmtjzzs() {
	var r = new Rep_Rmtj_Test();
	var data_nl = new Array(); //数组对象  
	r.findDate_renyuan(new Eht.Responder({success:function(data){
		for (var i = 0; i < data.length; i++) {
			data_nl.push(
					{
					name: data[i].name,
	                value: data[i].value
	                } 
					);
		}
	//案件占比情况js
	var dom = document.getElementById("anjqk-zbqk-shuj");
	var myChart2 = echarts.init(dom);
	option = {
			//文字处理
		    tooltip : {
		        formatter: "{b} : {c}人<br/>占总人数： {d}%"
		    },
		    color: ['#84b3fc','#1e9cfc','#71c162','#43c7f7','#24e8ef','#19b3b3','#69ba6d','#cfe03e','#fd8e26','#8962f5','#7075ff','#2f67fb','#5886ff','#718edb'],
		    legend: {
		        orient: 'vertical',
		        left: 'left',
		    },
		    series : [
		        {
		            type: 'pie',
		            radius : '55%',
		            center: ['50%', '60%'],
		            data:data_nl,
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
	if (option && typeof option === "object") {
	    myChart2.setOption(option, true);
	};
	}}));
}

//人民调解案件数量走势
function rmtj_tjajslzs(name) {
	var r = new Rep_Rmtj_Test();
	var data_name = new Array(); //数组对象
	var data_value = new Array(); //数组对象
	var data1_name = new Array(); //数组对象
	var data1_value = new Array(); //数组对象
	r.findJfTotals(name,new Eht.Responder({success:function(data){
		var totals = 0;
		for(var i = 0; i < data.length; i++){
			totals += data[i].sl;
		}
		for (var i = 0; i < data.length; i++) {
			data_name.push(data[i].name);
			data_value.push({value: data[i].sl,name:data[i].name,zb:(data[i].sl/totals * 100)});
		}
		
		
		//检索折线图
		r.findAllByMonth(name,new Eht.Responder({success:function(data){
			for (var i = 0; i < data.length; i++) {
				data1_name.push(data[i].name);
				data1_value.push({value: data[i].sl});
			}
	
	//全区调解案件趋势
	var dom = document.getElementById("anjqk-zbqk-anjqs");
	var myChart3 = echarts.init(dom);
	var app = {};
	option = null;
	option = {
	    xAxis: {
	        type: 'category',
	        axisLine:{
		        lineStyle:{
		            color:'#fff'
		        }
		    },
		    axisLabel: {
	            interval: 0
	        },
	        data:data1_name,
	    },
	    yAxis: {
	        type: 'value',
	        	axisLine:{
			        lineStyle:{
			            color:'#fff'
			        },
			    },
	    },
	    series: [{
	    	 itemStyle : { 
	    		 normal: {
	    			 label : {
	    				 show: true
	    				 }
	    		 }
	    	 },
	        data: data1_value,
	        type: 'line',
	    }]
	};
	if (option && typeof option === "object") {
	    myChart3.setOption(option, true);
	};	
	
		}}));
	
	//全区各类纠纷案件统计
	var dom = document.getElementById("anjqk-anjjf-shuj");
	var myChart4 = echarts.init(dom);
	option = null;
	option = {
	    tooltip: {
	    	 formatter: function(o){
	    		 console.log(o);
	    		 return o[0].name + ":" + o[0].value +"件 <br/> 占案件总数：" + o[0].data.zb.toFixed(2) + "%" ;
	    	 },//"'{b}:{c}: ({d}%)",
	        trigger: 'axis',
	        axisPointer: {
	            type: 'shadow',
	            axisLine:{
			        lineStyle:{
			            color:'#fff'
			        },
			    },
	        },
	    },
	    grid: {
	        left: '3%',
	        right: '4%',
	        bottom: '3%',
	        containLabel: true
	    },
	    xAxis: {
	        type: 'value',
	        axisLine:{
		        lineStyle:{
		            color:'#fff'
		        }
		    },
	        boundaryGap: [0, 0.01]
	    },
	    yAxis: {
	        type: 'category',
	        axisLine:{
		        lineStyle:{
		            color:'#fff'
		        }
		    },
            axisLabel: {
                textStyle: {
                    color: '#fff',
                }
            },
            axisTick: {
                show: false
            },
            splitLine: {
                show: true,
                lineStyle: {
                    type: "dotted",
                    color: ["rgba(255,60,104,.1)"]
                }
            },
	        data: data_name
	    },
	    series: [
	        {
	            name: '2018年',
	            type: 'bar',
	            itemStyle:{
                    normal:{
                        color:'#fd8e26'
                    },
                },
	            data: data_value
	        },
	       
	    ]
	};
	if (option && typeof option === "object") {
	    myChart4.setOption(option, true);
	};
	}}));
}

//全区2018年第一季度各类案件同比增长率
function qy_tbzzl(name) {
	var r = new Rep_Rmtj_Test();
	var data_lx_name = new Array(); //数组对象
	var data_lx_value = new Array(); //数组对象
	r.findTbzz(name,new Eht.Responder({success:function(data){
		var max=data[0].tbzz;
		for (var i = 0; i < data.length; i++) {
			data_lx_name.push(data[i].dictname);
			data_lx_value.push({value:data[i].tbzz  ,name:data[i].dictname,tb:(data[i].sl2)});
			 if(max<data[i].tbzz)
		        {
		              max=data[i].tbzz;
		        }
		}
		
	//全区2018年第一季度各类案件同比增长率
	var dom = document.getElementById("anjqk-zzl-zzlShuj");
	var myChart5 = echarts.init(dom);
	option = null;
	option = {
	    tooltip: {
	    	formatter: function(o){
	    		 return o[0].name + ":" + o[0].data.tb +"件 <br/> 同比增长：" + o[0].value + "%" ;
	    	 },
	        trigger: 'axis',
	        axisPointer: {
	            type: 'shadow',
	            axisLine:{
			        lineStyle:{
			            color:'#fff',
			            type : 'shadow'  
			        }
			    },
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
	        axisLine:{
		        lineStyle:{
		            color:'#fff'
		        },
		        max:1100
		    },
	        boundaryGap: [0, 0.01]
	        
	    },
	   
	    yAxis: {
	        type: 'category',
	        axisLine:{
		        lineStyle:{
		            color:'#fff'
		        }
		    },
		    type : 'category',
            axisTick : {show: false},
	        data:data_lx_name
	    },
	    series: [
	        {
	            name: '2018年',
	            type: 'bar',
	            itemStyle:{
                    normal:{
                        color:'#4ad2ff',//'cfe03e'
                    },
                },
	            data:data_lx_value
	        },
	       
	    ]
	};
	if (option && typeof option === "object") {
		myChart5.setOption(option, true);
	}
	}}));
}