<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!--孙海龙 -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<script type="text/javascript" src="${localCtx }/json/JcflgzzService.js"></script>
<title>基层法律工作者</title>
<script type="text/javascript">
$(function(){
	var json_data = {};
	var query = {};
	var service = new JcflgzzService();
	var form = new Eht.Form({selector:'#listJcflgzz #jcflfwgzzForm',autolayout:true});
	var tableview = new Eht.TableView({selector:'#listJcflgzz #tableview'});
	//展示页面信息
	tableview.loadData(function(page,res){
		service.findAll(query,page,res);
	});
	//单击一行获取该行的信息
	tableview.clickRow(function(data){
		json_data = data;
	});
	//新增按钮触发事件
	$('#listJcflgzz #add').click(function(){
		form.clear();
		$('#myModal').modal({backdrop:'static'});
	});
	//初始提示信息为隐藏状态
	$('#close_alert_div').hide();
	$('#delete_alert_div').hide();
	//查询按钮事件
	$('#listJcflgzz #search').click(function(){
		query["jgmc[like]"] = $('#search-xm').val();
		tableview.refresh();
	});	
	//修改按钮事件
	$('#listJcflgzz #edit').click(function(){
		if(json_data.id==null){
			$('#listJcflgzz #close_alert_div').show();
		}else{
			form.fill(json_data);
			$('#listJcflgzz #myModal').modal({backdrop:'static'});
		}
	});
	$('#listJcflgzz #delete').click(function(){
		if(json_data.id==null){
			$('#listJcflgzz #close_alert_div').show();
		}else{
			$('#listJcflgzz #delete_alert_div').show();
		}
	});
	$('#listJcflgzz #no').click(function(){
		$('#listJcflgzz #delete_alert_div').hide();
	});
	$('#listJcflgzz #yes').click(function(){
		service.remove(json_data.id,new Eht.Responder({
			success:function(){
				tableview.refresh();
				$('#listJcflgzz #delete_alert_div').hide();
			}
		}));
	});
	//提示框关闭按钮
	$('#listJcflgzz #close_alert').click(function(){
		$('#listJcflgzz #close_alert_div').hide();
	});
	
	//模态框保存并且隐藏
	$('#listJcflgzz #submit').click(function(){
		if(form.validate()){
			service.saveOne(form.getData(),new Eht.Responder({
				success:function(data){
					$('#myModal').modal('hide');
					tableview.refresh();
				}
			}));
		}
	});
	var textareaName = "#listJcflgzz #floor";//备注输入框id
	var spanName = "#listJcflgzz #count";//计数span的id
	$(textareaName).click(function() {
		countChar(textareaName, spanName);
	});
	$(textareaName).keyup(function(){
		countChar(textareaName, spanName);
	});
	$(textareaName).keydown(function() {
		countChar(textareaName, spanName);
	});
	//
	function countChar(textareaName, spanName) {
		if ($(textareaName).val() != "") {
			$(spanName)
					.text("" + $(textareaName).val().length + "/1000");
			if ($(textareaName).val().length > 0) {
				$(spanName).css("color", "#3F51B5");
			}
			;
			if ($(textareaName).val().length > 240) {
				$(spanName).css("color", "#FF0000");
			}
			;
		} else {
			$(spanName).text("0/1000");
		}
	};
});
</script>
</head>
<body>
	<div id="listJcflgzz">
		<div class="panel panel-default">
			<div class="panel-heading">
				<fieldset>
					<input type="text" id="search-xm" class="btn btn-default" placeholder="请输入姓名"/>
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
					<div field="xb" label="性别" ></div>
					<div field="xl" label="学历"></div>
					<div field="qsnd" label="起始年度"></div>
					<div field="xq" label="刑期"></div>
					<div field="bzsj" label="颁证时间"></div>
					<div field="ywzc" label="业务专长"></div>
					<div field="zt" label="状态"></div>
				</div>
			</div>
		</div>
		<!-- 新增法律工作者信息(Modal) -->
		<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
							&times;
						</button>
						<h4 class="modal-title" id="myModalLabel">新增法律工作者信息</h4>
					</div>
					<div class="modal-body" style="overflow: auto;height:450px;">
						<div class="modal-body-div">
							<div id="jcflfwgzzForm">
								<div>
									<input type="hidden" name="id"/>
								</div>
								<input type="text" name="zyzh" label="职业证号"  placeholder="请输入职业证号" />
								<input type="text" name="xm" label="姓名" placeholder="请输入姓名" />
								<input type="text" name="xb" label="性别"  placeholder="请输入性别"  code="sys000"/>
								<input type="text" name="mz" label="民族"  placeholder="请输入民族"  code="sys003"/>
								<input type="text" name="xl" label="学历"  placeholder="请输入学历"  code="sys028"/>
								<input type="text" name="zzmm" label="政治面貌"  placeholder="请输入政治面貌"  code="sys091"/>
								<input type="text" name="gzdw" label="工作单位" placeholder="请输入工作单位" />
								<input type="text" name="qsnd" label="起始年度"  placeholder="请输入起始年度"  class="form_date" data-date-formate="yyyy-MM-dd" />
								<input type="text" name="bzsj" label="颁证时间"  placeholder="请输入颁证时间"  class="form_date" data-date-formate="yyyy-MM-dd" />
								<input type="text" name="njqk" label="年检情况"  placeholder="请输入年检情况" />
								<input type="text" name="zhnjsj" label="最后年检时间" placeholder="请输入最后年检时间"  class="form_date" data-date-formate="yyyy-MM-dd" />
								<input type="text" name="ywzc" label="业务专长"  placeholder="请输入业务专长" />
								<input type="text" name="zyxzqh" label="职业行政区划"  placeholder="请输入职业行政区划" />
								<input type="text" name="zt" label="状态" placeholder="请输入状态" />
								<textarea type="text" name="grjj" id="floor" maxlength="1000" label="个人简介"  placeholder="请输入个人简介" rows="8"></textarea>
								<span id="count" style="color: #3F51B5;margin-left: 450px;"></span>
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