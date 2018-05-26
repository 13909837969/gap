<%@ page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>
<html>
<head>
<title>帮扶信息</title>
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<script type="text/javascript" src="${localCtx}/json/BfxxService.js"></script>
<script type="text/javascript">
$(function() {
	var form = new Eht.Form({
		selector : "#sqjz_listBfxx #modal-body-div",autolayout:true
	});
	var tableView = new Eht.TableView({
		selector : "#sqjz_listBfxx #tableview"
	});
	var query ={};
	var service = new BfxxService();
	tableView.loadData(function(page, res) {
		service.findAllHelp(query, page, res);
	});
	//单击一行获取该行信息
	var json = {};
	tableView.clickRow(function(data) {
		json = data;
		
	});
	//双击弹出人员详情
	tableView.dblclickRow(function(data){
		$("#sqjz_listBfxx #myModal1").modal({backdrop: 'static', keyboard: false});//弹出模态框
		$("#sqjz_listBfxx #iframe").attr("src","${localCtx}/module/sqjz/viewSqjzryjbxxb.jsp?id=" + data.f_aid);//向子页传输id
	});
	//提示框div初始状态为隐藏
	$('#sqjz_listBfxx #hideDiv').hide();
	$('#sqjz_listBfxx #hideScDiv').hide();
	//关闭按钮
	$('#sqjz_listBfxx #guanbibtn').click(function(){
		$('#sqjz_listBfxx #hideDiv').hide();
	});
	
	//取消按钮
	$('#sqjz_listBfxx #quxiaobtn').click(function(){
		$('#sqjz_listBfxx #hideDiv').hide();
		tableView.refresh();
	})
	$('#sqjz_listBfxx #quxiaobtn1').click(function(){
		$("#sqjz_listBfxx #hideScDiv").hide();
		tableView.refresh();
	})
	//关闭按钮事件 清除未选择的数据
	$('#sqjz_listBfxx #close').click(function(){
		json={};
		tableView.refresh();
	});
	//关闭按钮事件 清除未选择的数据
	$('#sqjz_listBfxx #xxx').click(function(){
		json={};
		tableView.refresh();
	});
	//查询按钮事件
	$("#sqjz_listBfxx #querybtn").click(function() {
		query["xm[like]"]=$("#sqjz_listBfxx #selectXM").val();
		tableView.refresh();
	});
	/*增加一条信息  */
	$("#sqjz_listBfxx #addbtn").click(function(){
		$("#modal-body-div input").empty();
		$("#modal-body").show(function(){
			$(".form_date_time").datetimepicker({
				format: 'yyyy-mm-dd hh:ii', 
				language:  'zh-CN',
				autoclose: true,
		        weekStart: 1,
		        todayBtn:  1,
				autoclose: 1,
				minView: 0,
				forceParse: 0	
			});
			$(".calendar_time").unbind('click').bind('click',function(){
				$(this).parent().find(".form_date_time").datetimepicker("show");
			});
			$('#sqjz_listBfxx #btn-primary').unbind('click').bind('click',function(){
				service.saveHelp(form.getData(),new Eht.Responder({
					success:function(data){
						tableView.refresh();
						$('#sqjz_listBfxx #myModal').modal('hide');
					}
				}));
				form.clear();
			});
		})
		$("#myModal").modal({
			backdrop : 'static',
			keyboard : false
		}); 
	});
	
	/*修改一条信息  */
	$("#sqjz_listBfxx #updatebtn").click(function() {
		if(json.id==null){
			$('#sqjz_listBfxx #hideDiv').show();
		}else{
			form.fill(json);
			$("#modal-body").show(function(){
				$('#sqjz_listBfxx #btn-primary').unbind('click').bind("click",function(){
					service.saveHelp(form.getData(),new Eht.Responder({
						success:function(data){
							tableView.refresh();
							$('#sqjz_listBfxx #myModal').modal('hide');
						}
					}))
				})
			})
			$("#myModal").modal({
				backdrop : 'static',
				keyboard : false
			});
		}
	});
	/* 删除信息 */
	$("#sqjz_listBfxx #deletebtn").click(function() {
		var array = tableView.getSelectedData();
		if(array.length==0){
			$('#sqjz_listBfxx #hideDiv').show();
		}else{
				$('#sqjz_listBfxx #hideScDiv').show();
				//确定按钮
				$('#sqjz_listBfxx #shanchubtn').unbind('click').bind('click',function(){
					$('#sqjz_listBfxx #hideScDiv').hide();
					var f_aid = json.id;
					service.deleteHelp(f_aid);
					tableView.refresh();
				})
		}
	});
	//帮扶内容
	var textareaName = "#sqjz_listBfxx #floor";//备注输入框id
	var spanName = "#sqjz_listBfxx #count";//计数span的id
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
			$(spanName).text("已输入：" + $(textareaName).val().length + "/250");			
			if($(textareaName).val().length>0){
					$(spanName).css("color","#3F51B5");
			};
			if($(textareaName).val().length>240){
					$(spanName).css("color","#FF0000");
				};
		}else{
			$(spanName).text("已输入：0/250");
		}
	};
	
	service.findJzry(new Eht.Responder({
		success:function(data){
			$("#bfxxcjForm_jzry").empty();
			$("#bfxxcjForm_jzry").append('<option selected="selected"></option>');
			for(var i=0;i<data.length;i++){
				$("#bfxxcjForm_jzry").append("<option value="+data[i].id+">"+data[i].xm + "     " + data[i].grlxdh +"</option>");
			}
			$("#bfxxcjForm_jzry").comboSelect();
		}
	}));
})
 </script>
