<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 何向昕 -->
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<script type="text/javascript" src="${localCtx }/json/JzjzlxxService.js"></script>
<title>矫正--禁止令信息</title>
<script type="text/javascript">
$(function(){
	$('#close_alert_div').hide();
	$('#delete_alert_div').hide();
	var json_data = {};
	var query = {};
	var f_aid = "${param.f_aid}";
	query.f_aid = f_aid;
	var jzjzlxxService = new JzjzlxxService();
	var tableview = new Eht.TableView({selector:'#tableview',paginate:null});
	var form = new Eht.Form({selector:'#jzjzlxx-form',autolayout:true});
	$('#add').click(function(){
		form.clear("jzllx");
		$('#myModal').modal({backdrop:'static'});
	});
	tableview.loadData(function(page,res){
		jzjzlxxService.findJzlxx(query,res);
	});
	tableview.clickRow(function(data){
		json_data = data;
	});
	$('#search').click(function(){
		query.jzllx = $('#search-jzllx').val();
		tableview.refresh();
	});
	$('#edit').click(function(){
		if(json_data.jzlid==null){
			$('#close_alert_div').show();
		}else{
			form.fill(json_data);
			$('#myModal').modal({backdrop:'static'});
		}
	});
	$('#delete').click(function(){
		if(json_data.jzlid==null){
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
		jzjzlxxService.deleteOne({'id':json_data.jzlid},new Eht.Responder({
			success:function(){
				tableview.refresh();
				$('#delete_alert_div').hide();
			}
		}));
	});
	$('#submit').click(function(){
		if(form.validate()){
			jzjzlxxService.saveJzlxx(form.getData(),new Eht.Responder({
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
	<div class="panel panel-default">
		<div class="panel-heading">
			<fieldset>
				<select id="search-jzllx" class="selectpicker" placeholder="请选择禁止令类型">
					<option value=""></option>
					<option value="01">限制进入特定区域</option>
					<option value="02">限制从事特定活动</option>
					<option value="03">限制接触特定人员</option>
				</select>
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
				<div field="jzllx" label="禁止令类型" code="SYS053"></div>
				<div field="jzqxksrq" label="禁止令期限开始日期"></div>
				<div field="jzqxjsrq" label="禁止令期限结束日期"></div>
			</div>
		</div>
		<!-- 模态框 -->
		<div class="modal fade" id="myModal" tabindex="-1" role="dialog">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<Button class="close" type="button" data-dismiss="modal" aria-hidden="true">
							&times;
						</Button>
						<h4 class="modal-title" id="myModalLabel">新增虚拟身份信息</h4>
					</div>
					<div class="modal-body">
						<div id="jzjzlxx-form">
							<div>
								<input type="hidden" value="${param.f_aid}" fixedValue="true" name="f_aid"/>
								<input type="hidden" name="jzlid"/>
							</div>
							<input type="text" name="jzllx" labelCol="4" label="禁止令类型" placeholder="类型" valid="{required:true}" code="SYS053"/>
							<input type="text" name="jzqxksrq" labelCol="4" label="禁止令期限开始日期" placeholder="号码" valid="{required:true}" class="form_date" data-date-format="yyyy-MM-dd"/>
							<input type="text" name="jzqxjsrq" labelCol="4" label="禁止令期限结束日期" placeholder="备注" valid="{required:true}" class="form_date" data-date-format="yyyy-MM-dd"/>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
						<button type="button" class="btn btn-primary" id="submit">提交</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>