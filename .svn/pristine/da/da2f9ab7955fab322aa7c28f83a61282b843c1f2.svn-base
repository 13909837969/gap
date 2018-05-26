<%@ page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>
<html>
<head>
<title>签到管理</title>
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<script type="text/javascript" src="${localCtx}/json/SigninService.js"></script>
<script type="text/javascript">
	$(function() {
		var service = new SigninService();
		var tableView = new Eht.TableView({
			selector : "#listQdgl_container #listQdgl_div"
		});
		var form = new Eht.Form({
			selector : "#listQdgl_container #querypanel"
		});
		/* 多选 */
		tableView.transColumn("xzk", function(data) {
			return "<input type='checkbox' field='xzk'/>";
		});
		tableView.loadData(function(page, res) {
			service.findAll(form.getData(), page, res);
		});
		//单击行获取签到信息
		tableView.clickRow(function(data) {
			$("#listQdgl_container #myModal").modal({
				backdrop : 'static',
				keyboard : false
			});
			console.log(data.aid);
			$("#listQdgl_modal_body1").load("formQdxxfx.jsp?aid=" + data.aid + "&load=load");
		});

		/* 详细信息查询 */
		$("#listQdgl_container #listQdgl_xiangxi").click(function() {
			/* $("#listQdgl_modal_body").load("${localCtx}/module/sqjz/formQdxxfx.jsp?load=load",function(){
				
			}) */
			$("#listQdgl_container #myModal").modal({
				backdrop : 'static',
				keyboard : false
			});
		});
		/*查询信息  */
		$("#listQdgl_container #listQdgl_find").click(function() {
			tableView.refresh();
		});
		//关闭按钮
		$("#listQdgl_container #close").click(function(){
			tableView.refresh();
		})
		//关闭按钮x
		$("#listQdgl_container #xxx").click(function(){
			tableView.refresh();
		})
	});
</script>
<style>
</style>
</head>
<body>
	<div class="container-fluid" id="listQdgl_container">
		<div class="row-fluid">
			<div class="panel-heading ltrhao-toolbar">
				<fieldset id="querypanel">
					姓名:<input type="text" name="xm[like]" class="btn btn-default"
						placeholder="请输入姓名" /> 身份证号:<input type="text" name="sfzh[like]"
						class="btn btn-default" placeholder="请输入身份证号" /> <input
						class="btn btn-default" type="button" id="listQdgl_find"
						value="查询">
				</fieldset>
				<div id="listQdgl_div" class="table-responsive"
					style="padding: 3px;">
					<div field="xzk" label="选择" checkbox="true"></div>
					<div field="xm" label="姓名"></div>
					<div field="xb" label="性别" code="sys000"></div>
					<div field="sfzh" label="身份证号"></div>
					<div field="qdlx" label="签到类型"></div>
					<div field="qdwz" label="签到位置"></div>
					<div field="cts" label="签到时间"></div>
					<!-- <div field="lat" label="纬度"></div>
					<div field="lng" label="经度"></div> -->
					<div field="score" label="签到对比（相似度）"></div>
				</div>
				<!-- 模态框（Modal） -->
				<div class="modal fade" id="myModal">
					<div class="modal-dialog ">
						<div class="modal-content">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal"
									aria-hidden="false" id="xxx">×</button>
								<h4 class="modal-title" id="myModalLabel">签到数据分析</h4>
							</div>
							<div class="modal-body" id="listQdgl_modal_body1"
								style="height: 500px; overflow: auto;top:0px">
								
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-primary"
									data-dismiss="modal" id="close">关闭</button>
							</div>
						</div>
						<!-- /.modal-content -->
					</div>
					<!-- /.modal-dialog -->
				</div>
			</div>
		</div>
	</div>
</body>
</html>