<%@ page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>
<html>
<head>
<title>走访检查情况</title>
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<script type="text/javascript" src="${localCtx}/json/JdglService.js"></script>
</head>
<script type="text/javascript">
	$(function() {
		var form = new Eht.Form({
			selector : "#listJdglZfjcqk #querypanel"
		});
		var tableView = new Eht.TableView({
			selector : "#listJdglZfjcqk #tableview"
		});
		var service = new JdglService();
		
		var query={};
		tableView.loadData(function(page, res) {
			service.findVisitCheck(query, page, res);
		});
		//单击一行获取该行信息
		var json = {};
		tableView.clickRow(function(data) {
			json = data;
		});
		//查询按钮事件
		$("#listJdglZfjcqk #querybtn").click(function(){
			query["xm[like]"] = $("#xxx").val();
			tableView.refresh();
		});
		//随访信息查看
		$('#listJdglZfjcqk #sxhbcxbtn').click(function() {
			if(json.f_id == null){
				$("#close_alert_div").show();
			}else{
				$("#modal-body").show(function() {
					var form = new Eht.Form({selector : "#modal-body-div"});
					form.fill(json);
					form.disable();
					json = {};
				});
				$("#myModal").modal({
					backdrop : 'static',
					keyboard : false
				});
			}
		})
		//提示框取消按钮事件
		$("#close_alert_div").hide();
		$("#close_alert").click(function(){
			$("#close_alert_div").hide();
		})
		//关闭按钮
		$('#listJdglZfjcqk #close').click(function(){
			tableView.refresh();
		});
		$('#listJdglZfjcqk #xxx').click(function(){
			tableView.refresh();
		});
	})
</script>
<body>
	<div id="listJdglZfjcqk">
		<div class="panel panel-default">
			<div class="panel-heading ltrhao-toolbar" style="padding-left: 20px;">
				<fieldset id="querypanel">
					姓  名:<input class="btn btn-default" type="text" name="xm[like]" placeholder="请输入姓名" id="xxx"/> 
					<input class="btn btn-default" type="button" id="querybtn" value="查询">
					<input class="btn btn-default" type="button" id="sxhbcxbtn" value="随访信息查看">
				</fieldset>
			</div>
			<div class="alert alert-warning alert_dismissible" id="close_alert_div" role="alert" style="text-align:center;font-size:17px">
			<strong>提示</strong> 请选择一条信息!
				<input type="button" class="btn btn-default" id="close_alert" value="取消"/>
			</div>
			<div class="panel-body">
				<div id="tableview" class="table-responsive">
					<div field='op' label="选择"  checkbox="true"></div>
					<div field="xm" label="姓名"   id="xm" name="xm"></div>
					<div field="xb" label="性别" code="sys000"  id="xb" name="xb"></div>
					<div field="csrq" label="年龄"  id="nl" name="nl"></div>
					<div field="f_thr" label="谈话人"  id="f_thr" name="f_thr"></div>
					<div field="f_jlr" label="记录人"  id="f_jlr" name="f_jlr"></div>
					<div field="cts" label="创建时间" id="cts" name="cts"></div>
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
						<h4 class="modal-title" id="myModalLabel">走访检查情况</h4>
					</div>
					<div class="modal-body" id="modal-body"
						style="height: 400px; overflow: auto">
						<div id="modal-body-div">
							<div class="row form-group">
								<label for="firstname" class="col-sm-2 control-label">姓名</label>
								<div class="col-sm-10 col-padding15">
									<input name="xm" type="text" class="form-control"
										id="firstname" placeholder="姓名">
								</div>
							</div>
							<div class="row form-group">
								<label for="firstname" class="col-sm-2 control-label">性别</label>
								<div class="col-sm-10 col-padding15">
									<input name="xb" type="text" class="form-control"
										id="xb" placeholder="性别">
								</div>
							</div>
							<div class="row form-group">
								<label for="firstname" class="col-sm-2 control-label">年龄</label>
								<div class="col-sm-10 col-padding15">
									<input name="csrq" type="text" class="form-control"
										id="csrq" placeholder="年龄">
								</div>
							</div>
							<div class="row form-group">
								<label for="firstname" class="col-sm-2 control-label">文化程度</label>
								<div class="col-sm-10 col-padding15">
									<input name="whcd" type="text" class="form-control"
										id="whcd" placeholder="文化程度">
								</div>
							</div>
							<div class="row form-group">
								<label for="firstname" class="col-sm-2 control-label">个人联系电话</label>
								<div class="col-sm-10 col-padding15">
									<input name="grlxdh" type="text" class="form-control"
										id="grlxdh" placeholder="个人联系电话">
								</div>
							</div>
							<div class="row form-group">
								<label for="firstname" class="col-sm-2 control-label">谈话人</label>
								<div class="col-sm-10 col-padding15">
									<input name="f_thr" type="text" class="form-control"
										id="f_thr" placeholder="谈话人">
								</div>
							</div>
							<div class="row form-group">
								<label for="firstname" class="col-sm-2 control-label">记录人</label>
								<div class="col-sm-10 col-padding15">
									<input name="f_jlr" type="text" class="form-control"
										id="f_jlr" placeholder="记录人">
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
								<label for="firstname" class="col-sm-2 control-label">地址</label>
								<div class="col-sm-10 col-padding15">
									<input name="f_dz" type="text" class="form-control"
										id="f_dz" placeholder="地址">
								</div>
							</div>
							<div class="row form-group">
								<label for="firstname" class="col-sm-2 control-label">个人居住地明细</label>
								<div class="col-sm-10 col-padding15">
									<input name="grjzdmx" type="text" class="form-control"
										id="grjzdmx" placeholder="个人居住地明细">
								</div>
							</div>
							<div class="row form-group">
								<label for="firstname" class="col-sm-2 control-label">笔录内容</label>
								<div class="col-sm-10 col-padding15">
									<textarea class="form-control" rows="8" name="f_hbnr"></textarea>
								</div>
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