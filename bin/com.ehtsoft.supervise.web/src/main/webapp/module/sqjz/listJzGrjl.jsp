<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 何向昕 -->
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<script type="text/javascript" src="${localCtx }/json/JzgrjlService.js"></script>
<title>矫正--个人简历</title>
<script type="text/javascript">
$(function(){
	$('#close_alert_div').hide();
	$('#delete_alert_div').hide();
	var json_data = {};
	var query = {};
	var f_aid = "${param.f_aid}";
	query.f_aid = f_aid;
	var jzgrjlService = new JzgrjlService();
	var tableview = new Eht.TableView({selector:'#tableview',paginate:null});
	var form = new Eht.Form({selector:'#JzGrjl-form',autolayout:true});
	$('#add').click(function(){
		form.clear();
		$('#myModalLabel').html("新增个人简历");
		$('#myModal').modal({backdrop:'static'});
	});
	tableview.loadData(function(page,res){
		jzgrjlService.findGrjl(query,res);
	});
	tableview.clickRow(function(data){
		json_data = data;
	});
	$('#search').click(function(){
		query.szdw = $('#search-szdw').val();
		tableview.loadData(function(page,res){
			jzgrjlService.findGrjl(query,res);
		});
	});
	$('#edit').click(function(){
		if(json_data.id==null){
			$('#close_alert_div').show();
		}else{
			$('#myModalLabel').html("修改个人简历");
			jzgrjlService.findOne({'id':json_data.id},new Eht.Responder({
				success:function(data){
					form.fill(data);
					$('#myModal').modal({backdrop:'static'});
				}
			}));
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
		jzgrjlService.deleteOne({'id':json_data.id},new Eht.Responder({
			success:function(){
				tableview.refresh();
				$('#delete_alert_div').hide();
			}
		}));
	});
	$('#submit').click(function(){
		if(form.validate()){
			jzgrjlService.saveGrjl(form.getData(),new Eht.Responder({
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
				<input type="text" id="search-szdw" class="btn btn-default" placeholder="请输入所在单位" name="szdw"/>
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
				<div field="qs" label="起始日期"></div>
				<div field="zr" label="结束日期"></div>
				<div field="szdw" label="所在单位"></div>
				<div field="zw" label="职务"></div>
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
						<h4 class="modal-title" id="myModalLabel">新增个人简历</h4>
					</div>
					<div class="modal-body">
						<div id="JzGrjl-form">
							<input type="hidden" value="${param.f_aid}" fixedValue="true" name="f_aid"/>
								<input type="hidden" name="id"/>
							<input type="text" name="qs" label="起始日期" placeholder="起始日期" valid="{required:true}" class="form_date" data-date-format="yyyy-MM-dd"/>
							<input type="text" name="zr" label="结束日期" placeholder="结束日期" valid="{required:true}" class="form_date" data-date-format="yyyy-MM-dd"/>
							<input type="text" name="szdw" label="所在单位" placeholder="所在单位" valid="{required:true}"/>
							<input type="text" name="zw" label="职务" placeholder="职务" valid="{required:true}"/>
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