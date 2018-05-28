<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE HTML>
<!-- 顾恒维 -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<script type="text/javascript" src="${localCtx }/json/AzbjNdjdxxcjbService.js"></script>
<title>年度鉴定信息采集表（村居）</title>
<script type="text/javascript">
$(function() {
	var query = new Eht.Form({selector : "#query_form"});
	var service = new AzbjNdjdxxcjbService();
	var form = new Eht.Form({formCol : 2,selector : "#form",autolayout : true});
	var tableview = new Eht.TableView({selector : "#tableview"});
	//人员数据
	tableview.loadData(function(page, res) {
		service.findNdjdxxcjb(query.getData(), page, res);
	});
	//人员查询按钮
	$("#btn_search").click(function() {
		tableview.refresh();
	});
	//人员新增按钮...
	$('#btn_add').click(function() {
		form.enable();
		form.clear();
		//findRy();
		$("#btn_save").show();
		$("#myModal ").modal({backdrop:'static'});
	});
	//模态框新增人员信息事件
	function findRy(){
		service.findJz(new Eht.Responder({
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
	//查看人员按钮
	$("#btn_look").click(function() {
		if ($(":checkbox:checked").length == 1) {
			form.clear();
			$("#myModal ").modal({backdrop:'static'});
			$("#btn_close").show();
			$("#btn_save").hide();
			form.disable();
			form.fill($(":checkbox:checked").data());
		} else {
			var ale = new Eht.Alert();
			ale.show("请选中一条数据进行操作!!!!!!!!");
		}
	});
	// 编辑  人员编辑按钮
	$("#btn_edit").click(function() {
		if ($(":checkbox:checked").length == 1) {
			form.enable();
			form.clear();
			$("#btn_save").show();
			$("#btn_close").show();
			$("#myModal ").modal({backdrop:'static'});
			form.fill($(":checkbox:checked").data());
		} else {
			var ale = new Eht.Alert();
			ale.show("请选中一条数据进行操作!!!!!!!!");
		}
	});
	//删除事件
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
	//保存添加人员
	 $('#btn_save').click(function() {
		 /* if (form.validate()) { */
			service.saveOne(form.getData(), new Eht.Responder({
				success : function() {
					$('#myModal ').modal("hide");
					new Eht.Tips().show("保存成功");
					tableview.refresh();
				}
			}));
			/*} else {
				new Eht.Tips().show("保存失败");
	 	} */
	}); 
	//模态框查询安置帮办人员信息事件
	service.findJz(new Eht.Responder({
		success : function(data) {
			$("#azbjryid").empty();
			$("#azbjryid").append('<option selected="selected"></option>');
			for (var i = 0; i < data.length; i++) {
				if(i==6){
					$("#azbjryid").append("<option value="+data[i].id+"selected>"+data[i].xm + data[i].grlxdh + "</option>");	
					}else{
						$("#azbjryid").append("<option value="+data[i].id+">"+data[i].xm + data[i].grlxdh + "</option>");
					}
			}
			$("#azbjryid").comboSelect();
		}
	}))
	//多行文本框显示事件
	var textareaName1 = "#jjdsjwt";//备注输入框id
	var spanName1 = "#count1";//计数span的id
	$(textareaName1).click(function() {
		countChar(textareaName1, spanName1);
	});
	$(textareaName1).keyup(function() {
		countChar(textareaName1, spanName1);
	});
	$(textareaName1).keydown(function() {
		countChar(textareaName1, spanName1);
	});
	function countChar(textareaName, spanName) {
		if ($(textareaName).val() != "") {
			$(spanName).text("" + $(textareaName).val().length + "/500");
			if ($(textareaName).val().length > 0) {
				$(spanName).css("color", "#3F51B5");
			}
			;
			if ($(textareaName).val().length > 240) {
				$(spanName).css("color", "#FF0000");
			}
			;
		} else {
			$(spanName).text("0/500");
		}
	}
	;
});
</script>
</head>
<body>
<!-- 操作按钮部分 -->
<div class="toolbar">
	<button type="button" class="btn btn-default" style="margin-left: 10px;" id="btn_add">
		<span class="glyphicon glyphicon-plus" aria-hidden="true"></span>新增
	</button>
	<button type="button" class="btn btn-default" style="margin-left: 10px;" id="btn_look">
		<span class="glyphicon glyphicon-eye-open" aria-hidden="true"></span>查看
	</button>
	<button type="button" class="btn btn-default" style="margin-left: 10px;" id="btn_edit">
		<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>编辑
	</button>
	<button type="button" class="btn btn-default" style="margin-left: 10px;" id="btn_delete">
		<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>删除
	</button>
</div>
	<!-- 查询条件部分 -->
<form class="form-inline" style="margin: 10px;">
	<div id="query_form">
		<div class="form-group">
			<label for="xm">姓名</label> 
			<input type="text" class="form-control" name="xm[like]" id="xm" placeholder="姓名" style="width: 100px">
		</div>
		<div class="form-group">
			<label for="nd">年度</label> <input type="text" class="form-control" name="nd[like]" id="nd" placeholder="年度" style="width: 100px">
		</div>
		<div class="form-group">
			<label for="xsbx">现实表现</label> 
			<input type="text" code="SYS149" class="form-control" name="xsbx[like]" id="xsbx" placeholder="现实表现">
		</div>
		<div class="form-group">
			<label for="gzqk">工作情况</label> 
			<input type="text" class="form-control" name="gzqk[like]" id="gzqk" placeholder="工作情况" code="SYS150">
		</div>
		<div class="form-group">
			<label for="jjzk">经济情况</label> 
			<input type="text" class="form-control" name="jjzk[like]" id="jjzk" placeholder="经济情况" code="SYS240">
		</div>
		<div class="form-group">
			<label for="jtqk">家庭情况</label> 
			<input type="text" class="form-control" name="jtqk[like]" id="jtqk" placeholder="家庭情况" code="SYS151">
		</div>
		<div class="form-group">
			<label for="hdcs">活动场所</label> 
			<input type="text" class="form-control" name="hdcs[like]" id="hdcs" placeholder="活动场所" code="SYS152">
		</div>
		<div class="form-group">
			<label for="shjw">社会交往</label> <input type="text" class="form-control" name="shjw[like]" id="shjw" placeholder="社会交往" code="SYS152">
		</div>
		<button type="button" class="btn btn-primary"style="margin-left: 10px;" id="btn_search">
			<span class="glyphicon glyphicon-search" aria-hidden="true"></span>查询
		</button>
	</div>
</form>
<!-- //显示的界面的id -->
<div id="tableview">
	<div field="xz" label="选择" checkbox="true"></div>
	<div field="xm" label="姓名"></div>
	<div field="nd" label="年度"></div>
	<div field="xsbx" label="现实表现" code="SYS149"></div>
	<div field="gzqk" label="工作情况" code="SYS150"></div>
	<div field="jjzk" label="经济状况" code="SYS240"></div>
	<div field="jtqk" label="家庭情况" code="SYS151"></div>
	<div field="hdcs" label="活动场所" code="SYS152"></div>
	<div field="shjw" label="社会交往" code="SYS153"></div>
</div>
	<!-- 新增年度鉴定信息采集表（民居）信息(Modal) -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog" style="width: 800px;">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="myModalLabel">年度鉴定信息采集表</h4>
			</div>
			<div class="modal-body" style="overflow: auto; height: 450px;">
				<!-- //添加页面的id -->
				<div id="form">
					<input type="hidden" name="id">
					<select id="azbjryid" name="azbjryid" label="安置帮教人员"> 
					</select>
					<input type="text" name="nd" id="time" label="年度" valid="{required:true,number:true}"> 
					<input id="xsbx" name="xsbx" label="现实表现" code="SYS149" valid="{required:true}"> 
					<input id="gzqk" name="gzqk" label="工作情况" code="SYS150" valid="{required:true}"> 
					<input id="jjzk" name="jjzk" label="经济状况" code="SYS240" valid="{required:true}"> 
					<input id="jtqk" name="jtqk" label="家庭情况" code="SYS151" valid="{required:true}"> 
					<input id="hdcs" name="hdcs" label="活动场所" code="SYS152" valid="{required:true}"> 
					<input id="shjw" name="shjw" label="社会交往" code="SYS153" valid="{required:true}"> 
					<input type="text" id="zbzr" name="zbzr" label="治保（调解）主任" valid="{required:true}"> 
					<input type="text" id="zrrq" name="rq" label="日期" class="form_date" data-date-formate="yyyy-MM-dd" placeholder="日期"
						valid="{required:true}"> 
					<input type="text" id="zrqmj" name="zrqmj" label="责任区民警" valid="{required:true}"> 
					<input type="text" id="mjrq" name="mjrq" label="日期" class="form_date" data-date-formate="yyyy-MM-dd" placeholder="日期"
						valid="{required:true}"> 
					<input type="text" id="ywcxfzqx" name="ywcxfzqx" label="有无重新犯罪倾向" valid="{required:true}">
					<textarea type="text" id="jjdsjwt" name="jjdsjwt" label="解决实际问题"
						maxlength="500" rows="8" valid="{required:true}">
					</textarea>
					<div class="text-right">
						<span id="count1" style="color: #3F51B5; margin-right: 40px;"></span>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button id="btn_save" class="btn btn-primary" type="button">保存</button>
				<button id="btn_close" class="btn btn-default" type="button" data-dismiss="modal">取消</button>
			</div>
		</div>
	</div>
</div>
</body>
</html>
