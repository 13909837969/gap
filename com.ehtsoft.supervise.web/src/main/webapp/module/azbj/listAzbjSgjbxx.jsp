<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%-- 王维 --%>
<!DOCTYPE html>
<html>
<head>
<title>双管信息采集模块</title>
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<script type="text/javascript" src="${localCtx}/json/AzbjSgjbxxService.js"></script>
<script type="text/javascript" src="${localCtx}/json/AzbjCommonService.js"></script>
<script type="text/javascript">
$(function(){
	var dataService = new AzbjSgjbxxService();
	var commonService = new AzbjCommonService();
	//判断是否多次加载数据
	var findFlag = false;
	//查询条件表单Form
	var form_search = new Eht.Form({selector:"#form_search",codeEmpty:true,codeEmptyLabel:"全部"});
	//双管信息明细操作页面
	var form_add = new Eht.Form({selector:"#form_add",autolayout:true});
	//列表数据显示table
	var list_table = new Eht.TableView({selector:"#list_table",autolayout:true});
	//加载页面信息
	list_table.loadData(function(page, res){
		dataService.findBjxzxx(form_search.getData(), page, res);
	});
	//人员查询按钮
	$("#btn_search").click(function(){list_table.refresh();});
	//增加按钮操作
	$('#btn_add').click(function(){
		form_add.clear();
		form_add.enable();
		check_id=null;
		findYxjry('-1');
		$("#btn_save").show();
		$("#model_azbj").modal({backdrop:'static'});
	});
	//保存按钮事件
	$("#btn_save").click(function(){
		if (form_add.validate()) {
			var data = form_add.getData();
			dataService.saveBjxzxx(data, new Eht.Responder({
				success : function(){
					$("#model_azbj").modal("hide");
					new Eht.Tips().show("保存成功");
					list_table.refresh();
				}
			}));
		}
	});	
	//判断是否选中的公用方法
	function checkSelected(){
		if($("#list_table :checkbox:checked").length==1){
			return true;
		}else{
			new Eht.Alert().showNotSelected();
			return false;
		}
	}
	//编辑按钮事件
	$("#btn_edit").click(function(){
		if(checkSelected()){			
			form_add.enable();
			$("#btn_save").show();
			$("#model_azbj").modal({backdrop : 'static'});
			form_add.fill($("#list_table :checkbox:checked").data());
			findYxjry($("#list_table :checkbox:checked").data().aid);
		}
	});	
	//查看按钮事件
	$("#btn_view").click(function(){
		if(checkSelected()){
			$("#model_azbj").modal({backdrop:'static'});
			$("#btn_save").hide();
			form_add.disable();
			form_add.fill($("#list_table :checkbox:checked").data());
			findYxjry($("#list_table :checkbox:checked").data().aid);
		}
	});	
	//删除按钮事件
	$("#btn_delete").click(function(){
		if(checkSelected()){
			var confirm = new Eht.Confirm();
			confirm.showDelete();
			confirm.onOk(function(){
				dataService.removeOne($("#list_table :checkbox:checked").data(),new Eht.Responder({
					success:function(){
						list_table.refresh();
						confirm.close();
						new Eht.Tips().show();
					}
				}));
			});
		};
	});
	//已衔接人员姓名检索框
	function findYxjry(ryid){
		if (!findFlag){
			commonService.findYxjry(new Eht.Responder({
				success:function(data){
					$("#sel_xm").empty();
					$("#sel_xm").append('<option selected="selected"></option>');
					for(var i=0;i<data.length;i++){
						$("#sel_xm").append("<option value="+data[i].id+">"+data[i].xm +"   "+ data[i].grlxdh + "</option>");
					}
					$("#sel_xm").comboSelect();
					findFlag = true;
				}
			}));
			if(ryid!='-1'){
				$("#sel_xm option[value="+ryid+"]").attr("selected", "selected");
			}
		}
	};	
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
	<button type="button" id="btn_edit" class="btn btn-default" style="margin-left:10px;">
		<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>编辑</button>
	<button type="button" id="btn_delete"  class="btn btn-default" style="margin-left:10px;">
		<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>删除</button>			
</div>
<!-- 查询条件部分 -->
<form class="form-inline" style="margin:10px;">
	<div id="form_search">
		<div class="form-group">
			<label for="xm">姓名</label>
			<input type="text" class="form-control" name="a.xm[like]" placeholder="姓名"/>
		</div>
		 <div class="form-group"   style="margin-left:10px;">
			<label for="sqyy">申请原因</label>
			<input type="text" class="form-control" name="b.sqyy[like]" placeholder="申请原因"/>
		</div>
		<div class="form-group"   style="margin-left:10px;">
			<label for="gfhtmc">购房合同名称</label>
			<input type="text" class="form-control" name="b.gfhtmc[like]" placeholder="购房合同名称"/>
		</div>
		<div class="form-group"   style="margin-left:10px;">
			<label for="zfhtmc">租房合同名称</label>
			<input type="text" class="form-control" name="b.zfhtmc[like]" placeholder="租房合同名称"/>
		</div>
		<div class="form-group"   style="margin-left:10px;">
			<label for="gzhtmc">工作合同名称</label>
			<input type="text" class="form-control" name="b.gzhtmc[like]" placeholder="工作合同名称"/>
		</div>
		<div class="form-group"   style="margin-left:10px;">
			<label for="sqsj">申请时间</label>
			<input type="text" name="b.sqsj[like]" class="form_date form-control" data-date-format="yyyy-MM-dd" />
		</div>
		<button type="button" id="btn_search" class="btn btn-primary" style="margin-left:10px;">
			<span class="glyphicon glyphicon-search" aria-hidden="true"></span>查询</button>
	</div>
</form>
<!-- 列表数据 -->
<div id="list_table">
	<div field="id" label="选项" checkbox="true" width="60"></div>
	<div field="xm" label="姓名"></div>
	<div field="sqyy" label="申请原因"></div>
	<div field="gfhtmc" label="购房合同名称"></div>
	<div field="zfhtmc" label="租房合同名称"></div>
	<div field="gzhtmc" label="工作合同名称"></div>
	<div field="sqsj" label="申请时间"></div>
	<div field="spzt" label="审批状态"></div>
</div>
<!-- 模态安置人员信息 -->
<div class="modal fade" id="model_azbj" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"> 
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="myModalLabel">帮教小组信息</h4>
			</div>
			<div class="modal-body">
				<div id="form_add">
					<input type="hidden" name="id">
					<select id="sel_xm" name="azbjryid" label="安置帮教人员姓名" style="max-width:none"></select>
					<input type="text" name="sqyy" label="申请原因" valid="{required:true}"/> 
					<input type="text" name="gfhtmc" label="购房合同名称"/> 
					<input type="text" name="zfhtmc" label="租房合同名称"/> 
					<input type="text" name="gzhtmc" label="工作合同名称"/>
					<input type="text" name="qtzmcl" label="其他证明材料"/>
					<input type="text" name="sqsj" label="申请时间" class="form_date" data-date-formate="yyyy-MM-dd"/> 
					<input type="text" name="spzt" label="审批状态" valid="{required:true}"/>
					<input type="text" name="spyj" label="审批意见" valid="{required:true}"/>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" id="btn_save" class="btn btn-primary">保存</button>
				<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
			</div>
		</div>
	</div>
</div>
</body>
</html>