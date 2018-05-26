<%@ page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>

<html>
<head>
<title>人员调解总览界面_新</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<script type="text/javascript" src="${localCtx}/json/RmtjzlNewService.js"></script>

<script type="text/javascript" src="http://echarts.baidu.com/gallery/vendors/echarts/echarts.min.js"></script>
<script type="text/javascript" src="http://echarts.baidu.com/gallery/vendors/echarts-gl/echarts-gl.min.js"></script>
<script type="text/javascript" src="http://echarts.baidu.com/gallery/vendors/echarts-stat/ecStat.min.js"></script>
<script type="text/javascript" src="http://echarts.baidu.com/gallery/vendors/echarts/extension/dataTool.min.js"></script>
<script type="text/javascript" src="http://echarts.baidu.com/gallery/vendors/echarts/map/js/china.js"></script>
<script type="text/javascript" src="http://echarts.baidu.com/gallery/vendors/echarts/map/js/world.js"></script>
<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=ZUONbpqGBsYGXNIYHicvbAbM"></script>
<script type="text/javascript" src="http://echarts.baidu.com/gallery/vendors/echarts/extension/bmap.min.js"></script>
<script type="text/javascript" src="http://echarts.baidu.com/gallery/vendors/simplex.js"></script>
<script type="text/javascript" src="shine.js"></script>
<script type="text/javascript" src="infographic.js"></script>


<script type="text/javascript">
$(function(){
	var rmtjzl = new RmtjzlNewService();
	
	
	var dqsj = new Date().format("yyyy年MM月dd日 hh:mm:ss");
	document.getElementById("top_01").innerHTML=dqsj;
	var query_zs = {};
	query_zs["provinceid[eq]"] = '150000';
	rmtjzl.find_zs(query_zs,new Eht.Responder({
		success:function(data){
			if(data != null && data.length == 1){
				document.getElementById("top_02").innerHTML=data[0].cnt1; //调解总数
				document.getElementById("top_03").innerHTML=data[0].cnt2; //调解成功
				document.getElementById("top_04").innerHTML=data[0].cnt3; //调解不成功
				document.getElementById("cen_01").innerHTML=data[0].cnt1; //调解总数
				document.getElementById("cen_02").innerHTML=data[0].cnt4; //调解员
				document.getElementById("cen_03").innerHTML=data[0].cnt5; //调委会
				document.getElementById("cen_04").innerHTML=data[0].cnt2; //调解不成功
				document.getElementById("cen_05").innerHTML=data[0].cnt6; //协议金额
			}
		}
	}))
	
	
	var lxqk_list = [];
	var query_lxqk = {};
	//query_lxqk["provinceid[eq]"] = '150000';
	rmtjzl.find_lxqk(query_lxqk,new Eht.Responder({
		success:function(data){
			lxqk_list = data;
			if(lxqk_list != null){
				lxqk(lxqk_list);  //履行情况
			}
		}
	}));
	
	var ajly_list = [];
	rmtjzl.find_ajly(new Eht.Responder({
		success:function(data){
			ajly_list = data;
			if(ajly_list != null){
				ajly(ajly_list);  //案件来源
			}
		}
	}));
	
	var ssjk_list = [];
	rmtjzl.find_ssjk(new Eht.Responder({
		success:function(data){
			ssjk_list = data;
			if(ssjk_list != null){
				ssjk(ssjk_list);  //实时监控  地图
			}
		}
	}));
	
	var ajny_list = [];
	rmtjzl.find_ajny(new Eht.Responder({
		success:function(data){
			ajny_list = data;
			if(ajny_list != null){
				ajny(ajny_list);  //案件难易
			}
		}
	}));
	
	var ajjf_list = [];
	rmtjzl.find_ajjf(new Eht.Responder({
		success:function(data){
			ajjf_list = data;
			if(ajjf_list != null){
				ajjf(ajjf_list);  //案件纠纷情况
			}
		}
	}));
	
	var tjjg_list = [];
	rmtjzl.find_tjjg(new Eht.Responder({
		success:function(data){
			tjjg_list = data;
			if(tjjg_list != null){
				tjjg(tjjg_list);  //调解结果
			}
		}
	}));
 
});

