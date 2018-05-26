<%@ page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>

<html>
<head>
<title>全民社区矫正总览界面_新</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<script type="text/javascript" src="${localCtx}/json/SqjzzlNewService.js"></script>

<script type="text/javascript" src="http://echarts.baidu.com/gallery/vendors/echarts/echarts.min.js"></script>
<script type="text/javascript" src="http://echarts.baidu.com/gallery/vendors/echarts-gl/echarts-gl.min.js"></script>
<script type="text/javascript" src="http://echarts.baidu.com/gallery/vendors/echarts-stat/ecStat.min.js"></script>
<script type="text/javascript" src="http://echarts.baidu.com/gallery/vendors/echarts/extension/dataTool.min.js"></script>
<script type="text/javascript" src="http://echarts.baidu.com/gallery/vendors/echarts/map/js/china.js"></script>
<script type="text/javascript" src="http://echarts.baidu.com/gallery/vendors/echarts/map/js/world.js"></script>
<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=ZUONbpqGBsYGXNIYHicvbAbM"></script>
<script type="text/javascript" src="http://echarts.baidu.com/gallery/vendors/echarts/extension/bmap.min.js"></script>
<script type="text/javascript" src="http://echarts.baidu.com/gallery/vendors/simplex.js"></script>
<script type="text/javascript" src="../rmtj/shine.js"></script>
<script type="text/javascript" src="../rmtj/infographic.js"></script>


<script type="text/javascript">
$(function(){
	var sqjzzl = new SqjzzlNewService();
	
	var jzzs_list = [];
	/* sqjzzl.find_jzzs(new Eht.Responder({
		success:function(data){
			jzzs_list = data;
			if(jzzs_list != null){
				jzzs(jzzs_list);  //矫正人员总数
			}
		}
	})); */
	var jyjz_list = [];
	var syqk_list = [];
	var ssjk_list = [];
	var flqk_list = [];
	var jcqk_list = [];
	var zmqk_list = [];
	
	
	
	jzzs(jzzs_list);
	jyjz(jyjz_list);
	syqk(syqk_list);
	ssjk(ssjk_list);
	flqk(flqk_list);
	jcqk(jcqk_list);
	zmqk(zmqk_list);
 
});

function jzzs(jzzs_list){
	var dom = document.getElementById("l_top");
	var myChart = echarts.init(dom,'shine');
	
	/* var x_data = [];    //月份 
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
	} */
	
	option = {
		    tooltip : {
		        trigger: 'axis',
		        axisPointer: {
		            type: 'shadow'
		        }
		    },
		    grid: {
		    	top: '3%',
		    	left: '3%',
		        right: '8%',
		        bottom: '3%',
		        containLabel: true
		    },
		    xAxis : [
		        {
		            type : 'value',
		            boundaryGap : true,
		            axisLine: {
		            	show: false
		            },
		            axisLabel: {
		            	formatter: '{value}人',
		            	textStyle: {
		                    color: '#fff'
		                }
		            },
		            axisTick: {
		            	show: false
		            },
		            splitLine: {
		                show: false
		            },
		            
		        }
		    ],
		    yAxis : [
		        {
		            type : 'category',
		            splitLine: {show: false},
		            data : ['宽管','普管','严管'],
		            axisLine: {
		            	show: false
		            },
		            axisLabel: {
		            	textStyle: {
		                    color: '#fff'
		                }
		            },
		            axisTick: {
		            	show: false
		            }
		        }
		    ],
		    series : [
		        {
		            type:'bar',
		            z: 3,
		            itemStyle: {
		                normal: {
		                    color: {
		                        type: 'linear',
		                        x: 0,
		                        y: 0,
		                        x2: 1,
		                        y2: 1,
		                        colorStops: [{
		                            offset: 0,
		                            color: '#00d386' // 0% 处的颜色
		                        }, {
		                            offset: 1,
		                            color: '#0076fc' // 100% 处的颜色
		                        }],
		                        globalCoord: false // 缺省为 false
		                    },
		                    barBorderRadius: 15,
		                }
		            },
		            barWidth: '20%',
		            data:['20','30','50']
		        }
		    ]
		};
	
	if (option && typeof option === "object") {
	    myChart.setOption(option, true);
	}
}

