<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Eht.NavToolbar</title>
<jsp:include page="../common.jsp"></jsp:include>
<style type="text/css">

</style>
<script type="text/javascript">
$(function(){
	var navToolbar = new Eht.NavToolbar({selector:"#navtoolbar",iframe:false});
	
	var data = [];
	
	for(var i=0;i<10;i++){
		data[i] = {label:"label_" + i + "—管理系统"};
		var cs = [];
		for(var j=0;j<5;j++){
			cs[j]={label:"label_" + i + "_" + j + "_管理系统功能",url:"http://www.baidu.com"};
			var cc=[];
			if(j!=2 && j!=1){
				for(var k=0;k<5;k++){
					cc[k]={label:"label_" + i+ "_" + j + "_" + k + "_管理系统功能",url:"http://mail.163.com"}
				}
			}
		
			cs[j].children = cc;
		}
		data[i].children = cs;
	}
	
	
	navToolbar.loadData(data);
	
	
	var m = new Eht.Menu();
	m.loadData(data);
	$("#btn").click(function(e){
		m.show(e);
		return false;
	});
});
</script>
</head>
<body>
<div id="navtoolbar">
</div>
</body>
</html>