function lxqk(lxqk_list){
	var dom = document.getElementById("l_cen");
	var myChart = echarts.init(dom,'shine');
	
	var x_data = [];    //月份 
	var leg_city1 = [];    //{履行情况：[每个月的数据]}
	var leg_city2 = [];
	var leg_city3 = [];
	var leg_city4 = [];
	var leg_city5 = [];
	
	if(lxqk_list != null){
		for(var i=0; i<lxqk_list.length; i++){
			x_data.push(lxqk_list[i].city);
			leg_city1.push(lxqk_list[i].cnt1);
			leg_city2.push(lxqk_list[i].cnt2);
			leg_city3.push(lxqk_list[i].cnt3);
			leg_city4.push(lxqk_list[i].cnt4);
			leg_city5.push(lxqk_list[i].cnt5);
		}
	}
	
	option = {
		    title: {
		        text: '履行情况',
		        textStyle: {
		        	fontSize: 12,
		        	align: 'left',
		        	color: '#fff'
	            }
		    },
		    tooltip : {
		        trigger: 'axis',
		        axisPointer: {
		            type: 'cross',  //shadow
		            label: {
		                backgroundColor: '#6a7985'
		            }
		        }
		    },
		    legend: {
		    	type: 'scroll',
		    	pageIconColor: '#fff',
		    	pageTextStyle: {
		    		color: '#fff'
		    	},
		    	right:25,
		    	left:60,
		    	textStyle: {
		            color: '#fff'
		        },
		        data:['协议已履行','司法确认','达成协议后起诉','法院判决维持','其他']
		    },
		    grid: {
		    	left: '3%',
		        right: '8%',
		        bottom: '3%',
		        containLabel: true
		    },
		    xAxis : [
		        {
		            type : 'category',
		            boundaryGap : true,
		            axisLine: {
		                lineStyle: {
		                    color: '#fff'
		                }
		            },
		            axisLabel: {
		                textStyle: {
		                    color: '#fff'
		                }
		            },
		            axisTick: {
		                lineStyle: {
		                    color: '#fff'
		                }
		            },
		            data : ['2月','4月','6月','8月','10月']  //x_data
		        }
		    ],
		    yAxis : [
		        {
		            type : 'value',
		            splitLine: {show: false},
		            axisLine: {
		                lineStyle: {
		                    color: '#fff'
		                }
		            },
		            axisLabel: {
		                textStyle: {
		                    color: '#fff'
		                }
		            },
		            axisTick: {
		                lineStyle: {
		                    color: '#fff'
		                }
		            }
		        }
		    ],
		    series : [
		        {
		            name:'协议已履行',
		            type:'bar',
		            markLine: {
		                data: [{
		                    type: 'average',
		                    name: '平均值'
		                }]
		            },
		            data:[120, 132, 101, 134, 90]  //leg_city1
		        },
		        {
		            name:'司法确认',
		            type:'bar',
		            markLine: {
		                data: [{
		                    type: 'average',
		                    name: '平均值'
		                }]
		            },
		            data:[220, 182, 191, 234, 290]
		        },
		        {
		            name:'达成协议后起诉',
		            type:'bar',
		            markLine: {
		                data: [{
		                    type: 'average',
		                    name: '平均值'
		                }]
		            },
		            data:[150, 232, 201, 154, 190]
		        },
		        {
		            name:'法院判决维持',
		            type:'bar',
		            markLine: {
		                data: [{
		                    type: 'average',
		                    name: '平均值'
		                }]
		            },
		            data:[320, 332, 301, 334, 390]
		        },
		        {
		            name:'其他',
		            type:'bar',
		            markLine: {
		                data: [{
		                    type: 'average',
		                    name: '平均值'
		                }]
		            },
		            data:[20, 32, 1, 34, 90]
		        }
		    ]
		};
	
	if (option && typeof option === "object") {
	    myChart.setOption(option, true);
	}
}

