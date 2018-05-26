<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 何向昕 -->
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
	var f_aid = "${param.f_aid}";
	query.f_aid = f_aid;
	var jzxnsfxxService = new JzxnsfxxService();
	var tableview = new Eht.TableView({selector:'#tableview',paginate:null});
	var form = new Eht.Form({selector:'#jzxnsfxx-form',autolayout:true});
	$('#add').click(function(){
		form.clear();
		$('#myModal').modal({backdrop:'static'});
	});
	tableview.loadData(function(page,res){
		jzxnsfxxService.findJzxnsfxx(query,res);
	});
	tableview.clickRow(function(data){
		json_data = data;
	});
	$('#edit').click(function(){
		if(json_data.id==null){
			$('#close_alert_div').show();
		}else{
			form.fill(json_data);
			$('#myModal').modal({backdrop:'static'});
		}
	});
	$('#search').click(function(){
		query.hm = $('#search-hm').val();
		tableview.refresh();
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
		jzxnsfxxService.deleteOne({'id':json_data.id},new Eht.Responder({
			success:function(){
				tableview.refresh();
				$('#delete_alert_div').hide();
			}
		}));
	});
	$('#submit').click(function(){
		if(form.validate()){
			jzxnsfxxService.saveJzxnsfxx(form.getData(),new Eht.Responder({
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
				<input type="text" id="search-hm" class="btn btn-default" placeholder="请输入号码"/>
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
				<div field="lx" label="类型"></div>
				<div field="hm" label="号码"></div>
				<div field="remark" label="备注"></div>
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
						<div id="jzxnsfxx-form">
							<div>
								<input type="hidden" value="${param.f_aid}" fixedValue="true" name="f_aid"/>
								<input type="hidden" name="id"/>
							</div>
							<input type="text" name="lx" label="类型" placeholder="类型" valid="{required:true}"/>
							<input type="text" name="hm" label="号码" placeholder="号码" valid="{required:true}"/>
							<input type="text" name="remark" label="备注" placeholder="备注" valid="{required:true}"/>
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