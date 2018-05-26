<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 孙海龙 -->
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<script type="text/javascript" src="${localCtx }/json/JzjzlxxService.js"></script>
<title>矫正-禁止令信息表</title>
<script type="text/javascript">
$(function(){
	var query = {};
	var f_aid = "${param.id}";
	query.f_aid = f_aid;
	var jzjzlxxService = new JzjzlxxService();
	var tableview = new Eht.TableView({selector:'#sqjzryjbxxb_JzltableView',paginate:null});
	tableview.loadData(function(page,res){
		jzjzlxxService.findJzlxx(query.f_aid,page,res);
	});
})
</script>
</head>
<body>
	<div class="panel-body">
		<div id="sqjzryjbxxb_JzltableView" class="table-responsive">
				
				<div field="jzllx" label="禁止令类型" code="SYS053"></div>
				<div field="jrlx" label="禁入类型" code="sys101"></div>
				<div field="jzqxksrq" label="禁止令期限开始日期"></div>
				<div field="jzqxjsrq" label="禁止令期限结束日期"></div>
				<div field="tdqyzb" label="特定区域坐标"></div>
		</div>
	</div>
</body>
</html>