function ajly(ajly_list){
	var dom = document.getElementById("l_bot");
	var myChart = echarts.init(dom,'shine');
	
	var y_data = [];    //案件来源类型
	var lx_data = [];    //数量
	var selected = {};
	
	if(ajly_list != null){
		for(var i=0; i<ajly_list.length; i++){
			y_data.push(ajly_list[i].ajly);
			var data = {};
			data["value"] = ajly_list[i].cnt;
			data["name"] = ajly_list[i].ajly;
			lx_data.push(data);
			selected[ajly_list[i].ajly] = i < 5;  //选中5个
		}
	}
	
	option = null;
	option = {
		    title: {
		        text: '案件来源',
		        textStyle: {
		        	fontSize: 12,
		        	align: 'left',
		        	color: '#fff'
	            }
		    },
		    tooltip: {
		        trigger: 'item',
		        formatter: "{a} <br/>{b}: {c} ({d}%)"
		    },
		    legend: {
		    	type: 'scroll',
		        orient: 'vertical',
		        pageIconColor: '#fff',
		    	pageTextStyle: {
		    		color: '#fff'
		    	},
		        right: 15,
		        top: 40,
		        textStyle: {
		            color: '#fff'
		        },
		        data:y_data,
		        selected: selected

		    },
		    series : [
		        {
		            name:'案件来源',
		            type:'pie',
		            radius: ['40%', '60%'],
		            center: ['36%', '60%'],
		            avoidLabelOverlap: false,
		            label: {
		                normal: {
		                    show: true,
		                    formatter: "{c}", // / {d}%
		                    position: "outer"
		                }
		            },
		            labelLine: {
		                normal: {
		                    show: true
		                }
		            },
		            data:lx_data
		        }
		    ]
		};
	
	if (option && typeof option === "object") {
	    myChart.setOption(option, true);
	}
}

function ssjk(res) {
    var dom = document.getElementById("c_cen");
    var myChart = echarts.init(dom,'infographic');
    var app = {};
    option = null;
    myChart.showLoading();

    $.get('nmg.json', function(geoJson) {

        myChart.hideLoading();

        echarts.registerMap('NMG', geoJson);

        myChart.setOption(option = {
            title: {
                text: '实时监控',
                textStyle: {
                    fontSize: 12,
                    align: 'left',
                    color: '#fff'
                }
            },
            tooltip: {
                //trigger: 'item',
                formatter: '{b}<br/>{c} (人次)'
            },
            visualMap: {
            	left:'right',
            	type: 'piecewise',
                min: 0,
                max: 300,
                splitNumber: 5,
                //text: ['High', 'Low'],
                realtime: false,
                //calculable: true,
                textStyle: {
                	color: '#fff'
                }
                /* inRange: {
                    color: ['lightskyblue', 'yellow', 'orangered']
                } */
            },
            series: [{
                name: '实时监控',
                type: 'map',
                top: 58,
                //left: 30,
                mapType: 'NMG', // 自定义扩展图表类型
                itemStyle: {
                    /* normal: {
                        label: {
                            show: true
                        }
                    },
                    emphasis: {
                        label: {
                            show: true
                        }
                    } */
                },
                data: [{
                        name: '呼和浩特市',
                        value: 257.34
                    },
                    {
                        name: '包头市',
                        value: 77.48
                    },
                    {
                        name: '乌海市',
                        value: 86.1
                    },
                    {
                        name: '赤峰市',
                        value: 92.6
                    },
                    {
                        name: '通辽市',
                        value: 145.49
                    },
                    {
                        name: '鄂尔多斯市',
                        value: 189.64
                    },
                    {
                        name: '呼伦贝尔市',
                        value: 259.78
                    },
                    {
                        name: '巴彦淖尔市',
                        value: 180.97
                    },
                    {
                        name: '乌兰察布市',
                        value: 24.26
                    },
                    {
                        name: '兴安盟',
                        value: 100.9
                    },
                    {
                        name: '锡林郭勒盟',
                        value: 218.26
                    },
                    {
                        name: '阿拉善盟',
                        value: 181.84
                    }
                ]
            }]
        });
    });
    if (option && typeof option === "object") {
        myChart.setOption(option, true);
    }
}

