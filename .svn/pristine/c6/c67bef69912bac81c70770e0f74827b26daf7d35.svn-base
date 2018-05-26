<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<jsp:include page="../common.jsp"></jsp:include>
<title>jquery demo</title>
<script type="text/javascript">
	//javascript:
	function func(e){		
		var div = document.getElemetById("divId");
	}
	//jquery
	//$("#divId")   ====   document.getElemetById("divId");
$(function(){
	
	var a = $("<div><a>aaaaaaaaaa</a></div><div>aaaa</div>");
	
	//javascript: document.createElement("a");	
	
	$("#divId").append(a);
	$("#divId").append("<a>aaaaaaaaaa</a>");
	$("#divId").append("<a>bbbbbb</a>");
	$("#divId").before("<div>aaa</div>");
	$("#divId").after("<div>aaa</div>");
	
	var div2 = $("<div>aaa</div>");
	div2.insertBefore($("#divId"));
	div2.insertAfter($("#divId"));
	
	$("#divId").attr("other");/// divId.getAttribute("other");
	
	$("#divId").attr("other2","222");// divId.setAttribute("other2");
	$("#divId").attr("selected","ssss");
	$(".aaa").attr("selected","ssss");
	
	$("#txt").enable();
	$("#txt").disable();
	
	$("#txt").offset().left
	$("#txt").offset().top
	$("#txt").postion().left
	$("#txt").postion().top
	
	$("#div2").css({"font-size":12,"background":"#f00"});
	$("#div2").css("font-size","12");
	$("#div2").css("background","#f00");
	
	$("#div2").addClass("aaa");
	$("#div2").removeClass("aaa");
	$("#divId").removeAttr("other");
	$("#div2").hide();
	$("#div2").hide("show");
	$("#div2").hide(200);
	
	$("#div2").remove();
	
	$("#div2").hide("show",function(){
		
	});
	$("#div2").show("show",function(){
		
	});
	$("#div2").is("a");
	
	$(".aaa").is("div");
	$(".aaa").is(":hidden");
	
	
	$("#div2").children().remove();
	
	$("#div2").children().eq(1);
	
	var s = "s,s,s ";
	s.trim();
	s.split(",");
	var array = new Array();
	array = [1,2,3,2];
	array.join() === 123
	array.join(",") == 1,2,3
	array.splice(2,1);
	array.push(2);
	array.pop();
	
	array.shift("a");
	array.unshift();
	
	$("div",".divId").each(function(i,item){
		$(this) == $(item)
	});
	
	$("div[other='aaa']").find();
	
	$("#divId").find("div").each(function(){
		
	});
	$("#divId").children("div").each(function(){
		
	});
});
// ====>  onload="func(event)"
</script>
<style>
.aaa{
}
</style>
</head>
<body onload="func(event)">

<div  class='aaa' other = "aaa"  other2="222" selected>
	<div></div>
	<div></div>
</div>
<div id="divId" class='aaa' other = "bbb"  other2="222" selected>
	<div></div>
	<div>
		<div>
			<div></div>
		</div>
		<div></div>
	</div>
	<div></div>
	<a></a>
</div>


<input type="text" id="txt" disabled="disabled"/>
<div id="div2" class="aaa bbb">
	<div>sss</div>
	<div>bbb</div>
</div>
</body>
</html>