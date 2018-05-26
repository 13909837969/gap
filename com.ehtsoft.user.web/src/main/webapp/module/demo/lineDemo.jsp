<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>EHT Line Chart Demo</title>
<meta name="description" content="EHT 线性图 demo;演示地址：http://demo.ehtsoft.com/" />
<meta name="description" content="copyright:大连易恒通软件有限公司，http://www.ehtsoft.com"/>
<jsp:include page="../common.jsp"></jsp:include>
<script type="text/javascript">
$(function(){
	var l=new Eht.Line({selector:"#line"});
	$("#refresh").click(function(){
		l.refresh();
	});
	$("#showlabel").click(function(){
		l.showValue(!l.showVal);
		if(l.showVal){
			$(this).val("隐藏值");
		}else{
			$(this).val("显示值");
		}
	});
});
</script>
</head>
<body>
<input type="button" value="refresh" id="refresh"/>
<input type="button" value="显示值" id="showlabel"/>
<div id="line"></div>
</body>
</html>