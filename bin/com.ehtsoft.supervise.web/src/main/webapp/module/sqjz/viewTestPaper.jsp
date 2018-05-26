<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<!-- JZ_WJTKXXB -->
<title>试卷预览</title>
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<script type="text/javascript" src="${localCtx}/json/TestPaperService.js"></script>
<script type="text/javascript">
$(function(){
	var tps = new TestPaperService();
	
	tps.findOne("${param.stid}",new Eht.Responder({
		success:function(data){
			$("#testpagertitle").html(data.f_sjbt);
			if(data.children){
				data.children.forEach(function(o,i){
					var xtlxname = "";
					if(o.f_xtlx=="1"){
						xtlxname = "单选";
					}
					if(o.f_xtlx=="2"){
						xtlxname = "多选";
					}
					var li = $("<div><h5>"+(i+1)+". "+o.f_wtms+" ("+xtlxname+")"+"</h5></div>");
					$("#testpagecontent").append(li);
					if(o.children && o.children.length > 0){
						var ul = $("<pre></pre>");
						li.append(ul);
						o.children.forEach(function(a){
							ul.append("<div>"+a.f_daxx+"."+a.f_daxxms+"</div>");
						});
					}
				});
			}
			
		}
	}));
});
</script>
</head>
<body>
<div id="sqjz_viewtestpaper">
	<div class="panel panel-default">
	  <!-- Default panel contents -->
	  <div class="panel-heading" id="testpagertitle">Panel heading</div>
	  <div class="panel-body">
	    <div id="testpagecontent">
	    
	    </div>
	  </div>
	</div>
</div>
</body>
</html>