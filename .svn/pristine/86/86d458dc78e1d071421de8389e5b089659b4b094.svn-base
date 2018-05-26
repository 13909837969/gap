<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>行政法律援助（盟市）</title>
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<script type="text/javascript"  src="http://echarts.baidu.com/gallery/vendors/echarts/extension/bmap.min.js"></script>
<style type="text/css">
    .top_div_in{
	    height:30px; 
	    color:#d9d9d9; 
	    text-align:center;
	    border-radius:5px;
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
	.backcolor{
	 background-color: #f2f2f2;
	}
</style>
</head>
<script type="text/javascript">
$(function() {
	/* 行政法律援助 柱状图 */
	var t1 =  echarts.init(document.getElementById('xzflyz'));
	option = {
    /* title : {
        text: '行政法律援助',
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
            data : ['内蒙古自治区','呼和浩特','包头','乌海','通辽','赤峰','乌兰察布','鄂尔多斯','巴彦淖尔','呼伦贝尔','锡林郭勒','阿拉善盟','兴安盟'],
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
	
/* 行政法律援助案件环比率 */	
	var t2 =  echarts.init(document.getElementById('xzflyzajhbl'));
	option1 = {
			   /* title: {
			       text: "行政法律援助案件环比率",
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
			            }

			       }
			      
			   ]
			};
	t2.setOption(option1);	
	
	/* 批准情况 */
	var t3 = echarts.init(document.getElementById('spqk'));
	option2 ={
		   /*  title : {
		        text: '批准情况',
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
		            data : ['请求国家赔偿','请求社会保险待遇','工伤（请求工伤保险之外）','请求给予最低生活保障待遇','请求发给抚恤金救济金','申诉案件'],
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
		            data:[ 13.6, 16.2, 32.6, 20.0, 6.4, 3.3],
		            itemStyle:{
		                normal:{
		                    color:'#0d9bff'
		                }
		            }
		        },
		        {
		            name:'2017',
		            type:'bar',
		            data:[ 15.6, 18.2, 48.7, 18.8, 6.0, 2.3],
		            itemStyle:{
		                normal:{
		                    color:'#f5ce0c'
		                }
		            }
		        }
		    ]
		};
		t3.setOption(option2);
		/* 案件分类情况 */
		var t4 = echarts.init(document.getElementById('ajflqk'));
		option3 ={
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
			            }
			        },
			        {
			            name:'2017',
			            type:'bar',
			            data:[ 15.6, 18.2, 48.7, 18.8, 6.0, 2.3,12.5,2.0,19.3],
			            itemStyle:{
			                normal:{
			                    color:'#f5ce0c'
			                }
			            }
			        }
			    ]
			};
		t4.setOption(option3);
		/* 已结案件承办情况 */
		var t5 = echarts.init(document.getElementById('yjajcbqk'));
		option4 ={
			   /*  title : {
			        text: '已结案件承办情况',
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
			            data : ['诉讼','非诉讼'],
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
			            data:[ 13.6, 16.2, ],
			            itemStyle:{
			                normal:{
			                    color:'#0d9bff'
			                }
			            }
			        },
			        {
			            name:'2017',
			            type:'bar',
			            data:[ 15.6, 18.2, ],
			            itemStyle:{
			                normal:{
			                    color:'#f5ce0c'
			                }
			            }
			        }
			    ]
			};
		t5.setOption(option4);
		/* 行政法律援助案件同比率 */
		var t6 = echarts.init(document.getElementById('xzflyzajtbl'));
		option5={
			   /*  title: {
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
			        name:'%',
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
			    series: [
			        {
			            type:'line',
			            data:[1, -2],
			            itemStyle:{
			                normal:{
			                    color:'#0d9bff'
			                }
			            }
			        }
			    ]
			};
		t6.setOption(option5);
	});
</script>
<body>
	<div>
	<div class="col-md-12">
			<div class="col-md-6" id="top_div1">
				<div  style="border-radius: 5px;margin-top: 18px;padding-top: 20px;">
					<div  class="top_div_in"><input type="text" value="区域检索" style="width:110px;"></div>
					<div  class="top_div_in"><input type="text" value="开始时间"></div>
					<div class="top_div_in"><input type="text" value="结束时间"></div>
					<div style="background-color: #0d9bff; border-radius: 5px;border-radius: 5px;">
						<a href="javascript:void(0);" id="btn_ss"  value="搜索">搜索</a>
					</div>
				</div>
			</div>
			<div class="col-md-1">
			</div>
			<div class="col-md-5" id="top_div3">
			<div  style="margin-top: 3px;padding-top: 10px;" >
				<div style="background-color:#333;border-radius: 5px;margin-right: 46px;"><p>挽回损失或获得利益</p><p style="margin-left: 24%;">156.4万元</p></div>
				<div style="background-color:#333;border-radius: 5px;margin-right: 46px;"><p>申请行政案件援助</p><p style="margin-left: 24%;">156件</p></div>
				<div style="background-color:#333;border-radius: 5px;"><p>未结行政案件</p><p style="margin-left: 24%;">15件</p></div>
			</div>
			</div>
		</div>
		<div class="col-md-12">
			<div class="col-md-7" >
			<div style="background-color:#333;border-radius: 5px;">
			<div style="color: white;margin-left: 44.5%;font-size: 19px;line-height: 2.2;"><b>行政法律援助</b></div>
				<div id="xzflyz" style="width:100%;height:360px;" ></div>
			</div>
			</div>
			<div class="col-md-5">
			<div style="background-color:#333;border-radius: 5px;">
			<div style="color: white;margin-left: 34%;font-size: 19px;line-height: 2.2;"><b>行政法律援助案件环比率</b></div>
				<div id="xzflyzajhbl" style="width: 100%;height: 360px;"></div>
			</div>
			</div>
		</div>
		<div class="col-md-12">
			<div class="col-md-3">
				<div style="background-color:#333;border-radius: 5px;">
					<div style="color: white;margin-left: 41%;font-size: 19px;line-height: 2.2;"><b>批准情况</b></div>
					<div id="spqk"  style="width: 100%;height: 360px;"  calss="backcolor"></div>
				</div>	
			</div>
			<div class="col-md-3">
				<div style="background-color:#333;border-radius: 5px;">
					<div style="color: white;margin-left: 37%;font-size: 19px;line-height: 2.2;"><b>案件分类情况</b></div>
					<div id="ajflqk" style="width: 100%;height: 360px;"  calss="backcolor"></div>
				</div>
			</div>
			<div class="col-md-3">
				<div style="background-color:#333;border-radius: 5px;">
					<div style="color: white;margin-left: 33.5%;font-size: 19px;line-height: 2.2;"><b>已结案件承办情况</b></div>
					<div id="yjajcbqk" style="width: 100%;height: 360px;"  calss="backcolor"></div>
				</div>
			</div>
			<div class="col-md-3">
				<div style="background-color:#333;border-radius: 5px;">
					<div style="color: white;margin-left: 27.5%;font-size: 19px;line-height: 2.2;"><b>行政法律援助案件同比率</b></div>
					<div id="xzflyzajtbl" style="width: 100%;height: 360px;"  calss="backcolor"></div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>