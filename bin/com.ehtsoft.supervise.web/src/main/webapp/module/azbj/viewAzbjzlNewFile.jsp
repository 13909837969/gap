<%@ page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>

<html>
<head>
<title>安置帮教总览界面_新</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<jsp:include page="../ltrhao-common.jsp"></jsp:include>

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
	tjqk();//全区人员衔接途径情况
	bxqk();//全年安置帮教人员表现情况
	lx();//全区安置帮教类型曲线图
	shtjqk();//全区安置帮教获得社会救助统计情况
	zbqk(); //全区安置帮教安置方式占比情况
	bjqk();//全区解除安置帮教情况
	dt();//地图
});	
	
	
function tjqk(){
	var dom = document.getElementById("left_top");
	var myChart = echarts.init(dom);
	
	option = null;
	option = {
			title: {
		        text: '全区人员衔接途径情况',
		        link:'http://www.baidu.com',
		        textStyle: {
                    fontSize: 12,
                    align: 'left',
                	color:'#fff'
                }
		        
		    },
		    dataset: {
		        source: [
		            ['score', '人', 'product'],
		            [300, 58212, '公安机关落实管控'],
		            [400, 78254, '看守所刑满释放'],
		            [490, 41032, '监狱刑满释放'],
		            [510, 12755, '解除社区矫正'],
		         
		        ]
		    },
		    grid: {
		    	containLabel: true,
		    	top: '20%',
		    	left: '3%',
		    	right: '8%',
		    	bottom: '8%'
		    },
		    xAxis: {
		    	name: '人',
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
		    	},
		    yAxis: {
		    	type: 'category',
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
		    	},
		   
		    series: [
		        {
		            type: 'bar',
		            encode: {
		                // Map the "amount" column to X axis.
		                x: 'amount',
		                // Map the "product" column to Y axis
		                y: 'product'
		            }
		        }
		    ]
		};

	
	if (option && typeof option === "object") {
	    myChart.setOption(option, true);
	}
}

	
	

function bxqk(){
	var dom = document.getElementById("left_bot");
	var myChart = echarts.init(dom);
	
	option = null;
	option = {
	    title: {
	        text: '全年安置帮教人员表现情况',
	        link:'http://www.baidu.com',
	        textStyle: {
                fontSize: 12,
                align: 'left',
            	color:'#fff'
            }
	    },
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
	        data:['好','一般','不好'],
	        top: '15%',
	        left: '26%',
	        right: '4%',
	        bottom: '3%',
	        containLabel: true
	    },
	    grid: {
	    	top: '35%',
	        left: '3%',
	        right: '4%',
	        bottom: '3%',
	        containLabel: true
	    },
	    xAxis : [
	        {
	            type : 'category',
	            boundaryGap : false,
	            data : ['1月	','2月','3月','4月','5月','6月','7月','8月','9月','10月','11月','12月'],
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
	        }
	    ],
	    yAxis : [
	        {
	            type : 'value',
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
	            name:'好',
	            type:'line',
	            stack: '总量',
	            areaStyle: {normal: {}},
	            data:[120, 132, 101, 134, 90, 230, 210, 132, 101, 134, 90, 230]
	        },
	        {
	            name:'一般',
	            type:'line',
	            stack: '总量',
	            areaStyle: {normal: {}},
	            data:[220, 182, 191, 234, 290, 330, 310, 182, 191, 234, 290, 330]
	        },
	        {
	            name:'不好',
	            type:'line',
	            stack: '总量',
	            areaStyle: {normal: {}},
	            data:[150, 232, 201, 154, 190, 330, 410, 232, 201, 154, 190, 330]
	        },
	       
	           /*  areaStyle: {normal: {}}, */
	            /* data:[820, 932, 901, 934, 1290, 1330, 1320, 932, 901, 934, 1290, 1330]  */
	        /* } */
	    ]
	};
	if (option && typeof option === "object") {
	    myChart.setOption(option, true);
	}
	
}


