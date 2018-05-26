<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 孙海龙 -->
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<script type="text/javascript" src="${localCtx }/json/JzysxxService.js"></script>
<title>矫正-罪犯押送信息表</title>
<script type="text/javascript">
$(function(){
	var query = {};
	var f_aid = "${param.id}";
	query.f_aid = f_aid;
	var jzysxxService = new JzysxxService();
	var tableview = new Eht.TableView({selector:'#sqjzryjbxxb_YsxxtableView',paginate:null});
	tableview.loadData(function(page,res){
		jzysxxService.findYsxx(query.f_aid,page,res);
	});
})
</script>
</head>
<body>
	<div class="panel-heading">
		<div id="sqjzryjbxxb_YsxxtableView" class="table-responsive">
			<div field="zxysjcxm" label="执行押送警察姓名"></div>
			<div field="dwjzw" label="单位及职务"></div>
			<div field="ysrq" label="押送日期"></div>
		</div>
	</div>
</body>
</html>