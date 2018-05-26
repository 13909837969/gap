<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>机构总数</title>
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<link rel="stylesheet" href="css/ltrhaolhFlyz.css?<%=Math.random()%>"/>
<script type="text/javascript" src="http://echarts.baidu.com/gallery/vendors/simplex.js"></script>
<script type="text/javascript" src="${localCtx}/json/RegionService.js"></script>
<style type="text/css">
	input{
		border-radius: 5px;
		border: 1px;
		
	}
	#viewTsclqk_lyzs{
		background:#333;
		height:100px;
		color:#fff;
		border-radius:5px;
		text-align:center;
	}
	#btn_ss{
		background-color: #0d9bff;
		color: #fff;
	}
		
	html{
		height:100%;
		background: #f2f2f2;
	}
	#jigou{
		height:100%;
		background: #f2f2f2;
	}
	#viewTsclqk_sskinput{
		margin-top:20px;
	}
	#tsclzs{
		margin-top:20px;
		height: 300px;
		margin: 0 auto;
		background-color:#333;
		border-radius: 0 0 5px 5px;
	}
	
	form.form-search.row{
		height:100px;
		position:relative;
	}
	#tssxflqk{
		background: #333;
		border-radius: 0 0 5px 5px;
		height: 300px;
	}
	
	#cljdqk{
		background: #333;
		border-radius: 0 0 5px 5px;
		height: 300px;
	}
	
	#bfcljdqk{
		background: #333;
		border-radius: 0 0 5px 5px;
		height: 300px;
	}
	.clsx_title{
		color: #fff;
		margin-top:20px;
		padding-top:10px;
		text-align: center;
		background: #333;
		font-size: 20px;
		border-radius:5px 5px 0 0;
	}
	.input-medium{
	border:1px solid #ccc;
	height:30px;
	color:#d9d9d9;
	text-align:center;
	}
</style>
<script type="text/javascript">
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
	$("#viewTsclqk_qyss").click(function(){
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
	$("#viewTsclqk_kssj").unbind("click").bind("click",function(){
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
	
	$("#viewTsclqk_jssj").unbind("click").bind("click",function(){
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
//机构总数
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
	            name: '件',
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
	
	//投诉事项分类情况
	var dom = document.getElementById("tssxflqk-e");
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
                    },  
                  /*  formatter : function(params){
                        var newParamsName = "";// 最终拼接成的字符串
                        var paramsNameNumber = params.length;// 实际标签的个数
                        var provideNumber = 5;// 每行能显示的字的个数
                        var rowNumber = Math.ceil(paramsNameNumber / provideNumber);// 换行的话，需要显示几行，向上取整
                        /*
                         * 判断标签的个数是否大于规定的个数， 如果大于，则进行换行处理 如果不大于，即等于或小于，就返回原标签
                         */
                        // 条件等同于rowNumber>1
                        /*
                        if (paramsNameNumber > provideNumber) {
                            // 循环每一行,p表示行
                            for (var p = 0; p < rowNumber; p++) {
                                var tempStr = "";// 表示每一次截取的字符串
                                var start = p * provideNumber;// 开始截取的位置
                                var end = start + provideNumber;// 结束截取的位置
                                // 此处特殊处理最后一行的索引值
                                if (p == rowNumber - 1) {
                                    // 最后一次不换行
                                    tempStr = params.substring(start, paramsNameNumber);
                                } else {
                                    // 每一次拼接字符串并换行
                                    tempStr = params.substring(start, end) + "\n";
                                }
                                newParamsName += tempStr;// 最终拼成的字符串
                            }

                        } else {
                            // 将旧标签的值赋给新标签
                            newParamsName = params;
                        }
                        //将最终的字符串返回
                        return newParamsName
           			 }
	        		*/
	        		
                },
                axisLine: {
                    lineStyle: {
                        color: '#fff'
                    }
                },
	            data : ['违反规定办理法律援助受理审查事项或者违反规定指派安排法律援助人员','法律援助人员接受指派或安排后懈怠履行或者擅自停止履行法律援助职责','办理法律援助案件收取财物市','其他违反法律援助规定的行为']
	        }
	    ],
	    yAxis : [
	        {	show: true,
	            name: '件',
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
	            data:[1000, 100, 100, 500],
	            itemStyle:{
                    normal:{
                        color:'#0d9bff'
                    }
                },
	        },
	        {
	            name:'2017年',
	            type:'bar',
	            data:[1000,300, 300, 300],
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
	
	
	//处理决定情况
	var dom = document.getElementById("cljdqk-e");
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
                    },  
                },
                axisLine: {
                    lineStyle: {
                        color: '#fff'
                    }
                },
	            data : ['给予行政处罚行业惩戒纪律处分','投诉事项查证不实或者无法查实，对被投诉人不作处理','给予批评教育通报批评责令限期整改']
	        }
	    ],
	    yAxis : [
	        {	show: true,
	            name: '件',
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
	            data:[1000, 100, 100],
	            itemStyle:{
                    normal:{
                        color:'#0d9bff'
                    }
                },
	        },
	        {
	            name:'2017年',
	            type:'bar',
	            data:[1000,300,300],
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
	
	
	//不服处理决定情况
	var dom = document.getElementById("bfcljdqk-e");
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
                    },  
                },
                axisLine: {
                    lineStyle: {
                        color: '#fff'
                    }
                },
	            data : ['申请行政复议的','提起行政诉讼的','合计']
	        }
	    ],
	    yAxis : [
	        {	show: true,
	            name: '件',
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
	            data:[1000, 100, 100],
	            itemStyle:{
                    normal:{
                        color:'#0d9bff'
                    }
                },
	        },
	        {
	            name:'2017年',
	            type:'bar',
	            data:[1000,300, 300],
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
	
});
</script>


