<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 孙海龙 -->
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>上报管理--管理级别信息</title>
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<script type="text/javascript" src="${localCtx }/json/SbglGljbService.js"></script>
<script type="text/javascript">
$(function(){
	$('#close_alert_div').hide();
	$('#delete_alert_div').hide();
	var json_data = {};
	var query = {};
	var f_aid = "${param.id}";
	query.f_aid = f_aid;
	var service = new SbglGljbService();
	var tableview = new Eht.TableView({selector:'#listGljbxx #tableview',paginate:null});
	var form = new Eht.Form({selector:'#gljbxx-form',autolayout:true,formCol:2});
	$('#listGljbxx #add').click(function(){
		form.clear();
	});
	tableview.loadData(function(page,res){
		service.findAll(query,res);
	});
	tableview.clickRow(function(data){
		json_data = data;
		form.fill(json_data);
	});
	$('#listGljbxx #edit').click(function(){
		form.clear();
	});
	$('#listGljbxx #search').click(function(){
		query.hm = $('#search-hm').val();
		tableview.refresh();
	});
	$('#listGljbxx #delete').click(function(){
		if(json_data.id==null){
			$('#close_alert_div').show();
		}else{
			$('#delete_alert_div').show();
		}
	});
	$('#listGljbxx #close_alert').click(function(){
		$('#close_alert_div').hide();
	});
	$('#listGljbxx #no').click(function(){
		$('#delete_alert_div').hide();
	});
	$('#listGljbxx #yes').click(function(){
		service.deleteOne({'ID':json_data.id},new Eht.Responder({
			success:function(){
				$('#delete_alert_div').hide();
				tableview.refresh();
				form.clear();
			}
		}));
	});
	$('#listGljbxx #save').click(function(){
		if(form.validate()){
			service.save(form.getData(),new Eht.Responder({
				success:function(data){
					tableview.refresh();
					form.clear();
				}
			}));
		}
	});
	//
	var textareaName = "#listGljbxx #floor";//备注输入框id
	var spanName = "#listGljbxx #count";//计数span的id
	$(textareaName).click(function(){
		countChar(textareaName,spanName);
	});
	$(textareaName).keyup(function(){
		countChar(textareaName,spanName);
	});
	$(textareaName).keydown(function(){
		countChar(textareaName,spanName);
	});
	function countChar(textareaName,spanName){ 
		   if($(textareaName).val() != ""){
				$(spanName).text("已输入:"+ $(textareaName).val().length + "/500");			
				if($(textareaName).val().length>0){
						$(spanName).css("color","#3F51B5");
				};
				if($(textareaName).val().length>900){
						$(spanName).css("color","#FF0000");
					};
			}else{
				$(spanName).text("已输入：0/500");
			}
	};
	$("#listGljbxx #spsj1").datetimepicker({
		format: 'yyyy-mm-dd hh:ii', 
		language:  'zh-CN',
		autoclose: true,
        weekStart: 1,
        todayBtn:  1,
		autoclose: 1,
		minView: 0,
		forceParse: 0	
	});
});
</script>
</head>
<body>
<div class="panel panel-default" id="listGljbxx">
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
			<div id="gljbxx-form">
				<div>
					<input type="hidden" value="${param.id}" fixedValue="true" name="f_aid"/>
					<input type="hidden" name="id"/>
				</div>
				<input type="text" name="gljb" label="管理级别" placeholder="管理级别" valid="{required:true}" code="SYS054"/>
				<input type="text" name="bdrq" label="变动日期" placeholder="变动日期" valid="{required:true}" class="form_date" data-date-format="yyyy-MM-dd"/>
				<input type="text" name="spr" label="审批人" placeholder="审批人" valid="{required:true}" value="${CURRENT_USER_SESSION.name}" readonly="true"/>
				<input type="text" id="spsj1" name="spsj" label="审批时间" placeholder="审批时间" valid="{required:true}"  />
				<textarea name="tzyy" placeholder="调整原因" label="调整原因" maxlength="500" id="floor" ></textarea>
				<span id="count" style="margin-left:500px;color:#3F51B5;margin-left: 700px;"></span>
			</div>
		</div>
		<div class="panel-body">
			<div id="tableview" class="table-responsive">
				<div field='op' label="选择" checkbox="true"></div>
				<div field="gljb" label="管理级别"></div>
				<div field="tzyy" label="调整原因"></div>
				<div field="bdrq" label="变动日期"></div>
				<div field="spr" label="审批人"></div>
				<div field="spsj" label="审批时间"></div>
			</div>
		</div>
	</div>
</body>
</html>