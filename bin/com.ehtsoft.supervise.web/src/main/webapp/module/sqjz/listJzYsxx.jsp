<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 何向昕 -->
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
	var f_aid = "${param.f_aid}";
	query.f_aid = f_aid;
	var jzysxxService = new JzysxxService();
	var tableview = new Eht.TableView({selector:'#tableview',paginate:null});
	var form = new Eht.Form({selector:'#Jzysxx-form',autolayout:true});
	$('#add').click(function(){
		form.clear();
		$('#myModal').modal({backdrop:'static'});
	});
	tableview.loadData(function(page,res){
		jzysxxService.findYsxx(query,res);
	});
	tableview.clickRow(function(data){
		json_data = data;
	});
	$('#search').click(function(){
		query.zxysjcxm = $('#search-zxysjcxm').val();
		tableview.refresh();
	});
	$('#edit').click(function(){
		if(json_data.id==null){
			$('#close_alert_div').show();
		}else{
			form.fill(json_data);
			$('#myModal').modal({backdrop:'static'});
		}
	});
	$('#delete').click(function(){
		if(json_data.id==null){
			$('#close_alert_div').show();
		}else{
			$('#delete_alert_div').show();
		}
	});
	$('#close_alert').click(function(){
		$('#close_alert_div').hide();
	});
	$('#no').click(function(){
		$('#delete_alert_div').hide();
	});
	$('#yes').click(function(){
		jzysxxService.deleteOne({'id':json_data.id},new Eht.Responder({
			success:function(){
				tableview.refresh();
				$('#delete_alert_div').hide();
				json_data = {};
			}
		}));
	});
	$('#submit').click(function(){
		if(form.validate()){
			jzysxxService.saveYsxx(form.getData(),new Eht.Responder({
				success:function(data){
					$('#myModal').modal('hide');
					tableview.refresh();
					json_data = {};
				}
			}));
		}
	});
});
</script>
</head>
<body>
	<div class="panel panel-default">
		<div class="panel-heading">
			<fieldset>
				<input type="text" id="search-zxysjcxm" name="zxysjcxm" class="btn btn-default" placeholder="请输入姓名查询" />
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
			<input id="yes" class="btn btn-default" type="button" value="确定" />
			<input id="no" class="btn btn-default" type="button" value="取消" />
		</div>
		<div class="panel-body">
			<div id="tableview" class="table-responsive">
				<div field='op' label="选择" checkbox="true"></div>
				<div field="zxysjcxm" label="执行押送警察姓名"></div>
				<div field="dwjzw" label="单位及职务"></div>
				<div field="ysrq" label="押送日期"></div>
			</div>
		</div>
		<!-- 模态框 -->
		<div class="modal fade" id="myModal" tabindex="-1" role="dialog">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
							&times;
						</button>
						<h4 class="modal-title" id="myModalLabel">新增押送信息信息</h4>
					</div>
					<div class="modal-body" style="overflow: auto;">
						<div class="modal-body-div">
							<div id="Jzysxx-form">
								<div>
									<input type="hidden" value="${param.f_aid}" fixedValue="true" name="f_aid"/>
									<input type="hidden" name="id"/>
								</div>
								<input type="text" name="zxysjcxm" labelCol="3" label="执行押送警察姓名" placeholder="执行押送警察姓名" valid="{required:true}"/>
								<input type="text" name="dwjzw" labelCol="3" label="单位及职务" placeholder="单位及职务" valid="{required:true}"/>
								<input type="text" name="ysrq" labelCol="3" label="押送日期" placeholder="押送日期" valid="{required:true}" class="form_date" data-date-format="yyyy-MM-dd"/>
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