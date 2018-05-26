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
		tableView.loadData(function(page, res) {
			 service.findPeriodicReport(form.getData(), page, res);
		});
		//单击一行获取该行信息
		var json = {};
		tableView.clickRow(function(data) {
			json = data;
			var aid = json.f_aid;
		});
		//查询按钮事件
		$("#sqjz_JdglDqbgqk #querybtn").click(function() {
			tableView.refresh();
		});
		//思想汇报信息查询审核
		$('#sqjz_JdglDqbgqk #sxhbcxbtn').click(function(){
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
					service.updateStatus(1,json.cts,json.f_aid, new Eht.Responder({
						success:function(data){
							tableView.refresh();
						}
					}));
				})
				//评分进步按钮事件
				$('#sqjz_JdglDqbgqk #btn-jb').unbind('click').bind('click',function(){
					service.updateStatus(2,json.cts,json.f_aid, new Eht.Responder({
						success:function(data){
							tableView.refresh();
						}
					}));
				})
				//评分继续教育按钮事件
				$('#sqjz_JdglDqbgqk #btn-jxjy').unbind('click').bind('click',function(){
					service.updateStatus(3,json.cts,json.f_aid, new Eht.Responder({
						success:function(data){
							tableView.refresh();
						}
					}));
				})
			});
			$("#myModal").modal({
				backdrop : 'static',
				keyboard : false
			}); 
		})
		//关闭按钮
		$('#sqjz_JdglDqbgqk #close').click(function(){
			tableView.refresh();
		});
		$('#sqjz_JdglDqbgqk #xxx').click(function(){
			tableView.refresh();
		});
	});
</script>
</head>
<body>
	<div id="sqjz_JdglDqbgqk">
		<div class="panel panel-default">
			<div class="panel-heading ltrhao-toolbar" style="padding-left: 20px;">
				<fieldset id="querypanel">
					姓名:<input class="btn btn-default" type="text" name="xm[like]" placeholder="请输入姓名"/> 
					<input class="btn btn-default" type="button" id="querybtn" value="查询">
					<input class="btn btn-default" type="button" id="sxhbcxbtn" value="思想汇报信息查询审查"> 
				</fieldset>
			</div>
			<div class="panel-body">
				<div id="tableview" class="table-responsive">
					<div field='op' label="选择" checkbox="true"></div>
					<div field="xm" label="姓名"></div>
					<div field="cts" label="创建时间"></div>
					<div field="f_pf" label="评分(已审核)"></div>
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
								<label for="firstname" class="col-sm-2 control-label">社区矫正人员姓名</label>
								<div class="col-sm-10 col-padding15">
									<input name="xm" type="text" class="form-control"
										id="firstname" placeholder="社区矫正人员姓名">
								</div>
							</div>
							<div class="row form-group">
								<label for="firstname" class="col-sm-2 control-label">创建时间</label>
								<div class="col-sm-10 col-padding15">
									<input id="time" name="cts" type="text" 
									class="form_date_time form-control" data-date-format="yyyy-MM-dd" placeholder="创建时间">
								</div>
							</div>
							<div class="row form-group">
								<label for="firstname" class="col-sm-2 control-label">评分</label>
								<div class="col-sm-10 col-padding15">
									<input name="f_pf" type="text" class="form-control"
										id="firstname" placeholder="评分">
								</div>
							</div>
							<div class="row form-group">
								<label for="firstname" class="col-sm-2 control-label">汇报内容</label>
								<div class="col-sm-10 col-padding15">
									 <textarea class="form-control" rows="8"  name="f_hbnr"></textarea>
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