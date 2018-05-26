<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    
<!DOCTYPE html>
<html>
<head>
<title>曲线图/折线图/区域图 demo</title>
<meta charset="utf-8">
<jsp:include page="../common.jsp"></jsp:include>
        <script>
            $(function(){
            	var arr = [{a:0,y:0,y1:3,y2:5},{a:6,y:6,y1:10,y2:12},{a:10,y:7,y1:9,y2:10},
            	           {a:15,y:1,y1:5,y2:6},{a:20,y:6,y1:6,y2:8},
            	           {a:27,y:30,y1:18,y2:9},{a:33.4,y:12,y1:15,y2:11},
            	           {a:35,y:30,y1:18,y2:9},{a:44.5,y:12,y1:15,y2:11},
            	           {a:49,y:20,y1:18,y2:9},{a:55,y:12,y1:15,y2:30}
            	           ];
            	//图1
            	var grid = new Eht.CurveLine({selector:"#chart1",
            		xAxisField:"a",//字符串
        			yAxisField:["y","y1","y2"],//字符串或数组
        			colors:["#f00","#0f0","#00f"],
        			labels:["描述1","描述2","描述3"]
            	});
            	
            	grid.xAxisMod(function(i){
            		return i%12==0;
            	});
            	
            	 grid.yAxisMod(function(i){
            		return i%4==0;
            	}); 
            	 
            	grid.drawGrid();
            	grid.loadData(arr);
            	
            	//图2
            	var grid2 = new Eht.CurveLine({selector:"#chart2",
            		xAxisField:"a",//字符串
        			yAxisField:["y","y1","y2"],//字符串或数组
        			colors:["#f00","#0f0","#00f"],
        			labels:["描述1","描述2","描述3"],
        			isArea:true,
        			width:700,
        			height:500
            	});
            	grid2.xAxisMod(function(i){
            		return i%12==0;
            	});
            	grid2.yAxisMod(function(i){
            		return i%4==0;
            	});
            	grid2.drawGrid();
            	grid2.loadData(arr);
            	
            	
            	//图3
            	var grid3 = new Eht.CurveLine({selector:"#chart3",
            		xAxisField:"a",//字符串
        			yAxisField:["y","y1","y2"],//字符串或数组
        			colors:["#f00","#0f0","#00f"],
        			labels:["描述1","描述2","描述3"],
        			xAxisLine:64,//x轴最多竖线数
        			yAxisLine:32,//y轴最多横线数
        			
        			maxXAxis:128,//x 轴最大值
        			maxYAxis:64 //y 轴最大值
            	});
            	
            	grid3.xAxisMod(function(i){
            		return i%12==0;
            	});
            	
            	 grid3.yAxisMod(function(i){
            		return i%4==0;
            	}); 
            	 
            	grid3.drawGrid();
            	
            	grid3.loadData(arr);
            	
            	
            	
            	var arr4 = [{m:"2013-1-10",y:0,y1:3,y2:5},
            	            {m:"2013-1-17",y:6,y1:10,y2:12},
            	            {m:"2013-2-2",y:7,y1:9,y2:10},
            	           {m:"2013-3-2",y:1,y1:5,y2:6},
            	           {m:"2013-4-8",y:6,y1:6,y2:8},
            	           {m:"2013-5-7",y:30,y1:18,y2:9},
            	           {m:"2013-7-5",y:12,y1:15,y2:11}
            	           ];
            	//图4
            	var chart4 = new Eht.CurveLine({selector:"#chart4",
            		xAxisField:"m",//字符串
        			yAxisField:["y","y1","y2"],//字符串或数组
        			colors:["#f00","#0f0","#00f"],
        			labels:["描述1","描述2","描述3"],
        			xAxisLine:18,//x轴最多竖线数
        			yAxisLine:32,//y轴最多横线数
        			type:"line",
        			maxXAxis:18,//x 轴最大值
        			maxYAxis:64  //y 轴最大值
            	});
            	
            	chart4.xAxisMod(function(i){
            		return i%6==0;
            	});
            	chart4.xAxisConvert(function(xdata){
            		var firstDate = Eht.Utils.toDate(arr4[0].m);
            		return ((new Date(xdata).getTime()-firstDate.getTime())/(24*3600*1000))/30;
            	});
            	chart4.yAxisMod(function(i){
            		return i%4==0;
            	}); 
            	
            	chart4.xScaleLabel(function(i,gap){
            	var firstDate = Eht.Utils.toDate(arr4[0].m);
            		firstDate.setDate(( firstDate.getDate() + i * 30));
            		return firstDate.format("yyyy-MM-dd");
            	});
            	chart4.drawGrid();
            	chart4.loadData(arr4);
            	
            	$("input[type='button']","#b1").click(function(){
            		if($(this).attr("id")=="clear"){
            			grid.clear();
            		}else{
            			grid.setType($(this).attr("id"));
            		}
            	});
            	$("input[type='button']","#b2").click(function(){
            		if($(this).attr("id")=="clear"){
            			grid2.clear();
            		}else{
            			grid2.setType($(this).attr("id"));
            		}
            	});
            });
        </script>
    </head>
    	<div style="float:left">
	        <div id="chart1" style="width:700px;height:500px;"></div>
	        <div id="b1">
	        	<input type="button" value="Curve" id="curve"/>
	        	<input type="button" value="Line" id="line"/>
	        	<input type="button" value="Clear" id="clear"/>
	        </div>
        </div>
        <div style="float:left">
        <div id="chart2"></div>
         <div id="b2">
        	<input type="button" value="Curve" id="curve"/>
        	<input type="button" value="Line" id="line"/>
        	<input type="button" value="Clear" id="clear"/>
        </div>
        </div>
        
        <div id="chart3" style="width:700px;height:500px;float:left"></div>
        
        
        <div id="chart4" style="width:700px;height:500px;float:left"></div>
</body>
</html>