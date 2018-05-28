<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE HTML>
<!--李世伟  -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<script type="text/javascript" src="${localCtx }/json/AzbjBjxxglService.js"></script>
<title>帮教信息管理</title>
<script type="text/javascript">
$(function() {
	var service = new AzbjBjxxglService();
	var form = new Eht.Form({
		selector : '#bjxxglForm',
		autolayout : true
	});
	var tableview = new Eht.TableView({
		selector : '#tableview'
	});
	var qf = new Eht.Form({
		selector : "#query_form",
		codeEmpty : true,
		codeEmptyLabel : "全部"
	});
	v = null;
	//展示页面信息
	tableview.loadData(function(page, res) {
		service.findAll(qf.getData(), page, res);
	});
	//模态框新增人员信息事件
	function findRy() {
		service.findJz(new Eht.Responder({
			success : function(data) {
				$("#azbjryid").empty();
				$("#azbjryid").append('<option></option>');
				for (var i = 0; i < data.length; i++) {
					if (data[i].id == v) {
						$("#azbjryid").append(
								"<option value=" + data[i].id+" selected>"
										+ data[i].xm + data[i].grlxdh
										+ "</option>");
					} else {
						$("#azbjryid").append(
								"<option value=" + data[i].id+">"
										+ data[i].xm + data[i].grlxdh
										+ "</option>");
					}
				}
				$("#azbjryid").comboSelect();
			}
		}))
	}
	//获取当前选中行的数据
	form.fill($("#tableview :checkbox:checked").data());
	//新增按钮事件
	$('#btn_add').click(function() {
		form.clear();
		findRy();
		$('#myModal').modal({
			backdrop : 'static'
		});
		form.enable();
	});
	//点击查询时查模糊查询
	$("#btn_search").click(function() {
		tableview.refresh();
	});
	//修改按钮事件
	$("#btn_edit").click(function() {
		if($("#tableview :checkbox:checked").length==1){
			v = $("#tableview :checkbox:checked").data().aid;
			findRy();
			form.enable();
			$("#btn_submit").show();
			$("#myModal").modal({backdrop : 'static'});
			form.fill($("#tableview :checkbox:checked").data());
		}else {
			var ale = new Eht.Alert();
			ale.show("请选中一条数据进行操作!");
			tableview.refresh();
		}
		
	});
	//删除按钮事件
	$("#btn_delete").click(function() {
		if($("#tableview :checkbox:checked").length == 1){
			var c = new Eht.Confirm();
			c.show("此操作不可恢复，确定要删除选中记录吗！");
			c.onOk(function(){
				service.removeOne($("#tableview :checkbox:checked").data(),new Eht.Responder({
					success:function(){
						tableview.refresh();
						c.close();
						new Eht.Tips().show("删除成功");
					}
				}));
			});
		}else{
			var ale = new Eht.Alert();
			ale.show("请选中一条数据进行操作!");
		}
	});
	//查看按钮触发事件
	$("#btn_view").click(function() {
		if($("#tableview :checkbox:checked").length==1){
			v = $('#tableview :checkbox:checked').data().aid;
			findRy();
			$("#myModal").modal({backdrop : 'static'});
			$("#btn_submit").hide();
			form.disable();
			form.fill($("#tableview :checkbox:checked").data());
		}else {
			var ale = new Eht.Alert();
			ale.show("请选中一条数据进行操作!");
			tableview.refresh();
		}
	});
	//模态框保存并且隐藏
	$('#btn_submit').click(function() {
		  if (form.validate()) { 
			service.saveOne(form.getData(), new Eht.Responder({
				success : function(data) {
					$('#myModal').modal('hide');
					new Eht.Tips().show("保存成功");
					tableview.refresh();
				}
			}));
		 }else{
			new Eht.Tips().show("保存失败");
		}  
	});
});
</script>
</head>
<body>
	<div class="toolbar">
		<button type="submit" id="btn_add" class="btn btn-default" style="margin-left: 10px;">
			<span class="glyphicon glyphicon-plus" aria-hidden="true"></span>新增
		</button>
		<button type="submit" id="btn_view" class="btn btn-default" style="margin-left: 10px;">
			<span class="glyphicon glyphicon-eye-open" aria-hidden="true"></span>查看
		</button>
		<button type="submit" id="btn_edit" class="btn btn-default" style="margin-left: 10px;">
			<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>编辑
		</button>
		<button type="submit" id="btn_delete" class="btn btn-default" style="margin-left: 10px;">
			<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>删除
		</button>
	</div>
	<form class="form-inline" style="margin: 10px;">
		<div id="query_form">
			<div class="form-group" style="margin-left: 10px">
				<label for="xm">姓名</label>
				<input type="text" class="form-control" name="xm[like]" id="xm" placeholder="请输入姓名">
			</div>
			<div class="form-group" style="margin-left: 10px">
				<label for="sfbj">是否帮教</label>
				<input type="text" class="form-control" name="sfbj[eq]" id="sfbj" code="sys001" placeholder="是否帮教" >
			</div>
			<div class="form-group" style="margin-left: 10px">
				<label for="sfbj">帮教时间</label> 
				<input type="text" name="bjsj[eq]" class="form_date btn btn-default" data-date-formate="yyyy-MM-dd"  id="bjsj" data-date-formate="yyyy-MM-dd" placeholder="帮教时间">
			</div>
			<div class="form-group" style="margin-left: 10px">
				<label for="bjbx">帮教表现</label> 
				<input type="text" class="form-control" name="bjbx[eq]" id="bjbx" code="sys159" placeholder="帮教表现" >
			</div>
			<button type="button" id="btn_search" class="btn btn-primary" style="margin-left: 10px;">
				<span class="glyphicon glyphicon-search" aria-hidden="true"></span>查询
			</button>
		</div>
	</form>
	<div id="tableview" class="table-responsive">
		<div field="xzk" label="选择" checkbox="true"></div>
		<div field="xm" label="姓名"></div>
		<div field="sfbj" label="是否帮教" code="sys001"></div>
		<div field="bjsj" label="帮教时间"></div>
		<div field="bjbx" label="帮教表现" code="sys159"></div>
		<div field="sfshzzcybj" label="是否社会组织参与帮教" code="sys001"></div>
	</div>
	<!-- 新增帮教人员信息(Modal) -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalLabel">帮教管理信息</h4>
				</div>
				<div class="modal-body" style="overflow: auto; height: 600px;">
					<div class="modal-body-div">
						<div id="bjxxglForm">
							<input type="hidden" name="id"> 
							<select id="azbjryid" name="azbjryid" label="姓名"style="max-width: none" placeholder="姓名" ></select> 
							<input type="text" name="sfbj" label="是否帮教" placeholder="是否帮教" code="sys001"valid="{required:true} " placeholder="是否帮教" > 
							<input type="text" name="bjsj" class="form_date btn btn-default" data-date-formate="yyyy-MM-dd" label="帮教时间" placeholder="帮教时间" valid="{required:true}"> 
							<input type="text" name="bjbx" label="帮教表现" code="sys159" placeholder="帮教表现" />
							<input type="text" name="sfshzzcybj" label="是否社会组织参与帮教" code="sys001" placeholder="是否社会组织参与帮教"  valid="{required:true}"/>
						</div>
					</div>
					<div class="modal-footer">
						<button id="btn_submit" class="btn btn-primary" type="button">保存</button>
						<button class="btn btn-default" type="button" data-dismiss="modal">取消</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>