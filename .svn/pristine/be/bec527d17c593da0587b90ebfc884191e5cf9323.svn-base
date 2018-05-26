<%@page import="java.util.Enumeration"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>系统数据库差异分析工具</title>
<jsp:include page="common.jsp"></jsp:include>
<script type="text/javascript">
$(function(){
	var toolbar = new Eht.Toolbar({selector:"#toolbar"});
	toolbar.disable("#executeSql");
	toolbar.click(function(id){
		switch(id){
		case "validatedb":
			validatedb();
		break;	
		case "executeSql":
			executeSql();
			break;
		}
	});
	function executeSql(){
		var conf = new Eht.Confirm("确认要执行如下升级脚本？");
		conf.clickOk(function(){
		var rtn = jQuery.ajax({				
			type: 		"POST",
			url:  		"/" + $("#project").val() + "/json",
			data: 		{service:"DbMetaDataService",method:"executeSql",arguments:"[\""+$("#sqltxt").val()+"\"]"},
			dataType: 	"json",
			async: 		true,
			context:	{},
			success: 	function(data, textStatus, jqXHR){
				new Eht.Alert("数据库 SQL 升级成功 ！");
				$("#sqltxt").val("");
				toolbar.disable("#executeSql");
			},							
			error:   	function(request, textStatus, error){
				if(textStatus=="error" && request.status==0){
					new Eht.Alert({title:"错误信息",message:"应用停止服务或网络中断！"});
				}else{
					new Eht.Alert({title:"错误信息",message:request.responseText});
				}
			}
		});
		});
	}
	function validatedb(){
	var rtn = jQuery.ajax({				
		type: 		"POST",
		url:  		"/" + $("#project").val() + "/json",
		data: 		{service:"DbMetaDataService",method:"getCompareResult"},
		dataType: 	"text",
		async: 		true,
		context:	{},
		complete: 	function(res, status){
			var v = res.responseText.replace("\{\"value\":\"","").replace("\"\}","");
			if(v==""){
				new Eht.Alert("当前应用【"+$("#project").val()+"】数据库是最新版本，不需要升级");
				toolbar.disable("#executeSql");
			}else{
				toolbar.enable("#executeSql");
			}
			
			$("#sqltxt").val(v);
		},							
		error:   	function(request, textStatus, error){
			if(textStatus=="error" && request.status==0){
				new Eht.Alert({title:"错误信息",message:"应用停止服务或网络中断！"});
			}else{
				new Eht.Alert({title:"错误信息",message:request.responseText});
			}
		}
	});
	}
});
</script>
</head>
<body>
<div id="toolbar">
	<a id="validatedb" icon="eht-checkbtn-icon">检查数据库</a>
	<a id="executeSql" icon="eht-upbtn-icon">执行升级脚本</a>
</div>
<div>
	<div style="padding:4px;">
		<label>应用：</label><input type="text" id="project" value="community"/>
	</div>
	<div style="padding:4px;">
		<textarea id="sqltxt" readonly="readonly" style="width:800px;height:500px;"></textarea>
	</div>
</div>
</body>
</html>