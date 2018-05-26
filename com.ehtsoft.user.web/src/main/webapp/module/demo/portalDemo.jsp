<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<jsp:include page="../common.jsp"></jsp:include>
<title>PortalDemo</title>
<script type="text/javascript">
$(function(){
	new Eht.Portal({minWidth:500});
});
</script>
</head>
<body>
<div  class="eht-portal">
	<div class="eht-portal-title">客户资源（患者）情况</div>
	<div class="eht-portal-body">
	  患者数量,A类 ，B类，C类 各多少人
	</div>
</div>

<div  class="eht-portal">
	<div class="eht-portal-title">预约登记情况</div>
	<div class="eht-portal-body">
		预约时间，预约人数，预约科室，预约医生
	</div>
</div>

<div  class="eht-portal">
	<div class="eht-portal-title">回访情况</div>
	<div class="eht-portal-body">
	
	</div>
</div>

<div  class="eht-portal">
	<div class="eht-portal-title">问卷分类4</div>
	<div id="left" style="height: 200px;">
	dsdd
	</div>
</div>

<div  class="eht-portal">
	<div class="eht-portal-title">问卷分类5</div>
	<div id="left" style="height: 200px;">
	
	</div>
</div>

<div  class="eht-portal">
	<div class="eht-portal-title">问卷分类6</div>
	<div id="left" style="height: 200px;">
	
	</div>
</div>

<div  class="eht-portal">
	<div class="eht-portal-title">问卷分类7</div>
	<div id="left" style="height: 200px;">
	
	</div>
</div>

<div  class="eht-portal">
	<div class="eht-portal-title">问卷分类8</div>
	<div id="left" style="height: 200px;">
	
	</div>
</div>
</body>
</html>