</head>

<body>
		<div id="jigou">
			<div class="row-fluid">
			<div>
				<div class="form-search">
					<div class="col-md-12" id="viewTsclqk_sskinput">
						<div class="col-md-5" style="margin-top:30px;">
							<div class="col-md-3">
								<input type="text" class="input-medium search-query" id="viewTsclqk_qyss" placeholder="区域搜索"/>
							</div>
							<div class="col-md-3">
								<input type="text" class="input-medium search-query" id="viewTsclqk_kssj" placeholder="开始时间"/>
							</div>
							<div class="col-md-3">
								<input type="text" class="input-medium search-query" id="viewTsclqk_jssj" placeholder="结束时间"/>
							</div>
							<div class="col-md-3">
								<button type="submit" class="btn btn-primary" id="btn-primary" style="border:0px;">搜索</button>
							</div>
						</div>
						<div class="col-md-5"></div>
						<div  class="col-md-2">
							<div class="col-md-12" id="viewTsclqk_lyzs">
								<p style="margin-top:15px;"><a href="#">内蒙古自治区挽回损失或取得利益人员总数</a></p>
								<p>848万元</p>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

	<div class="col-md-12">
		<div class="col-md-12">
			<div class="clsx_title"><a href="#">内蒙古自治区投诉处理总数</a></div>
			<div id="tsclzs">
				<div id="jgzs" style="height:100%;"></div>
			</div>
		</div>
	</div>	
	
	<div class="col-md-12" id="qk">
		<div class="col-md-4">
			<div class="clsx_title">内蒙古自治区投诉事项分类情况</div>
				<div id="tssxflqk">
					<div id="tssxflqk-e" style="height:100%;"></div>
				</div>
		</div>
		<div class="col-md-4">
			<div class="clsx_title">内蒙古自治区处理决定情况</div>
				<div id="cljdqk">
					<div id="cljdqk-e" style="height:100%;"></div>
				</div>
		</div>
		<div class="col-md-4">
			<div class="clsx_title">内蒙古自治区不服处理决定情况</div>
				<div id="bfcljdqk">
					<div id="bfcljdqk-e" style="height:100%;"></div>
				</div>
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
