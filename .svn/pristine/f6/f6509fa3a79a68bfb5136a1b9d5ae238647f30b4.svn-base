<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<link rel="stylesheet" href="css/ltrhaolhFlyz.css?<%=Math.random()%>"/>
<script type="text/javascript"src="http://echarts.baidu.com/gallery/vendors/simplex.js"></script>
<script type="text/javascript" src="${localCtx}/json/RegionService.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>人员</title>
<style>
#flyz-ry{
	background:#f2f2f2;
	}
  #jzry-xbfb-xingbfb{
  height:400px;
  background: #333;
  border-radius:5px;
  margin-top: 6px;
  } 
	#jzry-dz{
	height:400px;
	background:#333;
	margin-top:20px;
	border-radius:5px;
	}
	#containerzhu{
    height: 400px;
	}
	
	#containerdz1 {
	height:400px;
	}
	#containerdz2{
	height: 240px;
    background: #333;
    margin-right:10px;
	}
	#flyz-bzzs{
	height:320px;
	}
	#text1,#text2{
	float: left;
	width:100%;
	height: 111px;
	margin: 5px;
	background-color: #333;
	text-align: center;
	border-radius:5px;
}
  #Flyj-gzz{
   color:#fff; 
   text-align: center;
   padding-top:10px;
   font-size:20px;
  }

  #jzry-dz-ryfenbqk{
   font-weight:bold;
   color:#fff;
    text-align: center; 
  }
   #text3{
   float: left;
	width: 100%;
	height: 120px;
	margin: 5px;
	background-color: #333;
	text-align: center;
	border-radius:5px;
   }
  #Flyzgzz-qyss,#Flyzgzz-kssjs,#Flyzgzz-kssj{
   border-radius:5px;
   margin-right: 15px;
   margin-top: 10px;
   }
	 #Flyzgzz-cxan{
   border-radius:5px;
   width:100%;
   margin-right: 15px;
   margin-top: 10px;
   height:34px;
   color:#fff;
	 }
	
