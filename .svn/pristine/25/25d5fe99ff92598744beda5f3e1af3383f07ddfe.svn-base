$(function(){
	//默认隐藏的区域选择
	//区域选择div
	$('#spsflyz-hidenDiv').hide();
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
	//显示隐藏的区域选择
	$("#flyz_sy_input_qyss").click(function(){
			$("#spsflyz-hidenDiv").css("height","0").show().animate({height:400});
		return false;
	});
	//点击其他地方区域隐藏
	$(window).click(function(){
		$("#spsflyz-hidenDiv").animate({height:0},function(){$(this).hide()});
	});
	
	$("#spsflyz-hidenDiv").click(function(){return false;});
	
	//点击确定按钮的时候关闭区域并且提交选择的数据
	$("#spsSqjz-hidenDiv-qd").click(function(){
		$("#spsflyz-hidenDiv").animate({height:0},function(){$(this).hide()});
	});
	//关闭按钮
	$("#spsSqjz-hidenDivBtn").click(function(){
		$("#spsflyz-hidenDiv").animate({height:0},function(){$(this).hide()});
	});
	
	
	$("#flyz_sy_input_kssj").unbind("click").bind("click",function(){
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
	
	$("#flyz_sy_input_jssj").unbind("click").bind("click",function(){
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
	
	
	
	//法律援助案件批准情况
	var dom = document.getElementById("flyz_fytb");
	var myChart = echarts.init(dom);
	var app = {};
	option = null;
	option = {
	    title : {
	    	left: 'center',
	        textStyle: {
	            color: '#fff',
	        },
	    },
	    grid:{
            x:70,
            y:30,
            x2:30,
            y2:30,
        },
        backgroundColor: '#333',
	    legend: {
	        data:['2016年','2017年'],
	        textStyle:{color: '#fff'}
	    
	    },
	    position: 'absolute',
	    top: 0,
	    bottom: 0,
	    tooltip : {
	        trigger: 'axis',
	    },
	    toolbox: {
	        show : true,
	        textStyle:{color: '#fff'},
	        feature : {
	            dataView : {show: true, readOnly: false},
	            magicType : {show: true, type: ['line', 'bar']},
	            restore : {show: true},
	            saveAsImage : {show: true}
	        }
	    },
	    calculable : true,
	    xAxis : [
	        {
	            type : 'category',
	            axisLabel: {
                    show: true,
                    textStyle: {
                        color: '#fff'
                    },
			        //interval: 0,
			        //rotate: 15  
                },
                axisLine: {
                    lineStyle: {
                        color: '#fff'
                    }
                },
	            data : ['内蒙古自治区','呼和浩特市','包头市','乌海市','通辽市','赤峰市','乌兰察布市','鄂尔多斯市','巴彦淖尔市','呼伦贝尔市','锡林郭勒盟','阿拉善盟','兴安盟']
	        }
	    ],
	    yAxis : [
	        {
	            type : 'value',
	            name: '件数',
	            min: 0,
	            axisLabel: {
                    show: true,
                    textStyle: {
                        color: '#fff'
                    },
                    formatter: '{value} 件'
                },
                axisLine: {
                    lineStyle: {
                        color: '#fff'
                    }
                },
	        }
	    ],
	    series : [
	        {
	            name:'2016年',
	            type:'bar',
	            data:[1000,100, 100, 500, 400, 200, 200, 200, 200, 200, 200, 200, 200],
	            itemStyle:{
                    normal:{
                        color:'#0d9bff'
                    }
                },
	        },
	        {
	            name:'2017年',
	            type:'bar',
	            data:[1000,300, 300, 300, 300, 300, 300, 300, 300, 300, 300, 300, 500],
	            itemStyle:{
                    normal:{
                        color:'#f5ce0c'
                    }
                },
	        }
	    ]
	};
	if (option && typeof option === "object") {
	    myChart.setOption(option, true);
	}
	//挽回损失或 取得利益总数
	var dom = document.getElementById("flyz_whssqdly");
	var myChart = echarts.init(dom);
	var app = {};
	option = null;
	option = {
	    title : {
	    	left: 'center',
	        textStyle: {
	            color: '#fff',
	        },
	    },
	    grid:{
            x:70,
            y:45,
            x2:30,
            y2:30,
        },
        backgroundColor: '#333',
	    tooltip : {
	        trigger: 'axis'
	    },
	    legend: {
	        data:['2016年','2017年'],
	        textStyle:{color: '#fff'}
	    
	    },
	    position: 'absolute',
	    top: 0,
	    bottom: 0,
	    toolbox: {
	        show : true,
	        feature : {
	            dataView : {show: true, readOnly: false},
	            magicType : {show: true, type: ['line', 'bar']},
	            restore : {show: true},
	            saveAsImage : {show: true}
	        }
	    },
	    calculable : true,
	    xAxis : [
	        {
	            type : 'category',
	            axisLabel: {
                    show: true,
                    textStyle: {
                        color: '#fff'
                    }
                },
                axisLine: {
                    lineStyle: {
                        color: '#fff'
                    }
                },
	            data : ['内蒙古自治区','呼和浩特市','包头市','乌海市','通辽市','赤峰市','乌兰察布市','鄂尔多斯市','巴彦淖尔市','呼伦贝尔市','锡林郭勒盟','阿拉善盟','兴安盟']
	        }
	    ],
	    yAxis : [
	        {
	            type : 'value',
	            name: '件数',
	            min: 0,
	            axisLabel: {
                    show: true,
                    textStyle: {
                        color: '#fff'
                    },
                    formatter: '{value} 件'
                },
                axisLine: {
                    lineStyle: {
                        color: '#fff'
                    }
                },
	        }
	    ],
	    series : [
	        {
	            name:'2016年',
	            type:'bar',
	            data:[1000,100, 100, 500, 400, 200, 200, 200, 200, 200, 200, 200, 200],
	            itemStyle:{
                    normal:{
                        color:'#0d9bff'
                    }
                },
	        },
	        {
	            name:'2017年',
	            type:'bar',
	            data:[1000,300, 300, 300, 300, 300, 300, 300, 300, 300, 300, 300, 500],
	            itemStyle:{
                    normal:{
                        color:'#f5ce0c'
                    }
                },
	        }
	    ]
	};
	if (option && typeof option === "object") {
	    myChart.setOption(option, true);
	};
	//各类人群案件
	var dom = document.getElementById("flyz_msflyz_tb");
	var myChart = echarts.init(dom);
	var app = {};
	option = null;
	option = {
	    title : {
	    	left: 'center',
	        textStyle: {
	            color: '#fff',
	        },
	    },
	    grid:{
            x:70,
            y:45,
            x2:30,
            y2:30,
        },
        backgroundColor: '#333',
	    tooltip : {
	        trigger: 'axis'
	    },
	    legend: {
	        data:['2016年','2017年'],
	        textStyle:{color: '#fff'}
	    
	    },
	    position: 'absolute',
	    top: 0,
	    bottom: 0,
	    toolbox: {
	        show : true,
	        feature : {
	            dataView : {show: true, readOnly: false},
	            magicType : {show: true, type: ['line', 'bar']},
	            restore : {show: true},
	            saveAsImage : {show: true}
	        }
	    },
	    calculable : true,
	    xAxis : [
	        {
	            type : 'category',
	            axisLabel: {
                    show: true,
                    textStyle: {
                        color: '#fff'
                    }
                },
                axisLine: {
                    lineStyle: {
                        color: '#fff'
                    }
                },
	            data : ['妇女','农牧民','农牧民工','少数民族','军人军属','残疾人','外国籍人或无国籍人','老年人','未成年人']
	        }
	    ],
	    yAxis : [
	        {
	            type : 'value',
	            name: '人数',
	            min: 0,
	            axisLabel: {
                    show: true,
                    textStyle: {
                        color: '#fff'
                    },
                    formatter: '{value} 人'
                },
                axisLine: {
                    lineStyle: {
                        color: '#fff'
                    }
                },
	        }
	    ],
	    series : [
	        {
	            name:'2016年',
	            type:'bar',
	            data:[1000,100, 100, 500, 400, 200, 200, 200, 200],
	            itemStyle:{
                    normal:{
                        color:'#0d9bff'
                    }
                },
	        },
	        {
	            name:'2017年',
	            type:'bar',
	            data:[1000,300, 300, 300, 300, 300, 300, 300, 300],
	            itemStyle:{
                    normal:{
                        color:'#f5ce0c'
                    }
                },
	        }
	    ]
	};
	if (option && typeof option === "object") {
	    myChart.setOption(option, true);
	};
	//来电咨询
	var dom = document.getElementById("flyz_zxfs_tb");
	var myCharta = echarts.init(dom);
	var app = {};
	option = null;
	var weatherIcons = {
	    'Sunny': './data/asset/img/weather/sunny_128.png',
	    'Cloudy': './data/asset/img/weather/cloudy_128.png',
	    'Showers': './data/asset/img/weather/showers_128.png'
	};

	option = {
	    title: {
	        text: '咨询方式分类',
	        left: 'center'
	    },
	    tooltip : {
	        trigger: 'item',
	        formatter: "{a} <br/>{b} : {c} ({d}%)"
	    },
	    legend: {
	        orient: 'vertical',
	        left: 'left',
	        textStyle:{
	        	color:'#fff'
	        },
	        data: ['来访','来信','来电','网络']
	    },
	    series : [
	        {
	            type: 'pie',
	            radius : '65%',
	            center: ['50%', '50%'],
	            selectedMode: 'single',
	            data:[
	                {value:55193, name: '来访'},
	                {value:15243, name: '来信'},
	                {value:64614, name: '来电'},
	                {value:8888, name: '网络'}
	            ]
	        }
	    ],
	    color:['#f5ce0c','#a817ec','#0d9bff','#1ce960']
	    
	};
	;
	if (option && typeof option === "object") {
	    myCharta.setOption(option, true);
	};
	
	/*已结案件人员*/ 
	var dom = document.getElementById("flyz_zxlx_tb");
	var myChart = echarts.init(dom);
	var app = {};
	option = null;
	app.title = '堆叠条形图';

	option = {
		backgroundColor:'#333',
	    tooltip : {
	        trigger: 'axis',
	        axisPointer : {            // 坐标轴指示器，坐标轴触发有效
	            type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
	        }
	    },
	    legend: {
	    	textStyle:{color: '#fff'}
	    	/*data:['法律援助机构人员办案数','社会律师办案数','基层法律服务工作者办案数','社会组织人员办案数','注册法律援助志愿者办案数']*/
	    },
	    grid: {
	        left: '5%',
	        right: '5%',
	        bottom: '5%',
	        containLabel: true
	    },
	    xAxis:  {
	        type: 'value',
	        	axisLabel: {
	                show: true,
	                textStyle: {
	                    color: '#fff'
	                },
	                formatter: '{value} 件'
	            },
	            axisLine: {
	                lineStyle: {
	                    color: '#fff'
	                }
	            },
	    },
	    yAxis: {
	        type: 'category',
	        axisLabel: {
                show: true,
                textStyle: {
                    color: '#fff'
                }
            },
            axisLine: {
                lineStyle: {
                    color: '#fff'
                }
            },
	        data: ['内蒙古自治区','呼和浩特市','包头市','赤峰市','乌兰察布市','乌海市','鄂尔多斯市','巴彦淖尔市','通辽市','呼伦贝尔市','兴安盟','锡林郭勒盟','阿拉善盟']
	    },
	    series: [
	        {
	            name: '法律援助机构人员办案数',
	            type: 'bar',
	            stack: '总量',
	            label: {
	                normal: {
	                    show: true,
	                    position: 'insideRight'
	                }
	            },
	            data: [320, 332, 301, 334, 390, 330, 320, 301, 334, 390, 330, 320, 320],
	            itemStyle:{
                    normal:{
                        color:'#0d9bff'
                    }
                }
	        },
	        {
	            name: '社会律师办案数',
	            type: 'bar',
	            stack: '总量',
	            label: {
	                normal: {
	                    show: true,
	                    position: 'insideRight'
	                }
	            },
	            data: [320, 332, 301, 334, 390, 330, 320, 301, 334, 390, 330, 320, 320],
	            itemStyle:{
                    normal:{
                        color:'#a817ec'
                    }
                }
	        },
	        {
	            name: '基层法律服务工作者办案数',
	            type: 'bar',
	            stack: '总量',
	            label: {
	                normal: {
	                    show: true,
	                    position: 'insideRight'
	                }
	            },
	            data: [320, 332, 301, 334, 390, 330, 320, 301, 334, 390, 330, 320, 320],
	            itemStyle:{
                    normal:{
                        color:'#0d9bff'
                    }
                }
	        },
	        {
	            name: '社会组织人员办案数',
	            type: 'bar',
	            stack: '总量',
	            label: {
	                normal: {
	                    show: true,
	                    position: 'insideRight'
	                }
	            },
	            data: [320, 332, 301, 334, 390, 330, 320, 301, 334, 390, 330, 320, 320],
	            itemStyle:{
                    normal:{
                        color:'#1ce960'
                    }
                }
	        },
	        {
	            name: '注册法律援助志愿者办案数',
	            type: 'bar',
	            stack: '总量',
	            label: {
	                normal: {
	                    show: true,
	                    position: 'insideRight'
	                }
	            },
	            data: [320, 332, 301, 334, 390, 330, 320, 301, 334, 390, 330, 320, 320],
	            itemStyle:{
                    normal:{
                        color:'#f5ce0c'
                    }
                }
	        }
	    ]
	};
	if (option && typeof option === "object") {
	    myChart.setOption(option, true);
	};
	
	
	
	
	//刑事法律援助案件总数
	var dom = document.getElementById("flyz_xsfy_tb_bar");
	var myChart = echarts.init(dom);
	var app = {};
	option = null;
	option = {
	    title : {
	    	left: 'center',
	        textStyle: {
	            color: '#fff',
	        },
	    },
	    grid:{
            x:70,
            y:45,
            x2:30,
            y2:30,
        },
        backgroundColor: '#333',
	    tooltip : {
	        trigger: 'axis'
	    },
	    legend: {
	        data:['2016年','2017年'],
	        textStyle:{color: '#fff'}
	    
	    },
	    position: 'absolute',
	    top: 0,
	    bottom: 0,
	    toolbox: {
	        show : true,
	        feature : {
	            dataView : {show: true, readOnly: false},
	            magicType : {show: true, type: ['line', 'bar']},
	            restore : {show: true},
	            saveAsImage : {show: true}
	        }
	    },
	    calculable : true,
	    xAxis : [
	        {
	            type : 'category',
	            axisLabel: {
                    show: true,
                    textStyle: {
                        color: '#fff'
                    }
                },
                axisLine: {
                    lineStyle: {
                        color: '#fff'
                    }
                },
	            data : ['内蒙古自治区','呼和浩特市','包头市','乌海市','通辽市','赤峰市','乌兰察布市','鄂尔多斯市','巴彦淖尔市','呼伦贝尔市','锡林郭勒盟','阿拉善盟','兴安盟']
	        }
	    ],
	    yAxis : [
	        {
	            type : 'value',
	            name: '件数',
	            min: 0,
	            axisLabel: {
                    show: true,
                    textStyle: {
                        color: '#fff'
                    },
                    formatter: '{value} 件'
                },
                axisLine: {
                    lineStyle: {
                        color: '#fff'
                    }
                },
	        }
	    ],
	    series : [
	        {
	            name:'2016年',
	            type:'bar',
	            data:[1000,100, 100, 500, 400, 200, 200, 200, 200, 200, 200, 200, 200],
	            itemStyle:{
                    normal:{
                        color:'#0d9bff'
                    }
                },
	        },
	        {
	            name:'2017年',
	            type:'bar',
	            data:[1000,300, 300, 300, 300, 300, 300, 300, 300, 300, 300, 300, 500],
	            itemStyle:{
                    normal:{
                        color:'#f5ce0c'
                    }
                },
	        }
	    ]
	};
	if (option && typeof option === "object") {
	    myChart.setOption(option, true);
	};
	//咨询总数
	var dom = document.getElementById("flyz_zxzs_tb_bar");
	var myChart = echarts.init(dom);
	var app = {};
	option = null;
	option = {
	    title : {
	    	left: 'center',
	        textStyle: {
	            color: '#fff',
	        },
	    },
	    grid:{
            x:70,
            y:45,
            x2:30,
            y2:30,
        },
        backgroundColor: '#333',
	    tooltip : {
	        trigger: 'axis'
	    },
	    legend: {
	        data:['2016年','2017年'],
	        textStyle:{color: '#fff'}
	    
	    },
	    position: 'absolute',
	    top: 0,
	    bottom: 0,
	    toolbox: {
	        show : true,
	        feature : {
	            dataView : {show: true, readOnly: false},
	            magicType : {show: true, type: ['line', 'bar']},
	            restore : {show: true},
	            saveAsImage : {show: true}
	        }
	    },
	    calculable : true,
	    xAxis : [
	        {
	            type : 'category',
	            axisLabel: {
                    show: true,
                    textStyle: {
                        color: '#fff'
                    }
                },
                axisLine: {
                    lineStyle: {
                        color: '#fff'
                    }
                },
	            data : ['内蒙古自治区','呼和浩特市','包头市','乌海市','通辽市','赤峰市','乌兰察布市','鄂尔多斯市','巴彦淖尔市','呼伦贝尔市','锡林郭勒盟','阿拉善盟','兴安盟']
	        }
	    ],
	    yAxis : [
	        {
	            type : 'value',
	            name: '件数',
	            min: 0,
	            axisLabel: {
                    show: true,
                    textStyle: {
                        color: '#fff'
                    },
                    formatter: '{value} 件'
                },
                axisLine: {
                    lineStyle: {
                        color: '#fff'
                    }
                },
	        }
	    ],
	    series : [
	        {
	            name:'2016年',
	            type:'bar',
	            data:[1000,100, 100, 500, 400, 200, 200, 200, 200, 200, 200, 200, 200],
	            itemStyle:{
                    normal:{
                        color:'#0d9bff'
                    }
                },
	        },
	        {
	            name:'2017年',
	            type:'bar',
	            data:[1000,300, 300, 300, 300, 300, 300, 300, 300, 300, 300, 300, 500],
	            itemStyle:{
                    normal:{
                        color:'#f5ce0c'
                    }
                },
	        }
	    ]
	};
	if (option && typeof option === "object") {
	    myChart.setOption(option, true);
	};
	
	
	//行政法律援助案件总数
	var dom = document.getElementById("flyz_xzfy_tb_bar");
	var myChart = echarts.init(dom);
	var app = {};
	option = null;
	option = {
	    title : {
	    	left: 'center',
	        textStyle: {
	            color: '#fff',
	        },
	    },
	    grid:{
            x:70,
            y:45,
            x2:30,
            y2:30,
        },
        backgroundColor: '#333',
	    tooltip : {
	        trigger: 'axis'
	    },
	    legend: {
	        data:['2016年','2017年'],
	        textStyle:{color: '#fff'}
	    
	    },
	    position: 'absolute',
	    top: 0,
	    bottom: 0,
	    toolbox: {
	        show : true,
	        feature : {
	            dataView : {show: true, readOnly: false},
	            magicType : {show: true, type: ['line', 'bar']},
	            restore : {show: true},
	            saveAsImage : {show: true}
	        }
	    },
	    calculable : true,
	    xAxis : [
	        {
	            type : 'category',
	            axisLabel: {
                    show: true,
                    textStyle: {
                        color: '#fff'
                    }
                },
                axisLine: {
                    lineStyle: {
                        color: '#fff'
                    }
                },
	            data : ['内蒙古自治区','呼和浩特市','包头市','乌海市','通辽市','赤峰市','乌兰察布市','鄂尔多斯市','巴彦淖尔市','呼伦贝尔市','锡林郭勒盟','阿拉善盟','兴安盟']
	        }
	    ],
	    yAxis : [
	        {
	            type : 'value',
	            name: '件数',
	            min: 0,
	            axisLabel: {
                    show: true,
                    textStyle: {
                        color: '#fff'
                    },
                    formatter: '{value} 件'
                },
                axisLine: {
                    lineStyle: {
                        color: '#fff'
                    }
                },
	        }
	    ],
	    series : [
	        {
	            name:'2016年',
	            type:'bar',
	            data:[1000,100, 100, 500, 400, 200, 200, 200, 200, 200, 200, 200, 200],
	            itemStyle:{
                    normal:{
                        color:'#0d9bff'
                    }
                },
	        },
	        {
	            name:'2017年',
	            type:'bar',
	            data:[1000,300, 300, 300, 300, 300, 300, 300, 300, 300, 300, 300, 500],
	            itemStyle:{
                    normal:{
                        color:'#f5ce0c'
                    }
                },
	        }
	    ]
	};
	if (option && typeof option === "object") {
	    myChart.setOption(option, true);
	};
	//民事法律援助
	var dom = document.getElementById("flyz_yjaj_tb_bar");
	var myChart = echarts.init(dom);
	var app = {};
	option = null;
	option = {
	    title : {
	    	left: 'center',
	        textStyle: {
	            color: '#fff',
	        },
	    },
	    grid:{
            x:70,
            y:45,
            x2:30,
            y2:30,
        },
        backgroundColor: '#333',
	    tooltip : {
	        trigger: 'axis'
	    },
	    legend: {
	        data:['2016年','2017年'],
	        textStyle:{color: '#fff'}
	    
	    },
	    position: 'absolute',
	    top: 0,
	    bottom: 0,
	    toolbox: {
	        show : true,
	        feature : {
	            dataView : {show: true, readOnly: false},
	            magicType : {show: true, type: ['line', 'bar']},
	            restore : {show: true},
	            saveAsImage : {show: true}
	        }
	    },
	    calculable : true,
	    xAxis : [
	        {
	            type : 'category',
	            axisLabel: {
                    show: true,
                    textStyle: {
                        color: '#fff'
                    }
                },
                axisLine: {
                    lineStyle: {
                        color: '#fff'
                    }
                },
	            data : ['内蒙古自治区','呼和浩特市','包头市','乌海市','通辽市','赤峰市','乌兰察布市','鄂尔多斯市','巴彦淖尔市','呼伦贝尔市','锡林郭勒盟','阿拉善盟','兴安盟']
	        }
	    ],
	    yAxis : [
	        {
	            type : 'value',
	            name: '件数',
	            min: 0,
	            axisLabel: {
                    show: true,
                    textStyle: {
                        color: '#fff'
                    },
                    formatter: '{value} 件'
                },
                axisLine: {
                    lineStyle: {
                        color: '#fff'
                    }
                },
	        }
	    ],
	    series : [
	        {
	            name:'2016年',
	            type:'bar',
	            data:[1000,100, 100, 500, 400, 200, 200, 200, 200, 200, 200, 200, 200],
	            itemStyle:{
                    normal:{
                        color:'#0d9bff'
                    }
                },
	        },
	        {
	            name:'2017年',
	            type:'bar',
	            data:[1000,300, 300, 300, 300, 300, 300, 300, 300, 300, 300, 300, 500],
	            itemStyle:{
                    normal:{
                        color:'#f5ce0c'
                    }
                },
	        }
	    ]
	};
	if (option && typeof option === "object") {
	    myChart.setOption(option, true);
	};
	//已结案件批准情况
	var dom = document.getElementById("flyz_yjzjpz_tb_bar");
	var myChart = echarts.init(dom);
	var app = {};
	option = null;
	option = {
	    title : {
	    	left: 'center',
	        textStyle: {
	            color: '#fff',
	        },
	    },
	    grid:{
            x:70,
            y:45,
            x2:30,
            y2:30,
        },
        backgroundColor: '#333',
	    tooltip : {
	        trigger: 'axis'
	    },
	    legend: {
	        data:['2016年','2017年'],
	        textStyle:{color: '#fff'}
	    
	    },
	    position: 'absolute',
	    top: 0,
	    bottom: 0,
	    toolbox: {
	        show : true,
	        feature : {
	            dataView : {show: true, readOnly: false},
	            magicType : {show: true, type: ['line', 'bar']},
	            restore : {show: true},
	            saveAsImage : {show: true}
	        }
	    },
	    calculable : true,
	    xAxis : [
	        {
	            type : 'category',
	            axisLabel: {
                    show: true,
                    textStyle: {
                        color: '#fff'
                    }
                },
                axisLine: {
                    lineStyle: {
                        color: '#fff'
                    }
                },
	            data : ['内蒙古自治区','呼和浩特市','包头市','乌海市','通辽市','赤峰市','乌兰察布市','鄂尔多斯市','巴彦淖尔市','呼伦贝尔市','锡林郭勒盟','阿拉善盟','兴安盟']
	        }
	    ],
	    yAxis : [
	        {
	            type : 'value',
	            name: '件数',
	            min: 0,
	            axisLabel: {
                    show: true,
                    textStyle: {
                        color: '#fff'
                    },
                    formatter: '{value} 件'
                },
                axisLine: {
                    lineStyle: {
                        color: '#fff'
                    }
                },
	        }
	    ],
	    series : [
	        {
	            name:'2016年',
	            type:'bar',
	            data:[1000,100, 100, 500, 400, 200, 200, 200, 200, 200, 200, 200, 200],
	            itemStyle:{
                    normal:{
                        color:'#0d9bff'
                    }
                },
	        },
	        {
	            name:'2017年',
	            type:'bar',
	            data:[1000,300, 300, 300, 300, 300, 300, 300, 300, 300, 300, 300, 500],
	            itemStyle:{
                    normal:{
                        color:'#f5ce0c'
                    }
                },
	        }
	    ]
	};
	if (option && typeof option === "object") {
	    myChart.setOption(option, true);
	};
	
	
	
});