<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!-- 武文涛 -->
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<script type="text/javascript" src="${localCtx }/json/AzbjNdjdXxcjbXzService.js"></script>
<title>年度鉴定信息采集表(乡镇)</title>
<script type="text/javascript">
$(function() {
	var service = new AzbjNdjdXxcjbXzService();
	var form = new Eht.Form({selector : "#jcflfwsForm",autolayout : true});
	var qf = new Eht.Form({selector : "#divcx",codeEmpty : true,codeEmptyLabel : "全部"});
	var tableview = new Eht.TableView({selector : "#tableview",multable : false});
	var v = null;
	//显示页面信息
	tableview.loadData(function(page, res) {
		service.findAll(qf.getData(), page, res)
		});
	//新增按钮触发事件
	$("#btn_add").click(function() {
		v=null;
		form.clear();
		$("#btn_submit").show();
		form.enable();
		huixian();
		$("#myModal").modal({
			backdrop : "static"
		});
	});
	//模糊查询按钮事件
	$("#btn_cha").click(function() {
		tableview.refresh();
	});
	//查看按钮事件
	$("#btn_search").click(function() {
		if ($("#tableview :checkbox:checked").length == 1) {
			v = $("#tableview :checkbox:checked").data().aid;
			huixian();
			$("#myModal").modal();
			form.disable();
			form.fill($("#tableview :checkbox:checked").data());
			$("#btn_submit").hide();
		} else {
			var ale = new Eht.Alert();
			ale.show("请选中一条数据进行操作!");
		}
	});
	//编辑按钮事件
	$("#btn_edit").click(function() {
		if ($("#tableview :checkbox:checked").length == 1) {
			v = $("#tableview :checkbox:checked").data().aid;
			huixian();
			form.enable();
			form.clear();
			$("#btn_submit").show();
			$("#myModal").modal();
			form.fill($("#tableview :checkbox:checked").data());
			
		} else {
			var ale = new Eht.Alert();
			ale.show("请选中一条数据进行操作!");
		}
	});
	//删除按钮事件
	$("#btn_delete").click(
			function() {
				var sd_ry = tableview.getSelectedData();
				if (sd_ry.length == 1) {
					var c = new Eht.Confirm();
					c.show("此操作不可恢复！确定要删除选中记录吗!");
					c.onOk(function() {
						service.removeOne($("#tableview :checkbox:checked").data().id,
						new Eht.Responder({
							success : function() {
								c.close();
								new Eht.Tips().show("删除成功");
								tableview.refresh();
							}
						}));
					});
				} else {
					var ale = new Eht.Alert();
					ale.show("请选中一条数据进行操作!");
				}
			});
	//模态框保存并且隐藏
	$("#btn_submit").click(function() {
		if(form.validate()){
			service.saveOne(form.getData(), new Eht.Responder({
				success : function(data) {
					$("#myModal").modal("hide");
					tableview.refresh();
					new Eht.Tips().show("保存成功");
				}
			}));
		}else{
			new Eht.Tips().show("保存失败");
		}
	});
	//模态框查询矫正人员信息事件
	function huixian(){
		service.findJz(new Eht.Responder({
			success:function(data){
			$("#jzryxx_xmajglx").empty();
			$("#jzryxx_xmajglx").append('<option></option>');
			for(var i=0;i<data.length;i++){
				if(data[i].aid == v){
					$("#jzryxx_xmajglx").append("<option value=" + data[i].aid+" selected>" + data[i].xm + data[i].grlxdh + "</option>");
				}else{
					$("#jzryxx_xmajglx").append("<option value=" + data[i].aid+">" + data[i].xm + data[i].grlxdh + "</option>");
					}
				}
			$("#jzryxx_xmajglx").comboSelect();
			}
		}))

	}
});
</script>
</head>
<body>
<!-- 按钮 -->
<div class="toolbar">
	<button type="button" id="btn_add" class="btn btn-default" style="margin-left:10px;">
	<span class="glyphicon glyphicon-plus" aria-hidden="true"></span>新增</button>
	<button type="button" id="btn_search" class="btn btn-default" style="margin-left:10px;">
	<span class="glyphicon glyphicon-eye-open" aria-hidden="true"></span>查看</button>
	<button type="button" id="btn_edit" class="btn btn-default" style="margin-left:10px;">
	<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>编辑</button>
	<button type="button" id="btn_delete" class="btn btn-default" style="margin-left:10px;">
	<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>删除</button>					
</div>
<!-- 模糊查询条件 -->
<form class="form-inline" style="margin:10px;">
  <div id="divcx">
	<div class="form-group" style="max-width:none">
		<label for="xm">姓名</label>
		<input type="text" class="form-control" name="xm[like]" id="xm" placeholder="姓名" style="width:100px">
	</div>
	<div class="form-group" style="margin-left:10px">
		<label for="khfzr">考核负责人</label>
		<input type="text" class="form-control" name="khfzr[like]" id="khfzr" placeholder="考核负责人" style="width:100px" >
	</div>
	<div class="form-group" style="margin-left:10px;">
		<label for="nd">年度</label>
		<input type="text" class="form-control" name="nd[ike]" id="nd" placeholder="年度"  style="width:100px">
	</div>
	<div class="form-group" style="margin-left:10px;">
		<label for="qzrq">签字日期</label>
		<input type="text" name="qzrq[like]"  class="form-control" data-date-formate="yyyy-MM-dd" placeholder="签字日期" style="width:100px">
	</div>
	<button type="button" class="btn btn-primary" id="btn_cha" style="margin-left:10px;">
	<span class="glyphicon glyphicon-search" aria-hidden="true"></span>查询</button>
	</div>
 </form>
<!-- 显示信息 -->
<div id="tableview" class="table-responsive">
	<div field="xzk" label="选择" checkbox="true"></div>
	<div field="xm" label="姓名"></div>
	<div field="nd" label="年度"></div>
	<div field="khfzr" label="考核负责人"></div>
	<div field="qzrq" label="签字日期"></div>
</div>
<!-- myModal 模态框 -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog" >
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="myModalLabel">年度鉴定信息采集</h4>
			</div>
			<div class="modal-body" style="overflow: auto; height: 450px;">
				<div class="modal-body-div">
					<div id="jcflfwsForm">
						<input type="hidden" name="id"> 
						<select id="jzryxx_xmajglx" name="azbjryid" label="安置帮教人员编号"></select>
						<!-- 添加信息-->
						<input name="nd" type="text" label="年度" valid="{required:true}" > 
						<input name="dqzfthqk" type="text" label="定期走访谈话情况"valid="{required:true}">
						<input name="bjxzcylsqk" type="text" label="帮教小组成员落实情况"valid="{required:true}"> 
						<input name="jzjzqk" type="text" label="卷宗记载情况"valid="{required:true}">
						<input name="fzjyqk" type="text" label="法制教育情况"valid="{required:true}"> 
						<input name="khfzr" type="text" label="考核负责人"valid="{required:true}" >
						<input type="text" name="qzrq"  class="form_date" data-date-formate="yyyy-MM-dd" label="签字日期" valid="{required:true}" >
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button id="btn_submit" class="btn btn-primary" type="button">保存</button>
				<button class="btn btn-default" type="button" data-dismiss="modal">取消</button>
			</div>
		</div>
	</div>
</div>
</body>
</html>