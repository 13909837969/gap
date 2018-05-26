<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 孙海龙 -->
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<script type="text/javascript" src="${localCtx }/json/RmtjWyhService.js"></script>
<title>人民调解--委员会基本信息</title>
<script type="text/javascript">
	$(function(){
		var service = new RmtjWyhService();
		var tableView = new Eht.TableView({selector:"#listRmtj_wyhjbxx #tableview"});
		//页面数据展示
		var query = {};
		tableView.loadData(function(page,res){
			service.findAllWyh(query,page,res);
		})
		//查询按钮触发事件
		$("#listRmtj_wyhjbxx #search").click(function(){
			query["twhbm[like]"] = $("#search-bm").val();
			query["twhmc[like]"] = $("#search-mc").val();
			tableView.refresh();
		})
	})
</script>
</head>
<body>
	<div class="panel panel-default" id="listRmtj_wyhjbxx">
		<div class="panel-heading">
			<fieldset>
				<input type="text" id="search-bm" class="btn btn-default" placeholder="请输入委员会编码"/>
				<input type="text" id="search-mc" class="btn btn-default" placeholder="请输入委员会名称"/>
				<input type="button" id="search" class="btn btn-default" value="查询"/>
			</fieldset>
		</div>
		<div class="panel-body" style="text-align:center;" id="tableview">
			<div field="twhbm" label="调委会编码"></div>
			<div field="twhmc" label="调委会名称"></div>
			<div field="twhlx" label="调委会类型"></div>
			<div field="zztjyrs" label="专职调解员人数"></div>
			<div field="jztjyrs" label="兼职调解员人数"></div>
			<div field="lxdz" label="联系地址"></div>
			<div field="fzr" label="负责人"></div>
			<div field="clrq" label="成立日期"></div>
		</div>
	</div>
</body>
</html>