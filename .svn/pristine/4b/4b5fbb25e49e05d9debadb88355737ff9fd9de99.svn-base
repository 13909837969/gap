<%@ page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>
<html>
<head>
<title>定期报告情况</title>
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<script type="text/javascript" src="${localCtx}/json/JdglService.js"></script>
<script type="text/javascript">
	$(function() {
		var form = new Eht.Form({
			selector : "#sqjz_JdglDqbgqk #querypanel"
		});
		var tableView = new Eht.TableView({
			selector : "#sqjz_JdglDqbgqk #tableview"
		});
		var service = new JdglService();
		//定义一个查询条件变量
		var querySearch = {};
		$("#sqjz_JdglDqbgqk #querybtn").click(function() {
			querySearch["xm"] = $("#sqjz_JdglDqbgqk #search-xm").val();
			tableView.refresh();
			
		});
		
		tableView.loadData(function(page,res) {
			service.findPeriodicReport(querySearch,page,res);
		})
		
		/* //查询按钮事件
		$("#sqjz_JdglDqbgqk #querybtn").click(function() {
			tableView.refresh();
		});
		tableView.loadData(function(page, res) {
			 service.findPeriodicReport(form.getData(), page, res);
		}); */
		//单击一行获取该行信息
		var json = {};
		tableView.clickRow(function(data) {
			$("#close_alert_div").hide();
			json = data;
			
		});
		//思想汇报信息查询审核
		$('#sqjz_JdglDqbgqk #sxhbcxbtn').click(function(){
			if(json.f_id ==null){
				$('#close_alert_div').show();
			}else{
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
					/* 单击时间框选择时间 */
					$(".calendar_time").unbind('click').bind('click',function(){
						$(this).parent().find(".form_date_time").datetimepicker("show");
					});
					var form = new Eht.Form({selector:"#modal-body-div"});
					form.fill(json);
					//评分良好按钮事件
					$('#sqjz_JdglDqbgqk #btn-lh').unbind('click').bind('click',function(){
						service.updateStatus(1,json.f_id,new Eht.Responder({
							success:function(data){
								$("#sqjz_JdglDqbgqk #myModal").modal("hide");
								tableView.refresh();
							}
						}));
								json.f_id=null;
					})
					//评分进步按钮事件
					$('#sqjz_JdglDqbgqk #btn-jb').unbind('click').bind('click',function(){
						service.updateStatus(2,json.f_id, new Eht.Responder({
							success:function(data){
								$("#sqjz_JdglDqbgqk #myModal").modal("hide");
								tableView.refresh();
							}
						}));
								json.f_id=null;
					})
					//评分继续教育按钮事件
					$('#sqjz_JdglDqbgqk #btn-jxjy').unbind('click').bind('click',function(){
						service.updateStatus(3,json.f_id, new Eht.Responder({
							success:function(data){
								$("#sqjz_JdglDqbgqk #myModal").modal("hide");
								tableView.refresh();
							}
						}));
								json.f_id=null;
					})
				});
				$("#myModal").modal({
					backdrop : 'static',
					keyboard : false
				}); 
			}
		})
		//关闭按钮
		$('#sqjz_JdglDqbgqk #close').click(function(){
			tableView.refresh();
		});
		$('#sqjz_JdglDqbgqk #xxx').click(function(){
			tableView.refresh();
		});
		//初始提示信息为隐藏状态
		$('#close_alert_div').hide();
		$('#close_alert').click(function(){
			$('#close_alert_div').hide();
		});
	});
</script>
</head>
<body>
	<div id="sqjz_JdglDqbgqk">
		<div class="panel panel-default">
			<div class="panel-heading ltrhao-toolbar" style="padding-left: 20px;">
				<fieldset id="querypanel">
					姓名:<input id="search-xm" class="btn btn-default" type="text"  placeholder="请输入姓名" autocomplete="off"/> 
					<input class="btn btn-default" type="button" id="querybtn" value="查询">
					<input class="btn btn-default" type="button" id="sxhbcxbtn" value="思想汇报信息查询审查"> 
				</fieldset>
			</div>
			<div class="alert alert-warning alert_dismissible" id="close_alert_div" role="alert" style="text-align:center;font-size:17px">
				<strong>提示</strong> 请选择一条信息!
				<input type="button" class="btn btn-default" id="close_alert" value="取消"/>
			</div>
			<div class="panel-body">
				<div id="tableview" class="table-responsive">
					<div field='op' label="选择" checkbox="true"></div>
					<div field="xm" label="姓名"></div>
					<div field="cts" label="创建时间"></div>
					<div field="f_pf" label="评分(已审核)"></div>
					<div field="f_hbnr" label="汇报内容"></div>
				</div>
			</div>
		</div>
		<!-- 模态框（Modal） -->
		<div class="modal fade" id="myModal">
			<div class="modal-dialog ">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="false" id="xxx">×</button>
						<h4 class="modal-title" id="myModalLabel">定期报告情况</h4>
					</div>
					<div class="modal-body" id="modal-body" style="height: 400px; overflow: auto">
						<div id="modal-body-div">
							<div class="row form-group">
								<label for="firstname" class="col-sm-2 control-label">社区服刑人员姓名</label>
								<div class="col-sm-10 col-padding15">
									<input name="xm" type="text" class="form-control"
										 placeholder="社区服刑人员姓名" disabled>
								</div>
							</div>
							<div class="row form-group">
								<label for="firstname" class="col-sm-2 control-label">创建时间</label>
								<div class="col-sm-10 col-padding15">
									<input id="time" name="cts" type="text" disabled
									class="form_date_time form-control" data-date-format="yyyy-MM-dd" placeholder="创建时间">
								</div>
							</div>
							<div class="row form-group">
								<label for="firstname" class="col-sm-2 control-label">评分</label>
								<div class="col-sm-10 col-padding15">
									<input name="f_pf" type="text" class="form-control" disabled
										 placeholder="评分">
								</div>
							</div>
							<div class="row form-group">
								<label for="firstname" class="col-sm-2 control-label">汇报内容</label>
								<div class="col-sm-10 col-padding15">
									 <textarea class="form-control" rows="8"  name="f_hbnr" disabled></textarea>
								</div>
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-success" id="btn-lh">良好</button>
								<button type="button" class="btn btn-success" id="btn-jb">进步</button>
								<button type="button" class="btn btn-success" id="btn-jxjy">继续教育</button>
							</div>
						</div>
						
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