function ajny(ajny_list){
	var dom = document.getElementById("c_bot");
	var myChart = echarts.init(dom,'shine');
	var x_data = [];    //城市名 
	var leg_city1 = [];    //{难易级别：[每个市的数据]}
	var leg_city2 = [];
	var leg_city3 = [];
	var leg_city4 = [];
	var leg_city5 = [];
	
	if(ajny_list != null){
		for(var i=0; i<ajny_list.length; i++){
			x_data.push(ajny_list[i].city);
			leg_city1.push(ajny_list[i].cnt1);
			leg_city2.push(ajny_list[i].cnt2);
			leg_city3.push(ajny_list[i].cnt3);
			leg_city4.push(ajny_list[i].cnt4);
			leg_city5.push(ajny_list[i].cnt5);
		}
	}
	
	option = null;
	option = {
		    title: {
		        text: '案件难易级别',
		        textStyle: {
		        	fontSize: 12,
		        	align: 'left',
		        	color: '#fff'
	            }
		    },
		    tooltip : {
		        trigger: 'axis',
		        axisPointer: {
		            type: 'shadow'
		        }
		    },
		    legend: {
		    	right:25,
		    	textStyle: {
		            color: '#fff'
		        },
		        data:["简单纠纷","一般纠纷","重大纠纷","疑难纠纷","未说明"]
		    },
		    grid: {
		    	left: '3%',
		        right: '5%',
		        bottom: '3%',
		        containLabel: true
		    },
		    xAxis : [
		        {
		            type : 'category',
		            boundaryGap : true,
		            axisLine: {
		                lineStyle: {
		                    color: '#fff'
		                }
		            },
		            axisLabel: {
		                textStyle: {
		                    color: '#fff'
		                }
		            },
		            axisTick: {
		                lineStyle: {
		                    color: '#fff'
		                }
		            },
		            data : x_data
		        }
		    ],
		    yAxis : [
		        {
		            type : 'value',
		            splitLine: {show: false},
		            axisLine: {
		                lineStyle: {
		                    color: '#fff'
		                }
		            },
		            axisLabel: {
		                textStyle: {
		                    color: '#fff'
		                }
		            },
		            axisTick: {
		                lineStyle: {
		                    color: '#fff'
		                }
		            }
		            
		        }
		    ],
		    series : [
		        {
		            name:"简单纠纷",
		            type:'bar',
		            stack: '总值',
		            data:leg_city1
		        },
		        {
		            name:"一般纠纷",
		            type:'bar',
		            stack: '总值',
		            data:leg_city2
		        },
		        {
		            name:"重大纠纷",
		            type:'bar',
		            stack: '总值',
		            data:leg_city3
		        },
		        {
		            name:"疑难纠纷",
		            type:'bar',
		            stack: '总值',
		            data:leg_city4
		        },
		        {
		            name:"未说明",
		            type:'bar',
		            stack: '总值',
		            data:leg_city5
		        }
		    ]
		};
	
	if (option && typeof option === "object") {
	    myChart.setOption(option, true);
	}
}