//教育矫正
function jyjz(jyjz_list){
	var dom = document.getElementById("l_cen");
	var myChart = echarts.init(dom,'shine');
	
	/* var y_data = [];    //案件来源类型
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
	} */
	
	option = null;
	option = {
		    tooltip: {
		        trigger: 'axis'
		    },
		    legend: {
		    	type: 'scroll',
		    	pageIconColor: '#fff',
		    	pageTextStyle: {
		    		color: '#fff'
		    	},
		    	textStyle: {
		            color: '#fff'
		        },
		        data:['集中教育','个别教育']

		    },
		    grid: {
		    	top: '20%',
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
		                show: false
		            },
		            data : ['2月','4月','6月','8月','10月']
		        }
		    ],
		    yAxis : [
		        {
		        	type: 'value',
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
		                show: false
		            }
		        }
		    ],
		    series : [
		    	{
		            name:'集中教育',
		            type:'line',
		            data:['10','20','15','25','30']
		        },
		        {
		            name:'个别教育',
		            type:'line',
		            data:['20','25','10','15','22']
		        }
		    ]
		};
	
	if (option && typeof option === "object") {
	    myChart.setOption(option, true);
	}
}
//全年服刑人员使用情况
function syqk(syqk_list){
	var dom = document.getElementById("l_bot");
	var myChart = echarts.init(dom,'shine');
	
	/* var y_data = [];    //案件来源类型
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
	} */
	
	option = null;
	option = {
			tooltip : {
		        trigger: 'axis',
		        axisPointer: {
		            type: 'cross',
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
		    	textStyle: {
		            color: '#fff'
		        },
		        data:['报警人员','矫正人员使用app情况','三天内未登录人员总数']

		    },
		    grid: {
		    	top: '20%',
		    	left: '3%',
		        right: '4%',
		        bottom: '3%',
		        containLabel: true
		    },
		    xAxis : [
		        {
		            type : 'category',
		            boundaryGap : false,
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
		                show: false
		            },
		            data : ['2月','4月','6月','8月','10月']
		        }
		    ],
		    yAxis : [
		        {
		        	type: 'value',
		            min: 0,
		            max: 100,
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
		                show: false
		            }
		        }
		    ],
		    series : [
		    	{
		            name:'报警人员',
		            type:'line',
		            stack: '使用总数',
		            areaStyle: {normal: {}},
		            data:['10','20','15','25','30']
		        },
		        {
		            name:'矫正人员使用app情况',
		            type:'line',
		            stack: '使用总数',
		            areaStyle: {normal: {}},
		            data:['20','25','10','15','22']
		        },
		        {
		            name:'三天内未登录人员总数',
		            type:'line',
		            stack: '使用总数',
		            areaStyle: {normal: {}},
		            data:['15','28','20','30','10']
		        }
		    ]
		};
	
	if (option && typeof option === "object") {
	    myChart.setOption(option, true);
	}
}

