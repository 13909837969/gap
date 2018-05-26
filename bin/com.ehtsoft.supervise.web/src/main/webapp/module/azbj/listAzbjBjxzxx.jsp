<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<!-- 姜英卓 -->
<!DOCTYPE html>
<html>
<head>
<title>帮教小组信息</title>
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<script type="text/javascript"	src="${localCtx}/json/AzbjBjxzxxService.js"></script>
<script type="text/javascript">
$(function() {
	var azbj = new AzbjBjxzxxService();
	var azbj_query = new Eht.Form({selector : "#azbj_query"});
	var azbj_form = new Eht.Form({selector : "#azbj_form",autolayout : true});
	var azbj_bjxzxx = new Eht.TableView({selector : "#azbj_bjxzxx"});
	v = null;
	//人员数据
	azbj_bjxzxx.loadData(function(page, res) {
		azbj.findBjxzxx(azbj_query.getData(), page, res);
	});
	//人员查询按钮
	$("#btn_query").click(function() {
		azbj_bjxzxx.refresh();
	});
	//人员新增按钮
	$('#btn_add').click(function() {
		azbj_form.enable();
		azbj_form.clear();
		findRy();
		$("#btn_save").show();
		$("#azbj_modal").modal({backdrop : 'static'});
	});
	//模态框新增人员信息事件
	function findRy(){
		azbj.findJz(new Eht.Responder({
			success:function(data){
				$("#azbjryid").empty();
				$("#azbjryid").append('<option></option>');
				for(var i=0;i<data.length;i++){
					if(data[i].id == v){
						$("#azbjryid").append("<option value=" + data[i].id+" selected>" + data[i].xm + data[i].grlxdh + "</option>");
					}else{
						$("#azbjryid").append("<option value=" + data[i].id+">" + data[i].xm + data[i].grlxdh + "</option>");
					}
				}
				$("#azbjryid").comboSelect();
			}
		}))
	}
	
	//确认添加人员
	$("#btn_save").click(function() {
		if (azbj_form.validate()) {
			var data = azbj_form.getData();
			azbj.saveBjxzxx(data, new Eht.Responder({
				success : function() {
					$("#azbj_modal").modal("hide");
					new Eht.Tips().show("保存成功");
					azbj_bjxzxx.refresh();
				}
			}));
		}
	});
	
	//人员编辑按钮
	$("#btn_update").click(function() {
		if($(":checkbox:checked").length==1){
			v = $(':checkbox:checked').data().aid;
			findRy();
			azbj_form.enable();
			$("#btn_save").show();
			$("#azbj_modal").modal({backdrop : 'static'});
			azbj_form.fill($(":checkbox:checked").data());
		}
	});
	
	//查看人员按钮
	$("#btn_view").click(function() {
		if($(":checkbox:checked").length==1){
			v = $(':checkbox:checked').data().aid;
			findRy();
			$("#azbj_modal").modal({backdrop : 'static'});
			$("#btn_save").hide();
			azbj_form.disable();
			azbj_form.fill($(":checkbox:checked").data());
		}
	});
	
	//人员删除按钮
	$("#btn_delete").click(function(){
		if($(":checkbox:checked").length==1){
			var c = new Eht.Confirm();
			c.show("请确认是否删除！");
			c.onOk(function(){
				azbj.removeOne($(":checkbox:checked").data(),new Eht.Responder({
					success:function(){
						azbj_bjxzxx.refresh();
						c.close();
						new Eht.Tips().show();
					}
				}));
			});
		}
	})
});
</script>
</head>
<body>
<!-- 操作按钮部分 -->
<div class="toolbar">
	<button type="button" id="btn_add" class="btn btn-default" style="margin-left:10px;">
			<span class="glyphicon glyphicon-plus" aria-hidden="true"></span>新增</button>
	<button type="button" id="btn_view" class="btn btn-default" style="margin-left:10px;">
			<span class="glyphicon glyphicon-eye-open" aria-hidden="true"></span>查看</button>
	<button type="button" id="btn_update" class="btn btn-default" style="margin-left:10px;">
			<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>编辑</button>
	<button type="button" id="btn_delete"  class="btn btn-default" style="margin-left:10px;">
			<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>删除</button>			
</div>
<!-- 查询条件部分 -->
<form class="form-inline" style="margin:10px;">
	<div id="azbj_query">
		<div class="form-group">
			<label for="xm">姓名</label>
			<input type="text" class="form-control" name="b.xm[like]" id="xm" placeholder="姓名">
		</div>
		<div class="form-group"   style="margin-left:10px;">
			<label for="gzdwjzw">工作单位及职务</label>
			<input type="text" class="form-control" name="b.gzdwjzw[like]" id="gzdwjzw" placeholder="工作单位及职务">
		</div>
		<button type="button" id="btn_query" class="btn btn-primary" style="margin-left:10px;">
			<span class="glyphicon glyphicon-search" aria-hidden="true"></span>查询</button>
	</div>
</form>
<div id="azbj_bjxzxx">
	<div field="id" label="选项" checkbox="true" width="60"></div>
	<div field="axm" label="安置帮教人员姓名" ></div>
	<div field="xm" label="姓名" ></div>
	<div field="xb" label="性别" code="SYS000"></div>
	<div field="nl" label="年龄" ></div>
	<div field="gzdwjzw" label="工作单位及职务"></div>
	<div field="dh" label="电话"></div>
</div>

<!-- Modal -->
<div class="modal fade" id="azbj_modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"> 
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="myModalLabel">帮教小组信息</h4>
			</div>
			<div class="modal-body">
				<div id="azbj_form">
					<select id="azbjryid" name="azbjryid" label="安置帮教人员姓名" style="max-width:none"></select>
					<input type="text" name="xm" label="姓名" valid="{required:true}" /> 
					<input type="text" name="xb" label="性别" valid="{required:true}" code="SYS000" /> 
					<input type="text" name="nl" label="年龄" valid="{required:true,number:true}" /> 
					<input type="text" name="gzdwjzw" label="工作单位及职务" valid="{required:true}" /> 
					<input type="text" name="dh" label="电话" valid="{required:true,mobile:true}" />
				</div>
			</div>
			<div class="modal-footer" id="modal-footer">
				<button type="button" id="btn_save" class="btn btn-primary">保存</button>
				<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
			</div>
		</div>
	</div>
</div>
</body>
</html>