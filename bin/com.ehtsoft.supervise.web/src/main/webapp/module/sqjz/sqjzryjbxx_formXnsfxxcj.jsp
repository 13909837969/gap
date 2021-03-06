<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!--孙海龙 -->
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<script type="text/javascript" src="${localCtx }/json/JzxnsfxxService.js"></script>
<title>矫正--虚拟身份信息</title>
<script type="text/javascript">
$(function(){
	$('#close_alert_div').hide();
	$('#delete_alert_div').hide();
	var json_data = {};
	var query = {};
	var f_aid = "${param.id}";
	query.f_aid = f_aid;
	var jzxnsfxxService = new JzxnsfxxService();
	var tableview = new Eht.TableView({selector:'#sqjzryjbxx_xnsfForm #tableview',paginate:null});
	var form = new Eht.Form({selector:'#jzxnsfxx-form',autolayout:true,formCol:2});
	$('#sqjzryjbxx_xnsfForm #add').click(function(){
		form.clear();
	});
	tableview.loadData(function(page,res){
		console.log(query.f_aid);
		jzxnsfxxService.findJzxnsfxx(query.f_aid,page,res);
	});
	tableview.clickRow(function(data){
		$("#close_alert_div").hide();
		json_data = data;
		form.fill(json_data);
	});
	$('#sqjzryjbxx_xnsfForm #edit').click(function(){
		form.clear();
	});
	$('#sqjzryjbxx_xnsfForm #search').click(function(){
		query.hm = $('#search-hm').val();
		tableview.refresh();
	});
	$('#sqjzryjbxx_xnsfForm #delete').click(function(){
		if(json_data.id==null){
			$('#close_alert_div').show();
		}else{
			$('#delete_alert_div').show();
		}
	});
	$('#sqjzryjbxx_xnsfForm #close_alert').click(function(){
		$('#close_alert_div').hide();
	});
	$('#sqjzryjbxx_xnsfForm #no').click(function(){
		$('#delete_alert_div').hide();
	});
	$('#sqjzryjbxx_xnsfForm #yes').click(function(){
		jzxnsfxxService.deleteOne({'id':json_data.id},new Eht.Responder({
			success:function(){
				$('#delete_alert_div').hide();
				json_data = {};
				tableview.refresh();
				form.clear();
				new Eht.Tips().show();
			}
		}));
	});
	$('#sqjzryjbxx_xnsfForm #save').click(function(){
		if(form.validate()){
			jzxnsfxxService.saveJzxnsfxx(form.getData(),new Eht.Responder({
				success:function(data){
					json_data = {};
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
<div class="panel panel-default" id="sqjzryjbxx_xnsfForm">
		<div class="panel-heading">
			<div class="panel-heading">
				<fieldset>
					<input type="button" id="edit" class="btn btn-default" value="新增"/>
					<input type="button" id="delete" class="btn btn-default" value="删除"/>
					<input type="button" id="save" class="btn btn-default" value="保存"/>
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
			<div id="jzxnsfxx-form">
				<div>
					<input type="hidden" value="${param.id}" fixedValue="true" name="f_aid"/>
					<input type="hidden" name="id"/>
				</div>
				<input type="text" name="lx" label="类型" placeholder="类型" valid="{required:true}" code="sys052"/>
				<input type="text" name="hm" label="号码" placeholder="号码" valid="{required:true,number:true}"/>
				<input type="text" name="remark" label="备注" placeholder="备注" valid="{required:true}"/>
			</div>
		</div>
		<div class="panel-body">
			<div id="tableview" class="table-responsive">
				<div field='op' label="选择" checkbox="true"></div>
				<div field="lx" label="类型" code="sys052"></div>
				<div field="hm" label="号码"></div>
				<div field="remark" label="备注"></div>
			</div>
		</div>
	</div>
</body>
</html>