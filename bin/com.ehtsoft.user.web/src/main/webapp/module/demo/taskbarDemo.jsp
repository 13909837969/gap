<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<jsp:include page="../common.jsp"></jsp:include>
<title>Taskbar</title>
<style type="text/css">
</style>
<script type="text/javascript">
$(function(){
	var taskbar = new Eht.Taskbar({selector:"#taskbar"});
	//taskbar.setPosition("left");
	for(var i=0;i<5;i++){
		var s = new Eht.Window({remove:true,iframe:true});
		s.setIcon("eht-func-icon");
		s.setTitle("window_" + i);
		s.open();
		taskbar.addWindow(s);
	}
	taskbar.clickStart(function(){
		console.log("==================");
	});
});
</script>
</head>
<body>
<!-- 
<div class="eht-taskbar">
	<div class="eht-taskbar-base eht-taskbar-startbar"></div>
	<div class="eht-taskbar-base eht-taskbar-contbar">
		<div class="child-task">
			<div>aaaaa</div>
			<div>bbbbb</div>
		</div>
		<div class="child-task">bbb</div>
		<div class="child-task">bbb</div>
		<div class="child-task">bbb</div>
		<div class="child-task">bbb</div>
	</div>
	<div class="eht-taskbar-base eht-taskbar-iconbar"></div>
</div>
-->
<div id="console"></div>
<div id="taskbar"></div>
</body>
</html>