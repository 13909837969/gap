<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>法律援助工作站</title>
 <jsp:include page="../ltrhao-common.jsp"></jsp:include>
<style type="text/css">
 #Flyzgzz-ym{
    width:100%;
    height:100%;
    background:#f2f2f2
 }
 #Flyzgzz-zs{
   height:400px;
   background:#333;
   border-radius:5px;
   margin-top: 10px;
 }
 #containerzhu1{
 height:360px;
 }
 #containerzhu2{
 height:360px;
 }
 #Flyzgzz-fyzx{
 background:#333;
 margin-top:30px;
  border-radius:5px;
 }
 
 #Flyzgzz-ss{
    text-align: center;
	margin-top:16px;
	margin:0 auto;
	}
 #Flyz-gzz{
   text-align: center;
    color:#fff;  
    border-radius:5px;
 }
 #flyz-fyzx{
  text-align: center;
   color:#fff;  
 }
  #Flyzgzz-qyss,#Flyzgzz-kssjs,#Flyzgzz-kssja{
   border-radius:5px;
   margin-top: 10px;
   }
	 #Flyzgzz-cxan{
   border-radius:5px;
   width:100%;
   margin-right: 15px;
   margin-top: 10px;
   height:30px;
   color:#fff;
   border: 0px;
	 }
</style>
<script type="text/javascript">
    $(function(){
  	  var dom = document.getElementById("containerzhu1");
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
			            data : ['呼和浩特市','赛罕区','新城区','玉泉区','清水河县','土默特左旗','武川县','托克托县','和林格尔县','回民区']
			        
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
			            
			            data:[240, 200, 300, 200, 200, 200, 200, 200, 200,150],
			          
			            itemStyle:{
		                    normal:{
		                        color:'#0d9bff'
		                    }
		                },
			        },
			        {
			            name:'2017年',
			            type:'bar',
			            data:[300, 300, 300, 320, 100, 200, 230, 100, 300,350],
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
	    
	
	  var dom = document.getElementById("containerzhu2");
	  var myChart = echarts.init(dom);
	  var app = {};
	  option = null;
	  option = {
			    title : {
			        text: '',
			        borderColor:'#f2f2f2',
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
			            data : ['依托基层司法所','依托工会','依托共青团','依托妇联','依托老龄委','依托残联','依托信访','依托高校','依托监狱、戒毒所','依托看守所','依托人民法院','依托部队、人武部','其他']
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
			            
			            data:[240,210,200, 300, 200, 200, 200, 200, 200, 200, 200, 200,200],
			            itemStyle:{
		                    normal:{
		                        color:'#0d9bff'
		                    }
		                },
			        },
			        {
			            name:'2017年',
			            type:'bar',
			            data:[300, 300, 300, 400, 100, 200, 420, 100, 300,200, 400, 100, 300],
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
	  $("#Flyzgzz-kssja").unbind("click").bind("click",function(){
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
	  $("Flyzgzz-kssjs").unbind("click").bind("click",function(){
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
  <div id="Flyzgzz-ym" class="container">
  <!-- 搜索框区域 -->
    <div id="Flyzgzz-ss" class="col-md-5">
      <div class="col-md-3">      
      	<input id="Flyzgzz-qyss"  type="text" placeholder="搜索区域" style="height:30px; border:1px solid #ccc;color:#d9d9d9;text-align:center"/>
      </div>
      <div class="col-md-3">
      	<input id="Flyzgzz-kssja" class="input-append date form_datetime" type="text" placeholder="开始时间" style="height:30px;color:#d9d9d9; border:1px solid #ccc;text-align:center"/>
      </div>
      <div class="col-md-3">
            <input id="Flyzgzz-kssjs" class="input-append date form_datetime" type="text" placeholder="结束时间" style="height:30px;color:#d9d9d9; border:1px solid #ccc;text-align:center"/>
      </div>
      <div class="col-md-3">
            <button id="Flyzgzz-cxan" type="button" onclick=""style="background:#0d9bff;" style="height:30px;border:0px;">搜索</button>
      </div>
    </div>
    <!-- 主界面 -->
    <div id="Flyzgzz-zjm">
      <div id="Flyzgzz-zs" class="col-md-12">
        <div id="Flyz-hz" class="col-md-12">
        	<div id="Flyz-gzz" style="font-size:20px;height:40px;line-height:40px;">呼和浩特市法律援助工作站总数</div>       
        	<div id="containerzhu1"></div>
        </div>
      </div>
      <div id="Flyzgzz-fyzx" class="col-md-12">
      	<div id="flyz-fyzx"  style="font-size:20px;height:40px;line-height:40px;">呼和浩特市法律援助中心工作站</div>
        <div id="containerzhu2"></div>
      </div>
    </div>
  </div>
</body>
</html>