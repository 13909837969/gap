<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<jsp:include page="../common.jsp"></jsp:include>
<script type="text/javascript">
$(function(){
	new Eht.Layout({
		top:{selector:"#top"},	
		left:{selector:"#left",title:"left"},
		center:{selector:"#center",title:"center"},
		});
	new Eht.Layout({
		top:{selector:"#center-top",title:"sss"},center:"#center-center"
	});
	
	var l = new Eht.Layout({top:{selector:"#w-top",title:"aaaa"},left:"#w-left",center:{selector:"#w-center",title:"afafafaf"},bottom:"#w-bottom"});
	var l2 = new Eht.Layout({left:{selector:"#wc-left",title:"afafaf"},center:{selector:"#wc-right",title:"sssss23rfda"}});
	var win1=new Eht.Window({selector:"#win1"});
	win1.openComplete(function(){
		l.resize();
		l2.resize();
	});
	win1.resize(function(){
		l.resize();
		l2.resize();
	});
	$("#openWin").click(function(){
		win1.open();
	});
});
</script>
</head>
<body>
<div id="top" style="background:#ff0;height:90px;"></div>
<div id="left" style="border:1px solid #000;background:#f00;width:200px;"></div>
<div id="center" style="border:1px solid #000;background:#ff0;">
	<div id="center-top" style="height:100px;border:1px solid #f00;">
		<input type="button" id="openWin" value="open window"/>
	</div>
	<div id="center-center" style="border:1px solid #00f;"></div>
</div>
<div id="win1">
	<div id="w-top" style="border:1px solid #f00;height:100px;">top</div>
	<div id="w-left" style="border:1px solid #f00;width:100px;">left</div>
	<div id="w-center" style="border:1px solid #f00;">
		<div id="wc-left" style="width:300px;">
			
		</div>
		<div id="wc-right"></div>
	</div>
	<div id="w-bottom" style="border:1px solid #f00;height:100px;">bottom</div>
</div>
</body>
</html>