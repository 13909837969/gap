<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>刑事法律援助（盟市）</title>
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<script type="text/javascript"  src="http://echarts.baidu.com/gallery/vendors/echarts/extension/bmap.min.js"></script>
<style type="text/css">
	.row {
    margin-right: 0px;
    margin-left: 0px;
    }
    .top_div_in{
	    height:30px; 
	    color:#d9d9d9; 
	    text-align:center;
	    border-radius: 5px;
    }
	#btn_ss{
		background-color: #0d9bff;
		color: #fff;
		font-size: 18px;
	}

	#top_div1 div{
		float: left;
		padding: 0 10px;
	}
	#top_div1 div{
		float: left;
	    margin: 0 8px;
	    margin-bottom: 19px;
	}
	#top_div3 div{
		float: left;
	    margin: 0 8px;
	    margin-bottom: 19px;
	    font-size: 20px;
	    padding: 4px 20px;
	    color: white;
	}
	
	#top_div4 div{
		float: left;
	    margin: 0 8px;
	    margin-bottom: 19px;
	    font-size: 20px;
	    background-color: #f2f2f2;
	    padding: 4px 20px;
	}
	
	.backcolor{
	 background-color: #f2f2f2;
	}
</style>
</head>
<script type="text/javascript">
$(function() {
	/* 刑事法律援助 */
	var t1 =  echarts.init(document.getElementById('xsflyz'));
	option = {
    /* title : {
        text: '刑事法律援助',
        borderColor:'#fff',
        textStyle: {
            color: '#fff'       
        }
    }, */
    tooltip : {
        trigger: 'axis'
    },
    legend: {
        data:['2016','2017'],
        borderColor:'#fff',
        textStyle: {
            color: '#fff'       
        }
    },
    toolbox: {
        show : true,
        feature : {
            dataView : {show: false, readOnly: false},
            magicType : {show: true, type: ['line', 'bar']},//折线、柱状图的切换
            restore : {show: true},//刷新
            saveAsImage : {show: false} //转存图片
        }
    },
    calculable : true,
    xAxis : [
        {
            type : 'category',
            data : ['呼和浩特','包头','乌海','通辽','赤峰','乌兰察布','鄂尔多斯','巴彦淖尔','呼伦贝尔','锡林郭勒','阿拉善盟','兴安盟'],
            axisLabel: {
                show: true,
                textStyle: {
                    color: '#fff'
                }
            },
            axisLine:{
                lineStyle:{
                    color:'#fff',
                    width:1,
                }
            }
        }
    ],
    yAxis : [
        {
            type : 'value',
            axisLabel: {
                show: true,
                textStyle: {
                    color: '#fff'
                }
            },
            axisLine:{
                lineStyle:{
                    color:'#fff',
                    width:1,
                }
            }
        }
    ],
    series : [
        {
            name:'2016',
            type:'bar',
            itemStyle:{
                normal:{
                    color:'#0d9bff'
                }
            },
            data:[2.0, 4.9, 7.0, 23.2, 25.6, 76.7, 13.6, 16.2, 32.6, 20.0, 6.4, 3.3],
        },
        {
            name:'2017',
            type:'bar',
            itemStyle:{
                normal:{
                    color:'#f5ce0c'
                }
            },
            data:[2.6, 5.9, 9.0, 26.4, 28.7, 70.7, 15.6, 18.2, 48.7, 18.8, 6.0, 2.3],
        }
    ]
};
	t1.setOption(option);
	
/* 刑事法律援助案件环比率 */	
	var t2 =  echarts.init(document.getElementById('xsflyzajhbl'));
	option1 = {
			  /*  title: {
			       text: "刑事法律援助案件环比率",
			       x: "center",
			        borderColor:'#fff',
			        textStyle: {
			            color: '#fff'       
			        }
			   }, */
			   tooltip: {
			       trigger: "item",
			       formatter: "{a} <br/>{b} : {c}"
			   },
			  
			   xAxis: [
			       {
			           type: "category",
			           splitLine: {show: false},
			           data: ["1月", "2月", "3月", "4月", "5月", "6月", "7月", "8月", "9月","10月","11月","12月"],
			           axisLabel: {
			                show: true,
			                textStyle: {
			                    color: '#fff'
			                }
			            },
			            axisLine:{
			                lineStyle:{
			                    color:'#fff',
			                    width:1,
			                }
			            }
			       }
			   ],
			   yAxis: [
			       {
			           type: "log",
			           name: "%",
			           axisLabel: {
			                show: true,
			                textStyle: {
			                    color: '#fff'
			                }
			            },
			            axisLine:{
			                lineStyle:{
			                    color:'#fff',
			                    width:1,
			                }
			            }
			       }
			   ],
			    toolbox: {
			       show: true,
			       feature: {
			           mark: {
			               show: true
			           },
			           dataView: {
			               show: false,
			               readOnly: true
			           },
			           restore: {
			               show: false
			           },
			           saveAsImage: {
			               show: false
			           }
			       }
			   },
			   calculable: true,
			   series: [
			       {
			           name: "3的指数",
			           type: "line",
			           data: [1, 3, 9, 27, 81, 247, 741, 2223, 6669, 741, 2223, 6669],
			           itemStyle:{
			                normal:{
			                    color:'#0d9bff'
			                }
			            },

			       }
			      
			   ]
			};
	t2.setOption(option1);	
	/* 案件分类情况 */
	var t3 = echarts.init(document.getElementById('ajflqk'));
	option2 ={
		    /* title : {
		        text: '案件分类情况',
		        borderColor:'#fff',
		        textStyle: {
		            color: '#fff'       
		        }
		    }, */
		    tooltip : {
		        trigger: 'axis'
		    },
		    legend: {
		        data:['2016','2017'],
		        borderColor:'#fff',
		        textStyle: {
		            color: '#fff'       
		        }
		    },
		    toolbox: {
		        show : true,
		        feature : {
		            dataView : {show: false, readOnly: false},
		            magicType : {show: true, type: ['line', 'bar']},//折线、柱状图的切换
		            restore : {show: true},//刷新
		            saveAsImage : {show: false} //转存图片
		        }
		    },
		    calculable : true,
		    xAxis : [
		        {
		            type : 'category',
		            data : ['妇女','农牧民','农牧民工','少数民族','军人均属','残疾人','外国人或无国籍人','老年人','未成年人'],
		            axisLabel: {
		                show: true,
		                textStyle: {
		                    color: '#fff'
		                }
		            },
		            axisLine:{
		                lineStyle:{
		                    color:'#fff',
		                    width:1,
		                }
		            }
		        }
		    ],
		    yAxis : [
		        {
		            type : 'value',
		            axisLabel: {
		                show: true,
		                textStyle: {
		                    color: '#fff'
		                }
		            },
		            axisLine:{
		                lineStyle:{
		                    color:'#fff',
		                    width:1,
		                }
		            }
		        }
		    ],
		    series : [
		        {
		            name:'2016',
		            type:'bar',
		            data:[ 13.6, 16.2, 32.6, 20.0, 6.4, 3.3,12.2,45.3,16.3],
		            itemStyle:{
		                normal:{
		                    color:'#0d9bff'
		                }
		            },
		        },
		        {
		            name:'2017',
		            type:'bar',
		            data:[ 15.6, 18.2, 48.7, 18.8, 6.0, 2.3,12.5,2.0,19.3],
		            itemStyle:{
		                normal:{
		                    color:'#f5ce0c'
		                }
		            },
		        }
		    ]
		};
		t3.setOption(option2);
		/* 刑事法律援助通知辩护案件 */
		var t4 = echarts.init(document.getElementById('xsflyztzbhaj1'));
		option3 = {
			    /* title : {
			        text: '刑事法律援助通知辩护案件',
			        subtext: '按阶段分',
			        x:'center',
			        borderColor:'#fff',
			        textStyle: {
			            color: '#fff'       
			        }
			    }, */
			    tooltip : {
			        trigger: 'item',
			        formatter: "{a} <br/>{b} : {c} ({d}%)"
			    },
			    toolbox: {
			        show : true,
			        feature : {
			            mark : {show: true},
			            dataView : {show: true, readOnly: false},
			            magicType : {
			                show: true, 
			                type: ['pie', 'funnel'],
			                option: {
			                    funnel: {
			                        x: '25%',
			                        width: '50%',
			                        funnelAlign: 'left',
			                        max: 1548
			                    }
			                }
			            },
			            restore : {show: true},
			            saveAsImage : {show: true}
			        }
			    },
			    calculable : true,
			    series : [ 	
			        {
			            name:'访问来源',
			            type:'pie',
			            radius : '55%',
			            center: ['50%', '60%'],
			            data:[
			                {value:335, name:'侦查'},
			                {value:310, name:'审判'},
			                {value:234, name:'审查起诉'}
			            ]
			        }
			    ],
		        color: ['#1ce960','#a817ec','#0d9bff']
			};
			                    
		t4.setOption(option3);
		
		var t40 = echarts.init(document.getElementById('xsflyztzbhaj2'));
		option30 = {
		    title : {
		    	subtext: '按对象分',
		        x:'center',
		        borderColor:'#fff',
		        textStyle: {
		            color: '#fff'       
		        }
		    },
		    tooltip : {
		        trigger: 'axis'
		    },
		    legend: {
		        data:['2016','2017'],
		        x:'left',
		        borderColor:'#fff',
		        textStyle: {
		            color: '#fff'       
		        }
		    },
		    toolbox: {
		        show : true,
		        feature : {
		            dataView : {show: false, readOnly: false},
		            magicType : {show: true, type: ['line', 'bar']},//折线、柱状图的切换
		            restore : {show: true},//刷新
		            saveAsImage : {show: false} //转存图片
		        }
		    },
		    calculable : true,
		    xAxis : [
		        {
		            type : 'category',
		            data : ['妇女','农牧民','农牧民工','少数民族','军人 军属','尚未完全丧失辨认','残疾人','外国人或无国籍人','老年人','未成年人','其他'],
		            axisLabel: {
		                show: true,
		                textStyle: {
		                    color: '#fff'
		                }
		            },
		            axisLine:{
		                lineStyle:{
		                    color:'#fff',
		                    width:1,
		                }
		            }
		        }
		    ],
		    yAxis : [
		        {
		            type : 'value',
		            axisLabel: {
		                show: true,
		                textStyle: {
		                    color: '#fff'
		                }
		            },
		            axisLine:{
		                lineStyle:{
		                    color:'#fff',
		                    width:1,
		                }
		            }
		        }
		    ],
		    series : [
		        {
		            name:'2016',
		            type:'bar',
		            data:[ 13.6, 16.2, 32.6, 20.0, 6.4, 3.3,12.2,45.3,16.3],
		            itemStyle:{
		                normal:{
		                    color:'#0d9bff'
		                }
		            },
		        },
		        {
		            name:'2017',
		            type:'bar',
		            data:[ 15.6, 18.2, 48.7, 18.8, 6.0, 2.3,12.5,2.0,19.3],
		            itemStyle:{
		                normal:{
		                    color:'#f5ce0c'
		                }
		            },
		        }
		    ]
		};          
		t40.setOption(option30);
		/* 刑事法律援助申请案件 */
		var t5 = echarts.init(document.getElementById('yjajcbqk1'));
		option4 ={
				title : {
			        /* text: '刑事法律援助申请案件', */
			        subtext:'转交申请',
			        	 x: "center",
					        borderColor:'#fff',
					        textStyle: {
					            color: '#fff'       
					        }
			    },
			    tooltip : {
			        trigger: 'axis',
			        formatter: "{a} <br/>{b} : {c}"
			    },
			    legend: {
			        data:['2016','2017'],
			        x: "left",
			        borderColor:'#fff',
			        textStyle: {
			            color: '#fff'       
			        }
			    },
			    toolbox: {
			        show : true,
			        feature : {
			            dataView : {show: false, readOnly: false},
			            magicType : {show: true, type: ['line', 'bar']},//折线、柱状图的切换
			            restore : {show: true},//刷新
			            saveAsImage : {show: false} //转存图片
			        }
			    },
			    calculable : true,
			    xAxis : [
			        {
			            type : 'category',
			            data : ['公安机关','人民法院','人民检察院','其他','合计'],
			            axisLabel: {
			                show: true,
			                textStyle: {
			                    color: '#fff'
			                }
			            },
			            axisLine:{
			                lineStyle:{
			                    color:'#fff',
			                    width:1,
			                }
			            }
			        }
			    ],
			    yAxis : [
			        {
			            type : 'value',
			            axisLabel: {
			                show: true,
			                textStyle: {
			                    color: '#fff'
			                }
			            },
			            axisLine:{
			                lineStyle:{
			                    color:'#fff',
			                    width:1,
			                }
			            }
			        }
			    ],
			    series : [
			        {
			            name:'2016',
			            type:'bar',
			            data:[ 13.6, 16.2, 15.6,17.6,19.3],
			            itemStyle:{
			                normal:{
			                    color:'#0d9bff'
			                }
			            },
			        },
			        {
			            name:'2017',
			            type:'bar',
			            data:[ 13.6, 16.2, 15.6,17.6,19.3 ],
			            itemStyle:{
			                normal:{
			                    color:'#f5ce0c'
			                }
			            },
			        }
			    ]
			};
		t5.setOption(option4);
		
		
		var t0 = echarts.init(document.getElementById('yjajcbqk2'));
		option0 ={
			    title : {
			    	subtext:'直接申请',
			    	 x: "center",
				        borderColor:'#fff',
				        textStyle: {
				            color: '#fff'       
				        }
			    },
			    tooltip : {
			        trigger: 'axis'
			    },
			    legend: {
			        data:['2016','2017'],
			        x: "left",
			        borderColor:'#fff',
			        textStyle: {
			            color: '#fff'       
			        }
			    },
			    toolbox: {
			        show : true,
			        feature : {
			            dataView : {show: false, readOnly: false},
			            magicType : {show: true, type: ['line', 'bar']},//折线、柱状图的切换
			            restore : {show: true},//刷新
			            saveAsImage : {show: false} //转存图片
			        }
			    },
			    calculable : true,
			    xAxis : [
			        {
			            type : 'category',
			            data : ['犯罪嫌疑人','被告人','被害人','自诉人','合计'],
			            axisLabel: {
			                show: true,
			                textStyle: {
			                    color: '#fff'
			                }
			            },
			            axisLine:{
			                lineStyle:{
			                    color:'#fff',
			                    width:1,
			                }
			            }
			        }
			    ],
			    yAxis : [
			        {
			            type : 'value',
			            axisLabel: {
			                show: true,
			                textStyle: {
			                    color: '#fff'
			                }
			            },
			            axisLine:{
			                lineStyle:{
			                    color:'#fff',
			                    width:1,
			                }
			            }
			        }
			    ],
			    series : [
			        {
			            name:'2016',
			            type:'bar',
			            data:[13.6, 16.2, 15.6,17.6,19.3 ],
			            itemStyle:{
			                normal:{
			                    color:'#0d9bff'
			                }
			            },
			        },
			        {
			            name:'2017',
			            type:'bar',
			            data:[13.6, 16.2, 15.6,17.6,19.3 ],
			            itemStyle:{
			                normal:{
			                    color:'#f5ce0c'
			                }
			            },
			        }
			    ]
			};
		t0.setOption(option0);
		
		
		/* 行政法律援助案件同比率 */
		var t6 = echarts.init(document.getElementById('xzflyzajtbl'));
		option5={
			    /* title: {
			        text: '行政法律援助案件同比率',
			        borderColor:'#fff',
			        textStyle: {
			            color: '#fff'       
			        }
			    }, */
			    tooltip: {
			        trigger: 'axis'
			    },
			    toolbox: {
			        show: false,
			        feature: {
			            dataZoom: {
			                yAxisIndex: 'none'
			            },
			            dataView: {readOnly: false},
			            magicType: {type: ['line', 'bar']},
			            restore: {},
			            saveAsImage: {}
			        }
			    },
			    xAxis:  {
			        type: 'category',
			        boundaryGap: false,
			        data: ['2016年5月','2017年5月'],
			        axisLabel: {
		                show: true,
		                textStyle: {
		                    color: '#fff'
		                }
		            },
		            axisLine:{
		                lineStyle:{
		                    color:'#fff',
		                    width:1,
		                }
		            }
			    },
			    yAxis: {
			        type: 'value',
			        axisLabel: {
			            formatter: '{value} %',
			            axisLabel: {
			                show: true,
			                textStyle: {
			                    color: '#fff'
			                }
			            },
			            axisLine:{
			                lineStyle:{
			                    color:'#fff',
			                    width:1,
			                }
			            }
			        }
			    },
			    series: [
			        {
			            type:'line',
			            data:[1, -2],
			            itemStyle:{
			                normal:{
			                    color:'#0d9bff'
			                }
			            },
			        }
			    ]
			};
		t6.setOption(option5);
	});