function ajjf(ajjf_list){
	var dom = document.getElementById("r_top");
	var myChart = echarts.init(dom,'shine');

	var y_data = [];    //纠纷类型
	var lx_data = [];    //[纠纷数量]
	
	if(ajjf_list != null){
		for(var i=0; i<ajjf_list.length; i++){
			y_data.push(ajjf_list[i].jflx);
			lx_data.push(ajjf_list[i].cnt);
		}
	}
	
	option = null;
	option = {
		    title: {
		        text: '案件纠纷情况',
		        textStyle: {
		        	fontSize: 12,
		        	align: 'left',
		        	color: '#fff'
	            }
		    },
		    tooltip : {
		        trigger: 'axis',
		        axisPointer: {
		            type: 'shadow'
		        }
		    },
		    grid: {
		    	left: '3%',
		        right: '8%',
		        bottom: '3%',
		        containLabel: true
		    },
		    xAxis : [
		        {
		        	type: 'value',
		        	boundaryGap : true,
		        	axisLine: {
		                lineStyle: {
		                    color: '#fff'
		                }
		            },
		            axisLabel: {
		                textStyle: {
		                    color: '#fff'
		                }
		            },
		            axisTick: {
		                lineStyle: {
		                    color: '#fff'
		                }
		            },
		            splitLine: {
		                show: false
		            }
		        }
		    ],
		    yAxis : [
		        {
		        	type: 'category',
		        	data : y_data,
		        	splitLine: {
		                show: false
		            },
		            axisLine: {
		                lineStyle: {
		                    color: '#fff'
		                }
		            },
		            axisLabel: {
		                textStyle: {
		                    color: '#fff'
		                }
		            },
		            axisTick: {
		                lineStyle: {
		                    color: '#fff'
		                }
		            }
		        }
		    ],
		    series : [
		    	{
		            type: 'bar',
		            stack: 'chart',
		            z: 3,
		            label: {
		                normal: {
		                    position: 'right',
		                    show: true,
		                    textStyle: {
		                    	color: '#fff'
		                    }
		                }
		            },
		            data:lx_data
		        }
		    ]
		};
	
	if (option && typeof option === "object") {
	    myChart.setOption(option, true);
	}
}

function tjjg(tjjg_list){
	var dom = document.getElementById("r_bot");
	var myChart = echarts.init(dom,'shine');
	
	var x_data = [];    //月份 
	var leg_data1 = [];    //{调解结果：[每个月]}
	var leg_data2 = [];
	var leg_data3 = [];
	var leg_data4 = [];
	
	if(tjjg_list != null){
		for(var i=0; i<tjjg_list.length; i++){
			x_data.push(tjjg_list[i].tjrq);
			leg_data1.push(tjjg_list[i].cnt1);
			leg_data2.push(tjjg_list[i].cnt2);
			leg_data3.push(tjjg_list[i].cnt3);
			leg_data4.push(tjjg_list[i].cnt4);
		}
	}
	
	option = null;
	option = {
		    title: {
		        text: '调解结果',
		        textStyle: {
		        	fontSize: 12,
		        	align: 'left',
		        	color: '#fff'
	            }
		    },
		    tooltip : {
		    	trigger: 'axis'
		    },
		    legend: {
		    	type: 'scroll',
		    	pageIconColor: '#fff',
		    	pageTextStyle: {
		    		color: '#fff'
		    	},
		    	right:25,
		    	left:60,
		    	textStyle: {
		            color: '#fff'
		        },
		        data:['调解成功','调解不成功','继续调节','未说明']
		    },
		    grid: {
		    	left: '3%',
		        right: '4%',
		        bottom: '3%',
		        containLabel: true
		    },
		    xAxis : [
		        {
		            type : 'category',
		            boundaryGap : true,
		            axisLine: {
		                lineStyle: {
		                    color: '#fff'
		                }
		            },
		            axisLabel: {
		                textStyle: {
		                    color: '#fff'
		                }
		            },
		            axisTick: {
		                lineStyle: {
		                    color: '#fff'
		                }
		            },
		            data : x_data
		        }
		    ],
		    yAxis : [
		        {
		        	type: 'value',
		            //name: '',
		            min: 0,
		            max: 50,
		            interval: 10,
		            splitLine: {show: false},
		            axisLine: {
		                lineStyle: {
		                    color: '#fff'
		                }
		            },
		            axisLabel: {
		                textStyle: {
		                    color: '#fff'
		                }
		            },
		            axisTick: {
		                lineStyle: {
		                    color: '#fff'
		                }
		            }
		        }
		    ],
		    series : [
		        {
		            name:'调解成功',
		            type:'line',
		            data:leg_data1
		        },
		        {
		            name:'调解不成功',
		            type:'line',
		            data:leg_data2
		        },
		        {
		            name:'继续调节',
		            type:'line',
		            data:leg_data3
		        },
		        {
		            name:'未说明',
		            type:'line',
		            data:leg_data4
		        }
		    ]
		};
	
	if (option && typeof option === "object") {
	    myChart.setOption(option, true);
	}
}

