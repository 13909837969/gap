<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!--孙海龙  -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<script type="text/javascript" src="${localCtx }/json/JcflfwsService.js"></script>
<title>基层法律服务所</title>
<script type="text/javascript">
$(function(){
	var json_data = {};
	var query = {};
	var service = new JcflfwsService();
	var form = new Eht.Form({selector:'#listJcflfws #jcflfwsForm',autolayout:true});
	var tableview = new Eht.TableView({selector:'#listJcflfws #tableview'});
	//展示页面信息
	tableview.loadData(function(page,res){
		service.findAll(query,page,res);
	});
	//单击一行获取该行的信息
	tableview.clickRow(function(data){
		json_data = data;
	});
	//新增按钮触发事件
	$('#listJcflfws #add').click(function(){
		form.clear();
		service.findOne(new Eht.Responder({
			success:function(data){
				form.fill(data);
			}
		}))
		$('#myModal').modal({backdrop:'static'});
	});
	//初始提示信息为隐藏状态
	$('#close_alert_div').hide();
	$('#delete_alert_div').hide();
	//查询按钮事件
	$('#listJcflfws #search').click(function(){
		query["jgmc[like]"] = $('#search-xm').val();
		tableview.refresh();
	});	
	//修改按钮事件
	$('#listJcflfws #edit').click(function(){
		if(json_data.id==null){
			$('#listJcflfws #close_alert_div').show();
		}else{
			form.fill(json_data);
			form.enable();
			$('#listJcflfws #myModal').modal({backdrop:'static'});
		}
	});
	$('#listJcflfws #delete').click(function(){
		if(json_data.id==null){
			$('#listJcflfws #close_alert_div').show();
		}else{
			$('#listJcflfws #delete_alert_div').show();
		}
	});
	$('#listJcflfws #no').click(function(){
		$('#listJcflfws #delete_alert_div').hide();
	});
	$('#listJcflfws #yes').click(function(){
		service.remove(json_data.id,new Eht.Responder({
			success:function(){
				tableview.refresh();
				$('#delete_alert_div').hide();
			}
		}));
	});
	//提示框关闭按钮
	$('#listJcflfws #close_alert').click(function(){
		$('#listJcflfws #close_alert_div').hide();
	});
	
	//模态框保存并且隐藏
	$('#listJcflfws #submit').click(function(){
		if(form.validate()){
			service.saveOne(form.getData(),new Eht.Responder({
				success:function(data){
					$('#myModal').modal('hide');
					tableview.refresh();
				}
			}));
		}
	});
	var textareaName = "#listJcflfws #floor";//备注输入框id
	var spanName = "#listJcflfws #count";//计数span的id
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
					.text("" + $(textareaName).val().length + "/2000");
			if ($(textareaName).val().length > 0) {
				$(spanName).css("color", "#3F51B5");
			}
			;
			if ($(textareaName).val().length > 240) {
				$(spanName).css("color", "#FF0000");
			}
			;
		} else {
			$(spanName).text("0/2000");
		}
	};
});
</script>
</head>
<body>
	<div id="listJcflfws">
		<div class="panel panel-default">
			<div class="panel-heading">
				<fieldset>
					<input type="text" id="search-xm" class="btn btn-default" placeholder="请输入机构名称"/>
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
					<div field="jgmc" label="机构名称"></div>
					<div field="zzxs" label="组织形式"></div>
					<div field="bzsj" label="颁证时间"></div>
					<div field="fzr" label="负责人"></div>
					<div field="dh" label="电话"></div>
					<div field="dz" label="地址"></div>
					<div field="jgzh" label="机构证号"></div>
				</div>
			</div>
		</div>
		<!-- 新增法律服务所信息(Modal) -->
		<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
							&times;
						</button>
						<h4 class="modal-title" id="myModalLabel">新增法律服务所信息</h4>
					</div>
					<div class="modal-body" style="overflow: auto;height:450px;">
						<div class="modal-body-div">
							<div id="jcflfwsForm">
								<div>
									<input type="hidden" name="id"/>
								</div>
								<input type="text" name="jgmc" label="机构名称" placeholder="请输入机构名称" />
								<input type="text" name="zzxs" label="组织形式"  placeholder="请选择组织形式" code="sys147" />
								<input type="text" name="bzsj" label="颁证时间"  placeholder="请输入颁证时间"  class="form_date" data-date-formate="yyyy-MM-dd" />
								<input type="text" name="fzr" label="负责人"  placeholder="请输入负责人" />
								<input type="text" name="dh" label="电话"  placeholder="请输入电话" valid="{required:true,mobile:true}"/>
								<input type="text" name="dz" label="地址" placeholder="请输入地址" />
								<input type="text" name="dqzt" label="当前状态"  placeholder="请输入当前状态"  code="sys148"/>
								<input type="text" name="jgzh" label="机构证号" placeholder="请输入机构证号" />
								<input type="text" name="zzbm" label="组织编号"  placeholder="请输入组织编号" />
								<input type="text" name="regionid" label="行政区划ID"  placeholder="请输入行政区划ID" getdis="true" disabled/>
								<input type="text" name="lng" label="经度" placeholder="请输入经度" getdis="true" disabled/>
								<input type="text" name="lat" label="纬度"  placeholder="请输入纬度" getdis="true" disabled/>
								<input type="text" name="zt" label="状态" placeholder="请输入状态" />
								<textarea type="text" name="jgjj" id="floor" label="机构简介"  placeholder="请输入机构简介" rows="8" maxlength="2000"></textarea>
								<span id="count"  style="color: #3F51B5;margin-left: 450px;"></span>
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