<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE HTML>
<!--王世凯  -->
<html>
<head>
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<script type="text/javascript" src="${localCtx }/json/AzbjJyzfxxService.js"></script>
<script type="text/javascript" src="${localCtx}/json/AzbjCommonService.js"></script>
<title>教育走访信息管理</title>
<script type="text/javascript">
$(function() {
	var dataService = new AzbjJyzfxxService();
	var commonService = new AzbjCommonService();
	//查询条件表单Form
	var form_add = new Eht.Form({selector:"#form_add",autolayout:true});
	//列表数据显示table
	var list_table = new Eht.TableView({selector:"#list_table"});
	//查询条件表单Form
	var form_search = new Eht.Form({selector:"#form_search",codeEmpty:true,codeEmptyLabel:"全部"});
	//展示页面信息
	list_table.loadData(function(page,res){dataService.findAll(form_search.getData(),page,res);});
	//模糊查询
	$("#btn_search").click(function(){list_table.refresh();});
	//判断是否多次加载数据
	var findFlag = false;
	//判断是否选中的公用方法
	function checkSelected(){
		if($("#list_table :checkbox:checked").length==1){
			return true;
		}else{
			new Eht.Alert().showNotSelected();
			return false;
		}
	}
	//已衔接人员姓名检索框
	function findYxjry(ryid){
		if (!findFlag){
			commonService.findYxjry(new Eht.Responder({
				success:function(data){
					$("#sel_id").empty();
					$("#sel_id").append('<option selected="selected"></option>');
					for(var i=0;i<data.length;i++){
						$("#sel_id").append("<option value="+data[i].id+">"+data[i].xm +"   "+ data[i].grlxdh + "</option>");
					}
					$("#sel_id").comboSelect();
					findFlag = true;
				}
			}));
		}else{
			if(ryid!='-1'){
				$("#sel_id option[value="+ryid+"]").attr("selected", "selected");
			}
		}
	}
	//新增按钮触发事件
	$("#btn_add").click(function(){
		form_add.clear();
		form_add.enable();
		findYxjry('-1');
		$("#btn_save").show();
		$("#modal_jyzf").modal({backdrop:'static'})
	});
	//点击查看时显示代码只读
	$("#btn_view").click(function(){
		if(checkSelected()){
			form_add.clear();
			$("#modal_jyzf").modal({backdrop:'static'});
			$("#btn_save").hide();
			form_add.disable();
			findYxjry($("#list_table :checkbox:checked").data().jid);
			form_add.fill($("#list_table :checkbox:checked").data());
		}
	});
	//编辑按钮事件
	$("#btn_edit").click(function(){
		form_add.clear();
		if(checkSelected()){
		form_add.enable();
		$("#btn_save").show();
		findYxjry($("#list_table :checkbox:checked").data().jid);
		$("#modal_jyzf").modal({backdrop : 'static'});
		form_add.fill($("#list_table :checkbox:checked").data());
		}
	});
	//删除按钮事件
	$("#btn_delete").click(function(){
		if(checkSelected()){
			$("#btn_save").show();
			var confirm = new Eht.Confirm();
			confirm.showDelete();
			confirm.onOk(function(){
				dataService.removeJyzf($("#list_table :checkbox:checked").data().id,new Eht.Responder({
					success:function(){
						list_table.refresh();
						confirm.close();
						new Eht.Tips().show();
					}
				}));
			});
		}
	});
	$('#btn_save').click(function(){
		if(form_add.validate()){
    		dataService.saveJyzf(form_add.getData(),new Eht.Responder({
    			success:function(){$("#modal_jyzf").modal("hide");
    				new Eht.Tips().show();
    				list_table.refresh();
    			}
    		}));
		  }
		});
});
</script>
</head>
<body>
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
	<button type="button" id="btn_delete" class="btn btn-default" style="margin-left:10px;">
		<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>删除
	</button>
</div>
<form class="form-inline" style="margin: 10px;">
	<div id="form_search">
		<div class="form-group" style="margin-left: 10px">
			<label for="xm">姓名</label>
			<input type="text" class="form-control" name="xm[like]" placeholder="请输入姓名">
		</div>
		<div class="form-group" style="margin-left: 10px">
			<label for="zfrq">走访日期</label> 
			<input type="text" name="zfrq[eq]" class="form_date btn btn-default" data-date-formate="yyyy-MM-dd" data-date-formate="yyyy-MM-dd" placeholder="走访日期">
		</div>
		<button type="button" id="btn_search" class="btn btn-primary" style="margin-left: 10px;">
			<span class="glyphicon glyphicon-search" aria-hidden="true"></span>查询
		</button>
	</div>
</form>
<div id="list_table" class="table-responsive">
	<div field="xzk" label="选择" checkbox="true" width="60px;"></div>
	<div field="xm" label="姓名"></div>
	<div field="zfrq" label="走访日期"></div>
	<div field="zfdd" label="走访地点"></div>
	<div field="thnr" label="谈话内容"></div>
	<div field="zfxg" label="走访效果"></div>
</div>
<!-- 新增帮教人员信息(Modal) -->
<div class="modal fade" id="modal_jyzf" tabindex="-1" role="dialog" aria-labelledby="ModalLabel" aria-hidden="true">
	<div class="modal-dialog" style="width:600px;">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="ModalLabel">教育走访信息</h4>
			</div>
			<div class="modal-body" style="overflow: auto; height: 450px;">
				<div id="form_add">
					<input type="hidden" name="id"> 
					<select id="sel_id" name="aid" label="人员姓名" style="max-width: none" placeholder="姓名" valid="{required:true}"></select> 
					<input type="text" name="zfrq" class="form_date" data-date-formate="yyyy-MM-dd" label="走访日期" placeholder="走访日期" valid="{required:true}"> 
					<input type="text" name="zfdd" label="走访地点" placeholder="走访地点" valid="{required:true}"/>
					<input type="text" name="thnr" label="谈话内容" placeholder="谈话内容" valid="{required:true}"/>
					<input type="text" name="zfxg" label="走访效果" placeholder="走访效果" valid="{required:true}"/>
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