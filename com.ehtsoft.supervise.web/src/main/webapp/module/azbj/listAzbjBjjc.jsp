<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- 宋占成 --%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>帮教解除</title>
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<script type="text/javascript" src="${localCtx}/json/AzbjBjjcService.js"></script>
<script type="text/javascript">
$(function(){
	var dataService = new AzbjBjjcService();
	//解除帮教人员列表
	var list_table = new Eht.TableView({selector:"#list_table",multable:false});
	//查询模块
	var form_search = new Eht.Form({selector:"#form_search"});
	//模态框
	var form_add = new Eht.Form({selector:"#form_add",autolayout:true});
	//模态框查询人员信息事件
  	function findRy(){
  		dataService.findJz(new Eht.Responder({
			success:function(data){
				$("#xjry_xm").empty();
				$("#xjry_xm").append('<option></option>');
				for(var i=0;i<data.length;i++){
					$("#xjry_xm").append("<option value="+data[i].id+">" + data[i].xm + data[i].grlxdh + "</option>");
				}
				$("#xjry_xm").comboSelect();
			}
		}));
  	}
  	//判断是否选中的公用方法
	function checkSelected(){
		if($("#list_table :checkbox:checked").length==1){
			return true;
		}else{
			new Eht.Alert().showNotSelected();
			return false;
		}
	}
	//模糊查询
	list_table.loadData(function(page, res){dataService.findAzbjBjjcAll(form_search.getData(), page, res);});
	//查询刷新
	$("#btn_search").click(function(){list_table.refresh();});
	//点击新增按钮
	$("#btn_add").click(function(){
		$("#xjry_xm").css("display","block");
		findRy();
		form_add.enable();
		form_add.clear();
		$("#btn_save").show();
		$("#azbj_bjjc_modal").modal({backdrop : 'static'});
	})
	//点击查看按钮
	$("#btn_view").click(function(){
		if(checkSelected()){
			$("#xjry_xm").find("option:selected").text("");
		 	form_add.disable();
			form_add.clear();
			$("#xjry_xm").empty();
			$("#btn_save").hide();
			$("#azbj_bjjc_modal").modal({backdrop : 'static'});
			form_add.fill($("#list_table :checkbox:checked").data()); 
			var jzry_name = $("#list_table :checkbox:checked").data().xm;
			$("#xjry_xm").append("<option selected='selected' value=''>"+jzry_name+"</option>");
		}
	})
	//点击删除按钮
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
		}
	});
	//点击保存
	$("#btn_save").click(function(){
		var f_aid = form_add.getData().f_aid;
		if(form_add.validate()&&f_aid != ''){
			dataService.saveOne(form_add.getData(), new Eht.Responder({
				success : function() {
					$("#azbj_bjjc_modal").modal("hide");
					new Eht.Tips().show("保存成功");
					list_table.refresh();
				}
			}));
		}else{
			new Eht.Tips().show("保存失败");
		}
	})
})
</script>
</head>
<body>
<div class="toolbar" id="toolbar">
	<button type="button" id="btn_add" class="btn btn-default" style="margin-left: 10px;">
		<span class="glyphicon glyphicon-plus" aria-hidden="true"></span>解除
	</button>
	<button type="button" id="btn_view" class="btn btn-default" style="margin-left: 10px;">
		<span class="glyphicon glyphicon-eye-open" aria-hidden="true"></span>查看
	</button>
	<button type="button" id="btn_delete" class="btn btn-default" style="margin-left: 10px;">
		<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>删除
	</button>
</div>
<form class="form-inline" style="margin: 10px;">
	<div id="form_search">
		<div class="form-group">
			<label for="xm">姓名</label> 
			<input id="query_xm" type="text" class="form-control" name="xm[like]">
		</div>
		<div class="form-group" style="margin-left: 10px;">
			<label for="jcsj">解除时间</label> 
			<input id="query_xjsj" type="text" name="jcsj[eq]" class="form_date form-control" data-date-format="yyyy-MM-dd" />
		</div>
		<div class="form-group" style="margin-left: 10px;">
			<label for="jcyy">解除原因</label> 
			<input id="query_xjtj" type="text" name="jcyy[like]" class="form-control" code="SYS169"/>
		</div>
		<button type="button" id="btn_search" class="btn btn-primary" style="margin-left: 10px;">
			<span class="glyphicon glyphicon-search" aria-hidden="true"></span>查询
		</button>
	</div>
</form>
<div class="tab-pane active" id="list_table">
	<div field="xx1" label="选项" width="80" checkbox=true></div>
	<div field="xm" label="姓名"></div>
	<div field="jcsj" label="解除时间"></div>
	<div field="jcyy" label="解除原因" code="SYS169"></div>
	<div field="jcbjzj" label="解除帮教总结"></div>
	<div field="audit" label="审核状态"></div>
</div>
<div class="modal fade" id="azbj_bjjc_modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	<div class="modal-dialog" role="document" style="width: 800px; height: 500px;">
		<div class="modal-content" id="modal_content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="myModalLabel">帮教解除信息</h4>
			</div>
			<div class="modal-body">
				<div id="form_add" class="tab-pane active">
					<select id="xjry_xm" name="f_aid" label="姓名" style="max-width:none">
					</select>
					<input type="text" name="jcsj" label="解除时间" valid="{required:true}" class="form_date form-control" data-date-formate="yyyy-MM-dd" /> 
					<input type="text" name="jcyy" label="解除原因" valid="{required:true}" code="SYS169"/>
					<textarea  rows="8" name="jcbjzj"  id="jcbjzj" type="text" maxlength="250" label="解除帮教总结" ></textarea>		
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