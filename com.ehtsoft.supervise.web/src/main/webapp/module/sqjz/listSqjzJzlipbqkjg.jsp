<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<html>
<head>
<title>社区矫正力量配比情况监管</title>
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<script type="text/javascript" src="${localCtx}/json/SqjzjzryqkjgService.js"></script>
<script  type="text/javascript">
$(function(){
	//连接后台Service和获取资源数据
	var Service = new SqjzjzryqkjgService();
	//主界面演示引用Tablew
	var tableView = new Eht.TableView({
		selector:'#list_Jzlipbqkjg #list_Jzlipbqkjg_Interface',
		autolayout:true
	});
	var json={};
	//定义查询表单
	var form_query = new Eht.Form({selector:"#querypanel"});
	//使用后台方法给TableView主界面带入数据信息
	tableView.loadData(function(page,res){
		Service.find(form_query.getData(),page,res);
	});
	//查询按钮
	$("#list_Jzlipbqkjg #query").click(function(){
		tableView.refresh();
	});
	
	
});
</script>
</head>
<body>
<div id="list_Jzlipbqkjg">
	<div class="panel panel-default">
		<div class="panel-heading ltrhao-toolbar" style="padding-left: 20px;">
			<fieldset id="querypanel">
				司法所人员查询:<input class="btn btn-default" 	type="text" 	placeholder="请输入司法人员姓名"  name="a.xm[like]"	style="margin-left: 10px;"/>
				 矫正人员查询:<input class="btn btn-default" 	type="text" 	placeholder="请输入矫正人员姓名"  name="b.xm[like]"	style="margin-left: 10px;"/>
						  <input class="btn btn-default" 	type="button" 	id="query" 	value="查询" 	style="margin-left: 10px;"/>
			</fieldset>
		</div>
		<!-- 主界面展示数据 -->
		<div id="list_Jzlipbqkjg_Interface">
			<div  field="xm"	label="司法所人员姓名"></div>
			<div  field="xb"	label="司法所人员性别" code="sys000"></div>
			<div  field="sj"	label="司法所人员联系电话"></div>
			<div  field="sqjzryxm"	label="社区矫正人员姓名" ></div>
			<div  field="sqjzryxb"	label="社区矫正人员性别" code="sys000"></div>
			<div  field="sqjzrylxdh"	label="社区矫正人员联系电话"></div>
			
		</div>    
	</div>
</div>
</body>
</html>