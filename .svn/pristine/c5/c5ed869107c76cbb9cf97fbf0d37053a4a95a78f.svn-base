<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!--孙海龙  -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<script type="text/javascript" src="${localCtx }/json/GMPService.js"></script>
<title>考核管理</title>
<script type="text/javascript">
$(function(){
	var json_data = {};
	var query = {};
	var service = new GMPService();
	var form = new Eht.Form({selector:'#listKhgl_div #jcflfwsForm',autolayout:true});
	var tableview = new Eht.TableView({selector:'#listKhgl_div #tableview'});
	//展示页面信息
	tableview.loadData(function(page,res){
		service.findAll(query, page, res);
	});
	//单击一行获取该行的信息
	tableview.clickRow(function(data){
		json_data = data;
	});
	//新增按钮触发事件
	$('#listKhgl_div #add').click(function(){
		form.clear();
		$('#myModal').modal({backdrop:'static'});
	});
	//初始提示信息为隐藏状态
	$('#listKhgl_div #close_alert_div').hide();
	$('#listKhgl_div #delete_alert_div').hide();
	//查询按钮事件
	$('#listKhgl_div #search').click(function(){
		query["xm[like]"] = $('#search-xm').val();
		tableview.refresh();
	});	
	//修改按钮事件
	$('#listKhgl_div #edit').click(function(){
		if(json_data.khid==null){
			$('#listKhgl_div #close_alert_div').show();
		}else{
			form.fill(json_data);
			$('#listKhgl_div #myModal').modal({backdrop:'static'});
		}
	});
	$('#listKhgl_div #delete').click(function(){
		if(json_data.khid==null){
			$('#listKhgl_div #close_alert_div').show();
		}else{
			$('#listKhgl_div #delete_alert_div').show();
		}
	});
	$('#listKhgl_div #no').click(function(){
		$('#listKhgl_div #delete_alert_div').hide();
	});
	$('#listKhgl_div #yes').click(function(){
		service.removeOne(json_data.khid,new Eht.Responder({
			success:function(){
				tableview.refresh();
				$('#listKhgl_div #delete_alert_div').hide();
			}
		}));
	});
	//提示框关闭按钮
	$('#listKhgl_div #close_alert').click(function(){
		$('#listKhgl_div #close_alert_div').hide();
	});
	
	//模态框保存并且隐藏
	$('#listKhgl_div #submit').click(function(){
		if(form.validate()){
			service.saveOne(form.getData(),new Eht.Responder({
				success:function(data){
					$('#myModal').modal('hide');
					tableview.refresh();
				}
			}));
		}
	});
	//模态框查询矫正人员信息事件
	service.findJz(new Eht.Responder({
		success:function(data){
			$("#jzryxx_xmajglx").empty();
			$("#jzryxx_xmajglx").append('<option selected="selected"></option>');
			for(var i=0;i<data.length;i++){
				$("#jzryxx_xmajglx").append("<option value="+data[i].id+">"+data[i].xm +    +data[i].grlxdh+"</option>");
			}
			$("#jzryxx_xmajglx").comboSelect();
		}
	}))
	
	var textareaName1 = "#listKhgl_div #floor1";//备注输入框id
	var spanName1 = "#listKhgl_div #count1";//计数span的id
	$(textareaName1).click(function() {
		countChar(textareaName1, spanName1);
	});
	$(textareaName1).keyup(function(){
		countChar(textareaName1, spanName1);
	});
	$(textareaName1).keydown(function() {
		countChar(textareaName1, spanName1);
	});
	var textareaName2 = "#listKhgl_div #floor2";//备注输入框id
	var spanName2 = "#listKhgl_div #count2";//计数span的id
	$(textareaName2).click(function() {
		countChar(textareaName2, spanName2);
	});
	$(textareaName2).keyup(function(){
		countChar(textareaName2, spanName2);
	});
	$(textareaName2).keydown(function() {
		countChar(textareaName2, spanName2);
	});
	function countChar(textareaName, spanName) {
		if ($(textareaName).val() != "") {
			$(spanName)
					.text("" + $(textareaName).val().length + "/500");
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
	};

});
</script>
</head>
<body>
	<div id="listKhgl_div">
		<div class="panel panel-default">
			<div class="panel-heading">
				<fieldset>
					<input type="text" id="search-xm" class="btn btn-default" placeholder="请输入姓名"/>
					<input type="button" id="search" class="btn btn-default" value="查询"/>
					<input type="button" id="add" class="btn btn-default" value="新增"/>
					<input type="button" id="edit" class="btn btn-default" value="修改"/>
					<input type="button" id="delete" class="btn btn-default" value="删除"/>
				</fieldset>
			</div>
			<div class="alert alert-warning alert_dismissible" id="close_alert_div" role="alert" style="text-align:center;font-size:17px">
				<strong>提示</strong> 请选择一条信息!
				<input type="button" class="btn btn-default" id="close_alert" value="取消"/>
			</div>
			<div class="alert alert-info alert-dissmissible" id="delete_alert_div" role="alert" style="text-align:center;font-size:17px">
				<strong>提示</strong> 确定删除？
				<input id="yes" class="btn btn-default" type="button" value="确定" >
				<input id="no" class="btn btn-default" type="button" value="取消" >
			</div>
			<div class="panel-body">
				<div id="tableview" class="table-responsive">
					<div field="xzk" label="选择" checkbox="true"></div>
					<div field="xm" label="服刑人员"></div>
					<div field="xb" label="性别" code="sys000"></div>
					<div field="khrq" label="考核日期"></div>
					<div field="khksrq" label="考核开始日期"></div>
					<div field="khjsrq" label="考核结束日期"></div>
					<div field="khr" label="考核人"></div>
					<!-- <div field="sfsspr" label="司法所审批人"></div>
					<div field="sfsspsj" label="司法所审批时间"></div> -->
				</div>
			</div>
		</div>
		<!-- 新增服刑人员状态信息(Modal) -->
		<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
							&times;
						</button>
						<h4 class="modal-title" id="myModalLabel">新增服刑人员考核信息</h4>
					</div>
					<div class="modal-body" style="overflow: auto;height:450px;">
						<div class="modal-body-div">
							<div id="jcflfwsForm">
								<input type="hidden" name="khid"> 
								<select id="jzryxx_xmajglx" name="aid" label="服刑人员">
								</select>
								<input id="time" name="khrq" type="text" label="考核日期" class="form_date" data-date-formate="yyyy-MM-dd" placeholder="考核日期"> 
								<input type="text"  name="khksrq" class="form_date" data-date-formate="yyyy-MM-dd" label="考核开始日期" placeholder="考核开始日期">
								<input type="text"  name="khjsrq" class="form_date" data-date-formate="yyyy-MM-dd" label="考核结束日期" placeholder="考核结束日期">
								<input id="sfsspsj" type="text"  class="form_date" data-date-formate="yyyy-MM-dd HH:mm"  placeholder="社区服务开始时间" name="sfsspsj" label="社区服务开始时间">
								<textarea name="rcbxqkfx" id="floor1" type="text"  label="日常表现情况分析"  maxlength="500" placeholder="日常表现情况分析" rows="8"></textarea>
								<div class="text-right"><span id="count1"  style="color: #3F51B5;margin-right: 40px;"></span></div>
								<!-- <textarea name="sfsspyj" id="floor2" type="text"  placeholder="司法所审批意见" maxlength="500" label="司法所审批意见" rows="8"></textarea>
								<div class="text-right"><span id="count2"  style="color: #3F51B5;margin-right: 40px;"></span></div>
								<input name="sfsspr" type="text" label="司法所审批人" placeholder="司法所审批人"> -->
								<input name="khr" type="text"  id="khr" label="考核人"placeholder="考核人" value="${CURRENT_USER_SESSION.name}" readonly="true" fixedValue="true">
							</div>
						</div>
					</div>
					<div class="modal-footer">
						<button class="btn btn-default" type="button" data-dismiss="modal">关闭</button>
						<button id="submit" class="btn btn-primary" type="button">提交</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>