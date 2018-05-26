<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 孙海龙 -->
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>矫正--矫正小组</title>
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<script type="text/javascript" src="${localCtx }/json/JzjzxzService.js"></script>
<script type="text/javascript">
$(function(){
	var query = {};
	var f_aid = "${param.id}";
	query.f_aid = f_aid;
	var jzjzxzService = new JzjzxzService();
	var tableview = new Eht.TableView({selector:'#sqjzryjbxxb_tableView',paginate:null});
	tableview.loadData(function(page,res){
		jzjzxzService.findXzcy(query.f_aid,page,res);
	});
})
</script>
</head>
<body>
	<div class="panel-heading">
		<div id="sqjzryjbxxb_tableView" class="table-responsive">
			<div field="xm" label="姓名"></div>
			<div field="xb" label="性别" code="SYS000"></div>
			<div field="xzcylx" label="成员类型" code="SYS020"></div>
			<div field="sj" label="手机"></div>
		</div>
	</div>
</body>
</html>