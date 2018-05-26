<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>EHT Warning Chart Demo</title>
<jsp:include page="../common.jsp"></jsp:include>
<script type="text/javascript" src="../../resources/script/core/eht.chart.sector.js"></script>
<script type="text/javascript" src="../../resources/script/core/eht.chart.warning.js"></script>
<script type="text/javascript" src="../../resources/script/core/eht.chart.pointer.js"></script>
<style>
#wainningpanel div{
	float: left;
}
</style>
<script type="text/javascript">
$(function(){
	var w1=new Eht.Warning({selector:"#warning1"});
	
	var w2=new Eht.Warning({selector:"#warning2",showLabel:false,value:20});
	
	var w3=new Eht.Warning({selector:"#warning3",type:"sector",value:50});
	$("#refresh").click(function(e){
		w1.refresh();
		w2.refresh();
		w3.refresh();
	});
});
/**
 * 气球
 */
Eht.Ballon=function(options){
	var defaults={
			paper:null,
			x:100,
			y:50
		};
	this.options=$.extend(defaults,options);
	this.paper = this.options.paper;
	var x = this.options.x;
	var y = this.options.y;
	
	this.path = ["M",x,y,"l",15,-10,"l",25,0,"l",0,-20,"l",-80,0,"l",0,20,"l",25,0,"Z"];
	
	this.ballon=this.paper.path(this.path);
};
Eht.Ballon.prototype.getPath=function(x,y){
	this.path.splice(1,1,x);
	this.path.splice(2,1,y);
	return this.path;
};
</script>
</head>
<body>
<input type="button" value="refresh" id="refresh"/>
<div id="wainningpanel">
<div id="warning1"></div>
<div id="warning2"></div>
<div id="warning3"></div>
<div id="warning4"></div>
</div>
</body>
</html>