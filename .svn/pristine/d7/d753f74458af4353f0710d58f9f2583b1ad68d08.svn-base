<%@ page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>
<html>
<head>
<title>日常报告</title>
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<script type="text/javascript" src="${localCtx}/json/JdglService.js"></script>
<script type="text/javascript">
$(function(){
	//连接到数据库
	var service = new JdglService();
	//从servise里面获取数据填充到列表
	var tableview = new Eht.TableView({
		selector : "#list_Rcbg #list_RcbgField"
	});
	//页面显示获取数据库的信息
	tableView.loadData(function(page,res) {
		service.findPeriodicReport(query,page,res);
	});
	
	
	
});

</script>
</head>
<body>
	<div id="list_Rcbg">
		<div>
			<div class="panel panel-default">
				<div class="panel-heading ltrhao-toolbar" style="padding-left: 20px;">
					<fieldset id="querypanel">
						姓名:<input class="btn btn-default" 	type="text" 	placeholder="请输入姓名"  style="margin-left: 10px;" />
							<input class="btn btn-primary" 	type="button" 	id="query_cx" 		value="查询" 		style="margin-left: 10px;">
						 	<input class="btn btn-success" 	type="button" 	id="well" 			value="良好"		style="margin-left: 10px;">
						 	<input class="btn btn-success" 	type="button" 	id="progress" 		value="进步"		style="margin-left: 10px;">
							<input class="btn btn-success" 	type="button" 	id="continuing" 	value="继续教育"	style="margin-left: 10px;">
					</fieldset>
				</div>
				<div id="list_RcbgField">
					<div field='op' label="选择" checkbox="true"></div>
					<div field="xm" label="姓名"></div>
					<div field="bgsj" label="报告时间"></div>
					<div field="bgfs" label="报告方式"></div>
					<div field="bgnr" label="报告内容"></div>
					<div field="jlr" label="记录人"></div>
					<div field="jlsj" label="记录时间"></div>
				</div>
			</div>
		</div>
		
	</div>
</body>
</html>