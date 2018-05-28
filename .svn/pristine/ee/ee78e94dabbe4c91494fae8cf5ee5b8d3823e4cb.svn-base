<%@ page language="java" contentType="text/html; charset=utf-8"	pageEncoding="utf-8"%>
<!DOCTYPE HTML>
<!--马妍  -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<script type="text/javascript"src="${localCtx }/json/AzbjWcnznxxcjbService.js"></script>
<title>安置帮教未成年人信息采集表</title>
<script type="text/javascript">
$(function() {
	var service = new AzbjWcnznxxcjbService();
	var form = new Eht.Form({
		selector : "#wcnForm",
		autolayout : true
	});
	var tableview = new Eht.TableView({
		selector : "#tableview",
		multable : false
	});
	var qf = new Eht.Form({
		selector : "#divcx",
		codeEmpty : true,
		codeEmptyLabel : "全部"
	});
	var v = null;
	//展示页面信息
	tableview.loadData(function(page, res) {
		service.findAll(qf.getData(), page, res);
	});
	//查询按钮事件
	$("#btn_query").click(function() {
		tableview.refresh();
	});
	//新增按钮触发事件
	$("#btn_add").click(function() {
		form.clear();
		$('#myModal').modal({
			backdrop : 'static'
		});
		form.enable();
	});
	//编辑按钮事件
	$("#btn_update").click(function() {
		if ($("#tableview :checkbox:checked").length == 1) {
			v = $(':checkbox:checked').data().aid;
			$("#myModal").modal();
			form.enable();
			$("#btn_save").show();
			form.fill($("#tableview :checkbox:checked").data());
		} else {
			var ale = new Eht.Alert();
			ale.show("请选中一条数据进行操作!");
		}
	});
	//删除按钮事件
	$("#btn_delete").click(
			function() {
				if ($("#tableview :checkbox:checked").length == 1) {
					if (confirm("此操作不可恢复，确定要删除选中记录吗！")) {
						service.removeOne($("#tableview :checkbox:checked").data().id);
						new Eht.Tips().show("删除成功");
						tableview.refresh();
					}
				} else {
					var ale = new Eht.Alert();
					ale.show("请选中一条数据进行操作!");
				}
			})
	//查看
	$("#btn_select").click(function() {
		if ($("#tableview :checkbox:checked").length == 1) {
			v = $(':checkbox:checked').data().aid;
			$("#myModal").modal();
			$("#btn_save").hide();
			form.disable();
			form.fill($("#tableview :checkbox:checked").data());
		} else {
			var ale = new Eht.Alert();
			ale.show("请选中一条数据进行操作!");
		}
	});
	$("#btn_save").click(function(res) {
		var azbj_data = form.getData();
		if (form.validate(res)) {
			service.saveOne(azbj_data, new Eht.Responder({
				success : function() {
					$("#myModal").modal("hide");
					new myModal.Tips().show("保存成功");
					tableview.refresh();
				}
			}))
		} else {
			new Eht.Tips().show("保存失败");
		}
	});
	//模态框查询矫正人员信息事件
	service.findJz(new Eht.Responder({
		success : function(data) {
			$("#wcnrxx").empty();
			$("#wcnrxx").append('<option selected="selected"></option>');
			for (var i = 0; i < data.length; i++) {
				$("#wcnrxx").append(
						"<option value="+data[i].id+">" + data[i].xm
								+ data[i].grlxdh + "</option>");
			}
			$("#wcnrxx").comboSelect();
		}
	}))
});
</script>
</head>
<body>
	<div class="panel-heading">
		<fieldset>
			<button id="btn_add" class="btn btn-default">
				<span class="glyphicon glyphicon-plus" aria-hidden="true"></span>新增
			</button>
			<button id="btn_select" class="btn btn-default">
				<span class="glyphicon glyphicon-eye-open" aria-hidden="true"></span>查看
			</button>
			<button id="btn_update" class="btn btn-default">
				<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>修改
			</button>
			<button id="btn_delete" class="btn btn-default">
				<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>删除
			</button>
		</fieldset>
	</div>
	<!-- 查询 -->
	<form class="form-inline" style="margin: 10px;">
		<div id="divcx">
			<div class="form-group" style="margin-left: 10px;">
				<label for="jhrqk">监护人情况</label> 
				<input type="text" class="form-control" name="jhrqk[eq]" id="jhrqk" placeholder="监护人情况" code="sys156">
			</div>
			<div class="form-group" style="margin-left: 10px;">
				<label for="shkncd">生活困难程度</label> 
				<input type="text" class="form-control" name="shkncd[eq]" id="shkncd" placeholder="生活困难程度" code="sys157">
			</div>
			<div class="form-group" style="margin-left: 10px;">
				<label for="sfsx">是否失学</label> <input type="text"class="form-control" name="sfsx[eq]" id="sfsx" placeholder="生活困难程度"code="sys229">
			</div>
			<div class="form-group" style="margin-left: 10px;">
				<label for="sfllsh">是否流浪社会</label> 
				<input type="text" class="form-control" name="sfllsh[eq]" id="sfllsh" placeholder="是否流浪社会" code="sys230">
			</div>
			<div class="form-group" style="margin-left: 10px;">
				<label for="ywwffzxw">有无违法犯罪行为</label> 
				<input type="text" class="form-control" name="ywwffzxw[eq]" id="ywwffzxw" placeholder="有无违法犯罪行为" code="sys231">
			</div>
			<button type="button" id="btn_query" class="btn btn-primary" style="margin-left: 10px;">
				<span class="glyphicon glyphicon-search" aria-hidden="true"></span>查询
			</button>
		</div>
	</form>
	<!-- 页面显示 -->
	<div id="tableview" class="table-responsive">
		<div field="xzk" label="选择" checkbox="true"></div>
		<div field="wcnznxm" label="未成年子女姓名"></div>
		<div field="xb" label="性别" code="sys000"></div>
		<div field="jhrqk" label="监护人情况" code="sys156"></div>
		<div field="shkncd" label="生活困难程度" code="sys157"></div>
		<div field="sfsx" label="是否失学" code="sys229"></div>
		<div field="sfllsh" label="是否流浪社会" code="sys230"></div>
		<div field="ywwffzxw" label="有无违法犯罪行为" code="sys231"></div>
		<div field="csny" label="出生年月"></div>
	</div>
	<!-- 新增服刑人员未成年子女信息状态信息(Modal) -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalLabel">未成年子女信息采集表</h4>
				</div>
				<div class="modal-body" style="overflow: auto; height: 450px;">
					<div class="modal-body-div">
						<div id="wcnForm">
							<input type="hidden" name="id"> 
							<select id="wcnrxx" name="azbjryid" label="服刑人员" style="max-width: none">
							</select> 
							<input type="text" name="wcnznxm" id="wcnznxm" label="未成年子女姓名" valid="{required:true}"> 
							<input type="text" name="xb" id="xb" label="性别" code="sys000" valid="{required:true}">
							<input type="text" name="jhrqk" id="jhr"  code="sys156" label="监护人情况" valid="{required:true}"> 
							<input type="text" name="shkncd" id="shkn" code="sys157" label="生活困难程度" valid="{required:true}"> 
							<input type="text" name="sfsx" id="sx" code="sys229" label="是否失学"> 
							<input type="text" name="sfllsh" id="sh" code="sys230" label="是否流浪社会"> 
							<input type="text" name="ywwffzxw" id="xw" code="sys231" label="有无违法犯罪行为"> 
							<input type="text" name="csny" id="csny" class="form_date" data-date-formate="yyyy-MM-dd" label="出生年月" valid="{required:true}">
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button id="btn_save" class="btn btn-primary" type="button">保存</button>
					<button class="btn btn-default" type="button" data-dismiss="modal">取消</button>
				</div>
			</div>
		</div>
	</div>
</body>
</html>