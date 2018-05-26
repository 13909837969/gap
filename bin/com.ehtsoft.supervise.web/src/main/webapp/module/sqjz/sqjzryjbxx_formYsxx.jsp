<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 孙海龙 -->
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>矫正--押送信息</title>
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<script type="text/javascript" src="${localCtx }/json/JzysxxService.js"></script>
<script type="text/javascript">
$(function(){
	$('#close_alert_div').hide();
	$('#delete_alert_div').hide();
	var json_data = {};
	var query = {};
	var f_aid = "${param.id}";
	query.f_aid = f_aid;
	var jzysxxService = new JzysxxService();
	var tableview = new Eht.TableView({selector:'#sqjzryjbxx_formYsxx #tableview',paginate:null});
	var form = new Eht.Form({selector:'#sqjzryjbxx_formYsxx #jzryysxx-form',autolayout:true,formCol:2});
	tableview.loadData(function(page,res){
		jzysxxService.findYsxx(query.f_aid,page,res);
	});
	tableview.clickRow(function(data){
		json_data = data;
		form.fill(json_data);
	});
	$('#sqjzryjbxx_formYsxx #edit').click(function(){
		form.clear();
	});
	$('#sqjzryjbxx_formYsxx #delete').click(function(){
		if(json_data.id==null){
			$('#close_alert_div').show();
		}else{
			$('#delete_alert_div').show();
		}
	});
	$('#sqjzryjbxx_formYsxx #close_alert').click(function(){
		$('#close_alert_div').hide();
	});
	$('#sqjzryjbxx_formYsxx #no').click(function(){
		$('#delete_alert_div').hide();
	});
	$('#sqjzryjbxx_formYsxx #yes').click(function(){
		jzysxxService.deleteOne({'id':json_data.id},new Eht.Responder({
			success:function(){
				$('#sqjzryjbxx_formYsxx #delete_alert_div').hide();
				json_data = {};
				tableview.refresh();
				form.clear();
				new Eht.Tips().show();
			}
		}));
	});
	$('#sqjzryjbxx_formYsxx #save').click(function(){
		if(form.validate()){
			jzysxxService.saveYsxx(form.getData(),new Eht.Responder({
				success:function(data){
					tableview.refresh();
					form.clear();
					new Eht.Tips().show();
				}
			}));
		}
	});
});
</script>
</head>
<body>
<div class="panel panel-default" id="sqjzryjbxx_formYsxx">
		<div class="panel-heading">
			<div class="panel-heading">
				<fieldset>
					<input type="button" id="edit" class="btn btn-default" value="新增"/>
					<input type="button" id="delete" class="btn btn-default" value="删除"/>
					<input type="button" id="save" class="btn btn-default btn-sm" value="保存"/>
				</fieldset>
			</div>
		</div>
		<div class="alert alert-warning alert_dismissible" id="close_alert_div" role="alert" style="text-align:center;font-size:17px">
			<strong>提示</strong> 请选择一条信息!
			<input type="button" class="btn btn-default" id="close_alert" value="取消"/>
		</div>
		<div class="alert alert-info alert-dissmissible" id="delete_alert_div" role="alert" style="text-align:center;font-size:17px">
			<strong>提示</strong> 确定删除？
			<input id="yes" class="btn btn-default" type="button" value="确定" />
			<input id="no" class="btn btn-default" type="button" value="取消" />
		</div>	
		
		<div class="panel-body" >
			<div id="jzryysxx-form">
				<div>
					<input type="hidden" value="${param.id}" fixedValue="true" name="f_aid"/>
					<input type="hidden" name="id"/>
				</div>
				<input type="text" name="zxysjcxm" labelCol="3" label="执行押送警察姓名" placeholder="执行押送警察姓名" valid="{required:true}"/>
				<input type="text" name="dwjzw" labelCol="3" label="单位及职务" placeholder="单位及职务" valid="{required:true}"/>
				<input type="text" name="ysrq" labelCol="3" label="押送日期" placeholder="押送日期" valid="{required:true}" class="form_date" data-date-format="yyyy-MM-dd"/>
			</div>
		</div>
		<div class="panel-heading">
			<div id="tableview" class="table-responsive">
				<div field='op' label="选择" checkbox="true"></div>
				<div field="zxysjcxm" label="执行押送警察姓名"></div>
				<div field="dwjzw" label="单位及职务"></div>
				<div field="ysrq" label="押送日期"></div>
			</div>
		</div>
	</div>
</body>
</html>