function lx(){
	var dom = document.getElementById("cen_bot");
	var myChart = echarts.init(dom);
	
	option = null;
	option = {
		    title: {
		        text: '全区安置帮教类型曲线图',
		        link:'http://www.baidu.com',
		        textStyle: {
	                fontSize: 12,
	                align: 'left',
	               	color:'#fff'
	            }
		    },
		    tooltip: {
		        trigger: 'axis'
		    },
		    legend: {
		        data:['重点帮教对象','一般帮教对象'],
		        top: '15%',
		        left: '26%',
		        right: '4%',
		        bottom: '3%',
		        containLabel: true, 
		        textStyle: {
		            color: '#fff'
		        },
		    },
		    grid: {
		        left: '3%',
		        right: '4%',
		        bottom: '3%',
		        containLabel: true
		    },
		   
		    xAxis: {
		        type: 'category',
		        boundaryGap: false,
		        data : ['1月	','2月','3月','4月','5月','6月','7月','8月','9月','10月','11月','12月'],
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
		    },
		    yAxis: {
		        type: 'value',
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
		    },
		    series: [
		        {
		            name:'重点帮教对象',
		            type:'line',
		            stack: '总量',
		            data:[120, 132, 101, 134, 90, 230, 210, 132, 101, 134, 90, 230]
		        },
		        {
		            name:'一般帮教对象',
		            type:'line',
		            stack: '总量',
		            data:[220, 182, 191, 234, 290, 330, 310, 182, 191, 234, 290, 330]
		        },
		    ]
		};

	
	if (option && typeof option === "object") {
	    myChart.setOption(option, true);
	}
}


