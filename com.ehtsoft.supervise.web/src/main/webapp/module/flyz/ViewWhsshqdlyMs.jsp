<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>挽回损失或取得利益(盟市)</title>
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<link rel="stylesheet" href="css/ltrhaolhFlyz.css?<%=Math.random()%>"/>
<script type="text/javascript"src="http://echarts.baidu.com/gallery/vendors/simplex.js"></script>
<script type="text/javascript" src="${localCtx}/json/RegionService.js"></script>
<!-- 设置图表样式 -->
<style>
#whss-kpzs a div:hover span{
	color:#f5ce0c;
}
#top_div1 {
	padding-top: 20px;
	padding-bottom: 2px;
	margin-top: 10px;
	border-radius:5px;
}

#top_div1 div {
	float: left;
	margin-bottom: 19px;
}

/*浮动*/
#text3 {
	height: 110px;
	/* margin-right: 39px; */
	background-color: #333;
	text-align: center;
	color:#fff;
	border-radius:5px;  
}
#whss-kpzs .text3 {
	height: 90px;
	background-color: #333;
	text-align: center;
	color:#fff;
	border-radius:5px;  
	vertical-align: middle;
	font-size:16px;
	line-height:30px;
}
#test1{
	padding-top: 28px;
}
/*1-已结案件总数*/
#Whsshqdly-div1 {
	margin-top: 20px;
	border-radius:10px;
	
}
/*2-所有字体居中，改色*/
.form-Whsshqdly {
	color: #fff;
	text-align: center;
	border-radius: 5px;
	font-size:20px;
	padding-top:10px;
}

