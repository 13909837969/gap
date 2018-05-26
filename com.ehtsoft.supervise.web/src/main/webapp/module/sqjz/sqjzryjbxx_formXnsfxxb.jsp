<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 孙海龙 -->
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<script type="text/javascript"
	src="${localCtx }/json/JzxnsfxxService.js"></script>
<title>矫正-虚拟身份信息表</title>
<script type="text/javascript">
	$(function() {
		var query = {};
		var f_aid = "${param.id}";
		query.f_aid = f_aid;
		var jzxnsfxxService = new JzxnsfxxService();
		var tableView = new Eht.TableView({
			selector : "#sqjzryjbxx_formXnfsxxb_tableView",
			paginate : null
		});
		tableView.loadData(function(page,res) {
			console.log(query.f_aid);
			jzxnsfxxService.findJzxnsfxx(query.f_aid,page,res);
		})
	})
</script>
</head>
<body>
	<div class="panel-body">
		<div id="sqjzryjbxx_formXnfsxxb_tableView" class="table-responsive">
			<div field="lx" label="类型" code="sys052"></div>
			<div field="hm" label="号码"></div>
			<div field="remark" label="备注"></div>
		</div>
	</div>
</body>
</html>