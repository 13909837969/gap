<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>机构总数</title>
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<script type="text/javascript" src="http://echarts.baidu.com/gallery/vendors/simplex.js"></script>

<script type="text/javascript">

//机构总数
$(function(){
	var dom = document.getElementById("jgzs");
	var myChart = echarts.init(dom);
	var app = {};
	option = null;
	option = {

	    tooltip : {
	        trigger: 'axis'
	    },
	    legend: {
	        data:['2016年','2017年'],
	        textStyle:{color: '#fff'}
	    
	    },
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
	        {	show: true,
	            name: '个',
	            position: 'left',
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
	
	//法律援助
	var dom = document.getElementById("flyz");
	var myChart = echarts.init(dom);
	var app = {};
	option = null;	
	option = {
	    tooltip : {
	        trigger: 'axis'
	    },
	    legend: {
	        data:['2016年','2017年'],
	        textStyle:{color: '#fff'}
	    },
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
	            data : ['业务经费列入同级财政预算的','有法律援助律师的','办公业务用房面积平米数','有专门接待场所的','临街一层的','设置无障碍通道的']
	        
	        }
	    ],
	    yAxis : [
	        {	show: true,
	        	name: '个',
	        	position: 'left',
	            axisLabel: {
                    show: true,
                    textStyle: {
                        color: '#fff'
                    },
			        axisLabel: {
		                formatter: '{value} 个'
		            }
                },
                axisLine: {
                    lineStyle: {
                        color: '#fff'
                    }
                },
	            type : 'value'
	        }
	    ],
	    series : [
	        {
	            name:'2016年',
	            type:'bar',
	            data:[2.0, 4.9, 7.0, 23.2, 25.6, 76.7],
	            itemStyle:{
                    normal:{
                        color:'#0d9bff'
                    }
                },
	        },
	        {
	            name:'2017年',
	            type:'bar',
	            data:[2.6, 5.9, 9.0, 26.4, 28.7, 70.7,],
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
	
	//法律援助机构性质
	var dom = document.getElementById("fvyzjgxz");
	var myChart = echarts.init(dom);
	var app = {};
	option = null;
	option = {
	    tooltip : {
	        trigger: 'item',
	        formatter: "{a} <br/>{b} : {c} ({d}%)"
	    },
	    legend: {
	        orient: 'vertical',
	        left: 'left',
	        data: ['全额拨款','参公管理','其他','其它'],
	        textStyle:{color: '#fff'}
	    },
	    series : [
	        {
	            name: '访问来源',
	            type: 'pie',
	            radius : '55%',
	            center: ['50%', '60%'],
	            data:[
	                {value:335, name:'全额拨款'},
	                {value:310, name:'参公管理'},
	                {value:234, name:'其他'},
	                {value:135, name:'其它'},
	               
	            ],
	            itemStyle: {
		                emphasis: {
	                    shadowBlur: 10,
	                    shadowOffsetX: 0,
	                    shadowColor: 'rgba(0, 0, 0, 0.5)'
	                }
	            }
	        }
	    ],
	    color: ['#1ce960','#a817ec','#0d9bff','#f5ce0c']
	};
	if (option && typeof option === "object") {
	    myChart.setOption(option, true);
	}
	
});

</script>

<style type="text/css">
	input{
		border-radius: 5px;
		border: 1px;
	}
	
	#btn_ss{
		background-color: #0d9bff;
		color: #fff;
	}

	#jgzs{
		background-color:#333;
		z-index:auto 10;
		}
		
	html{
		height:100%;
		background: #f2f2f2;
	}
	#jigou{
		height:100%;
		background: #f2f2f2;
	}

	div#tb.col-md-4{
		margin-top:20px;
		margin-bottom:20px;
		height: 670px;
		background-color:#333;
		border-radius: 5px;
	}
	
	div#zt-jg.col-md-12{
		height: 320px;
		width: 100%;
		background-color:#333;
		border-radius: 0 0 5px 5px;
	}
	div#zt-fl.col-md-12{
		
		height: 280px;
		width: 100%;
		background-color:#333;
		border-radius: 0 0 5px 5px;
	}
	canvas{
		height: 300px;
	}
	
	form.form-search.row{
		height:100px;
		position:relative;
	}
	
	#fvyzjgxz_bt{
		height: 300px;
	}
	
	#btn_ss{
		margin-right: 108px;
	}
	
	#jigou_x0,#jigou_x1,#jigou_x2,#jigou_x3{
	height: 1px;
	background: #666;
	margin-top: 30px;
	text-align: center;
	}
	
	#jg_title,#flyzjgxz_title,#flyzjgqk_title{
	   margin-top:20px;
	   border-radius: 5px 5px 0 0;
	   color: #fff ;
	   background:#333;
	   font-size: 18px;
	   text-align: center;
	   font-weight: 5px;
	}
	
	#tb{
	font-size: 18px;
	}
	#ssqy{
	margin-top: 20px;
	}
	
</style>
</head>
<body>
		<div id="jigou">
			<div class="row-fluid">
				<form class="form-search">
				<div class="row">
					<div class="col-md-3"></div>
					
					<div class="col-md-6" id="ssqy">
							<div class="col-md-3">
						<input class="input-medium search-query" type="text" placeholder="区域搜索"  style="height:30px; color:#d9d9d9; text-align:center;" id="qyss"/>
							</div>
						<div class="col-md-3">
							<input class="input-medium search-query" type="text" placeholder="开始时间"  style="height:30px; color:#d9d9d9;text-align:center;"/>
						</div>
						<div class="col-md-3">
							<input class="input-medium search-query" type="text" placeholder="结束时间"  style="height:30px; color:#d9d9d9;text-align:center;"/>
						</div>
						<div class="col-md-3">
							<button type="submit" id="btn_ss" class="btn" style="text-align:center">搜索</button>
						</div>
					</div>
					<div class="col-md-3"></div>
				</div>
				</form>
			</div>
		
		
	<div class="col-md-12" id="zt">
		<div class="col-md-8" id="zt">
		<div class="col-md-12">
			<div id="jg_title">机构总数</div>
					<div class="col-md-12" id="zt-jg">
					    <div id="jgzs" style="height:100%;"></div>
					</div>
				</div>
				
				<div class="col-md-12">
					<div id="flyzjgqk_title">法律援助机构情况</div>
						<div class="col-md-12" id="zt-fl">
						<div id="flyz" style="height:100%;"></div>
					</div>
				</div>
				
		</div>	
		
		<div class="col-md-4" id="tb" style="color: white;">
			<div>
				<div id="flyzjgxz_title">法律援助机构性质</div>
				<div class="col-md-12">
					<div id="jigou_x0" class="col-md-5"></div>
					<div class="col-md-2" style="margin-top: 20px;text-align: center;line-height: 50px;">事业</div>
					<div id="jigou_x1" class="col-md-5"></div>
				</div>
				<div class="row" style="line-height: 28px;">
					<div class="col-md-6" style="margin-top: 10px;text-align: center;">
						<div>全额拨款:65个</div>
					</div>
					<div class="col-md-6" style="margin-top: 10px;text-align: center;">
						<div>参公管理:11个</div>
						<div>其他:53个</div>
					</div>
				</div>
				<div id="jigou_x2"></div>
				<div style="margin-top: 30px; text-align: center;">其他:5个</div>
				<div id="jigou_x3"></div>
			</div>
			<div class="col-md-12">
				<div id="fvyzjgxz_bt">
					<div id="fvyzjgxz" style="height:100%;"></div>
				</div>
			</div>
			
		</div>
	</div>
	</div>
</body>
<html>