#Whsshqdly-div2 {
	margin-top: 20px;
}
/*给所有的Echarts表格修改为圆边框*/
.form-Whsshqdly-1{
	border-radius: 5px;
}
</style>
<!-- 引入图表样式 设置触发事件-->
<script type="text/javascript">
$(function() {
		
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
	$("#ViewWhsshqdlyMs_qyss").click(function(){
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
		
		/*时间事件*/
		$("#ViewWhsshqdlyMs_kssj").unbind("click").bind("click",function(){
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

$("#ViewWhsshqdlyMs_jssj").unbind("click").bind("click",function(){
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
	
		/**表1-已结案件总数*/
		var dom = document.getElementById("rofm-Whsshqdly-zs");
		var myChart = echarts.init(dom);
		var app = {};
		option = null;
		option = {
		
			tooltip : {
				trigger : 'axis'
			},
			legend : {
				axisLabel : {
					show : true,
					textStyle : {
						color : '#fff'
					}
				},
				data : [ '2016年', '2017年' ],
				textStyle:{color: '#fff'}
				

			},
			toolbox : {
				show : true,
				feature : {
					dataView : {
						show : true,
						readOnly : false
					},
					magicType : {
						show : true,
						type : [ 'line', 'bar' ]
					},
					restore : {
						show : true
					},
					saveAsImage : {
						show : true
					}
				}
			},
			calculable : true,
			xAxis : [ {
				type : 'category',
				//颜色
				axisLabel : {
					show : true,
					textStyle : {
						color : '#fff'
					}
				},
				 axisLine:{
                     lineStyle:{
                         color:'#fff',
                     }
                 } ,
				data : [ '内蒙古自治区','呼和浩特市', '包头市', '乌海市', '通辽市', '赤峰市', '乌兰察布市', '鄂尔多斯市',
						'巴彦淖尔市', '呼伦贝尔市', '锡林郭勒盟', '阿拉善盟', '兴安盟' ]
			} ],
			yAxis : [ {
				
				type : 'value',
				name:'件',
				 min: 0,
				//颜色
				axisLabel : {
					show : true,
					textStyle : {
						color : '#fff'
					}
				},
				 axisLine:{
                     lineStyle:{
                         color:'#fff',
                     }
                 } ,
			} ],
			series : [
					{
						name : '2016年',
						type : 'bar',

						data : [ 500,1, 100, 500, 400, 200, 200, 200, 200, 200,
								200, 200, 200 ],
						itemStyle : {
							normal : {
								color : '#0d9bff'
							}
						},
					},
					{
						name : '2017年',
						type : 'bar',
						data : [ 500,300, 300, 600, 1000, 700, 100, 200, 800, 100,
								500, 500, 500 ],
						itemStyle : {
							normal : {
								color : '#f5ce0c'
							}
						},
					} ]
		};
		if (option && typeof option === "object") {
			myChart.setOption(option, true);
		}
		//表2，已结案件总数环比率
		var dom = document.getElementById("rofm-Whsshqdly-hb");
		var myChart = echarts.init(dom);
		var app = {};
		option = null;
		option = {
			title : {
				textStyle : {
					color : '#fff'
				}
			},
			xAxis : {
				type : 'category',
				axisLabel : {
					show : true,
					textStyle : {
						color : '#fff'
					}
				},
				data : [ '1月', '2月', '3月', '4月', '5月', '6月', '7月', '8月', '9月','10月', '11月', '12月' ],
				//颜色
				 axisLine:{
                     lineStyle:{
                         color:'#fff',
                     }
                 } 
			
			},
			yAxis : {
				type : 'value',
				name:'件',
				 min: 0,
				//颜色
				axisLabel : {
					show : true,
					textStyle : {
						color : '#fff'
					}
				},
				 axisLine:{
                     lineStyle:{
                         color:'#fff',
                     }
                 } 

			},
			series : [ {
				data : [ 0, 50, 60, 70, 80, 60, 80, 100 , 80, 60, 80, 100],
				type : 'line'
			} ]
		};
		if (option && typeof option === "object") {
			myChart.setOption(option, true);
		}
	
		/*表4-已结案件总数的同比率*/
		var dom = document.getElementById("rofm-Whsshqdly-tb");
		var myChart = echarts.init(dom);
		var app = {};
		option = null;
		var colors = ['#5793f3', '#d14a61', '#675bba'];


		option = {
		    color: colors,

		    tooltip: {
		        trigger: 'none',
		        axisPointer: {
		            type: 'cross'
		        }
		    },
		    legend: {
		        data:['2016年', '2017年'],
		        textStyle:{color: '#fff'}
		        
		    },
		    grid: {
		        top: 70,
		        bottom: 50
		    },
		    xAxis: [
		        {
		            type: 'category',
		            axisTick: {
		                alignWithLabel: true
		            },
		            axisLine: {
		                onZero: false,
		                lineStyle: {
		                    color: colors[1]
		                }
		            },
		            axisPointer: {
		                label: {
		                    formatter: function (params) {
		                        return '同比率  ' + params.value
		                            + (params.seriesData.length ? '：' + params.seriesData[0].data : '');
		                    }
		                }
		            },
		            data: ["2017-1", "2017-2", "2017-3", "2017-4", "2017-5", "2017-6", "2017-7", "2017-8", "2017-9", "2017-10", "2017-11", "2017-12"]
		        },
		        {
		            type: 'category',
		            axisTick: {
		                alignWithLabel: true
		            },
		            axisLine: {
		                onZero: false,
		                lineStyle: {
		                    color: colors[0]
		                }
		            },
		            axisPointer: {
		                label: {
		                    formatter: function (params) {
		                        return '同比率  ' + params.value
		                            + (params.seriesData.length ? '：' + params.seriesData[0].data : '');
		                    }
		                }
		            },
		            data: ["2016-1", "2016-2", "2016-3", "2016-4", "2016-5", "2016-6", "2016-7", "2016-8", "2016-9", "2016-10", "2016-11", "2016-12"]
		        }
		    ],
		    yAxis: [
		        {
		            type: 'value',
		            	name:'%',
						 min: 0,
							axisLabel : {
								show : true,
								textStyle : {
									color : '#fff'
								}
							},
							 axisLine:{
			                     lineStyle:{
			                         color:'#fff',
			                     }
			                 } ,
		        }
		    ],
		    series: [
		        {
		            name:'2016年',
		            type:'line',
		            xAxisIndex: 1,
		            smooth: true,
		            data: [2.6, 5.9, 9.0, 26.4, 28.7, 70.7, 175.6, 182.2, 48.7, 18.8, 6.0, 2.3]
		        },
		        {
		            name:'2017年',
		            type:'line',
		            smooth: true,
		            data: [3.9, 5.9, 11.1, 18.7, 48.3, 69.2, 231.6, 46.6, 55.4, 18.4, 10.3, 0.7]
		        }
		    ]
		};

		
		if (option && typeof option === "object") {
			myChart.setOption(option, true);
		}

	});
</script>


</head>
<body>
<!--表头搜索 总计  -->
		<div class="col-md-12"  style="padding-top:20px;">
			<div class="col-md-5" id="test1">
				<div class="col-md-3">
					<input type="text" class="form-control" id="ViewWhsshqdlyMs_qyss" placeholder="区域搜索">
				</div>
				<div class="col-md-3">
					<input type="text" class="form-control form_datetime" id="ViewWhsshqdlyMs_kssj" placeholder="开始时间">
				</div>
				<div class="col-md-3">
					<input type="text" class="form-control form_datetime" id="ViewWhsshqdlyMs_jssj" placeholder="结束时间">
				</div>
				<div class="col-md-3">
					<button type="button" class="btn btn-primary" id="btn-primary" >搜索</button>
				</div>
			</div>
			
			<div class="col-md-7">
			<div  class="col-md-3">
					<div class="col-md-12" id="text3">
						<p style="margin-top: 15px"><a href="#">内蒙古自治区挽回损失或取得利益人员总数</a></p>
						<p>848万元</p>
					</div>
				</div>
				<div  class="col-md-3">
					<div class="col-md-12" id="text3">
						<p style="margin-top: 15px">内蒙古自治区刑事法律援助挽回损失或取得利益</p>
						<p>2496万元</p>
					</div>
				</div>
				
				<div  class="col-md-3">
					<div class="col-md-12" id="text3">
						<p style="margin-top: 15px">内蒙古自治区民事法律援助挽回损失或取得利益</p>
						<p>241万元</p>
					</div>
				</div>
				
				<div  class="col-md-3">
					<div class="col-md-12" id="text3">
						<p style="margin-top: 15px">内蒙古自治区行政法律援助挽回损失或取得利益</p>
						<p>24961件</p>
					</div>
				</div>
			</div>	
		</div>
		<!-- 1-已结案件总数图表 -->
		<div class="col-md-12" >
			<div class="col-md-12" id="Whsshqdly-div1">
				<div style="background-color: #333;" class="form-Whsshqdly-1" >
					<div class="form-Whsshqdly"><a href="#">内蒙古自治区挽回损失或取得利益总览</a></div>
					<div id="rofm-Whsshqdly-zs" style="width: 100%; height: 400px; height: 360px"></div>
				</div>
			</div>
		</div>
		<!-- 2-已结案件的环比率 -->
		<div class="col-md-12">
			<div class="col-md-5" id="Whsshqdly-div2">
				<div style="background-color: #333;" class="form-Whsshqdly-1" >
				<div class="form-Whsshqdly">内蒙古自治区挽回损失或取得利益的环比率</div>
					<div id="rofm-Whsshqdly-hb" style="width: 100%; height: 400px; height: 360px"></div>
				</div>
			</div>
			<!-- 4-已结案件总数的同比率 -->
			<div class="col-md-7" id="Whsshqdly-div2">
				<div style="background-color: #333;" class="form-Whsshqdly-1" >
					<div class="form-Whsshqdly">内蒙古自治区挽回损失或取得利益的同比率</div>
					<div id="rofm-Whsshqdly-tb"style="width: 100%; height: 400px; height: 360px"></div>
				</div>
			</div>
			
		</div>
<!--  区域显示隐藏的div  -->
 		<div type="hiden" id="spsflyz-hidenDiv" style="display:none;">
			<div class="spssjfx-indicate"></div>
			<div id="spsSqjz-hidenDiv-div1">
				<div id="spsSqjz-hidenDiv-div11">区域选择</div>
				<input type="button" class="btn btn-warning"   id="spsSqjz-hidenDiv-qc" value="清除" style="padding:4px 8px;">
				<input type="button" class="btn btn-info"  id="spsSqjz-hidenDiv-qd" value="确定" style="padding:4px 8px;">
				<div id="spsSqjz-hidenDivBtn" class="glyphicon glyphicon-remove-circle" style="opacity:0.7;"></div>
			</div>
			<div id="spsSqjz-hidenDivSS"></div>
		</div>		
</body>
</html>