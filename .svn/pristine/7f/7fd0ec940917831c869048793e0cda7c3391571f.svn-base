<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 孙海龙 -->
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>矫正基地管理--社会矫正信息</title>
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<script type="text/javascript" src="${localCtx }/json/SqjzzxService.js"></script>
<script type="text/javascript">
$(function(){
	var json_data = {};
	var query = {};
	var service = new SqjzzxService();
	var form = new Eht.Form({selector:'#listSqjzzx #sqjzzxForm',autolayout:true});
	var tableview = new Eht.TableView({selector:'#listSqjzzx #tableview'});
	//默认界面展示的数据
	tableview.loadData(function(page,res){
		service.findAll(query,page,res);
	});
	//单击一行获取数据
	tableview.clickRow(function(data){
		json_data = data;
	});
	//查询按钮事件
	
	//新增按钮事件
	$('#listSqjzzx #add').click(function(){
		$('#listSqjzzx #myModal').modal({backdrop:'static'});
	});
	//修改按钮事件
	$('#listSqjzzx #edit').click(function(){
		if(json_data.id==null){
			$('#listSqjzzx #close_alert_div').show();
		}else{
			service.findOne({'id':json_data.id},new Eht.Responder({
				success:function(data){
					form.fill(data);
					$('#listSqjzzx #myModal').modal({backdrop:'static'});
				}
			}));
		}
	});
	//删除按钮事件
	$('#listSqjzzx #delete').click(function(){
		if(json_data.id==null){
			$('#listSqjzzx #close_alert_div').show();
		}else{
			$('#listSqjzzx #delete_alert_div').show();
		}
	});
	//初始提示信息为隐藏状态
	$('#listSqjzzx #close_alert_div').hide();
	$('#listSqjzzx #delete_alert_div').hide();
	//查询按钮事件
	$('#listSqjzzx #search').click(function(){
		query.xm = $('#listSqjzzx #search-xm').val();
		tableview.loadData(function(page,res){
			service.findAll(query,page,res);
		});
	});	
	//提示界面取消按钮事件
	$('#listSqjzzx #no').click(function(){
		$('#listSqjzzx #delete_alert_div').hide();
	});
	//提示界面确定按钮事件
	$('#listSqjzzx #yes').click(function(){
		service.deleteOne({'id':json_data.id},new Eht.Responder({
			success:function(){
				tableview.refresh();
				$('#listSqjzzx #delete_alert_div').hide();
			}
		}));
	});
	
	$('#listSqjzzx #close_alert').click(function(){
		$('#listSqjzzx #close_alert_div').hide();
	});
	//模态框保存并且隐藏
	$('#listSqjzzx #submit').click(function(){
		if(form.validate()){
			service.saveOne(form.getData(),new Eht.Responder({
				success:function(data){
					$('#listSqjzzx #myModal').modal('hide');
					tableview.refresh();
				}
			}));
		}
	});
	var textareaName = "#listSqjzzx #floor";//备注输入框id
	var spanName = "#listSqjzzx #count";//计数
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
	<div id="listSqjzzx">
		<div class="panel panel-default">
			<div class="panel-heading">
				<fieldset>
					<input type="text" id="search-xm" class="btn btn-default" placeholder="请输入基地名称"/>
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
					<div field="zxmc" label="中心名称"></div>
					<div field="clrq" label="中心成立日期"></div>
					<div field="fzr" label="中心负责人"></div>
					<div field="lxdh" label="联系电话"></div>
					<div field="jddz" label="中心地址"></div>
				</div>
			</div>
		</div>
		<!-- 新增社会矫正信息(Modal) -->
		<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
							&times;
						</button>
						<h4 class="modal-title" id="myModalLabel">新增社会矫正信息</h4>
					</div>
					<div class="modal-body" style="overflow: auto;height:470px">
						<div class="modal-body-div">
							<div id="sqjzzxForm">
								<div>
									<input type="hidden" name="id"/>
								</div>
								<input type="text" id="zxmc" name="zxmc" label="中心名称"  valid="{required:true}"/>
								<input type="text" name="zxdz" label="中心地址" getdis="true" valid="{required:true}"  />
								<input type="text" name="zxgn" label="中心功能" getdis="true"  valid="{required:true}"  />
								<input type="text" name="fzr" label="负责人" getdis="true"  valid="{required:true}"/>
								<input type="text" name="clrq" label="成立日期" getdis="true"  valid="{required:true}" class="form_date" data-date-formate="yyyy-MM-dd"/>
								<input type="text" name="pzjlrq" label="批准建立日期" getdis="true"  valid="{required:true}" class="form_date" data-date-formate="yyyy-MM-dd"/>
								<input type="text" name="pzr" label="批准人" getdis="true"  valid="{required:true}"/>
								<input type="text" name="lxdh" label="联系电话"  valid="{required:true,mobile: true}"/>
								<input type="text" name="frdb" label="法人代表" getdis="true"  valid="{required:true}"/>
								<textarea type="text" name="zxgk" label="中心概况" id="floor"   maxlength="500"  valid="{required:true}" rows="8"></textarea>
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
	</div>
</body>
</html>