</script>
<body>
	<div>
		<div class="row">
			<div class="col-md-5" id="top_div1">
			<div  style="background-color:#333;border-radius: 5px;margin-top: 10px;padding-top: 16px;" >
				<div  class="top_div_in"><input type="text" value="区域检索" style="width: 110px;"></div>
				<div  class="top_div_in"><input type="text" value="开始时间"></div>
				<div class="top_div_in"><input type="text" value="结束时间"></div>
				<div style="background-color: #0d9bff; border-radius: 5px;border-radius: 5px;">
				<a href="javascript:void(0);" id="btn_ss"  value="搜索">搜索</a>
				</div>
			</div>
			</div>
			<div class="col-md-7" id="top_div3">
			<div  style="margin-left: 13px;" >
				<div style="background-color:#333;border-radius: 5px;margin-right: 46px;"><p>挽回损失或获得利益</p><p style="margin-left: 20%;">156.4万元</p></div>
				<div style="background-color:#333;border-radius: 5px;margin-right: 46px;"><p>强制医疗通知代理案件 </p><p style="margin-left: 30%;">15件</p></div>
				<div style="background-color:#333;border-radius: 5px;margin-right: 46px;"><p>申请刑事案件援助</p><p style="margin-left: 30%;">156件</p></div>
				<div style="background-color:#333;border-radius: 5px;"><p>未结案件</p><p style="margin-left: 38%;">15件</p></div>
			</div>
			</div>
		</div>
		<div class="row">
			<div class="col-md-7">
			<div  style="background-color:#333;border-radius: 5px;" >
				<dvi style="color:white;margin-left: 44%;font-size: 20px;line-height: 2.2;"><b>刑事法律援助</b></dvi>
				<div id="xsflyz" style="width:100%;height:400px;" ></div>
			</div>
			</div>
			<div class="col-md-5" >
			<div  style="background-color:#333;border-radius: 5px;" >
				<dvi style="color:white;margin-left: 36%;font-size: 20px;line-height: 2.2;"><b>刑事法律援助案件环比率</b></dvi>
				<div id="xsflyzajhbl" style="width: 100%;height: 400px;"></div>
			</div>
			</div>
		</div>
		<div class="row" style="height: 20px;"></div>
		<div class="row">
			<div class="col-md-3">
			<div  style="background-color:#333;border-radius: 5px;" >
				<dvi style="color:white;margin-left: 36%;font-size: 20px;line-height: 2.2;"><b>案件分类情况</b></dvi>
				<div id="ajflqk"  style="width: 100%;height: 400px;"  calss="backcolor"></div>
			</div>
			</div>
			<div class="col-md-3">
			<div  style="background-color:#333;border-radius: 5px;" >
				<dvi style="color:white;margin-left: 23%;font-size: 20px;line-height: 2.2;"><b>刑事法律援助通知辩护案件</b></dvi>
				<div id="xsflyztzbhaj1" style="width: 100%;height: 200px;"  calss="backcolor"></div>
				<div id="xsflyztzbhaj2" style="width: 100%;height: 200px;"  calss="backcolor"></div>
			</div>
			</div>
			<div class="col-md-3">
			<div  style="background-color:#333;border-radius: 5px;" >
				<dvi style="color:white;margin-left: 27%;font-size: 20px;line-height: 2.2;"><b>刑事法律援助申请案件</b></dvi>
				<div id="yjajcbqk1" style="width: 100%;height: 200px;"  calss="backcolor"></div>
				<div id="yjajcbqk2" style="width: 100%;height: 200px;"  calss="backcolor"></div>
			</div>
			</div>
			<div class="col-md-3">
				<div  style="background-color:#333;border-radius: 5px;" >
				<dvi style="color:white;margin-left: 27%;font-size: 20px;line-height: 2.2;"><b>行政法律援助案件同比率</b></dvi>
				<div id="xzflyzajtbl" style="width: 100%;height: 300px;"  calss="backcolor"></div>
				</div>
				<div style="height: 10px;"></div>
				<div id="top_div4"  style="background-color:#333;border-radius: 5px;" >
				<div style="width: 100%;height: 90px;background-color:#333;border-radius: 5px;color: white;margin-left: 0;"><p>依申请案件批准合计</p><p style="margin-left: 20%;">156件</p></div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>