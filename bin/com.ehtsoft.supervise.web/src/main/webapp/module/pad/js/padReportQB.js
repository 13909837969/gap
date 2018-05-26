$(function(){
	var pad = new PadZhtjService();
	//人民调解
	var data_lx_name = new Array(); //数组对象
	var data_lx_value = new Array(); //数组对象
	var data_nl = new Array(); //数组对象 
	pad.findRmtj(new Eht.Responder({success:function(datas){
		for (var i = 0; i < datas.list_lb.length; i++) {
			data_lx_name.push(datas.list_lb[i].name);
			data_lx_value.push({value: datas.list_lb[i].value});
		}
		for (var i = 0; i < datas.list_jg.length; i++) {
			data_nl.push(
					{
					name: datas.list_jg[i].name,
	                value: datas.list_jg[i].value
	                } 
					);
		}
		var dom = document.getElementById("rmtj_day");
		var myChart = echarts.init(dom);
		var app = {};
		option = null;
		var waterMarkText = 'ECHARTS';
		var canvas = document.createElement('canvas');
		var ctx = canvas.getContext('2d');
		option = {
		    color: ['#00a65a'],
		    tooltip : {
		        trigger: 'axis',
		        axisPointer : {            // 坐标轴指示器，坐标轴触发有效
		            type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
		        }
		    },
		    grid: {
		        left: '3%',
		        right: '4%',
		        bottom: '3%',
				top: '20%',
		        containLabel: true
		    },
		    xAxis: [{
	        type: 'value',
	        max: builderJson.all,
	        splitLine: {
	            show: false
	        }
	    }],
	    	yAxis: [{
	        type: 'category',
	        data: data_lx_name,
	        splitLine: {
	            show: false
	        }
	    }],
		    series: [{
	        type: 'bar',
	        stack: 'chart',
	        z: 1,
	        /*label: {
	            normal: {
	                position: 'right',
	                show: true
	            }
	        },*/
	        data:data_lx_value
	    }, 
	    {
	        type: 'pie',
	        name:'成功率',
		    barWidth: '60%',
			radius : '30%',
	        center: ['75%', '20%'],
	        data: data_nl
	    }]
		};
		
		if (option && typeof option === "object") {
		    myChart.setOption(option, true);
		}
		
	}}));
	//人民调解2
	var dom = document.getElementById("flyz_month");
	var myChart = echarts.init(dom);
	var app = {};
	option = null;
	app.title = '水印 - ECharts 下载统计'

	var builderJson = {
	  "all": 10887,
	  "charts": {
	    "婚姻纠纷": 3237,
	    "邻里纠纷": 2164,
	    "": 7561,
	    "": 7778,
	    "": 7355,
	    "": 2405,
	    "": 1842,
	    "": 2090,
	    "": 1762,
	    "": 1593,
	    "": 2060,
	    "": 1537,
	    "": 1908,
	    "": 2107,
	    "": 1692,
	    "": 1568
	  }
	};

	var downloadJson = {
	  "成功": 17365,
	  "不成功": 4079,
	};
	var waterMarkText = 'ECHARTS';

	var canvas = document.createElement('canvas');
	var ctx = canvas.getContext('2d');
	option = {
	    backgroundColor: {
	        type: 'pattern',
	        image: canvas,
	        repeat: 'repeat'
	    },
	    tooltip: {},
	    title: [{
	        text: '纠纷类型',
	        x: '25%',
	        textAlign: 'center'
	    }, {
	        text: '成功率',
	        x: '75%',
	        textAlign: 'center'
	    }],
	    grid: [{
	        top: 50,
	        width: '50%',
	        left: 10,
	        containLabel: true
	    }],
	    xAxis: [{
	        type: 'value',
	        max: builderJson.all,
	        splitLine: {
	            show: false
	        }
	    }],
	    yAxis: [{
	        type: 'category',
	        data: Object.keys(builderJson.charts),
	        axisLabel: {
	            interval: 0,
	            rotate: 30
	        },
	        splitLine: {
	            show: false
	        }
	    }],
	    series: [{
	        type: 'bar',
	        stack: 'chart',
	        z: 3,
	        label: {
	            normal: {
	                position: 'right',
	                show: true
	            }
	        },
	        data: Object.keys(builderJson.charts).map(function (key) {
	            return builderJson.charts[key];
	        })
	    }, {
	        type: 'pie',
	        radius: [0, '30%'],
	        center: ['75%', '50%'],
	        data: Object.keys(downloadJson).map(function (key) {
	            return {
	                name: key.replace('.js', ''),
	                value: downloadJson[key]
	            }
	        })
	    }]
	};
	if (option && typeof option === "object") {
	    myChart.setOption(option, true);
	};
	//人民调解3
	var dom = document.getElementById("rmtj_quarter");
	var myChart = echarts.init(dom);
	var app = {};
	option = null;
	app.title = '水印 - ECharts 下载统计'

	var builderJson = {
	  "all": 10887,
	  "charts": {
	    "婚姻纠纷": 3237,
	    "邻里纠纷": 2164,
	    "": 7561,
	    "": 7778,
	    "": 7355,
	    "": 2405,
	    "": 1842,
	    "": 2090,
	    "": 1762,
	    "": 1593,
	    "": 2060,
	    "": 1537,
	    "": 1908,
	    "": 2107,
	    "": 1692,
	    "": 1568
	  }
	};

	var downloadJson = {
	  "成功": 17365,
	  "不成功": 4079,
	};
	var waterMarkText = 'ECHARTS';
	var canvas = document.createElement('canvas');
	var ctx = canvas.getContext('2d');
	option = {
	    backgroundColor: {
	        type: 'pattern',
	        image: canvas,
	        repeat: 'repeat'
	    },
	    tooltip: {},
	    title: [{
	        text: '纠纷类型',
	        x: '25%',
	        textAlign: 'center'
	    }, {
	        text: '成功率',
	        x: '75%',
	        textAlign: 'center'
	    }],
	    grid: [{
	        top: 50,
	        width: '50%',
	        left: 10,
	        containLabel: true
	    }],
	    xAxis: [{
	        type: 'value',
	        max: builderJson.all,
	        splitLine: {
	            show: false
	        }
	    }],
	    yAxis: [{
	        type: 'category',
	        data: Object.keys(builderJson.charts),
	        axisLabel: {
	            interval: 0,
	            rotate: 30
	        },
	        splitLine: {
	            show: false
	        }
	    }],
	    series: [{
	        type: 'bar',
	        stack: 'chart',
	        z: 3,
	        label: {
	            normal: {
	                position: 'right',
	                show: true
	            }
	        },
	        data: Object.keys(builderJson.charts).map(function (key) {
	            return builderJson.charts[key];
	        })
	    }, {
	        type: 'pie',
	        radius: [0, '30%'],
	        center: ['75%', '50%'],
	        data: Object.keys(downloadJson).map(function (key) {
	            return {
	                name: key.replace('.js', ''),
	                value: downloadJson[key]
	            }
	        })
	    }]
	};
	if (option && typeof option === "object") {
	    myChart.setOption(option, true);
	};
	
	var data_sx_name = new Array(); //数组对象
	var data_sx_value = new Array(); //数组对象
	var data_syrlb_name = new Array(); //数组对象
	var data_syrlb_value = new Array(); //数组对象
	pad.findFlyz(new Eht.Responder({success:function(datas){
		for (var i = 0; i < datas.list_sx.length; i++) {
			data_sx_name.push(datas.list_sx[i].name);
			data_sx_value.push(datas.list_sx[i].value);
		}
		for (var i = 0; i < datas.list_syrlb.length; i++) {
			data_syrlb_name.push(datas.list_syrlb[i].name);
			data_syrlb_value.push(datas.list_syrlb[i].value);
		}	
	//法律援助案件情况分析1
	var dom = document.getElementById("flyz_day");
	var myChart = echarts.init(dom);
	var app = {};
	option = null;
	var canvas = document.createElement('canvas');
	option = {
	    	backgroundColor: {
	        type: 'pattern',
	        image: canvas,
	        repeat: 'repeat'
	    },
		title: [{
	        text: '事项类型',
	        x: '25%',
	        textAlign: 'center'
	    },{
	        text: '受援人类别',
	        x: '75%',
	        textAlign: 'center'
	    }],
	    grid: [{
	        top: 50,
	        width: '45%',
	        bottom: '10%',
	        right: '55%',
	        containLabel: true
	    }, {
	        top: 30,
	        width: '45%',
	        bottom: '10%',
	        right: 20,
	        containLabel: true
	    }],
	    xAxis: [{
	        type: 'value',
	        splitLine: {
	            show: false
	        }
	    }, {
	        type: 'value',
	        gridIndex: 1,
	        splitLine: {
	            show: false
	        }
	    }],
	    yAxis: [{
	        type: 'category',
	        data: data_sx_name,
	        axisLabel: {
	            interval: 0,
	            rotate: 45
	        },
	        splitLine: {
	            show: false
	        }
	    }, {
	        gridIndex: 1,
	        type: 'category',
	        data: data_syrlb_name,
	        axisLabel: {
	        	rotate: 45
	        },
	        splitLine: {
	            show: false
	        }
	    }],
	    series: [{
	        type: 'bar',
	        stack: 'chart',
	        z: 3,
	        label: {
	            normal: {
	                position: 'right',
	                show: true
	            }
	        },
	        data: data_sx_value
	    }, {
	        type: 'bar',
	        stack: 'chart',
	        silent: true,
	        itemStyle: {
	            normal: {
	                color: '#eee'
	            }
	        },
	       data: data_syrlb_value[0] - data_syrlb_value
	    }, {
	        type: 'bar',
	        stack: 'component',
	        xAxisIndex: 1,
	        yAxisIndex: 1,
	        z: 3,
	        label: {
	            normal: {
	                position: 'right',
	                show: true
	            }
	        },
	        data: data_syrlb_value
	        
	    }, {
	        type: 'bar',
	        stack: 'component',
	        silent: true,
	        xAxisIndex: 1,
	        yAxisIndex: 1,
	        itemStyle: {
	            normal: {
	                color: '#eee'
	            }
	        },
	        data: data_syrlb_value[0] - data_syrlb_value
	    }]
	};
	if (option && typeof option === "object") {
	    myChart.setOption(option, true);
	};
	
}}));	

	//法律援助案件情况分析2
	var dom = document.getElementById("flyz_month");
	var myChart = echarts.init(dom);
	var app = {};
	option = null;


	var builderJson = {
	  "charts": {
	    "民事法律援助": 3237,
	    "刑事法律援助": 2164,
	    "民政法律援助": 7561,
	    "": 7778,
	    "": 7355,
	    "": 2405,
	    "": 1842,
	    "": 2090,
	    "": 1762,
	    "": 1593,

	  },
	  "components": {
	    "妇女": 2788,
	    "未成年人": 9575,
	    "老年人": 9400,
	    "军人军属": 9466,
	    "残疾人": 9266,
	    "": 3419,
	    "": 2984,
	    "": 2739,
	    "": 2744,
	    "": 2466,
	    "": 3034,
	    "": 1945
	  },
	  "ie": 9743
	};
	var canvas = document.createElement('canvas');
	option = {
	    	backgroundColor: {
	        type: 'pattern',
	        image: canvas,
	        repeat: 'repeat'
	    },
		title: [{
	        text: '事项类型',
	        x: '25%',
	        textAlign: 'center'
	    },{
	        text: '受援人类别',
	        x: '75%',
	        textAlign: 'center'
	    }],
	    grid: [{
	        top: 50,
	        width: '50%',
	        bottom: '10%',
	        left: 0,
	        containLabel: true
	    }, {
	        top: 50,
	        width: '50%',
	        bottom: '10%',
	        right: 0,
	        containLabel: true
	    }],
	    xAxis: [{
	        type: 'value',
	        max: builderJson.all,
	        splitLine: {
	            show: false
	        }
	    }, {
	        type: 'value',
	        max: builderJson.all,
	        gridIndex: 1,
	        splitLine: {
	            show: false
	        }
	    }],
	    yAxis: [{
	        type: 'category',
	        data: Object.keys(builderJson.charts),
	        axisLabel: {
	            interval: 0,
	            rotate: 30
	        },
	        splitLine: {
	            show: false
	        }
	    }, {
	        gridIndex: 1,
	        type: 'category',
	        data: Object.keys(builderJson.components),
	        axisLabel: {
	            interval: 0,
	            rotate: 30
	        },
	        splitLine: {
	            show: false
	        }
	    }],
	    series: [{
	        type: 'bar',
	        stack: 'chart',
	        z: 3,
	        label: {
	            normal: {
	                position: 'right',
	                show: true
	            }
	        },
	        data: Object.keys(builderJson.charts).map(function (key) {
	            return builderJson.charts[key];
	        })
	    }, {
	        type: 'bar',
	        stack: 'chart',
	        silent: true,
	        itemStyle: {
	            normal: {
	                color: '#eee'
	            }
	        },
	        data: Object.keys(builderJson.charts).map(function (key) {
	            return builderJson.all - builderJson.charts[key];
	        })
	    }, {
	        type: 'bar',
	        stack: 'component',
	        xAxisIndex: 1,
	        yAxisIndex: 1,
	        z: 3,
	        label: {
	            normal: {
	                position: 'right',
	                show: true
	            }
	        },
	        data: Object.keys(builderJson.components).map(function (key) {
	            return builderJson.components[key];
	        })
	    }, {
	        type: 'bar',
	        stack: 'component',
	        silent: true,
	        xAxisIndex: 1,
	        yAxisIndex: 1,
	        itemStyle: {
	            normal: {
	                color: '#eee'
	            }
	        },
	        data: Object.keys(builderJson.components).map(function (key) {
	            return builderJson.all - builderJson.components[key];
	        })
	    }]
	};
	if (option && typeof option === "object") {
	    myChart.setOption(option, true);
	};
	////法律援助案件情况分析3
	var dom = document.getElementById("flzx_quarter");
	var myChart = echarts.init(dom);
	var app = {};
	option = null;
	var builderJson = {
	  "charts": {
	    "民事法律援助": 3237,
	    "刑事法律援助": 2164,
	    "民政法律援助": 7561,
	    "": 7778,
	    "": 7355,
	    "": 2405,
	    "": 1842,
	    "": 2090,
	    "": 1762,
	    "": 1593,

	  },
	  "components": {
	    "妇女": 2788,
	    "未成年人": 9575,
	    "老年人": 9400,
	    "军人军属": 9466,
	    "残疾人": 9266,
	    "": 3419,
	    "": 2984,
	    "": 2739,
	    "": 2744,
	    "": 2466,
	    "": 3034,
	    "": 1945
	  },
	  "ie": 9743
	};
	var canvas = document.createElement('canvas');
	option = {
	    	backgroundColor: {
	        type: 'pattern',
	        image: canvas,
	        repeat: 'repeat'
	    },
		title: [{
	        text: '事项类型',
	        x: '25%',
	        textAlign: 'center'
	    },{
	        text: '受援人类别',
	        x: '75%',
	        textAlign: 'center'
	    }],
	    grid: [{
	        top: 50,
	        width: '50%',
	        bottom: '10%',
	        left: 0,
	        containLabel: true
	    }, {
	        top: 50,
	        width: '50%',
	        bottom: '10%',
	        right: 0,
	        containLabel: true
	    }],
	    xAxis: [{
	        type: 'value',
	        max: builderJson.all,
	        splitLine: {
	            show: false
	        }
	    }, {
	        type: 'value',
	        max: builderJson.all,
	        gridIndex: 1,
	        splitLine: {
	            show: false
	        }
	    }],
	    yAxis: [{
	        type: 'category',
	        data: Object.keys(builderJson.charts),
	        axisLabel: {
	            interval: 0,
	            rotate: 30
	        },
	        splitLine: {
	            show: false
	        }
	    }, {
	        gridIndex: 1,
	        type: 'category',
	        data: Object.keys(builderJson.components),
	        axisLabel: {
	            interval: 0,
	            rotate: 30
	        },
	        splitLine: {
	            show: false
	        }
	    }],
	    series: [{
	        type: 'bar',
	        stack: 'chart',
	        z: 3,
	        label: {
	            normal: {
	                position: 'right',
	                show: true
	            }
	        },
	        data: Object.keys(builderJson.charts).map(function (key) {
	            return builderJson.charts[key];
	        })
	    }, {
	        type: 'bar',
	        stack: 'chart',
	        silent: true,
	        itemStyle: {
	            normal: {
	                color: '#eee'
	            }
	        },
	        data: Object.keys(builderJson.charts).map(function (key) {
	            return builderJson.all - builderJson.charts[key];
	        })
	    }, {
	        type: 'bar',
	        stack: 'component',
	        xAxisIndex: 1,
	        yAxisIndex: 1,
	        z: 3,
	        label: {
	            normal: {
	                position: 'right',
	                show: true
	            }
	        },
	        data: Object.keys(builderJson.components).map(function (key) {
	            return builderJson.components[key];
	        })
	    }, {
	        type: 'bar',
	        stack: 'component',
	        silent: true,
	        xAxisIndex: 1,
	        yAxisIndex: 1,
	        itemStyle: {
	            normal: {
	                color: '#eee'
	            }
	        },
	        data: Object.keys(builderJson.components).map(function (key) {
	            return builderJson.all - builderJson.components[key];
	        })
	    }]
	};
	if (option && typeof option === "object") {
	    myChart.setOption(option, true);
	};
	
	
	var data_zxsx_name = new Array(); //数组对象
	var data_zxsx_value = new Array(); //数组对象
	var data_zxsf_name = new Array(); //数组对象
	var data_zxsf_value = new Array(); //数组对象
	pad.findFlzx(new Eht.Responder({success:function(datas){
		for (var i = 0; i < datas.list_zxsx.length; i++) {
			data_zxsx_name.push(datas.list_zxsx[i].name);
			data_zxsx_value.push(datas.list_zxsx[i].count);
		}
		for (var i = 0; i < datas.list_zxsf.length; i++) {
			data_zxsf_name.push(datas.list_zxsf[i].name);
			data_zxsf_value.push(datas.list_zxsf[i].value);
		}	
	//法律咨询案件情况分析
	var dom = document.getElementById("flzxqk_day");
	var myChart = echarts.init(dom);
	var app = {};
	option = null;

	var canvas = document.createElement('canvas');
	option = {
	    	backgroundColor: {
	        type: 'pattern',
	        image: canvas,
	        repeat: 'repeat'
	    },
		title: [{
	        text: '事项类型',
	        x: '25%',
	        textAlign: 'center'
	    },{
	        text: '身份类别',
	        x: '75%',
	        textAlign: 'center'
	    }],
	    grid: [{
	        top: 50,
	        width: '45%',
	        bottom: '10%',
	        right: '55%',
	        containLabel: true
	    }, {
	        top: 50,
	        width: '50%',
	        bottom: '10%',
	        right: 15,
	        containLabel: true
	    }],
	    xAxis: [{
	        type: 'value',
	        max: builderJson.all,
	        splitLine: {
	            show: false
	        }
	    }, {
	        type: 'value',
	        max: builderJson.all,
	        gridIndex: 1,
	        splitLine: {
	            show: false
	        }
	    }],
	    yAxis: [{
	        type: 'category',
	        data: data_zxsx_name,
	        axisLabel: {
	            interval: 0,
	            rotate: 60
	        },
	        splitLine: {
	            show: false
	        }
	    }, {
	        gridIndex: 1,
	        type: 'category',
	        data: data_zxsf_name,
	        axisLabel: {
	            interval: 0,
	            rotate: 60
	        },
	        splitLine: {
	            show: false
	        }
	    }],
	    series: [{
	        type: 'bar',
	        stack: 'chart',
	        z: 3,
	        label: {
	            normal: {
	                position: 'right',
	                show: true
	            }
	        },
	        data:data_zxsx_value
	    }, {
	        type: 'bar',
	        stack: 'chart',
	        silent: true,
	        itemStyle: {
	            normal: {
	                color: '#eee'
	            }
	        },
	        data:data_zxsf_value[0] - data_zxsf_value
	    }, {
	        type: 'bar',
	        stack: 'component',
	        xAxisIndex: 1,
	        yAxisIndex: 1,
	        z: 3,
	        label: {
	            normal: {
	                position: 'right',
	                show: true
	            }
	        },
	        data: data_zxsf_value 
	    }, {
	        type: 'bar',
	        stack: 'component',
	        silent: true,
	        xAxisIndex: 1,
	        yAxisIndex: 1,
	        itemStyle: {
	            normal: {
	                color: '#eee'
	            }
	        },
	        data:data_zxsf_value[0] - data_zxsf_value
	    }]
	};
	if (option && typeof option === "object") {
	    myChart.setOption(option, true);
	};
	}}));
	
	var data_lsx_name = new Array(); //数组对象
	var data_lsx_value = new Array(); //数组对象
	var data_nsl = new Array(); //数组对象 
	pad.findFlxc(new Eht.Responder({success:function(datas){
		for (var i = 0; i < datas.list_sx.length; i++) {
			data_lsx_name.push(datas.list_sx[i].name);
			data_lsx_value.push({value: datas.list_sx[i].value});
		}
		for (var i = 0; i < datas.list_sf.length; i++) {
			data_nsl.push(
					{
					name: datas.list_sf[i].name,
	                value: datas.list_sf[i].value
	                } 
					);
		}
	//法治宣传情况分析1 
		//柱
	var dom = document.getElementById("flxcfx_day");
	var myChart = echarts.init(dom);
	var app = {};
	option = null;
	var waterMarkText = 'ECHARTS';
	var canvas = document.createElement('canvas');
	var ctx = canvas.getContext('2d');
	option = {
	    backgroundColor: {
	        type: 'pattern',
	        image: canvas,
	        repeat: 'repeat'
	    },
	    tooltip: {},
	    title: [{
	        x: '25%',
	        textAlign: 'center'
	    }],
	    grid: [{
	        top: 30,
	        left: 50,
	        bottom: 20,
	        containLabel: true
	    }],
	    yAxis: [{
	        type: 'value',
	        splitLine: {
	            show: false
	        }
	    }],
	    xAxis: [{
	        type: 'category',
	        data: data_lsx_name,
	        axisLabel: {
	            interval: 0,
	            rotate: 15
	        },
	        splitLine: {
	            show: false
	        }
	    }],
	    series: [{
	        type: 'bar',
	        "barMaxWidth": 35,
	        stack: 'chart',
	        z: 3,
	        label: {
	            normal: {
	                position: 'top',
	                show: true
	            }
	        },
	        data:data_lsx_value
	    }]
	};
	if (option && typeof option === "object") {
	    myChart.setOption(option, true);
	};
	//饼
	var dom = document.getElementById("flxcfxa_day");
	var myChart = echarts.init(dom);
	var app = {};
	option = null;
	var waterMarkText = 'ECHARTS';
	var canvas = document.createElement('canvas');
	var ctx = canvas.getContext('2d');
	option = {
	    backgroundColor: {
	        type: 'pattern',
	        image: canvas,
	        repeat: 'repeat'
	    },
	    tooltip: {},
	    grid: [{
	        top: 30,
	        left: 50,
	        bottom: 20,
	        containLabel: true
	    }],
	    series: [{
	        type: 'pie',
	        stack: 'chart',
	        z: 3,
	        label: {
	            normal: {
	                position: 'right',
	                show: true
	            }
	        },
	        data:data_nsl
	    }]
	};
	if (option && typeof option === "object") {
	    myChart.setOption(option, true);
	};
	}}));

	
	
	
	
	
	
	//法治宣传情况分析2
	var dom = document.getElementById("flxcfx_month");
	var myChart = echarts.init(dom);
	var app = {};
	option = null;
	
	var builderJson = {
	  "all": 10887,
	  "charts": {
	    "青少年": 3237,
	    "妇女": 2164,
	    "": 7561,
	    "": 7778,
	    "": 7355,
	    "": 2405,
	    "": 1842,
	    "": 2090,
	    "": 1762,
	    "": 1593,
	    "": 2060,
	    "": 1537,
	    "": 1908,
	    "": 2107,
	    "": 1692,
	    "": 1568
	  }
	};
	
	var downloadJson = {
	  "文艺演出": 17365,
	  "普法宣传": 4079,
	  "": 8365,
	  "": 5365,
	  "": 9365
	};
	var waterMarkText = 'ECHARTS';
	
	var canvas = document.createElement('canvas');
	var ctx = canvas.getContext('2d');
	option = {
	    backgroundColor: {
	        type: 'pattern',
	        image: canvas,
	        repeat: 'repeat'
	    },
	    tooltip: {},
	    title: [{
	        text: '纠纷类型',
	        x: '25%',
	        textAlign: 'center'
	    }, {
	        text: '成功率',
	        x: '75%',
	        textAlign: 'center'
	    }],
	    grid: [{
	        top: 50,
	        width: '50%',
	        left: 10,
	        containLabel: true
	    }],
	    xAxis: [{
	        type: 'value',
	        max: builderJson.all,
	        splitLine: {
	            show: false
	        }
	    }],
	    yAxis: [{
	        type: 'category',
	        data: Object.keys(builderJson.charts),
	        axisLabel: {
	            interval: 0,
	            rotate: 30
	        },
	        splitLine: {
	            show: false
	        }
	    }],
	    series: [{
	        type: 'bar',
	        stack: 'chart',
	        z: 3,
	        label: {
	            normal: {
	                position: 'right',
	                show: true
	            }
	        },
	        itemStyle:{
                normal:{
                    color:'#f0f'
                }
            },
	        data: Object.keys(builderJson.charts).map(function (key) {
	            return builderJson.charts[key];
	        })
	    }, {
	        type: 'pie',
	        radius: [0, '30%'],
	        center: ['75%', '50%'],
	        data: Object.keys(downloadJson).map(function (key) {
	            return {
	                name: key.replace('.js', ''),
	                value: downloadJson[key]
	            }
	        })
	    }]
	};
	if (option && typeof option === "object") {
	    myChart.setOption(option, true);
	};
	//法治宣传情况分析3
	var dom = document.getElementById("flxcfx_quarter");
	var myChart = echarts.init(dom);
	var app = {};
	option = null;
	
	var builderJson = {
	  "all": 10887,
	  "charts": {
	    "青少年": 3237,
	    "妇女": 2164,
	    "": 7561,
	    "": 7778,
	    "": 7355,
	    "": 2405,
	    "": 1842,
	    "": 2090,
	    "": 1762,
	    "": 1593,
	    "": 2060,
	    "": 1537,
	    "": 1908,
	    "": 2107,
	    "": 1692,
	    "": 1568
	  }
	};
	
	var downloadJson = {
	  "文艺演出": 17365,
	  "普法宣传": 4079,
	  "": 8365,
	  "": 5365,
	  "": 9365
	};
	var waterMarkText = 'ECHARTS';
	
	var canvas = document.createElement('canvas');
	var ctx = canvas.getContext('2d');
	option = {
	    backgroundColor: {
	        type: 'pattern',
	        image: canvas,
	        repeat: 'repeat'
	    },
	    tooltip: {},
	    title: [{
	        text: '纠纷类型',
	        x: '25%',
	        textAlign: 'center'
	    }, {
	        text: '成功率',
	        x: '75%',
	        textAlign: 'center'
	    }],
	    grid: [{
	        top: 50,
	        width: '50%',
	        left: 10,
	        containLabel: true
	    }],
	    xAxis: [{
	        type: 'value',
	        max: builderJson.all,
	        splitLine: {
	            show: false
	        }
	    }],
	    yAxis: [{
	        type: 'category',
	        data: Object.keys(builderJson.charts),
	        axisLabel: {
	            interval: 0,
	            rotate: 30
	        },
	        splitLine: {
	            show: false
	        }
	    }],
	    series: [{
	        type: 'bar',
	        stack: 'chart',
	        z: 3,
	        label: {
	            normal: {
	                position: 'right',
	                show: true
	            }
	        },
	        data: Object.keys(builderJson.charts).map(function (key) {
	            return builderJson.charts[key];
	        })
	    }, {
	        type: 'pie',
	        radius: [0, '30%'],
	        center: ['75%', '50%'],
	        data: Object.keys(downloadJson).map(function (key) {
	            return {
	                name: key.replace('.js', ''),
	                value: downloadJson[key]
	            }
	        })
	    }]
	};
	if (option && typeof option === "object") {
	    myChart.setOption(option, true);
	};
	
	

	
	
	
	var data_fl1_name = new Array(); //数组对象
	var data_fl1_value = new Array(); //数组对象
	var data_fl = new Array(); //数组对象
	pad.findJcflfw(new Eht.Responder({success:function(datas){
		for (var i = 0; i < datas.list_sx.length; i++) {
			data_fl1_name.push(datas.list_sx[i].name);
			data_fl1_value.push({value: datas.list_sx[i].total});
		}
		for (var i = 0; i < datas.list_sx.length; i++) {
			data_fl.push({
				name: datas.list_sx[i].name,
				value: datas.list_sx[i].total});
		}	
	/*}}));*/
	
	
	//基层法律服务登记情况分析1
		//柱
	var dom = document.getElementById("jzflfw_day");
	var myChart = echarts.init(dom);
	var app = {};
	option = null;
	var waterMarkText = 'ECHARTS';
	var canvas = document.createElement('canvas');
	var ctx = canvas.getContext('2d');
	option = {
	    backgroundColor: {
	        type: 'pattern',
	        image: canvas,
	        repeat: 'repeat'
	    },
	    tooltip: {},
	    title: [{
	        x: '25%',
	        textAlign: 'center'
	    }],
	    grid: [{
	        top: 30,
	        left: 50,
	        bottom: 20,
	        containLabel: true
	    }],
	    yAxis: [{
	        type: 'value',
	        max: builderJson.all,
	        splitLine: {
	        	show: false
	        }
    	}],
    	xAxis: [{
	        type: 'category',
	        data: data_fl1_name,
	        axisLabel: {
	            interval: 0,
	        },
        splitLine: {
            show: false
        }
    	}],
    	series: [{
	        type: 'bar',
	        "barMaxWidth": 35,
	        stack: 'chart',
	        z: 3,
	        label: {
	            normal: {
	                position: 'top',
	                show: true
	            }
	        },
	        data: data_fl1_value
    	}]
	};
	if (option && typeof option === "object") {
	    myChart.setOption(option, true);
	};
	//饼
	var dom = document.getElementById("jzflfwa_day");
	var myChart = echarts.init(dom);
	var app = {};
	option = null;
	var waterMarkText = 'ECHARTS';
	var canvas = document.createElement('canvas');
	var ctx = canvas.getContext('2d');
	option = {
	    backgroundColor: {
	        type: 'pattern',
	        image: canvas,
	        repeat: 'repeat'
	    },
	    tooltip: {},
	    grid: [{
	        top: 30,
	        left: 50,
	        bottom: 20,
	        containLabel: true
	    }],
	    series: [{
	        type: 'pie',
	        center: ['50%', '50%'],
	        data: data_fl
    	}]
	};
	if (option && typeof option === "object") {
	    myChart.setOption(option, true);
	};
}}));	
	//基层法律服务登记情况分析2
	var dom = document.getElementById("jzflfw_month");
	var myChart = echarts.init(dom);
	var app = {};
	option = null;
	var builderJson = {
	  "charts": {
	    "": 3237,
	    "": 2164,
	    "": 7561,
	    "": 7778,
	    "": 7355,
	    "": 2405,
	    "": 1842,
	    "": 2090,
	    "": 1762,
	    "": 1593,
	    "": 2060,
	    "": 1537,
	    "": 1908,
	    "": 2107,
	    "": 1692,
	    "": 1568
	  }
	};
	
	var downloadJson = {
	  "担任法律服务": 17365,
	  "解答法律咨询": 4079,
	  "解答法律咨询1": 4079,
	  "解答法律咨询2": 4079,
	  "解答法律咨询4": 4079,
	  "解答法律咨询7": 4079,
	  "解答法律咨询8": 4079,
	};
	var waterMarkText = 'ECHARTS';
	
	var canvas = document.createElement('canvas');
	var ctx = canvas.getContext('2d');
	option = {
	    backgroundColor: {
	        type: 'pattern',
	        image: canvas,
	        repeat: 'repeat'
	    },
	    tooltip: {},
	    title: [{
	        text: '工作类型',
	        x: '25%',
	        textAlign: 'center'
	    }, {
	        text: '工作类型',
	        x: '75%',
	        textAlign: 'center'
	    }],
	    grid: [{
	        top: 50,
	        width: '50%',
	        left: 10,
	        containLabel: true
	    }],
	    xAxis: [{
	        type: 'value',
	        max: builderJson.all,
	        splitLine: {
	            show: false
	        }
	    }],
	    yAxis: [{
	        type: 'category',
	        data: Object.keys(builderJson.charts),
	        axisLabel: {
	            interval: 0,
	            rotate: 30
	        },
	        splitLine: {
	            show: false
	        }
	    }],
	    series: [{
	        type: 'bar',
	        stack: 'chart',
	        z: 3,
	        label: {
	            normal: {
	                position: 'right',
	                show: true
	            }
	        },
	        data: Object.keys(builderJson.charts).map(function (key) {
	            return builderJson.charts[key];
	        })
	    }, {
	        type: 'pie',
	        radius: [0, '30%'],
	        center: ['75%', '50%'],
	        data: Object.keys(downloadJson).map(function (key) {
	            return {
	                name: key.replace('.js', ''),
	                value: downloadJson[key]
	            }
	        })
	    }]
	};
	if (option && typeof option === "object") {
	    myChart.setOption(option, true);
	};
	//基层法律服务登记情况分析3
	var dom = document.getElementById("jzflfw_quarter");
	var myChart = echarts.init(dom);
	var app = {};
	option = null;
	var builderJson = {
	  "charts": {
	    "": 3237,
	    "": 2164,
	    "": 7561,
	    "": 7778,
	    "": 7355,
	    "": 2405,
	    "": 1842,
	    "": 2090,
	    "": 1762,
	    "": 1593,
	    "": 2060,
	    "": 1537,
	    "": 1908,
	    "": 2107,
	    "": 1692,
	    "": 1568
	  }
	};
	
	var downloadJson = {
	  "担任法律服务": 17365,
	  "解答法律咨询": 4079,
	  "解答法律咨询1": 4079,
	  "解答法律咨询2": 4079,
	  "解答法律咨询4": 4079,
	  "解答法律咨询7": 4079,
	  "解答法律咨询8": 4079,
	};
	var waterMarkText = 'ECHARTS';
	
	var canvas = document.createElement('canvas');
	var ctx = canvas.getContext('2d');
	option = {
	    backgroundColor: {
	        type: 'pattern',
	        image: canvas,
	        repeat: 'repeat'
	    },
	    tooltip: {},
	    title: [{
	        text: '工作类型',
	        x: '25%',
	        textAlign: 'center'
	    }, {
	        text: '工作类型',
	        x: '75%',
	        textAlign: 'center'
	    }],
	    grid: [{
	        top: 50,
	        width: '50%',
	        left: 10,
	        containLabel: true
	    }],
	    xAxis: [{
	        type: 'value',
	        max: builderJson.all,
	        splitLine: {
	            show: false
	        }
	    }],
	    yAxis: [{
	        type: 'category',
	        data: Object.keys(builderJson.charts),
	        axisLabel: {
	            interval: 0,
	            rotate: 30
	        },
	        splitLine: {
	            show: false
	        }
	    }],
	    series: [{
	        type: 'bar',
	        stack: 'chart',
	        z: 3,
	        label: {
	            normal: {
	                position: 'right',
	                show: true
	            }
	        },
	        data: Object.keys(builderJson.charts).map(function (key) {
	            return builderJson.charts[key];
	        })
	    }, {
	        type: 'pie',
	        radius: [0, '30%'],
	        center: ['75%', '50%'],
	        data: Object.keys(downloadJson).map(function (key) {
	            return {
	                name: key.replace('.js', ''),
	                value: downloadJson[key]
	            }
	        })
	    }]
	};
	if (option && typeof option === "object") {
	    myChart.setOption(option, true);
	}
});