</script>

<style type="text/css"> 
body{height:100%;background-image: url(bg.png);color: #fff;}
.left_div{height:29.5%;border: 1px solid #005eaa;border-radius: 4px;box-shadow: 0 1px 3px rgba(0,0,0,.1);padding: 5px;margin-bottom:10px;}
</style> 

</head>
<body>
<div>  <!--background-color:#191970;  color: #fff;text-shadow: 1px 1px 2px #333;-->
	<div id="left" style="float:left;margin:10px;width:29%;margin-top:40px;">
		<div id="l_top" class="left_div">
			<div> <!-- 图标 --><span>调解案件总数</span>
				<div style="padding:30px;font-size: 16px;line-height: 20px;">
				  &nbsp;&nbsp;截至<label id="top_01"></label>,全区调解案件总数<label id="top_02"></label>件,其中调解成功<label id="top_03"></label>件,调解不成功<label id="top_04"></label>件.
				</div>
			</div>
		</div>
		<div id="l_cen" class="left_div"></div>
		<div id="l_bot" class="left_div" style="margin-bottom:0px;"></div>
	</div>
	<div id="center" style="float:left;margin:47px 0px 10px 0px;width:39%;">
		<div id="c_top" class="left_div" style="height:10%;">
			<div>
				<div style="padding:2px 2px;text-align:center;width:20%;float:left;font-size:14px;line-height:18px;">
					<label id="cen_01" style="padding:2px;color:#c12e34;"></label><br/>
					<label>调解案件总数</label>
				</div>
				<div style="padding:2px 0px;text-align:center;width:20%;float:left;font-size:14px;line-height:18px;">
					<label id="cen_02" style="padding:2px;color:#e87c25;"></label><br/><label>人民调解员总数</label>
				</div>
				<div style="padding:2px 2px;text-align:center;width:20%;float:left;font-size:14px;line-height:18px;">
					<label id="cen_03" style="padding:2px;color:#fad860;"></label><br/><label>调委会总数</label>
				</div>
				<div style="padding:2px 2px;text-align:center;width:20%;float:left;font-size:14px;line-height:18px;">
					<label id="cen_04" style="padding:2px;color:#7bd9a5;"></label><br/><label>调解成功总数</label>
				</div>
				<div style="padding:2px 2px;text-align:center;width:20%;float:left;font-size:14px;line-height:18px;">
					<label id="cen_05" style="padding:2px;color:#005eaa;"></label><br/><label>协议涉及金额</label>
				</div>
			</div>
		</div>
		<div id="c_cen" class="left_div" style="height:48%;"></div>
		<div id="c_bot" class="left_div" style="margin-bottom:0px;"></div>
	</div>
	<div id="right" style="float:left;margin:10px;width:29%;margin-top:40px;">
		<div id="r_top" class="left_div" style="height:60.6%;"></div>
		<div id="r_bot" class="left_div" style="margin-bottom:0px;"></div>
	</div>
	
</div>
</body>


</html>