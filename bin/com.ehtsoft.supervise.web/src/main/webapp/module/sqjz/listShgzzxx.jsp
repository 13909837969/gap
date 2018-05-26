
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!--孙海龙  -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<script type="text/javascript" src="${localCtx }/json/ShgzzService.js"></script>
<title>社会工作者信息采集表</title>
<script type="text/javascript">
$(function(){
	var json_data = {};
	var query = {};
	var service = new ShgzzService();
	var form = new Eht.Form({selector:'#listShgzzxx #jcflfwsForm',autolayout:true});
	var tableview = new Eht.TableView({selector:'#listShgzzxx #tableview'});
	//展示页面信息
	tableview.loadData(function(page,res){
		service.findAll(query,page,res);
	});
	//单击一行获取该行的信息
	tableview.clickRow(function(data){
		json_data = data;
	});
	//新增按钮触发事件
	$('#listShgzzxx #add').click(function(){
		form.clear();
		$("#listShgzzxx #sfzh").change(function(){
			var csrq = $("#listShgzzxx #sfzh").val().substring(6,14);
			var csrqyyyy = csrq.substring(0,4);
			var csrqMM = csrq.substring(4,6);
			var csrqdd = csrq.substring(6);
			$("#listShgzzxx #csrq").val(csrqyyyy+"-"+csrqMM+"-"+csrqdd);
		})
		$('#myModal').modal({backdrop:'static'});
	});
	//初始提示信息为隐藏状态
	$('#listShgzzxx #close_alert_div').hide();
	$('#listShgzzxx #delete_alert_div').hide();
	//查询按钮事件
	$('#listShgzzxx #search').click(function(){
		query["xm[like]"] = $('#search-xm').val();
		query["sfzh[like]"] = $('#search-sfzh').val();
		tableview.refresh();
	});	
	//修改按钮事件
	$('#listShgzzxx #edit').click(function(){
		if(json_data.id==null){
			$('#listShgzzxx #close_alert_div').show();
		}else{
			form.fill(json_data);
			$('#listShgzzxx #myModal').modal({backdrop:'static'});
		}
	});
	$('#listShgzzxx #delete').click(function(){
		if(json_data.id==null){
			$('#listShgzzxx #close_alert_div').show();
		}else{
			$('#listShgzzxx #delete_alert_div').show();
		}
	});
	$('#listShgzzxx #no').click(function(){
		$('#listShgzzxx #delete_alert_div').hide();
	});
	$('#listShgzzxx #yes').click(function(){
		service.removeOne(json_data.id,new Eht.Responder({
			success:function(){
				tableview.refresh();
				$('#listShgzzxx #delete_alert_div').hide();
			}
		}));
	});
	//提示框按钮事件
	$('#listShgzzxx #close_alert').click(function(){
		$('#listShgzzxx #close_alert_div').hide();
	});
	
	//模态框保存并且隐藏
	$('#listShgzzxx #submit').click(function(){
		if(form.validate()){
			service.saveOne(form.getData(),new Eht.Responder({
				success:function(data){
					$('#myModal').modal('hide');
					tableview.refresh();
				}
			}));
		}
	});
	var textareaName = "#listShgzzxx #floor";//备注输入框id
	var spanName = "#listShgzzxx #count";//计数span的id
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
					.text("" + $(textareaName).val().length + "/250");
			if ($(textareaName).val().length > 0) {
				$(spanName).css("color", "#3F51B5");
			}
			;
			if ($(textareaName).val().length > 240) {
				$(spanName).css("color", "#FF0000");
			}
			;
		} else {
			$(spanName).text("0/250");
		}
	};
});
</script>
</head>
<body>
	<div id="listShgzzxx">
		<div class="panel panel-default">
			<div class="panel-heading">
				<fieldset>
					<input type="text" id="search-xm" class="btn btn-default" placeholder="请输入姓名"/>
					<input type="text" id="search-sfzh" class="btn btn-default" placeholder="请输入身份证号"/>
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
					<div field="sfzh" label="身份证号"></div>
					<div field="zy" label="专业" code="sys095"></div>
					<div field="lxdh" label="联系电话"></div>
					<div field="htq" label="合同期" code="sys029"></div>
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
						<h4 class="modal-title" id="myModalLabel">新增社会工作者信息</h4>
					</div>
					<div class="modal-body" style="overflow: auto;height:450px;">
						<div class="modal-body-div">
							<div id="jcflfwsForm">
								<div>
									<input type="hidden" name="id"/>
								</div>
								<input type="text" name="xm" label="姓名" placeholder="请输入姓名" />
								<input type="text" name="xb" label="性别"  placeholder="请选择性别" code="sys000" />
								<input type="text" name="sfzh" id="sfzh" label="身份证号"  placeholder="请输入身份证号" valid="{cardNo:true}"/>
								<input type="text" name="csrq" id="csrq" label="出生日期"  placeholder="请输入出生日期" disabled class="form_date" data-date-formate="yyyy-MM-dd" />
								<input type="text" name="xl" label="学历"  placeholder="请输入学历" code="sys028"/>
								<input type="text" name="zgxw" label="最高学位" placeholder="请输入最高学位" code="sys093"/>
								<input type="text" name="zzmm" label="政治面貌"  placeholder="请输入政治面貌"  code="sys091"/>
								<input type="text" name="zy" label="专业" placeholder="请输入专业" code="sys095"/>
								<input type="text" name="zc" label="职称"  placeholder="请输入职称" code="sys026"/>
								<input type="text" name="xcspd" label="薪酬水平段"  placeholder="请输入薪酬水平段" code="sys027"/>
								<input type="text" name="ssjg" label="所属机构" placeholder="请输入所属机构" />
								<input type="text" name="lxdh" label="联系电话"  placeholder="请输入联系电话" />
								<input type="text" name="sj" label="手机" placeholder="请输入手机" valid="{required:true,mobile:true}"/>
								<input type="text" name="jtzz" label="家庭住址" placeholder="请输入家庭住址" />
								<input type="text" name="htq" label="合同期" placeholder="请输入合同期" code="sys029"/>
								<textarea type="text" name="remark" id="floor" label="备注"  placeholder="请输备注" rows="8" maxlength="250"></textarea>
								<span id="count"  style="color: #3F51B5;margin-left: 470px;"></span>
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