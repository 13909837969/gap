<%@ page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>
<html>
<head>
<title>报警详细情况</title>
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<script type="text/javascript" src="${localCtx}/json/GMPService.js"></script>
<script type="text/javascript">
	
</script>
<style>
	.demo_line{
		height: 1px;
		border-top: 1px solid #ddd;
		text-align: center;
	}
	.control-label-a{
		text-align:center;
	}
	.control-label-b{
		display:inline-block;
	}
	.control-label-a textarea{
		width:90%;
		height:200px;
	}
</style>
</head>
<body>
	<div id="formBjxxb">
		<div class="control-label-a" id="control-label-div">
			<span class="control-label" id="xm" style="font-size:20px;font-weight:bold;"></span>
			<span class="control-label" style="font-size:20px;font-weight:bold;">2017年11月24日</span> 
			<span class="control-label" style="font-size:20px;font-weight:bold;">越界</span><br>
			<span class="control-label">报警原因:</span>
			<span class="control-label">未按照请假目的地行动</span><br>
			<div class="demo_line"><span></span></div>
			<span class="control-label">当前位置信息:</span> 
			<span class="control-label">呼和浩特市赛罕区</span>
		</div>
		<div class="control-label-a">
			<span class="control-label" style="font-size:20px;font-weight:bold;">请假信息</span>
			<div class="demo_line"><span></span></div>
			<div class="control-label-b">
				<span class="control-label">基本地址</span><br>
				<input id="querybtn" class="btn btn-default" type="button" value="呼和浩特">
			</div>
			<div class="control-label-b">
				<span class="control-label">7天</span><br>
				<span class="control-label">-----------------------------------</span><br>
				<span class="control-label">2017年11月24日至2017年11月30日</span><br>
			</div>
			<div class="control-label-b">
				<span class="control-label">目的地址</span><br>
				<input id="querybtn" class="btn btn-default" type="button" value="上海">
			</div>
		</div>
		<div class="control-label-a">
			<span class="control-label" style="font-size:20px;font-weight:bold;">处理措施</span>
			<div class="demo_line"><span></span></div>
			<span class="control-label">已经与服刑人员联系</span>&nbsp;&nbsp;&nbsp;&nbsp;
			<span class="control-label">未与服刑人员联系</span>
			<textarea name="f_wtms"></textarea>
		</div>
	</div>
</body>
</html>