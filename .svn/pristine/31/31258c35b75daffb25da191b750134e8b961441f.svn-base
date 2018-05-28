<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!-- 吴涛  家庭成员信息 -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<script type="text/javascript" src="${localCtx }/json/AzbjJtcyxxService.js"></script>
<title>家庭成员信息</title>
<script type="text/javascript">
$(function() {
	//获取service类的对象
	var azbj = new AzbjJtcyxxService();	
	//对应着下拉菜单里边的数据  就是点击增加按钮弹出的对话框
	var form = new Eht.Form({selector:"#azbj_form",autolayout:true});
	//对应着表中的字段和数据
	var tableview = new Eht.TableView({selector : "#tableview"});
	//对应着查询条件  和查询条件有关的
	var qf = new Eht.Form({selector:"#query_form",codeEmpty:true,codeEmptyLabel:"全部"});
	
	var checked_id = null;
	//展示页面信息
	tableview.loadData(function(page, res) {
		azbj.findAll(qf.getData(), page, res);
	});
	//点击查询按钮
	$('#btn_cha').click(function() {
		tableview.refresh();
	});
	//新增按钮触发事件
	$('#btn_add').click(function(){
		form.clear();
		checked_id = '-1';
		findRy();
		$('#myModal').modal({backdrop:'static'});
		$('#btn_submit').show();
		$('#btn_close').show();
		form.enable();
	});
	//查看按钮触发事件
	$('#btn_view').click(function(){
		if($(":checkbox:checked").length == 1){
			checked_id = $("#tableview :checkbox:checked").data().aid;
			findRy();
		$('#myModal').modal();
		$('#btn_submit').hide();
		$('#btn_close').hide();
		form.fill($(":checkbox:checked").data());
		form.disable();
		}else{
			var ale = new Eht.Alert();
			ale.show("请选中其中一条数据进行操作！");
		}
	});
	//人员编辑按钮 点击按钮 对选中人员信息进行编辑
	$("#btn_update").click(function() {
		if ($(":checkbox:checked").length == 1) {
			checked_id = $("#tableview :checkbox:checked").data().aid;
			findRy();
			form.enable();
			form.clear();
			$("#myModal").modal({backdrop : 'static'});
			$('#btn_submit').show();
			$('#btn_close').show();
			form.fill($(":checkbox:checked").data());
			tableview.refresh();
		}else{
			var ale = new Eht.Alert();
			ale.show("请选中一条数据进行操作!");
		}
	});
	//删除按钮触发事件  点击按钮删除选中的人
	$("#btn_delete").click(
	function() {
		var sd_ry = tableview.getSelectedData();
		if (sd_ry.length == 1) {
			var c = new Eht.Confirm();
			c.show("此操作不可恢复，确定要删除选中记录吗！");
			c.onOk(function() {
			azbj.removeOne($(":checkbox:checked").data().id,
				new Eht.Responder({
				success : function() {
				c.close();
				new Eht.Tips().show("删除成功");
				tableview.refresh();
				}
			}));
			});
		}else{
			var ale = new Eht.Alert();
			ale.show("请选中一条数据进行操作!");
			tableview.refresh();
		}
	});
	//模态框保存并且隐藏  点击保存按钮保存添加的信息
	$('#btn_submit').click(function() {
		if (form.validate()) {
			azbj.saveOne(form.getData(), new Eht.Responder({
				success : function(data) {
					$('#myModal').modal('hide');
					tableview.refresh();
				}
			}));
		}
	});
	function findRy(){
		azbj.findJz(new Eht.Responder({
		success:function(data){
			$("#jzryxx_xmajglx").empty();
			$("#jzryxx_xmajglx").append('<option selected="selected"></option>');
			console.log(data);
			for(var i=0;i<data.length;i++){
				//$("#jzryxx_xmajglx").append("<option value="+data[i].id+">"+data[i].xm+"</option>");
				if(data[i].id == checked_id){
					$("#jzryxx_xmajglx").append("<option value=" + data[i].id + " selected >" + data[i].xm + "</option>");
				}else{
					$("#jzryxx_xmajglx").append("<option value=" + data[i].id + ">" + data[i].xm +"</option>");
				}
			}
			$("#jzryxx_xmajglx").comboSelect();
		}
	}));
	}
});
</script>
</head>
<body>
<div class="panel-heading">
	<div id="query_form">
		<div class="toolbar">
			<button id="btn_add" type="button" class="btn btn-default" style="margin-left:10px;">
				<span class="glyphicon glyphicon-plus" aria-hidden="true"></span>新增</button>
			<button id="btn_view" type="button" class="btn btn-default" style="margin-left:10px;">
				<span class="glyphicon glyphicon-eye-open" aria-hidden="true"></span>查看</button>
			<button id="btn_update" type="button" class="btn btn-default" style="margin-left:10px;">
				<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>修改</button>
			<button id="btn_delete" type="button" class="btn btn-default" style="margin-left:10px;">
				<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>删除</button>			
		</div>
<!-- 查询条件部分 -->
		家庭成员姓名：<input type="text" id="j.xm" name="j.xm[like]" class="btn btn-default" placeholder="姓名" />
		<!-- 这里的id应该对应着我 service里边sql语句里边的名  我在sql中查询出两个姓名  如果不标出这里的是哪个姓名 就会报错 -->
		<!-- 但是这个模糊查询的方法写在哪里了 为什么刷新一次就自动刷新出符合条件的人员信息  实在刷新的方法里实现的？ -->
		关系：<input type="text" id="gx" name="gx[like]" class="btn btn-default" placeholder="关系" />
			<button type="button" id="btn_cha" class="btn btn-primary" style="margin-left:10px;">
			<span class="glyphicon glyphicon-search" aria-hidden="true"></span>查询</button>
	</div>
</div>
	<div id="tableview" class="table-responsive">
		<div field="xzk" label="选择" checkbox=true></div>
		<div field="axm" label="安置帮教人员姓名"></div>
		<div field="xm" label="家庭成员姓名"></div>
		<div field="gx" label="关系"></div>
		<div field="nl" label="年龄"></div>
		<div field="gzdw" label="工作单位"></div>
		<div field="dh" label="电话"></div>
	</div>
<!-- 增加家庭成员Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	<div class="modal-dialog" style="width:800px;">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"> 
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="myModalLabel">家庭成员信息</h4>
			</div>
			<div class="modal-body" style="overflow: auto; height: 450px;">
				<div id="azbj_form">
					<input type="hidden" name="id"/><!-- 新加用户的id 隐藏 系统自动生成 -->
					<select id="jzryxx_xmajglx" name="azbjryid" label="安置帮教人员" style="max-width:none" valid="{required:true}"></select>
					<!-- 下拉菜单安置帮教人员姓名 id 随意  name 和家庭成员表中的字段一致 valid代表非空验证 -->
					<!-- 选择某条信息就把该条信息中的主键字段值传入到本张表外键对应的字段 -->
					<input type="text" name="xm" label="家庭成员姓名" valid="{required:true}" /> 
					<input type="text" name="gx" label="关系" valid="{required:true}" /> 
					<input type="text" name="nl" label="年龄" valid="{required:true}" />
					<input type="text" name="gzdw" label="工作单位" valid="{required:true}" /> 
					<input type="text" name="dh" label="电话" valid="{required:true}" />
				</div>
			</div>
			<div class="modal-footer">
				<button id="btn_submit" class="btn btn-primary" type="button">保存</button>
				<button id="btn_close" class="btn btn-default" type="button" data-dismiss="modal">取消</button>
			</div>
		</div>			
	</div>
</div>
</body>
</html>