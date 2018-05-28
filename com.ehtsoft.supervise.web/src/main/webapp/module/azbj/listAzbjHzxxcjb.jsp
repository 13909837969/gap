<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%--陈崇--%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>回执信息采集表</title>
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<script type="text/javascript" src="${localCtx}/json/AzbjHzxxcjbService.js"></script>
<script type="text/javascript" src="${localCtx}/json/AzbjCommonService.js"></script>
<script type="text/javascript">
$(function(){
	var commonService = new AzbjCommonService();
	var dataService = new AzbjHzxxcjbService();
	//判断是否多次加载数据
	var findFlag = false;
	//查询条件表单Form
	var form_search = new Eht.Form({selector:"#form_search",codeEmpty:true,codeEmptyLabel:"全部"});
	//安置人员明细操作页面
	var form_add = new Eht.Form({selector:"#form_add",autolayout:true});
	//列表数据显示table
	var list_table = new Eht.TableView({selector:"#list_table",multable:false});
	//展示页面信息
	list_table.loadData(function(page,res){dataService.findAll(form_search.getData(), page, res);});
	//判断是否选中的公用方法
	function checkSelected(){
		if($("#list_table :checkbox:checked").length==1){
			return true;
		}else{
			new Eht.Alert().showNotSelected();
			return false;
		}
	}
	//保存按钮操作
	$("#btn_save").click(function(){			
		var data = form_add.getData();
	   	if(form_add.validate()){
	   		dataService.saveOne(data,new Eht.Responder({
	   			success:function(){
	   				$("#modal_pop").modal("hide");
	   				new Eht.Tips().show();
	   				list_table.refresh();
	   			}
	   		}));	
	   	}
	}); 
   	//新增按钮触发事件
  	$("#btn_add").click(function(){
		findYxjry('-1');
		form_add.clear();
		form_add.enable();
	   	$("#btn_save").show();
		$("#modal_pop").modal({backdrop : 'static'});
  	 });
   	//查询按钮操作
   	$("#btn_search").click(function(){list_table.refresh();});
   	//编辑按钮事件
   	$("#btn_edit").click(function(){
   		if(checkSelected()){	
			form_add.enable();
			$("#btn_save").show();
			$("#modal_pop").modal({backdrop : 'static'});
			form_add.fill($("#list_table :checkbox:checked").data());
			findYxjry($("#list_table :checkbox:checked").data().aid);
   		}
   	});
   	//查看按钮操作
   	$("#btn_view").click(function(){
		if(checkSelected()){		
			$("#btn_save").hide();
			$("#modal_pop").modal({backdrop:'static'});
			form_add.disable();
			form_add.fill($("#list_table :checkbox:checked").data());
			findYxjry($("#list_table :checkbox:checked").data().aid);
		}	
	});
   	//删除事件
   	$("#btn_delete").click(function(){
		if(checkSelected()){	
			var c = new Eht.Confirm();
			c.showDelete();
			c.onOk(function(){
				dataService.removeOne($("#list_table :checkbox:checked").data(),new Eht.Responder({
					success:function(){
						list_table.refresh();
						c.close();
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
					$("#sel_azbjryid").empty();
					$("#sel_azbjryid").append('<option selected="selected"></option>');
					for(var i=0;i<data.length;i++){
						$("#sel_azbjryid").append("<option value="+data[i].id+">"+data[i].xm +"   "+ data[i].grlxdh + "</option>");
					}
					$("#sel_azbjryid").comboSelect();
					findFlag = true;
				}
			}));
		}
		if(ryid!='-1'){
			$("#select_azbjryid option[value="+ryid+"]").attr("selected", "selected");
		}	
	}	
});  
</script>
</head>
<body>
<!-- 操作工具条 -->
<div class="toolbar">
   	<button id="btn_add" type="button" class="btn btn-default" style="margin-left:10px;">
		<span class="glyphicon glyphicon-plus" aria-hidden="true"></span>新增</button>
   	<button id="btn_view" type="button" class="btn btn-default" style="margin-left:10px;">
		<span class="glyphicon glyphicon-eye-open" aria-hidden="true"></span>查看</button>
	<button id="btn_edit" type="button" class="btn btn-default" style="margin-left:10px;">
		<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>编辑</button>
	<button id="btn_delete" type="button" class="btn btn-default" style="margin-left:10px;">
		<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>删除</button>
</div>
<!-- 查询条件部分 -->
<form class="form-inline" style="margin:10px;">
	<div id="form_search">
		<div class="form-group">
			<label for="xm">姓名</label>
			<input type="text" class="form-control" name="xm[like]" placeholder="请输入姓名"/>
		</div>
		<div class="form-group" style="margin-left:10px;">
			<label for="hznr">回执内容</label>
			<input type="text" class="form-control" name="hznr[like]" placeholder="请输入回执内容"/>
		</div>
		<div class="form-group" style="margin-left:10px;">
			<label for="hfckzt">回执查看状态</label>
			<input type="text" class="form-control" name="hfckzt[eq]" placeholder="请选择回执查看状态" code="SYS170"/>
		</div>
		<button id="btn_search" type="button" class="btn btn-primary" style="margin-left:10px;">
			<span class="glyphicon glyphicon-search" aria-hidden="true"></span>查询</button>
   	</div>
</form>
<!-- 列表数据 -->
<div id="list_table" class="table-responsive">
	<div field="xz" label="选择" checkbox="true" width="60"></div>
	<div field="xm" label="服刑人员"></div>
	<div field="hznr" label="回执内容"></div>
	<div field="hfxxbh" label="回复信息编号"></div>
	<div field="hfnr" label="回复内容"></div>
	<div field="hfckzt" label="回执查看状态" code="SYS170"></div>
</div>
<!-- 回执信息采集内容(Modal) -->
<div class="modal fade" id="modal_pop" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
   	<div class="modal-dialog" style="width:600px;">
   		<div class="modal-content">
   			<div class="modal-header">
   				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
   				<h4 class="modal-title">回执信息采集内容</h4>
   			</div>
   			<div class="modal-body" style="height:400px; overflow:auto">
   				<div class="modal-body-div">
   					<div id="form_add">
   						<input type="hidden" name="id"/>
   						<select id="sel_azbjryid" name="azbjryid" label="服刑人员:" style="max-width:none"></select>
						<input name="hznr" label="回执内容" valid="{required:true}"/>
						<input name="hfxxbh" label="回复信息编号"/>
						<input name="hfnr" label="回复内容"valid="{required:true}"/>
						<input name="hfckzt" label="回执查看状态" code="SYS170" valid="{required:true}"/>
   					</div>
   					</div>
   			</div>
   			<div class="modal-footer">
	   			<button id="btn_save" class="btn btn-primary" type="button">保存</button>
				<button  class="btn btn-default" type="button" data-dismiss="modal">取消</button>
			</div>
   		</div>
   	</div>
</div>
</body>
</html>