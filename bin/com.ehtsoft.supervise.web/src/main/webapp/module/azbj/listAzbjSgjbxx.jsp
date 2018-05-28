<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<!-- 王维 -->
<!DOCTYPE html>
<html>
<head>
<title>双管信息采集模块</title>
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<script type="text/javascript"	src="${localCtx}/json/AzbjSgjbxxService.js"></script>
<script type="text/javascript">
$(function() {
	var azbj = new AzbjSgjbxxService();
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
		if($("#azbj_bjxzxx :checkbox:checked").length==1){
			v = $('#azbj_table :checkbox:checked').data().aid;
			findRy();
			azbj_form.enable();
			$("#btn_save").show();
			$("#azbj_modal").modal({backdrop : 'static'});
			azbj_form.fill($("#azbj_bjxzxx :checkbox:checked").data());
		}else{
			var ale = new Eht.Alert();
			ale.show("请选中一条数据进行操作!");
		}
	});	
	//查看人员按钮
	$("#btn_view").click(function() {
		if($("#azbj_bjxzxx :checkbox:checked").length==1){
			v = $(':checkbox:checked').data().aid;
			findRy();
			$("#azbj_modal").modal({backdrop : 'static'});
			$("#btn_save").hide();
			$("#azbjryid").disable();
			azbj_form.disable();
			azbj_form.fill($("#azbj_bjxzxx :checkbox:checked").data());
		}else{
			var ale = new Eht.Alert();
			ale.show("请选中一条数据进行操作!");
		}
	});	
	//人员删除按钮
	$("#btn_delete").click(function(){
		if($("#azbj_bjxzxx :checkbox:checked").length==1){
			var c = new Eht.Confirm();
			c.show("请确认是否删除！");
			c.onOk(function(){
				azbj.removeOne($("#azbj_bjxzxx :checkbox:checked").data(),new Eht.Responder({
					success:function(){
						azbj_bjxzxx.refresh();
						c.close();
						new Eht.Tips().show();
					}
				}));
			});
		}else{
			var ale = new Eht.Alert();
			ale.show("请选中一条数据进行操作!");
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
			<input type="text" class="form-control" name="a.xm[like]" id="xm" placeholder="姓名">
		</div>
		 <div class="form-group"   style="margin-left:10px;">
			<label for="sqyy">申请原因</label>
			<input type="text" class="form-control" name="b.sqyy[like]" id="sqyy" placeholder="申请原因">
		</div>
		<div class="form-group"   style="margin-left:10px;">
			<label for="gfhtmc">购房合同名称</label>
			<input type="text" class="form-control" name="b.gfhtmc[like]" id="gfhtmc" placeholder="购房合同名称">
		</div>
		<div class="form-group"   style="margin-left:10px;">
			<label for="zfhtmc">租房合同名称</label>
			<input type="text" class="form-control" name="b.zfhtmc[like]" id="zfhtmc" placeholder="租房合同名称">
		</div>
		<div class="form-group"   style="margin-left:10px;">
			<label for="gzhtmc">工作合同名称</label>
			<input type="text" class="form-control" name="b.gzhtmc[like]" id="gzhtmc" placeholder="工作合同名称">
		</div>
		<div class="form-group"   style="margin-left:10px;">
			<label for="sqsj">申请时间</label>
			<input id="sqsj" type="text" name="b.sqsj[like]" class="form_date form-control" data-date-format="yyyy-MM-dd" />
		</div>
		<button type="button" id="btn_query" class="btn btn-primary" style="margin-left:10px;">
			<span class="glyphicon glyphicon-search" aria-hidden="true"></span>查询</button>
	</div>
</form>
<div id="azbj_bjxzxx">
	<div field="id" label="选项" checkbox="true" width="60"></div>
	<div field="xm" label="姓名"></div>
	<div field="sqyy" label="申请原因"></div>
	<div field="gfhtmc" label="购房合同名称" ></div>
	<div field="zfhtmc" label="租房合同名称"></div>
	<div field="gzhtmc" label="工作合同名称"></div>
	<div field="sqsj" label="申请时间"></div>
	<div field="spzt" label="审批状态"></div>
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
					<input type="text" name="sqyy" label="申请原因" valid="{required:true}"  /> 
					<input type="text" name="gfhtmc" label="购房合同名称"  /> 
					<input type="text" name="zfhtmc" label="租房合同名称"  /> 
					<input type="text" name="gzhtmc" label="工作合同名称"  />
					<input type="text" name="qtzmcl" label="其他证明材料"  />
					<input type="text" name="sqsj" label="申请时间" class="form_date" data-date-formate="yyyy-MM-dd" /> 
					<input type="text" name="spzt" label="审批状态" valid="{required:true}" />
					<input type="text" name="spyj" label="审批意见" valid="{required:true}" />
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