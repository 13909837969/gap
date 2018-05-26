<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 孙海龙 -->
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<script type="text/javascript" src="${localCtx }/json/RmtjWyhService.js"></script>
<title>人民调解--调解员基本信息</title>
<script type="text/javascript">
$(function(){
	var service = new RmtjWyhService();
	var tableView = new Eht.TableView({selector:"#listRmtj_tjyjbxx #tableview"});
	//页面数据展示
	var query = {};
	tableView.loadData(function(page,res){
		service.findAllTjy(query,page,res);
	})
	//查询按钮触发事件
	$("#listRmtj_tjyjbxx #search").click(function(){
		query["twhbm[like]"] = $("#search-bm").val();
		query["twhmc[like]"] = $("#search-mc").val();
		tableView.refresh();
	})
})
</script>
</head>
<body>
	<div class="panel panel-default" id="listRmtj_tjyjbxx">
		<div class="panel-heading">
			<fieldset>
				<input type="text" id="search-bm" class="btn btn-default" placeholder="请输入委员会编码"/>
				<input type="text" id="search-mc" class="btn btn-default" placeholder="请输入委员会名称"/>
				<input type="button" id="search" class="btn btn-default" value="查询"/>
			</fieldset>
		</div>
		<div class="panel-body" style="text-align:center;">
			<div id="tableview" class="table-responsive" >
				<div field="twhbm" label="调委会编码"></div>
				<div field="tjybm" label="调解员编码"></div>
				<div field="xm" label="姓名"></div>
				<div field="sfzhm" label="身份证号"></div>
				<div field="ssdw" label="所属单位"></div>
				<div field="twhzw" label="调委会职位"></div>
				<div field="sj" label="手机"></div>
				<div field="lxdz" label="联系地址"></div>
			</div>
		</div>
	</div>
</body>
</html>