function shtjqk(){
	var dom = document.getElementById("right_top");
	var myChart = echarts.init(dom);
	
	option = null;
	option = {
		    title : {
		        text: '全区安置帮教获得社会救助统计情况',
		        x:'left',
		        link:'http://www.baidu.com',
		        textStyle: {
	                fontSize: 12,
	                align: 'left',
	            	color:'#fff'
	            }
		    },
		    grid: {
		    	top: '30%',
		        left: '3%',
		        right: '4%',
		        bottom: '3%',
		        containLabel: true
		    },
		    tooltip : {
		        trigger: 'item',
		        formatter: "{a} <br/>{b} : {c} ({d}%)"
		    },
		    legend: {
		        orient: 'vertical',
		        left: 'left',
		        data: ['落实最低生活保障','落实特困人员供养','落实医疗救助','落实教育救助','落实住房救助','其他'],
		        textStyle: {
	                fontSize: 10,
	                align: 'left',
	                color: '#fff'
	            },
	            top: '15%',
		    },
		    series : [
		        {
		            name: '统计情况',
		            type: 'pie',
		            radius : '60%', 
		            center: ['60%', '60%'],
		            avoidLabelOverlap: false,
		            data:[
		                {value:120, name:'落实最低生活保障'},
		                {value:200, name:'落实特困人员供养'},
		                {value:130, name:'落实医疗救助'},
		                {value:210, name:'落实教育救助'},
		                {value:260, name:'落实住房救助'},
		                {value:80, name:'其他'}
		            ],
		            label: {
		                normal: {
		                    show: true,
		                    formatter: "{d}%", // / {d}%
		                    position: "outer"
		                }
		            },
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


function zbqk(){
	var dom = document.getElementById("right_cen");
	var myChart = echarts.init(dom);
	
	option = null;
	option = {
			title : {
		        text: '全区安置帮教安置方式占比情况',
		        x:'left',
		        link:'http://www.baidu.com',
		        textStyle: {
	                fontSize: 12,
	                align: 'left',
	            	color:'#fff'
	            }
		    },
		    tooltip: {
		        trigger: 'item',
		        formatter: "{a} <br/>{b}: {c} ({d}%)"
		    },
		   /*  legend: {
		        orient: 'vertical',
		        x: 'left',
		        data:['直接访问','邮件营销','联盟广告','视频广告','搜索引擎']
		    }, */
		    series: [
		        {
		            name:'占比情况',
		            type:'pie',
		            radius: ['50%', '70%'],
		            center: ['50%', '60%'],
		            avoidLabelOverlap: false,  
		             
		            /* label: {
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
		            }, */
		            data:[
		                {value:335, name:'从事个体经营'},
		                {value:310, name:'落实责任田'},
		                {value:234, name:'公益性岗位安置'},
		                {value:135, name:'自主创业'},
		                {value:1548, name:'企业户和经济实体吸纳就业'}
		           
		            ]
		        }  
		    ]
		};
	if (option && typeof option === "object") {
	    myChart.setOption(option, true);
	}

}


function bjqk(){
	var dom = document.getElementById("right_bot");
	var myChart = echarts.init(dom);
	
	option = null;
	option = {
			title : {
		        text: '全区解除安置帮教情况',
		        x:'left',
		        link:'http://www.baidu.com',
		        textStyle: {
	                fontSize: 12,
	                align: 'left',
	            	color:'#fff'
	            }
		    },
		    grid: {
		    	top: '30%',
		        left: '3%',
		        right: '8%',
		        bottom: '3%',
		        containLabel: true 
		    },
		    /* backgroundColor: '#011c3a',     */
		    xAxis: {
		        data: ['呼和浩特市', '包头市', '乌海市', '通辽市', '乌兰察布市', '巴彦淖尔市', '赤峰市', '兴安盟', '锡林郭勒盟'],
		        
		        axisLine: {
		            lineStyle: {
		                color: '#0177d4'
		            }
		        },
		        axisLabel: {
		            color: '#fff',
		            fontSize: 10
		        }
		    },
		    yAxis: {
		        name: "人",
		        nameTextStyle: {
		            color: '#fff',
		            fontSize: 10
		        },
		        axisLine: {
		            lineStyle: {
		                color: '#0177d4'
		            }
		        },
		        axisLabel: {
		            color: '#fff',
		            fontSize: 10
		        },
		        splitLine: {
		            show:false,
		            lineStyle: {
		                color: '#0177d4'
		            }
		        },
		        interval:100,
		        max:500

		    },
		    series: [{
		        type: 'bar',
		        barWidth: 18, 
		        itemStyle:{
		            normal:{
		                color:new echarts.graphic.LinearGradient(0, 0, 0, 1, [{
		                    offset: 0,
		                    color: '#00b0ff'
		                }, {
		                    offset: 0.8,
		                    color: '#7052f4'
		                }], false)
		            }
		        },
		        data: [450, 300, 220, 300, 350, 200, 470, 200, 320]
		    }]
		};
	
	if (option && typeof option === "object") {
	    myChart.setOption(option, true);
	}
}



function dt(res) {
    var dom = document.getElementById("cen_top");
    var myChart = echarts.init(dom,'infographic');
    var app = {};
    option = null;
    myChart.showLoading();

    $.get('nmg.json', function(geoJson) {

        myChart.hideLoading();

        echarts.registerMap('NMG', geoJson);

        myChart.setOption(option = {
            
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


function change()  
{  
   var x = document.getElementById("first");  
   var y = document.getElementById("second");  
   y.options.length = 0; // 清除second下拉框的所有内容  
   if(x.selectedIndex == 0)  
   {  
        y.options.add(new Option("呼和浩特市", "0"));  
        y.options.add(new Option("包头市", "1", false, true));  // 默认选中省会城市  
   }  
  
   /* if(x.selectedIndex == 1)  
   {  
        y.options.add(new Option("深圳", "0"));  
        y.options.add(new Option("广州", "1", false, true));  // 默认选中省会城市  
        y.options.add(new Option("肇庆", "2"));  
   }   */
  
}  



</script>



<style type="text/css"> 

.left_div{height:29.5%;border: 1px solid #005eaa;border-radius: 4px;box-shadow: 0 1px 3px rgba(0,0,0,.1);padding: 5px;margin-bottom:10px;}
.zhong_div{height:29.5%;border: 2px solid #005eaa;border-radius: 4px;box-shadow: 0 1px 3px rgba(0,0,0,.1);padding:5px;margin-bottom:10px;}

a:link {color: #FFFFFF;text-decoration: none;}
a:visited {color: #FFFFFF}
a:hover {color: #FFFFFF}
a:active {color: #FFFFFF}
 

</style> 
</head>
<body background="bg.png">


<div>
	<div id="left" style="float:left;margin:10px;width:29%;margin-top:40px;">
		<div id="left_top" class="left_div">
		</div>  
		<div id="left_cen" class="left_div">
			<div style="align:left;"><a href="http://www.baidu.com">全区人员衔接情况</a></div>
			<div id="1" class="zhong_div" style="float:left;border-color:green;margin:12px;width:43%;margin-top:20px;">
				<div style="color:white;float:right">衔接<br>2000</div>
			</div>   
			<div id="2" class="zhong_div" style="float:left;border-color:blue;margin:12px;width:43%;margin-top:20px;">
				<div style="color:white;float:right;">未衔接<br>5300</div>
			</div> 
			<div id="3" class="zhong_div" style="float:left;border-color:orange;margin:12px;width:43%;margin-top:15px;">
				<div style="color:white;float:right;">退回<br>2000</div>
			</div>   
			<div id="4" class="zhong_div" style="float:left;border-color:yellow;margin:12px;width:43%;margin-top:15px;">
				<div style="color:white;float:right;">必接必送<br>2000</div>
			</div> 
			   
			 
			
		</div>
		<div id="left_bot" class="left_div" style="margin-bottom:0px;"></div>
	</div>
	<div id="center" style="float:left;margin:47px 0px 10px 0px;width:39%;">
					 
		<div style="position: absolute;color:white;margin-left:260px;margin-top:15px;height:5px;margin-bottom:30px;">地区：  	   
			<select id="first" onChange="change()" style="background-color:black;color:white;"> 
				<option selected="selected" style="background-color:black;color:white;">内蒙古自治区</option>
			</select> 
			<select id="second" style="background-color:black;color:white;">
				<option selected="selected" style="background-color:black;color:white;">所属盟市</option>
				<option style="background-color:black;color:white;">呼和浩特市</option>
				<option style="background-color:black;color:white;">包头市</option> 
				<option style="background-color:black;color:white;">乌海市</option>
				<option style="background-color:black;color:white;">赤峰市</option>
				<option style="background-color:black;color:white;">通辽市</option>
				<option style="background-color:black;color:white;">鄂尔多斯市</option>
				<option style="background-color:black;color:white;">呼伦贝尔市</option>
				<option style="background-color:black;color:white;">巴彦淖尔市</option> 
				<option style="background-color:black;color:white;">乌兰察布市</option>
				<option style="background-color:black;color:white;">兴安盟</option>
				<option style="background-color:black;color:white;">锡林郭勒盟</option>
				<option style="background-color:black;color:white;">阿拉善盟</option>
			</select>
		</div>
		
		<div style="position: absolute;width:230px;height:15px;color:white;margin-top:50px;margin-left:15px;">
			截止2018年4月10日，安置帮教对象共计21652人，已衔接19873人，未衔接2185人
		</div>		 
					  
		<div id="cen_top" class="left_div" style="height:60%;"></div>
		<div id="cen_bot" class="left_div" style="margin-bottom:0px;"></div>
	</div>
	<div id="right" style="float:left;margin:10px;width:29%;margin-top:40px;">
		<div id="right_top" class="left_div" style="height:30%;"></div>
		<div id="right_cen" class="left_div" style="height:30%;"></div>
		<div id="right_bot" class="left_div" style="margin-bottom:0px;"></div>
	</div>
	
</div>
</body>


</html>