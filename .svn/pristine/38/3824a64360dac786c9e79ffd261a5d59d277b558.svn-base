<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE HTML>
<!--黄炜  -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<script type="text/javascript" src="${localCtx }/json/AzbjRytgxxcjbService.js"></script>
<title>人员脱管信息管理</title>
<script type="text/javascript">
$(function() {
	var query = {};
	// 人员信息查询条件
	var rytg = new AzbjRytgxxcjbService();
	// 人员信息显示
	var tableview = new Eht.TableView({
		selector : "#tableview"
	});
	// 模糊查询数据
	var qf = new Eht.Form({
		selector:"#query_form",
		codeEmpty:true,
		codeEmptyLabel:"全部"
	});
	// 新增编辑数据
	var form = new Eht.Form({
		selector:"#rytg_form",
		autolayout:true
	});
	// 选择标签的id
	var checked_id = null;
	// 展示页面信息
	tableview.loadData(function(page, res) {
		rytg.findAll(qf.getData(), page, res);
	});
	// 模糊查询
	$("#btn_query").click(function() {
		tableview.refresh();
	});
	// 新增按钮触发事件
	$("#btn_add").click(function() {
		form.enable();
		form.clear();
		checked_id = -1;
		$("#btn_submit").show();
		findRy();
		$("#myModal").modal({
			backdrop : 'static'
		});
	});
	// 点击查看时显示数据只读
	$("#btn_check").click(function(){
		if($("#tableview :checkbox:checked").length == 1){
			checked_id = $("#tableview :checkbox:checked").data().aid;
			findRy();
			$("#myModal").modal({
				backdrop : 'static'
			});
			$("#btn_submit").hide();
			form.fill($("#tableview :checkbox:checked").data());
			form.disable();
		}else{
			wxzts();
		}
	});
	// 修改按钮事件
	$("#btn_deitor").click(function() {
		if ($(":checkbox:checked").length == 1) {
			form.enable();
			form.clear();
			checked_id = $("#tableview :checkbox:checked").data().aid;
			findRy();
			$("#btn_submit").show();
			$("#myModal").modal({backdrop : 'static'});
			form.fill($(":checkbox:checked").data());
			tableview.refresh();
		}else{
			wxzts();
		}
	});
	// 删除按钮事件
	$("#btn_delete").click(function() {
		var sd_ry = tableview.getSelectedData();
		if (sd_ry.length == 1) {
		var c = new Eht.Confirm();
			c.show("请确认是否删除！");
			c.onOk(function() {
			    rytg.removeOne($(":checkbox:checked").data().id,
				new Eht.Responder({
					success : function() {
						c.close();
						new Eht.Tips().show("删除成功");
						tableview.refresh();
					}
				}));
			});
		}else{
			wxzts();
		}
	});
	// 未选中提示
	function wxzts(){
		var ale = new Eht.Alert();
		ale.show("请选中一条数据进行操作!");
		tableview.refresh();
	}
	// 模态框保存并且隐藏
	$('#btn_submit').click(function() {
		if (form.validate()) {
			rytg.saveOne(form.getData(), new Eht.Responder({
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
	// 模态框查询人员脱管信息
	function findRy(){
		rytg.findJz(new Eht.Responder({
			success:function(data){
				$("#jzryxx_xmajglx").empty();
				$("#jzryxx_xmajglx").append('<option></option>');
				console.log(data);
				for(var i=0;i<data.length;i++){
					if(data[i].id == checked_id){
						$("#jzryxx_xmajglx").append("<option value="+data[i].id+" selected>"+data[i].xm +    +data[i].grlxdh+"</option>");
					}else{
						$("#jzryxx_xmajglx").append("<option value="+data[i].id+">"+data[i].xm +    +data[i].grlxdh+"</option>");
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
    <div class="toolbar" id="toolbar">
		<button type="button" id="btn_add" class="btn btn-default" style="margin-left:10px;">
			<span class="glyphicon glyphicon-plus" aria-hidden="true"></span>新增
		</button>
		<button type="button" id="btn_check" class="btn btn-default" style="margin-left:10px;">
			<span class="glyphicon glyphicon-eye-open" aria-hidden="true"></span>查看
		</button>
		<button type="button" id="btn_deitor" class="btn btn-default" style="margin-left:10px;">
			<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>编辑
		</button>
		<button type="button" id="btn_delete" class="btn btn-default" style="margin-left:10px;">
			<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>删除
		</button>		
	</div>
	<form class="form-inline" id="query_form" style="margin:10px;">
		<div id="query_ryxj_form">
			<div class="form-group" style="margin-left:10px;">
				<label for="xm">姓名</label>
				<input id="query_xm" type="text" class="form-control" name="xm[like]" placeholder="姓名">
			</div>
			<div class="form-group" style="margin-left:10px;">
				<label for="sftg">是否脱管</label>
				<select class="form-control" name="sftg[like]" id="select_id">
					<option value ="">请选择</option>
  					<option value ="是">是</option>
  					<option value ="否">否</option>
				</select>
			</div>
			<div class="form-group" style="margin-left:10px;" >
				<label for="tgsj">脱管时间</label>
				<input id="query_tgsj" type="text" name="tgsj[like]" valid="{required:true}" class="form_date form-control" data-date-format="yyyy-MM-dd"/>
			</div>
			<div class="form-group" style="margin-left:10px;" >
				<label for="tgyy">脱管原因</label>
				<input id="query_tgyy" type="text" class="form-control" name="tgyy[like]" placeholder="脱管原因" />
			</div>
			<button type="button" id="btn_query" class="btn btn-primary" style="margin-left:10px;">
			<span class="glyphicon glyphicon-search" aria-hidden="true"></span>查询</button>
		</div>
	</form>
	<div id="tableview">
		<div field="xx" label="选择" checkbox="true" width="60"></div>
		<div field="xm" label="姓名" ></div>
		<div field="sftg" label="是否脱管"></div>
		<div field="tgsj" label="托管时间" ></div>
		<div field="tgyy" label="脱管原因"></div>
	</div>
	<!-- 新增脱管人员信息(Modal) -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="myModalLabel">人员脱管</h4>
	      </div>
	      <div class="modal-body">
	      	<div id="rytg_form">
	      		<input type="hidden" name="id"/>
	         	<select id="jzryxx_xmajglx" name="aid" label="姓名" style="max-width:none" valid="{required:true}"></select>
	         	<input type="text" name="sftg" id="sftg" label="是否脱管" placeholder="是/否" valid="{required:true}"/>
				<input id="tgsj" type="text" name="tgsj" label="托管时间" valid="{required:true}" class="form_date form-control" data-date-format="yyyy-MM-dd"/>	         	
				<input type="text" name="tgyy" id="tgyy" label="脱管原因" valid="{required:true}"/>
	         </div>
	      </div>
	      <div class="modal-footer">
	        <button type="button" id="btn_submit" class="btn btn-primary">保存</button>
	        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
	      </div>
	    </div>
	  </div>
	</div>
</body>
</html>