</head>
<body>
<div id="sqjz_listBfxx">
	<div class="panel panel-default">
			<div class="panel-heading ltrhao-toolbar" style="padding-left: 20px;">
				<fieldset id="querypanel">
					<input class="btn btn-default" type="text" name="xm[like]" id="selectXM" placeholder="请输入姓名" /> 
					<input class="btn btn-default" type="button" id="querybtn" value="查询">
					<input id="addbtn" class="btn btn-default" type="button" value="新增">
					<input id="updatebtn" class="btn btn-default" type="button" value="修改"> 
					<input id="deletebtn" class="btn btn-default" type="button" value="删除">
				</fieldset>
			</div>
			<div class="alert alert-warning alert-dismissible" role="alert" id="hideDiv" style="text-align:center;font-size:17px">
				    <strong>警告!</strong> 请先选择一条信息！
				    <input id="quxiaobtn" class="btn btn-default" type="button" value="取消" >
			</div>	
			<div class="alert alert-warning alert-dismissible" role="alert" id="hideScDiv" style="text-align:center;font-size:17px">
				    <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				    <strong>警告!</strong> 确定删除？
				    <input id="shanchubtn" class="btn btn-default" type="button" value="确定" >
				    <input id="quxiaobtn1" class="btn btn-default" type="button" value="取消" >
			</div>	
			<div class="panel-body">
				<div id="tableview" class="table-responsive">
					<div field='op' label="选择" checkbox="true"></div>
					<div field="xm" label="姓名"></div>
					<div field="xb" label="性别" code="sys000"></div>
					<div field="bfsj" label="帮扶时间"></div>
					<div field="bfdd" label="帮扶地点"></div>
					<div field="jlr" label="记录人"></div>
				</div>
			</div>
		</div>
	<!-- 新增弹出模态框（Modal） -->
	<div class="modal fade" id="myModal">
			<div class="modal-dialog ">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="false" id="xxx">×</button>
						<h4 class="modal-title" id="myModalLabel">帮扶信息采集表</h4>
					</div>
					<div class="modal-body" id="modal-body" style="height: 400px; overflow: auto">
						<div id="modal-body-div">
							<div hidden>
								<input name="id" type="hidden">
							</div>
							<select id="bfxxcjForm_jzry" name="f_aid" label="服刑人员">
							</select>
							<input  name="bfsj" type="text" label="帮扶时间" class="form_date_time form-control" data-date-format="yyyy-MM-dd" placeholder="请输入帮扶时间">
							<input name="bfdd" type="text" label="帮扶地点" placeholder="请输入帮扶地点">
							<input name="jlr" type="text" label="记录人" placeholder="请输入记录人" value="${CURRENT_USER_SESSION.name}" readonly="true" fixedValue="true">
							<textarea label="帮扶内容" rows="8" name="bfnr" id="floor" type="text" maxlength="250" placeholder="请输入帮扶内容"></textarea>
							<span id="count" style="margin-left:440px;color:#3F51B5"></span>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal" id="close">关闭</button>
						<button type="button" class="btn btn-primary" id="btn-primary">提交</button>
					</div>
				</div>
				<!-- /.modal-content -->
			</div>
			<!-- /.modal-dialog -->
		</div>
		<!-- 双击弹出模态框（Modal） -->
		<div class="modal fade" id="myModal1">
			<div class="modal-dialog">
				<div class="modal-content" >
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="false" id="xxx">×</button>
						<h4 class="modal-title" id="myModalLabel">矫正人员信息</h4>
					</div>
					<div class="modal-body" id="modal-body" style="height: 400px; overflow: auto">
						<iframe id="iframe" width="100%" height="100%" scrolling="yes" frameborder="0">
								
						</iframe>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal" id="close">关闭</button>
					</div>
				</div>
				<!-- /.modal-content -->
			</div>
			<!-- /.modal-dialog -->
		</div>
</div>
</body>
</html>