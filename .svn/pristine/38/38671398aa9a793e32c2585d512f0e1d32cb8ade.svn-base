<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>司法所工作人员参加培训情况</title>
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<script type="text/javascript" src="${localCtx }/json/SfsGzrycjpxService.js"></script>
<script type="text/javascript">
$(function(){
	var json_data = {};
	var query = {};
	var service = new SfsGzrycjpxService();
	var form = new Eht.Form({selector:'#listRypxqk #pxqkForm',autolayout:true});
	var showForm = new Eht.Form({selector:'#listRypxqk #showForm',autolayout:true});
	var search_form = new Eht.Form({selector:'#listRypxqk #search_field'});
	
	var tableview = new Eht.TableView({selector:'#listRypxqk #tableview'});
	//查询按钮事件
	$('#listRypxqk #search').click(function(){
		tableview.refresh();
	});	
	//默认界面展示的数据
	tableview.loadData(function(page,res){
		service.findAll(search_form.getData(),page,res);
	});
	//单击一行获取数据
	tableview.clickRow(function(data){
		json_data = data;
	});
	//查询按钮事件
	 
	//新增按钮事件
	$('#listRypxqk #add').click(function(){
		form.clear();
		//动态添加人员
		var Jzry_json={};
		$("#listRypxqk #myModalLabel").text("新增培训信息");
		$("#listRypxqk #ryxm").attr("disabled",false);
		service.findGzry(Jzry_json,new Eht.Responder({
			success:function(data){
				$("#listRypxqk #ryxm").empty();
				$("#listRypxqk #ryxm").append('<option selected="selected"></option>');
				for(var i=0;i<data.length;i++){
					$("#listRypxqk #ryxm").append("<option value="+data[i].id+">"+data[i].xm+"</option>");
				}
				/* $("#ryxm").comboSelect(); */
			}
		}));
		$('#listRypxqk #myModal').modal({backdrop:'static'});
	});
	$("#listRypxqk #ryxm").change(function(){
		$("#listRypxqk #id").val($(this).val());
		service.findRybm($(this).val(),new Eht.Responder({
			success:function(data){
				$("#listRypxqk #ryid").val(data.rybm);
			}
		}))
	})
	
	
	
	//修改按钮事件
	$('#listRypxqk #edit').click(function(){
		if(json_data.id==null){
			$('#listRypxqk #close_alert_div').show();
		}else{
			$("#listRypxqk #myModalLabel").text("修改信息");
			service.findOne({'id':json_data.id},new Eht.Responder({
				success:function(data){
					form.fill(data);
					$("#listRypxqk #ryxm").append('<option selected="selected">'+data.xm+'</option>');
					$("#listRypxqk #ryxm").attr("disabled",true);
					$('#listRypxqk #myModal').modal({backdrop:'static'});
				}
			}));
		}
	});
	//删除按钮事件
	$('#listRypxqk #delete').click(function(){
		if(json_data.id==null){
			$('#listRypxqk #close_alert_div').show();
		}else{
			$('#listRypxqk #delete_alert_div').show();
		}
	});
	//初始提示信息为隐藏状态
	$('#listRypxqk #close_alert_div').hide();
	$('#listRypxqk #delete_alert_div').hide();
	
	//提示界面取消按钮事件
	$('#listRypxqk #no').click(function(){
		$('#listRypxqk #delete_alert_div').hide();
	});
	//提示界面确定按钮事件
	$('#listRypxqk #yes').click(function(){
		service.deleteOne({'id':json_data.id},new Eht.Responder({
			success:function(){
				tableview.refresh();
				$('#listRypxqk #delete_alert_div').hide();
				new Eht.Tips().show();
			}
		}));
	});
	
	$('#listRypxqk #close_alert').click(function(){
		$('#listRypxqk #close_alert_div').hide();
	});
	//模态框保存并且隐藏
	$('#listRypxqk #submit').click(function(){
		if(form.validate()){
			service.saveOne(form.getData(),new Eht.Responder({
				success:function(data){
					$('#listRypxqk #myModal').modal('hide');
					tableview.refresh();
					new Eht.Tips().show();
				}
			}));
		}
	});
	
	tableview.transColumn("cz",function(data){
		var button=$('<button  class="btn btn-default btn-sm "><span class="glyphicon glyphicon-eye-open"></span>&nbsp;查看</button>');
		button.click(function(){
			
			service.findOne({'id':json_data.id},new Eht.Responder({
				success:function(data){
					showForm.fill(data);
					$("#listRypxqk #ryxm_s").append('<option selected="selected">'+data.xm+'</option>');
					
					$("#showForm input").each(function(){
						$(this).attr("disabled",true);
					})
					$("#pxlb").attr("disabled",true);
					
					$('#listRypxqk #showModal').modal({backdrop:'static'});
					
				}
			}));
			
		})
		return button;
	})
	var textareaName = "#listRypxqk #floor";//备注输入框id
	var spanName = "#listRypxqk #count";//计数
	$(textareaName).click(function() {
		countChar(textareaName, spanName);
	});
	$(textareaName).keyup(function(){
		countChar(textareaName, spanName);
	});
	$(textareaName).keydown(function() {
		countChar(textareaName, spanName);
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
	<div id="listRypxqk">
		<div class="panel panel-default">
			<div class="panel-heading ltrhao-toolbar">
				<fieldset id="search_field">
					<input type="text" id="search-xm" name="xm[like]" class="btn btn-default" placeholder="请输入姓名"/>
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
					<div field="xm" label="姓名"></div>
					<div field="xb" label="性别" code="sys000"></div>
					<div field="sfzh" label="身份证号码"></div>
					<div field="pxlb" label="培训类别"  code="sys210"></div>
					<div field="sjcjxs" label="实际参加学时"></div>
					<div field="cz" label="操作"></div>
				</div>
			</div>
		</div>
		<!-- 新增社会矫正基地信息(Modal) -->
		<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
							&times;
						</button>
						<h4 class="modal-title" id="myModalLabel">新增培训信息</h4>
					</div>
					<div class="modal-body" style="overflow: auto;height:400px">
						<div class="modal-body-div">
							<div id="pxqkForm">
								<div>
									<input type="hidden" name="ryid" id="id"/>
								</div>
								<select name="xm" label="姓名" id="ryxm"></select>
								<input type="text" id="ryid" name="rybm" label="人员编码"  valid="{required:true}"readonly="readonly"/>
								<input type="text" name="pxkcmc" label="培训课程名称" getdis="true"  valid="{required:true}"/>
								<input type="text" name="pxlb" label="培训类别" getdis="true"  valid="{required:true}" code="sys210" />
								<input type="text" name="pxksrq" label="培训开始日期" getdis="true"  valid="{required:true}" class="form_date" data-date-formate="yyyy-MM-dd"readonly="readonly"/>
								<input type="text" name="pxjsqr" label="培训结束日期" getdis="true"  valid="{required:true}" class="form_date" data-date-formate="yyyy-MM-dd"readonly="readonly"/>
								<input type="text" name="sjcjxs" label="实际参加学时" getdis="true"  valid="{required:true}"/>
								<div class="text-right"><span id="count"  style="color: #3F51B5"></span></div>
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
		
		<!-- 查看 -->
		<div class="modal fade" id="showModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
							&times;
						</button>
						<h4 class="modal-title">查看信息</h4>
					</div>
					<div class="modal-body" style="overflow: auto;height:400px">
						<div class="modal-body-div">
							<div id="showForm">
								
								<select name="xm" label="姓名" id="ryxm_s"disabled="disabled"></select>
								<input type="text" id="ryid" name="rybm" label="人员编码"  valid="{required:true}"disabled="disabled"/>
								<input type="text" name="pxkcmc" label="培训课程名称" getdis="true"  valid="{required:true}"disabled="disabled"/>
								<input type="text" id="pxlb" name="pxlb" label="培训类别" getdis="true"  valid="{required:true}" code="sys210" disabled="disabled"/>
								<input type="text" name="pxksrq" label="培训开始日期" getdis="true"  valid="{required:true}" class="form_date" data-date-formate="yyyy-MM-dd"disabled="disabled"/>
								<input type="text" name="pxjsqr" label="培训结束日期" getdis="true"  valid="{required:true}" class="form_date" data-date-formate="yyyy-MM-dd"disabled="disabled"/>
								<input type="text" name="sjcjxs" label="实际参加学时" getdis="true"  valid="{required:true}"disabled="disabled"/>
							</div>
						</div>
					</div>
					<div class="modal-footer">
						<button class="btn btn-default" type="button" data-dismiss="modal">关闭</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>