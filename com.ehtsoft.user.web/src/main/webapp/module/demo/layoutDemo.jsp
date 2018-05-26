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
		right:{selector:"#right",title:"right"},
		bottom:{selector:"#bottom"}});
	//new Eht.Layout({top:{selector:"#top2"},left:"#left2",center:"#center2",bottom:"#bottom2"});
	
	//var dg = new Eht.Datagrid({selector:"#datagrid"});
	
	var s=new Date();
	data = new Array();
	for(var i=0;i<30;i++){
		var d = {};
		for(var j=0;j<22;j++){
			d["field"+j]="field-"+i+"-"+j;
		}
		data.push(d);
	}
	//dg.loadData(data);
	
	//dg.loadData(data);

});
</script>
</head>
<body>
<div id="top" style="background:#ff0;height:90px;"></div>
<div id="left" style="border:1px solid #000;background:#f00;width:200px;"></div>
<div id="center" style="border:1px solid #000;background:#ff0;">
</div>
<div id="right" style="border:1px solid #000;background:#00f;width:200px;"></div>
<div id="bottom" style="border:1px solid #000;background:#0ff;height:40px;"></div>
</body>
</html>