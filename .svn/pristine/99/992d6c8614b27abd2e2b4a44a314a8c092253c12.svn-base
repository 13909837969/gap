$(function(){	
	
	var service_JZ = new RepJzryService();
	var res1 =  new Eht.Responder();
	res1.success=function(data){
		//默认当月第一天到今天新增的矫正人员
		$("#ltrhao-body-left1-div15").html(data.newin);
		//默认查询出所有矫正人员
		$("#ltrhao-body-left1-div11").html(data.total);
		//默认查询出今天为结束矫正日期的所有矫正人员
		$("#ltrhao-body-left1-div16").html(data.jcjzry);
	};
	var query1 = {};
	//获取查询条件开始日期
	var now = new Date();
	query1.ksrq = getCurrentMonthFirst();
	query1.jsrq = now.format("yyyy-MM-dd");
	function getCurrentMonthFirst(){
		 var date=new Date();
		 date.setDate(1);
		 return date.format("yyyy-MM-dd");
	}
	//将当月的第一天和当前日期显示在页面
	$("#quy-inputd").val(query1.ksrq);
	$("#quy-inputda").val(query1.jsrq);
	//默认状态新增矫正人员数量按当月第一天开始
	service_JZ.findCount(query1,res1);
	
	
	
	//柱状图js	
	var dom = document.getElementById("containerzhu");
	var myChart = echarts.init(dom);
	var app = {};
	option = null;
	option = {

	    tooltip : {
	        trigger: 'axis'
	    },

	    toolbox: {
	        show : true,
	    },
	    calculable : true,
	    xAxis : [
	        {
	            type : 'category',
	            data : ['19岁以下','20~29岁','30~39岁','40~49岁','50岁及以上']
	        }
	    ],
	    yAxis : [
	        {
	            type : 'value'
	        }
	    ],
	    series : [
	        {
	            name:'女性',
	            type:'bar',
	            data:[50, 80, 100,120,190],
	            markPoint : {
	                data : [
	                    {type : 'max', name: '最大值'},
	                    {type : 'min', name: '最小值'}
	                ]
	            },
	        },
	        {
	            name:'男性',
	            type:'bar',
	            data:[90, 110,140,170, 130],
	        }
	    ]
	};
	;
	if (option && typeof option === "object") {
	    myChart.setOption(option, true);
	}	
//文化程度js
	var dom = document.getElementById("containerquan");
	var myChart = echarts.init(dom);
	var app = {};
	option = null;
	app.title = '环形图';

	option = {
	    tooltip: {
	        trigger: 'item',
	        formatter: "{a} <br/>{b}: {c} ({d}%)"
	    },
	    series: [
	        {
	            name:'文化程度',
	            type:'pie',
	            radius: ['50%', '70%'],
	            avoidLabelOverlap: false,
	            label: {
	                normal: {
	                    show: false,
	                    position: 'center'
	                },
	                emphasis: {
	                    show: true,
	                    textStyle: {
	                        fontSize: '30',
	                        fontWeight: 'bold'
	                    }
	                }
	            },
	            labelLine: {
	                normal: {
	                    show: false
	                }
	            },
	            data:[
	                {value:120, name:'文盲'},
	                {value:135, name:'小学'},
	                {value:111, name:'初中'},
	                {value:123, name:'高中'},
	                {value:90, name:'大专'},
	                {value:135, name:'本科'},
	                {value:111,name:'硕士'}
	            ]
	        }
	    ]
	};
	;
	if (option && typeof option === "object") {
	    myChart.setOption(option, true);
	}
//性别分布js
	var dom = document.getElementById("containerbing");
	var myChart = echarts.init(dom);
	var app = {};
	option = null;
	option = {
	    title : {
	        x:'center'
	    },
	    tooltip : {
	        trigger: 'item',
	        formatter: "{a} <br/>{b} : {c} ({d}%)"
	    },
	    series : [
	        {
	            name: '性别分布',
	            type: 'pie',
	            radius : '55%',
	            center: ['50%', '60%'],
	            data:[
	                {value:335, name:'女性'},
	                {value:310, name:'男性'}
	            ],
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
	;
	if (option && typeof option === "object") {
	    myChart.setOption(option, true);
	};
//人员分布js
	var dom = document.getElementById("containerdz");
	var myChart = echarts.init(dom);
	var app = {};
	option = null;
	app.title = '气泡图';

	var data = [
	    [[28604,77,17096869,'Australia',1990],[31163,77.4,27662440,'Canada',1990],[1516,68,1154605773,'China',1990],[13670,74.7,10582082,'Cuba',1990],[28599,75,4986705,'Finland',1990],[29476,77.1,56943299,'France',1990],[31476,75.4,78958237,'Germany',1990],[28666,78.1,254830,'Iceland',1990],[1777,57.7,870601776,'India',1990],[29550,79.1,122249285,'Japan',1990],[2076,67.9,20194354,'North Korea',1990],[12087,72,42972254,'South Korea',1990],[24021,75.4,3397534,'New Zealand',1990],[43296,76.8,4240375,'Norway',1990],[10088,70.8,38195258,'Poland',1990],[19349,69.6,147568552,'Russia',1990],[10670,67.3,53994605,'Turkey',1990],[26424,75.7,57110117,'United Kingdom',1990],[37062,75.4,252847810,'United States',1990]],
	    [[44056,81.8,23968973,'Australia',2015],[43294,81.7,35939927,'Canada',2015],[13334,76.9,1376048943,'China',2015],[21291,78.5,11389562,'Cuba',2015],[38923,80.8,5503457,'Finland',2015],[37599,81.9,64395345,'France',2015],[44053,81.1,80688545,'Germany',2015],[42182,82.8,329425,'Iceland',2015],[5903,66.8,1311050527,'India',2015],[36162,83.5,126573481,'Japan',2015],[1390,71.4,25155317,'North Korea',2015],[34644,80.7,50293439,'South Korea',2015],[34186,80.6,4528526,'New Zealand',2015],[64304,81.6,5210967,'Norway',2015],[24787,77.3,38611794,'Poland',2015],[23038,73.13,143456918,'Russia',2015],[19360,76.5,78665830,'Turkey',2015],[38225,81.4,64715810,'United Kingdom',2015],[53354,79.1,321773631,'United States',2015]]
	];

	option = {
	    backgroundColor: new echarts.graphic.RadialGradient(0.3, 0.3, 0.8, [{
	        offset: 0,
	        color: '#f7f8fa'
	    }, {
	        offset: 1,
	        color: '#cdd0d5'
	    }]),
	    legend: {
	        right: 10,
	        data: ['1990', '2015']
	    },
	    xAxis: {
	        splitLine: {
	            lineStyle: {
	                type: 'dashed'
	            }
	        }
	    },
	    yAxis: {
	        splitLine: {
	            lineStyle: {
	                type: 'dashed'
	            }
	        },
	        scale: true
	    },
	    series: [{
	        name: '1990',
	        data: data[0],
	        type: 'scatter',
	        symbolSize: function (data) {
	            return Math.sqrt(data[2]) / 5e2;
	        },
	        label: {
	            emphasis: {
	                show: true,
	                formatter: function (param) {
	                    return param.data[3];
	                },
	                position: 'top'
	            }
	        },
	        itemStyle: {
	            normal: {
	                shadowBlur: 10,
	                shadowColor: 'rgba(120, 36, 50, 0.5)',
	                shadowOffsetY: 5,
	                color: new echarts.graphic.RadialGradient(0.4, 0.3, 1, [{
	                    offset: 0,
	                    color: 'rgb(251, 118, 123)'
	                }, {
	                    offset: 1,
	                    color: 'rgb(204, 46, 72)'
	                }])
	            }
	        }
	    }, {
	        name: '2015',
	        data: data[1],
	        type: 'scatter',
	        symbolSize: function (data) {
	            return Math.sqrt(data[2]) / 5e2;
	        },
	        label: {
	            emphasis: {
	                show: true,
	                formatter: function (param) {
	                    return param.data[3];
	                },
	                position: 'top'
	            }
	        },
	        itemStyle: {
	            normal: {
	                shadowBlur: 10,
	                shadowColor: 'rgba(25, 100, 150, 0.5)',
	                shadowOffsetY: 5,
	                color: new echarts.graphic.RadialGradient(0.4, 0.3, 1, [{
	                    offset: 0,
	                    color: 'rgb(129, 227, 238)'
	                }, {
	                    offset: 1,
	                    color: 'rgb(25, 183, 207)'
	                }])
	            }
	        }
	    }]
	};
	if (option && typeof option === "object") {
	    myChart.setOption(option, true);
	};	
	
	
	
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
				var child = $('<ul style="margin-top:10px;"></ul>');
				for(var j=0;j<data[0].nodes[i].nodes.length;j++){
					var li = $('<li><input type="checkbox" style="margin-left:10px; margin-right:3px;">'+data[0].nodes[i].nodes[j].region_name+'</li>');
					child.append(li);
					li.addClass("hidden-div-li");
				}
				root.append(child);
			}
		}
	}));
	
	
	/*$('#spssjfx-hidenDiv').hide();
	var service = new RegionService();
	service.find({},new Eht.Responder({
		success:function(data){
			for(var i=0;i<data[0].nodes.length;i++){
				var city = $('<ul></ul>');
				var root = $('<li><div><input type="checkbox" style="margin-left:10px; margin-right:3px;"><span>'+data[0].nodes[i].region_name+'</span></div></li>')
				city.append(root);
				$('#spsSqjz-hidenDivSS').append(city);
				city.addClass("hidden-div-ul");
				var child = $('<ul style="margin-top:10px;"></ul>');
				for(var j=0;j<data[0].nodes[i].nodes.length;j++){
					var li = $('<li><input type="checkbox" style="margin-left:10px; margin-right:3px;">'+data[0].nodes[i].nodes[j].region_name+'</li>');
					child.append(li);
					li.addClass("hidden-div-li");
				}
				root.append(child);
			}
		}
	}));*/
	//显示隐藏的区域选择
	$("#quy-inputa-clickone").click(function(){
			$("#spssjfx-hidenDiv").css("height","0").show().animate({height:400});
		return false;
	});
	//点击其他地方区域隐藏
	$(window).click(function(){
		$("#spssjfx-hidenDiv").animate({height:0},function(){$(this).hide()});
	});
	
	$("#spssjfx-hidenDiv").click(function(){return false;});
	
	//点击确定按钮的时候关闭区域并且提交选择的数据
	$("#spsSqjz-hidenDiv-qd").click(function(){
		$("#spssjfx-hidenDiv").animate({height:0},function(){$(this).hide()});
	});
	//关闭按钮
	$("#spsSqjz-hidenDivBtn").click(function(){
		$("#spssjfx-hidenDiv").animate({height:0},function(){$(this).hide()});
	});
	
	
	
	
	$("#quy-inputd").unbind("click").bind("click",function(){
		//日历
		$(".form_datetime").datetimepicker({
		       format: "yyyy-mm-dd",
		       language:  'zh-CN',
		       autoclose: true,
		       todayBtn: true,
		       minView: 2,
		       pickerPosition: "bottom-right"
		   });
	});
	$("#quy-inputda").unbind("click").bind("click",function(){
		//日历
		$(".form_datetime").datetimepicker({
		       format: "yyyy-mm-dd",
		       language:  'zh-CN',
		       autoclose: true,
		       todayBtn: true,
		       minView: 2,
		       pickerPosition: "bottom-right"
		   });
	});	
});