</style>
<script type="text/javascript">
  $(function(){
	  var dom = document.getElementById("containerzhu");
	  var myChart = echarts.init(dom);
	  var app = {};
	  option = null;
	  option = {
			    title : {
			        text: '',
			        borderColor:'#fff',			      
			    },
			    tooltip : {
			        trigger: 'axis'
			    },
			    legend: {
			        axisLabel: {
		                show: true,
		                textStyle: {
		                    color: '#fff'
		                }
		            },
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
			            axisLine:{
	                        lineStyle:{
	                            color:'#fff',  
	                        }
	                    } ,
			            axisLabel: {
		                    show: true,
		                    textStyle: {
		                        color: '#fff'
		                    }
		                },
			            data : ['呼和浩特市','包头市','乌海市','通辽市','赤峰市','乌兰察布市','鄂尔多斯市','巴彦淖尔市','呼伦贝尔市','锡林郭勒盟','阿拉善盟','兴安盟']
			        }
			    ],
			    yAxis : [
			        {
			            type : 'value',
			            axisLine:{
	                        lineStyle:{
	                            color:'#fff',  
	                        }
	                    } ,
			            axisLabel: {
		                    show: true,
		                    textStyle: {
		                        color: '#fff'
		                    }
		                },
			        }
			    ],
			    series : [
			        {
			            name:'2016年',
			            type:'bar',
			            
			            data:[240, 100, 200, 300, 200, 200, 200, 200, 200, 200, 200, 200],
			            itemStyle:{
		                    normal:{
		                        color:'#f5ce0c'
		                    }
		                },
			        },
			        {
			            name:'2017年',
			            type:'bar',
			            data:[300, 300, 340, 450, 420, 100, 200, 430, 100,440, 450, 360],
			            itemStyle:{
		                    normal:{
		                        color:'#0d9bff'
		                    }
		                },      
			        }
			    ]
			};
	  if (option && typeof option === "object") {
	      myChart.setOption(option, true);
	  }
	  var dom = document.getElementById("containerdz1");
	  var myChart = echarts.init(dom);
	  var app = {};
	  option = null;
	  option = {
			    title : {
			        text: '',
			        borderColor:'#fff',			      
			    },
			    tooltip : {
			        trigger: 'axis'
			    },
			    legend: {
			        axisLabel: {
		                show: true,
		                textStyle: {
		                    color: '#fff'
		                }
		            },
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
			            axisLine:{
	                        lineStyle:{
	                            color:'#fff',  
	                        }
	                    } ,
			            axisLabel: {
		                    show: true,
		                    textStyle: {
		                        color: '#fff'
		                    }
		                },
			            data : ['赛罕区','新城区','玉泉区','清水河县','武川县','土默特左旗','托克托县','和林格尔县','回民区']
			        }
			    ],
			    yAxis : [
			        {
			            type : 'value',
			            axisLine:{
	                        lineStyle:{
	                            color:'#fff',  
	                        }
	                    } ,
			            axisLabel: {
		                    show: true,
		                    textStyle: {
		                        color: '#fff'
		                    }
		                },
			        }
			    ],
			    series : [
			        {
			            name:'2016年',
			            type:'bar',
			            
			            data:[240, 100, 200, 300, 200, 200, 200, 200, 200],
			            itemStyle:{
		                    normal:{
		                        color:'#0d9bff'
		                    }
		                },
			        },
			        {
			            name:'2017年',
			            type:'bar',
			            data:[300, 300, 450,100, 200, 450, 100, 400, 440],
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
	  $("#Flyzgzz_kssj").unbind("click").bind("click",function(){
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
	  $("Flyzgzz_jssj").unbind("click").bind("click",function(){
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
  }); 
</script>
</head>
<body>
<div id="flyz-ry">
  <!-- 搜索区域 -->
  
	<div id="flyz-ryss-title" class="col-md-8">
		<div class="col-md-3">
			<input id="Flyzgzz-qyss"  type="text" placeholder="搜索区域" style="height:30px;color:#d9d9d9;text-align:center;border:1px solid #ccc;"/>
		</div>
		<div class="col-md-3">
			<input id="Flyzgzz-kssj" class="input-append date form_datetime"  type="text" placeholder="开始时间" style="height:30px;color:#d9d9d9;border:1px solid #ccc;text-align:center"/>
		</div>
		<div class="col-md-3">
			<input id="Flyzgzz-kssjs" class="input-append date form_datetime" type="text" placeholder="结束日期" style="height:30px; border:1px solid #ccc;color:#d9d9d9;text-align:center"/>
		</div>
		<div class="col-md-3">
			<button id="Flyzgzz-cxan" type="button" onclick="" style="background:#0d9bff;border:0px;">搜索</button>
		</div>
	</div>
  <!-- 搜索框结束 -->
  
  <!-- 图表 -->
	<div id="flyz-ry-tb">
	    <div class="col-md-12">
	       	<div id="jzry-xbfb-xingbfb" class="col-md-8">
			   <div id="Flyj-gzz" style="font-size:20px;">人员总数</div>
			   <div id="containerzhu"></div>
	    	</div>
	      	<div id="flyz-bzzs" class="col-md-4">     
	       		<div id="text1" style="color:#fff" class="col-md-4">
					<p style="margin-top: 15px" >编制总数:</p><p>479人</p>		
				</div>
				
				<div id="text2" style="color:#fff" class="col-md-4">
					<p style="margin-top:15px">实有人员总数:</p>
					<p>469人</p>
				</div>
				 <div id="text3" style="color:#fff" class="col-md-4">
					 <div class="col-md-6">
					   	<p>具有法律职业资格或律师资格人数</p>
					   	<p>217人</p>
					 </div>			 
				   	<div class="col-md-6">			   
						<p style="margin-top:15px">法律援助律师数</p>
						<p>167人</p>
						<p>其他：</p>
						<p>50人</p>			
				   	</div>
				</div>  
	    	</div>
	   	</div> 
	   	<div id="jzry-dsh">
	    	<div id="jzry-dz" class="col-md-12">
	    		<div id="jzry-dz-ryfenbqk" style="font-size:20px">区县人员总数</div>     
		 		<div id="containerdz1"></div>	
		  	</div>  
		</div>
	</div>
</div>
</body>
</html>