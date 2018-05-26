<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 何向昕 -->
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>矫正--家庭成员及主要社会关系</title>
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<script type="text/javascript" src="${localCtx }/json/JzjtcyService.js"></script>
<style type="text/css">

</style>
<script type="text/javascript">
$(function(){
	var json_data = {};
	var query = {};
	var f_aid = "${param.f_aid}";
	query.f_aid = f_aid;
	var jzjtcyService = new JzjtcyService();
	var form = new Eht.Form({selector:'#Jzjtcy-form',autolayout:true});
	var tableview = new Eht.TableView({selector:'#tableview',paginate:null});
	tableview.loadData(function(page,res){
		jzjtcyService.findJtcy(query,res);
	});
	tableview.clickRow(function(data){
		json_data = data;
	});
	//初始提示信息为隐藏状态
	$('#close_alert_div').hide();
	$('#delete_alert_div').hide();
	
	$('#add').click(function(){
		form.clear();
		$('#myModal').modal({backdrop:'static'});
	});
	$('#search').click(function(){
		query.xm = $('#search-xm').val();
		tableview.refresh();
	});	
	$('#edit').click(function(){
		if(json_data.f_id==null){
			$('#close_alert_div').show();
		}else{
			form.fill(json_data);
			$('#myModal').modal({backdrop:'static'});
		}
		form.clearValidStyle();
	});
	$('#delete').click(function(){
		if(json_data.f_id==null){
			$('#close_alert_div').show();
		}else{
			$('#delete_alert_div').show();
		}
	});
	$('#no').click(function(){
		$('#delete_alert_div').hide();
	});
	$('#yes').click(function(){
		jzjtcyService.deleteOne({'id':json_data.f_id},new Eht.Responder({
			success:function(){
				tableview.refresh();
				$('#delete_alert_div').hide();
			}
		}));
	});
	$('#close_alert').click(function(){
		$('#close_alert_div').hide();
	});
	$('#submit').click(function(){
		if(form.validate()){
			jzjtcyService.saveJtcy(form.getData(),new Eht.Responder({
				success:function(data){
					$('#myModal').modal('hide');
					tableview.refresh();
				}
			}));
		}
	});
});
</script>
</head>
<body>
	<div id="body">
		<div class="panel panel-default">
			<div class="panel-heading">
				<fieldset>
					<input type="text" id="search-xm" name="xm" class="btn btn-default" placeholder="请输入姓名"/>
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
					<div field='op' label="选择" checkbox="true"></div>
					<div field="gx" label="关系"></div>
					<div field="xm" label="姓名"></div>
					<div field="szdw" label="工作单位职务"></div>
					<div field="jtzz" label="家庭住址"></div>
					<div field="lxdh" label="电话"></div>
				</div>
			</div>
		</div>
		<!-- 新增同案犯信息(Modal) -->
		<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
							&times;
						</button>
						<h4 class="modal-title" id="myModalLabel">新增家庭成员及主要社会关系</h4>
					</div>
					<div class="modal-body" style="overflow: auto">
						<div class="modal-body-div">
							<div id="Jzjtcy-form">
								<input type="text" name="gx" label="关系" placeholder="请输入关系" valid="{required:true}"/>
								<input type="text" name="xm" label="姓名" placeholder="请输入姓名" valid="{required:true}"/>
								<input type="text" name="szdw" label="工作单位职务" placeholder="请输入工作单位职务" valid="{required:true}"/>
								<input type="text" name="jtzz" label="家庭住址" placeholder="请输入家庭住址" valid="{required:true}"/>
								<input type="text" name="lxdh" label="电话" placeholder="请输入电话" valid="{required:true,mobile:true}"/>
								<div>
									<input type="hidden" value="${param.f_aid}" fixedValue="true" name="f_aid"/>
									<input type="hidden" name="f_id"/>
								</div>
							</div>
						</div>
					</div>
					<div class="modal-footer">
						<button class="btn btn-default" type="button" data-dismiss="modal">关闭</button>
						<button class="btn btn-primary" type="button" id="submit">提交</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>