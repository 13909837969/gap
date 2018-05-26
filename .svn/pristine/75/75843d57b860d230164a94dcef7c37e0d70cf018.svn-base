<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 孙海龙 -->
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<script type="text/javascript" src="${localCtx }/json/JZTAFService.js"></script>
<script type="text/javascript" src="${localCtx}/resources/bootstrap/js/bootstrap-typeahead.js"></script>
<title>矫正-同案犯信息表</title>
<script type="text/javascript">
$(function(){
	var query = {};
	var f_aid = "${param.id}";
	query.f_aid = f_aid;
	var jztafService = new JZTAFService();
	var tableview = new Eht.TableView({selector:'#sqjzryjbxxb_TaftableView',paginate:null});
	tableview.loadData(function(page,res){
		jztafService.findTaf(query.f_aid,page,res);
	});
})
</script>
</head>
<body>
	<div class="panel-heading" >
		<div id="sqjzryjbxxb_TaftableView" class="table-responsive">
			<div field="xm" label="姓名"></div>
			<div field="xb" label="性别" code="sys000"></div>
			<div field="csrq" label="出生日期"></div>
			<div field="zm" label="罪名"></div>
			<div field="xq" label="刑期"></div>
			<div field="jtzz" label="家庭住址"></div>
			<div field="bpcxzjszjs" label="服刑地点"></div>
		</div>
	</div>
</body>
</html>