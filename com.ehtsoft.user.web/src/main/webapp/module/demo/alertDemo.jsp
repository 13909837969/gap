<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Alert demo</title>
<jsp:include page="../common.jsp"></jsp:include>
<script type="text/javascript">
$(function(){
	$("#a").click(function(){
	new Eht.Alert("我阿福网方法二高房价司法局为我阿福网方法二高房价司法局为I市工商局公司上飞机为各位帅哥wig时间啊啊个I市工商局公司上飞机为各位帅哥wig时间啊啊个");
	});
	$("#b").click(function(){
		var cf = new Eht.Confirm("确认需要删除数据吗？");
		cf.clickOk(function(){
			console.log("click ok");
		});
		cf.clickNo(function(){
			console.log("click No");
		});
	});
	
	$("#c").click(function(){
		new Eht.EmpiDialog($(this).val()).clickOk(function(data){
			console.log(data);
		});
	});
});
</script>
</head>
<body>
<input type="button" value="Alert" id="a"/>
<input type="button" value="Confirm" id="b"/>
<input type="button" value="Empi Window" id="c"/>
</body>
</html>