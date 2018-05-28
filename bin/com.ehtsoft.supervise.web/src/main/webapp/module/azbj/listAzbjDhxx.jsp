<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<!-- 姜英卓 -->
<!DOCTYPE html >
<html>
<head>
<title>对话信息</title>
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<script type="text/javascript"	src="${localCtx}/json/AzbjDhxxService.js"></script>
<script type="text/javascript">
$(function(){
	var dhxx = new AzbjDhxxService();
	var azbj_query = new Eht.Form({
		selector : "#azbj_query"
		});
	var azbj_form = new Eht.Form({
		selector : "#azbj_form",
		autolayout : true
		});
	var azbj_dhxx = new Eht.TableView({
		selector : "#azbj_dhxx"
		});
	//人员数据
	azbj_dhxx.loadData(function(page, res) {
		dhxx.findDhxx(azbj_query.getData(), page, res);
	});
	//条件查询
	$("#btn_query").click(function() {
		azbj_dhxx.refresh();
	});
	//新增
	$('#btn_add').click(function() {
		azbj_form.enable();
		azbj_form.clear();
		//$("#azbj_dhxx :checkbox:checked").removeProp('checked');
		findRy(null);
		$("#btn_save").show();
		$("#azbj_modal").modal({
			backdrop : 'static'
			});
	});
	//查看一条数据
	$("#btn_view").click(function() {
		if($("#azbj_dhxx :checkbox:checked").length == 1){
			checked_id = $("#azbj_dhxx :checkbox:checked").data().aid;
			findRy(checked_id);
			$("#azbj_modal").modal({
				backdrop : 'static'
				});
			$("#btn_save").hide();
			azbj_form.disable();
			azbj_form.fill($("#azbj_dhxx :checkbox:checked").data());
		}else{
			var ale = new Eht.Alert();
			ale.show("请选中一条数据进行操作!");
		}
	});
	//编辑
	$("#btn_update").click(function() {
		if($("#azbj_dhxx :checkbox:checked").length == 1){
			checked_id = $("#azbj_dhxx :checkbox:checked").data().aid;
			findRy(checked_id);
			azbj_form.enable();
			$("#btn_save").show();
			$("#azbj_modal").modal({
				backdrop : 'static'
				});
			azbj_form.fill($("#azbj_dhxx :checkbox:checked").data());
		}else{
			var ale = new Eht.Alert();
			ale.show("请选中一条数据进行操作!");
		}
	});
	//保存
	$("#btn_save").click(function() {
		if (azbj_form.validate()) {
			var data = azbj_form.getData();
			dhxx.saveDhxx(data, new Eht.Responder({
				success : function() {
					$("#azbj_modal").modal("hide");
					new Eht.Tips().show("保存成功");
					azbj_dhxx.refresh();
				}
			}));
		}else {
			new Eht.Tips().show("保存失败");
		}
	});
	//删除
	$("#btn_delete").click(function(){
		if($("#azbj_dhxx :checkbox:checked").length == 1){
			var c = new Eht.Confirm();
			c.show("此操作不可恢复，确定要删除选中记录吗！");
			c.onOk(function(){
				dhxx.removeOne($("#azbj_dhxx :checkbox:checked").data(),new Eht.Responder({
					success:function(){
						azbj_dhxx.refresh();
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
	//帮教人员姓名
	function findRy(lvl){
		dhxx.findJz(lvl,new Eht.Responder({
			success:function(data){
				$("#azbjryid").empty();
				$("#azbjryid").append("<option></option>");
				for(var i = 0;i < data.length;i++){
					if(data[i].id == lvl){
						$("#azbjryid").append("<option value=" + data[i].id + " selected >" + data[i].xm + data[i].grlxdh + "</option>");
					}else{
						$("#azbjryid").append("<option value=" + data[i].id + ">" + data[i].xm + data[i].grlxdh + "</option>");
					}
				}
				$("#azbjryid").comboSelect();
			}
		}))
	}
})
</script>
</head>
<body>
<!-- 操作按钮部分 -->
<div class="toolbar">
	<button type="button" id="btn_add" class="btn btn-default" style="margin-left:10px;">
			<span class="glyphicon glyphicon-plus" aria-hidden="true"></span>新增</button>
	<button type="button" id="btn_view" vlaue="" class="btn btn-default" style="margin-left:10px;">
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
			<input type="text" class="form-control" name="a.xm[like]" id="xm" placeholder="姓名">
		</div>
		<div class="form-group"   style="margin-left:10px;">
			<label for="dhbt">对话标题</label>
			<input type="text" class="form-control" name="b.dhbt[like]" id="dhbt" placeholder="对话标题">
		</div>
		<button type="button" id="btn_query" class="btn btn-primary" style="margin-left:10px;">
			<span class="glyphicon glyphicon-search" aria-hidden="true"></span>查询</button>
	</div>
</form>
<div id="azbj_dhxx">
	<div field="id" label="选项" checkbox="true" width="80"></div>
	<div field="axm" label="安置帮教人员姓名" ></div>
	<div field="hfdhdbh" label="回复对话的编号" ></div>
	<div field="dhbt" label="对话标题" ></div>
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
			<div class="modal-body" id="azbj_form">
				<select id="azbjryid" name="azbjryid" label="安置帮教人员姓名" valid="{required:true}"  style="max-width:none">
				</select>
				<input type="text" name="hfdhdbh" label="回复对话的编号" valid="{required:true,number:true}" /> 
				<input type="text" name="dhbt" label="对话标题" valid="{required:true}" /> 
				<textarea  rows="8" name="dhnr"  id="dhnr" type="text" maxlength="250" label="对话内容" ></textarea>
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