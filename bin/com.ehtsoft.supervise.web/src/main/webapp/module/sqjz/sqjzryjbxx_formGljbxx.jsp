<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 孙海龙 -->
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<script type="text/javascript" src="${localCtx }/json/SbglGljbService.js"></script>
<script type="text/javascript" src="${localCtx}/resources/bootstrap/js/bootstrap-typeahead.js"></script>
<title>矫正-上报管理级别信息</title>
<script type="text/javascript">
$(function(){
	var query = {};
	var f_aid = "${param.id}";
	query.f_aid = f_aid;
	var jztafService = new SbglGljbService();
	var tableview = new Eht.TableView({selector:'#sqjzryjbxxb_GljbtableView',paginate:null});
	tableview.loadData(function(page,res){
		jztafService.findAll(query,res);
	});
})
</script>
</head>
<body>
	<div class="panel-heading" >
		<div id="sqjzryjbxxb_GljbtableView" class="table-responsive">
			<div field="gljb" label="管理级别"></div>
			<div field="tzyy" label="调整原因"></div>
			<div field="bdrq" label="变动日期"></div>
			<div field="spr" label="审批人"></div>
			<div field="spsj" label="审批时间"></div>
		</div>
	</div>
</body>
</html>