//地图
function ssjk(ssjk_list) {
    var dom = document.getElementById("c_cen");
    var myChart = echarts.init(dom,'shine');//,'infographic'
    var app = {};
    option = null;
    myChart.showLoading();

    $.get('../rmtj/nmg.json', function(geoJson) {

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

//社区服刑人员分类情况
function flqk(flqk_list){
	var dom = document.getElementById("r_top");
	var myChart = echarts.init(dom,'shine');
	/* var x_data = [];    //城市名 
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
	} */
	
	option = null;
	option = {
		    tooltip : {
		    	trigger: 'item',
		        formatter: "{a} <br/>{b}: {c} ({d}%)"
		    },
		    legend: {
		    	type: 'scroll',
		        orient: 'vertical',
		        left: 'left',
		        pageIconColor: '#fff',
		    	pageTextStyle: {
		    		color: '#fff'
		    	},
		        textStyle: {
		            color: '#fff'
		        },
		        data:["按户籍","文化程度","性别","年龄","民族","就业就学情况"]
		        //selected: selected
		    },
		    series : [
		    	{
		            name:'人员分类情况',
		            type:'pie',
		            radius: '55%',
		            center: ['63%', '60%'],
		            avoidLabelOverlap: false,
		            label: {
		                normal: {
		                    show: true,
		                    formatter: "{d}%", // / {d}%
		                    position: "outer"
		                }
		            },
		            labelLine: {
		                normal: {
		                    show: true
		                }
		            },
		            data:[
		            	{value:20,name:'按户籍'},
		            	{value:30,name:'文化程度'},
		            	{value:40,name:'性别'},
		            	{value:50,name:'年龄'},
		            	{value:60,name:'民族'},
		            	{value:70,name:'就业就学情况'}
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
	
	if (option && typeof option === "object") {
	    myChart.setOption(option, true);
	}
}

//奖惩情况
function jcqk(jcqk_list){
	var dom = document.getElementById("r_cen");
	var myChart = echarts.init(dom,'shine');

	/* var y_data = [];    //纠纷类型
	var lx_data = [];    //[纠纷数量]
	
	if(ajjf_list != null){
		for(var i=0; i<ajjf_list.length; i++){
			y_data.push(ajjf_list[i].jflx);
			lx_data.push(ajjf_list[i].cnt);
		}
	}
	 */
	option = null;
	option = {
		    tooltip : {
		        trigger: 'item',
		        formatter: "{a} <br/>{b}: {c} ({d}%)"
		    },
		    series : [
		    	{
		            name:'奖惩情况',
		            type:'pie',
		            radius: ['40%', '60%'],
		            center: ['50%', '55%'],
		            avoidLabelOverlap: false,
		            label: {
		                normal: {
		                    show: true,
		                    formatter: "{b}", // / {d}%
		                    position: "outer"
		                }
		            },
		            labelLine: {
		                normal: {
		                    show: true
		                }
		            },
		            data:[
		            	{value:20,name:'治安'},
		            	{value:30,name:'警告'},
		            	{value:40,name:'撤销.缓刑.假释'},
		            	{value:50,name:'减刑'},
		            	{value:60,name:'暂予监外执行人员'}
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
	
	if (option && typeof option === "object") {
	    myChart.setOption(option, true);
	}
}
//全区服刑人员罪名情况
function zmqk(zmqk_list){
	var dom = document.getElementById("r_bot");
	var myChart = echarts.init(dom,'shine');
	
	/* var x_data = [];    //月份 
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
	} */
	
	option = null;
	option = {
			tooltip : {
		        trigger: 'axis',
		        axisPointer: {
		            type: 'cross',  //shadow
		            label: {
		                backgroundColor: '#6a7985'
		            }
		        }
		    },
		    grid: {
		    	top: '10%',
		    	left: '3%',
		        right: '3%',
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
		            data : ['故意伤害罪','抢劫','诈骗罪','寻衅滋事','非法拘禁','盗窃','聚众斗殴','交通肇事','强奸','其他'],
		            axisTick: {
		                alignWithLabel: true
		            }
		        }
		    ],
		    yAxis : [
		        {
		        	type: 'value',
		            /* min: 0,
		            max: 50,
		            interval: 10, */
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
		            name:'罪名情况',
		            type:'bar',
		            barWidth: '30%',
		            data:[30,31,32,33,34,35,36,37,38,39,40]
		        }
		    ]
		};
	
	if (option && typeof option === "object") {
	    myChart.setOption(option, true);
	}
}

</script>

<style type="text/css"> 
body{height:100%;background-image: url(../rmtj/bg.png);color: #fff;}

.left_div_a{height:29.5%;width:100%;margin-bottom:10px;}
.left_div_a a{color:#fff;height:14px;line-height:18px;}  /* border-bottom:2px solid #ef3838; border-radius: 4px;box-shadow: 0 1px 3px rgba(0,0,0,.1);*/

.left_div{height:90%;border-top: 1px solid #005eaa;border-bottom: 1px solid #005eaa;padding: 5px;}



/* .left_div a:before{content:""; width:1px; height:2px; position:absolute; bottom:-2px; right:-1px;} */

.bot_div{width:25%;height:35%;border: 3px solid #59c4e6;border-radius: 8px;margin:10px 20px;float:left;}

</style> 

</head>
<body>
<div>  <!--background-color:#191970;  color: #fff;text-shadow: 1px 1px 2px #333;-->
	<div id="left" style="float:left;margin:10px;width:29%;margin-top:40px;padding:0px 5px;">
		<div class="left_div_a">
			<a href="#">矫正人员总数</a><br/>
			<div class="left_div">
				<div style="height:100%;width:30%;float:left;">
					<div style="width:90%;height:35%;border: 3px solid #59c4e6;border-radius: 8px;margin:45% 0px;">
					</div>
				</div>
				<div id="l_top" style="height:100%;width:70%;float:right;border-left: 1px solid #005eaa;"></div>
			</div>
		</div>
		<div class="left_div_a">
			<a href="#">教育矫正</a><br/>
			<div id="l_cen" class="left_div"></div>
		</div>
		<div class="left_div_a">
			<a href="#">全年服刑人员使用情况</a><br/>
			<div id="l_bot" class="left_div" style="margin-bottom:0px;border-bottom: 0px"></div>
		</div>
	</div>
	<!--  -->
	<div id="center" style="float:left;margin:57.6px 0px 10px 0px;width:39%;padding:0px 5px;">
		<div id="c_cen" class="left_div" style="height:57.8%;margin-bottom:10px;border: 1px solid #005eaa;border-radius: 4px;"></div>
		<div class="left_div_a">
			<a href="#">各类社区服刑人员情况</a><br/>
			<div id="c_bot" class="left_div" style="margin-bottom:0px;border-bottom: 0px;">
				<div class="bot_div"></div>
				<div class="bot_div"></div>
				<div class="bot_div"></div>
				<br/>
				<div class="bot_div"></div>
				<div class="bot_div"></div>
				<div class="bot_div"></div>
			</div>
		</div>
	</div>
	<div id="right" style="float:left;margin:10px;width:29%;margin-top:40px;padding:0px 5px;">
		<div class="left_div_a">
			<a href="#">社区服刑人员分类情况</a><br/>
			<div id="r_top" class="left_div"></div>
		</div>
		<div class="left_div_a">
			<a href="#">奖罚情况</a><br/>
			<div id="r_cen" class="left_div"></div>
		</div>
		<div class="left_div_a">
			<a href="#">全年服刑人员罪名情况</a><br/>
			<div id="r_bot" class="left_div" style="margin-bottom:0px;border-bottom: 0px;"></div>
		</div>
	</div>
	
</div>
</body>


</html>