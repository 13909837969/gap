<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 姜英卓 -->
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>帮教小组信息</title>
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<script type="text/javascript" src="${localCtx}/json/AzbjBjxzxxService.js"></script>
<script type="text/javascript" src="${localCtx}/json/AzbjCommonService.js"></script>
<script type="text/javascript">
$(function(){
	var dataService = new AzbjBjxzxxService();
	var commonService = new AzbjCommonService();
	//判断是否多次加载数据
	var findFlag = false;
	//查询条件表单Form
	var form_search = new Eht.Form({selector:"#form_search"});
	//列表数据显示table
	var list_table = new Eht.TableView({selector:"#list_table",multable:false});
	//安置人员明细操作页面
	var form_add = new Eht.Form({selector:"#form_add",autolayout : true});
	//加载页面信息
	list_table.loadData(function(page,res){dataService.findBjxzxx(form_search.getData(), page, res);});
	//条件查询刷新
	$("#btn_search").click(function(){list_table.refresh();});
	//增加按钮操作
	$('#btn_add').click(function(){
		form_add.clear();
		form_add.enable();
		findYxjry('-1');
		$("#btn_save").show();
		$("#modal_bjxzxx").modal({backdrop:'static'});
	});
	//查看按钮操作
	$("#btn_view").click(function(){
		if(checkSelected()){
			$("#modal_bjxzxx").modal({backdrop:'static'});
			$("#btn_save").hide();
			form_add.disable();
			form_add.fill($("#list_table :checkbox:checked").data());
			findYxjry($("#list_table :checkbox:checked").data().aid);
		}
	});
	//编辑按钮操作
	$("#btn_edit").click(function(){
		if(checkSelected()){
			form_add.enable();
			$("#btn_save").show();
			$("#modal_bjxzxx").modal({backdrop:'static'});
			form_add.fill($("#list_table :checkbox:checked").data());
			findYxjry($("#list_table :checkbox:checked").data().aid);
		}
	});
	//保存按钮触发事件
	$("#btn_save").click(function(){
		if (form_add.validate()){
			dataService.saveBjxzxx(form_add.getData(),new Eht.Responder({
				success:function(){
					$("#modal_bjxzxx").modal("hide");
					new Eht.Tips().show();
					list_table.refresh();
				}
			}));
		}
	});
	//删除按钮操作
	$("#btn_delete").click(function(){
		if(checkSelected()){
			var confirm = new Eht.Confirm();
			confirm.showDelete();
			confirm.onOk(function(){
				dataService.removeBjxzxx($("#list_table :checkbox:checked").data(),new Eht.Responder({
					success:function(){
						list_table.refresh();
						confirm.close();
						new Eht.Tips().show();
					}
				}));
			});
		}
	});
	//已衔接人员姓名检索框
	function findYxjry(ryid){
		if(!findFlag){
			commonService.findYxjry(new Eht.Responder({
				success:function(data){
					$("#select_id").empty();
					$("#select_id").append('<option selected="selected"></option>');
					for(var i = 0;i < data.length;i++){
						$("#select_id").append("<option value=" + data[i].id + ">" + data[i].xm + data[i].grlxdh + "</option>");
					}
					$("#select_id").comboSelect();
					findFlag = true;
				}
			}));
		}
		if(ryid != '-1'){
			$("#select_id option[value=" + ryid + "]").attr("selected", "selected");
		}
		
	}
	//判断是否选中的公用方法
	function checkSelected(){
		if($("#list_table :checkbox:checked").length == 1){
			return true;
		}else{
			new Eht.Alert().showNotSelected();
			return false;
		}
	}
});
</script>
</head>
<body>
<!-- 操作按钮部分 -->
<div class="toolbar">
	<button type="button" id="btn_add" class="btn btn-default" style="margin-left:10px;">
		<span class="glyphicon glyphicon-plus" aria-hidden="true"></span>新增
	</button>
	<button type="button" id="btn_view" class="btn btn-default" style="margin-left:10px;">
		<span class="glyphicon glyphicon-eye-open" aria-hidden="true"></span>查看
	</button>
	<button type="button" id="btn_edit" class="btn btn-default" style="margin-left:10px;">
		<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>编辑
	</button>
	<button type="button" id="btn_delete"  class="btn btn-default" style="margin-left:10px;">
		<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>删除
	</button>			
</div>
<!-- 查询条件部分 -->
<form class="form-inline" style="margin:10px;">
	<div id="form_search">
		<div class="form-group">
			<label for="xm">姓名</label>
			<input type="text" class="form-control" name="b.xm[like]" placeholder="姓名"/>
		</div>
		<div class="form-group" style="margin-left:10px;">
			<label for="gzdwjzw">工作单位及职务</label>
			<input type="text" class="form-control" name="b.gzdwjzw[like]" placeholder="工作单位及职务"/>
		</div>
		<button type="button" id="btn_search" class="btn btn-primary" style="margin-left:10px;">
			<span class="glyphicon glyphicon-search" aria-hidden="true"></span>查询
		</button>
	</div>
</form>
<div id="list_table">
	<div field="id" label="选项" checkbox="true" width="80"></div>
	<div field="axm" label="安置帮教人员姓名" ></div>
	<div field="xm" label="姓名"></div>
	<div field="xb" label="性别" code="SYS000"></div>
	<div field="nl" label="年龄"></div>
	<div field="gzdwjzw" label="工作单位及职务"></div>
	<div field="dh" label="电话"></div>
</div>
<!-- Modal -->
<div class="modal fade" id="modal_bjxzxx" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"> 
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="myModalLabel">帮教小组信息</h4>
			</div>
			<div class="modal-body" style="overflow:auto;height:400px;">
		      	<div id="form_add">
					<input type="hidden" name="id"/>
					<select id="select_id" name="azbjryid" label="安置帮教人员姓名" valid="{required:true}" style="max-width:none">
					</select>
					<input type="text" name="xm" label="姓名" valid="{required:true}"/> 
					<input type="text" name="xb" label="性别" valid="{required:true}" code="SYS000"/> 
					<input type="text" name="nl" label="年龄" valid="{required:true,number:true}"/> 
					<input type="text" name="gzdwjzw" label="工作单位及职务" valid="{required:true}"/> 
					<input type="text" name="dh" label="电话" valid="{required:true,mobile:true}"/>
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