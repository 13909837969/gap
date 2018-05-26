<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<jsp:include page="../common.jsp"></jsp:include>
<title>Insert title here</title>
<style>
body{position;relative;}

</style>
</head>
<body>

<div id="a"></div>
<div id="b"></div>
<div style="position:absolute;left:0px;bottom:0px;width:50px;">
	<input type="button" id="an" value="按钮" >
</div>
<script>
$(function(){
	var win = new Eht.Window({iframe:true});
	//数据
	 var data=[{"a":1,"b":2,"icon":"eht-xitong-icon",'label':"label1",id:"demo",
			"children":[{"a":1,"b":2,icon:"s444",'label':"label1-133333333333333",url:"http://www.baidu.com"},
	            			{"a":1,"b":2,icon:"s444",'label':"label1-2",url:"http://www.qq.com"},
	            			{"a":1,"b":2,icon:"s444",'label':"label1-3","children":[{"a":1,"b":2,icon:"s444",'label':"label1-133333333333333"},
	            			                            	            			{"a":1,"b":2,icon:"s444",'label':"label1-2"},
	            			                            	            			{"a":1,"b":2,icon:"s444",'label':"label1-3"}]}]
	},{"a":1,"b":2,icon:"s444",'label':"label2"},{"a":1,"b":2,icon:"s1",'label':"label3"}];
	 
	data = [];
	for(var i=0;i<10;i++){
		var o1 = new Object();
		o1.icon = "eht-xitong-icon";
		o1.label = "label_" + i;
		o1.children = [];
		for(var j=0;j<10;j++){
			var o2 = new Object();
			o2.icon = "eht-xitong-icon";
			o2.label = "label_" + i;
			o1.children.push(o2);
		}
		data.push(o1);
		
	}
	 
	 //声明对象
	var ss=new Eht.Menu({selector:"#a",hasRight:true,width:400,cWidth:200,height:200,contextmenu:true});
	var ss2=new Eht.Menu({selector:"#b",hasRight:false,width:200,cWidth:200,height:200,contextmenu:false});
	 ss.loadData(data);
	 ss2.loadData(data);
	 $("#an").click(function(e){
		 ss2.show(e);
		 return false;
	 });
	 ss.clickItem(function(data){
		 win.setUrl(data.url);
		 win.open();
		 console.log(data);
	 });
	 
});



</script>



</body>
</html>

