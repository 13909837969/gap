<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!-- 冉令孚 -->
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<script type="text/javascript" src="${localCtx }/json/AzbjJcqkService.js"></script>
<title>奖惩情况信息管理</title>
<script type="text/javascript">
$(function(){
	var service = new AzbjJcqkService();
	var form = new Eht.Form({selector:"#jcqkForm",autolayout:true});
	var tableview = new Eht.TableView({selector:'#tableview'});
	var qf = new Eht.Form({selector:"#divcx",codeEmpty:true,codeEmptyLabel:"全部"});
	var v = null;
	//展示页面信息
	tableview.loadData(function(page,res){
		service.findAll(qf.getData(),page,res);
	});
	//新增按钮触发事件
	$('#btn_add').click(function(){
		form.clear();
		v = null;
		findRy();
		$('#myModal').modal({backdrop:'static'});
		$('#btn_submit').show();
		form.enable();
	});
	//查看按钮触发事件
	$('#btn_view').click(function(){
		if($("#tableview :checkbox:checked").length == 1){
			v = $("#tableview :checkbox:checked").data().aid; 
			findRy();
			$('#btn_submit').hide();
			$('#myModal').modal({backdrop:'static'});
			form.fill($("#tableview :checkbox:checked").data());
			form.disable();
		}else{
			var ale = new Eht.Alert();
			ale.show("请选中其中一条数据进行操作！");
		}
	});
	//删除
	$("#btn_delete").click(function(){
		if($("#tableview :checkbox:checked").length == 1){
			var c = new Eht.Confirm();
			c.show("此操作不可恢复，确定要删除选中记录吗！");
			c.onOk(function(){
				service.removeOne($("#tableview :checkbox:checked").data(),new Eht.Responder({
					success:function(){
						tableview.refresh();
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
	//查询按钮事件
	$('#btn_search').click(function(){
		tableview.refresh();
	});
	//修改按钮事件
	$('#btn_edit').click(function(){
			if($("#tableview :checkbox:checked").length ==1){
				v = $("#tableview :checkbox:checked").data().aid;
				findRy(); 
				$('#myModal').modal({backdrop:'static'});
				form.fill($("#tableview :checkbox:checked").data());
				$('#btn_submit').show();
				form.enable();
			}else{
				var ale = new Eht.Alert();
				ale.show("请选中其中一条数据进行操作！");
			}	
	});
	//模态框保存并且隐藏
	$('#btn_submit').click(function(){
		if(form.validate()){
			service.saveOne(form.getData(),new Eht.Responder({
				success:function(data){
					$('#myModal').modal('hide');
					tableview.refresh();
					new Eht.Tips().show("保存成功");
				}
			}));
		}else{
			new Eht.Tips().show("保存失败");
		}
	});
	//模态框新增人员信息事件
	function findRy(){
		service.findJz(new Eht.Responder({
			success:function(data){
				$("#jcqk_xmajglx").empty();
				$("#jcqk_xmajglx").append('<option></option>');
				for(var i=0;i<data.length;i++){
					if(data[i].id == v){
						$("#jcqk_xmajglx").append("<option value=" + data[i].id+" selected>" + data[i].xm + data[i].grlxdh + "</option>");
					}else{
						$("#jcqk_xmajglx").append("<option value=" + data[i].id+">" + data[i].xm + data[i].grlxdh + "</option>");
					}
				}
				$("#jcqk_xmajglx").comboSelect();
			}
		}))
	}
});
</script>
</head>
<body>
<!--增删改查操作按钮部分  -->
<div class="toolbar">
	<button id="btn_add"  type="button" class="btn btn-default" style="margin-left:10px;">
	<span class="glyphicon glyphicon-plus" aria-hidden="true"></span>新增</button>
	<button id="btn_view" type="button" class="btn btn-default" style="margin-left:10px;">
	<span class="glyphicon glyphicon-eye-open" aria-hidden="true"></span>查看</button>
	<button id="btn_edit" type="button" class="btn btn-default" style="margin-left:10px;">
	<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>编辑</button>
	<button id="btn_delete" type="button" class="btn btn-default" style="margin-left:10px;">
	<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>删除</button>			
</div>
<!--查询条件部分  -->
<form class="form-inline" style="margin:10px;">
	<div id="divcx">
		<div class="form-group">
			<label for="xm">姓名</label>
			<input type="text" class="form-control" name="xm[like]" placeholder="姓名">
		</div>
		<div class="form-group" style="margin-left:10px;">
			<label for="sj">时间</label>
			<input type="text"  name="sj[eq]" class="form_date btn btn-default" data-date-formate="yyyy-MM-dd HH:mm" placeholder="时间">
		</div>
		<div class="form-group" style="margin-left:10px;">
			<label for="bm">部门</label>
			<input type="text" class="form-control" name="bm[like]" placeholder="部门">
		</div>
		<button type="button" id="btn_search" class="btn btn-primary" style="margin-left:10px;">
			<span class="glyphicon glyphicon-search" aria-hidden="true"></span>查询</button>
	</div>
</form>
<!--页面遍历基本情况部分  -->
<div id="tableview" class="table-responsive">
	<div field="xzk" label="选择" checkbox="true"></div>
	<div field="xm" label="姓名"></div>
	<div field="sj" label="时间"></div>
	<div field="bm" label="部门"></div>
	<div field="sy" label="事由"></div>
</div>
<!-- 服刑人员奖惩情况信息(Modal) -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
					&times;
				</button>
				<h4 class="modal-title" id="myModalLabel">服刑人员奖惩情况信息</h4>
			</div>
			<div class="modal-body" style="overflow: auto;height:450px;">
				<div id="jcqkForm">
					<input type="hidden" name="id"/> 
					<select id="jcqk_xmajglx" name="azbjryid" label="服刑人员姓名" style="max-width:none">
					</select>
					<input id="sj" tpye="date" name="sj" label="时间" class="form_date btn btn-default" data-date-formate="yyyy-MM-dd HH:mm" placeholder="时间" valid="{required:true}">
   					<input id="bm" type="text" name="bm" label="部门" placeholder="部门" valid="{required:true}">
					<input id="sy" type="text" name="sy" label="事由" placeholder="事由" valid="{required:true}">
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