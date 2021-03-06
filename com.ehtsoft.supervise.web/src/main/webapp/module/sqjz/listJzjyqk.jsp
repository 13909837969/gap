<%@ page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>
<html>
<head>
<title>集中教育情况</title>
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<script type="text/javascript" src="${localCtx}/json/JypxService.js"></script>
<style type="text/css">
</style>
<script type="text/javascript">
	$(function() {
		var form = new Eht.Form({
			selector : "#sqjz_listJypx #querypanel"
		});
		var tableView = new Eht.TableView({
			selector : "#sqjz_listJypx #tableview",
			multable:true
		});
		var service = new JypxService();
		tableView.loadData(function(page, res) {
			var data = service.findFocusEducation(form.getData(), page, res);
		});
		//单击一行获取该行信息
		var json = {};
		tableView.clickRow(function(data) {
			$("#hideDiv").hide();
			json =data;
		});
		//提示框div初始状态为隐藏
		$('#sqjz_listJypx #hideDiv').hide();
		$('#sqjz_listJypx #hideScDiv').hide();
		//关闭按钮
		$('#sqjz_listJypx #guanbibtn').click(function(){
			$('#sqjz_listJypx #hideDiv').hide();
		});
		//取消按钮
		$('#sqjz_listJypx #quxiaobtn').click(function(){
			$('#hideDiv').hide();
			tableView.refresh();
		})
		$('#sqjz_listJypx #quxiaobtn1').click(function(){
			$("#sqjz_listJypx #hideScDiv").hide();
			tableView.refresh();
		})
		//关闭按钮事件 清除未选择的数据
		$('#sqjz_listJypx #close').click(function(){
			json={};
			tableView.refresh();
		});
		//关闭按钮事件 清除未选择的数据
		$('#sqjz_listJypx #xxx').click(function(){
			json={};
			tableView.refresh();
		});
		//查询按钮事件
		$("#sqjz_listJypx #querybtn").click(function() {
			tableView.refresh();
		});
		/*增加一条信息  */
		$("#sqjz_listJypx #addbtn").click(
			function(){
				$("#modal-body").load("${localCtx}/module/sqjz/formJzjyqk.jsp?load=load",
					function() {
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
						$(".calendar_time").click(function(){
							$(this).parent().find(".form_date_time").datetimepicker("show");
						});
					});
					$("#myModal").modal({
						backdrop : 'static',
						keyboard : false,
					});
					form.clear();
				});
		/*修改一条信息  */
		$("#sqjz_listJypx #updatebtn").click(
			function(){
						$("#Jzjyqk_form").empty();
				$("#modal-body").load("${localCtx}/module/sqjz/formJzjyqk.jsp?load=load",
					function(){
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
						$(".calendar_time").click(function(){
							$(this).parent().find(".form_date_time").datetimepicker("show");
						});
						var form = new Eht.Form({selector : "#Jzjyqk_form"});
						
						if(json.pxqkid==null){
							$('#sqjz_listJypx #hideDiv').show();
						}else{
							form.fill(json);
							json={};
							var id = {"pxqkid":json.pxqkid}; 
							service.saveOrUpdateFocusEducation(json, new Eht.Responder({
								success : function(data) {}
							}));
							$("#myModal").modal({
								backdrop : 'static',
								keyboard : false
							});
						}
				});
		})
		/* 删除信息 */
		$("#sqjz_listJypx #deletebtn").click(function() {
			var array = tableView.getSelectedData();
			if(array.length==0){
				$('#sqjz_listJypx #hideDiv').show();
			}else{
					$('#sqjz_listJypx #hideScDiv').show();
					//确定按钮
					$('#sqjz_listJypx #shanchubtn').unbind('click').bind('click',function(){
						$('#sqjz_listJypx #hideScDiv').hide();
						var id = json.pxqkid;
						service.removeFocusEducation(id);
						 json.pxqkid=null;
						tableView.refresh();
					})
			}
		});

	})
</script>
</head>
<body>
	<div id="sqjz_listJypx">
		<div class="panel panel-default">
			<div class="panel-heading ltrhao-toolbar">
				<fieldset id="querypanel" style="padding-left: 20px;">
					培训主题:<input type="text" name="pxztmc" class="btn btn-default" placeholder="请输入培训主题"/>
					 <input class="btn btn-default" type="button" id="querybtn" value="查询">
					<input id="addbtn" class="btn btn-default" type="button" value="新增">
					<input id="updatebtn" class="btn btn-default" type="button"
						value="修改"> <input id="deletebtn" class="btn btn-default"
						type="button" value="删除">
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
					<div field="pxztmc" label="培训主题名称"></div>
					<div field="ycjrs" label="应参加人数"></div>
					<div field="sjcjrs" label="实际参加人数"></div>
					<div field="pxlsmc" label="培训老师名称"></div>
					<div field="pxksj" label="培训时间"></div>
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
						<h4 class="modal-title" id="myModalLabel">集中教育情况</h4>
					</div>
					<div class="modal-body" id="modal-body" style="height: 400px; overflow: auto">
						<%-- <iframe src="${localCtx}/module/sqjz/formKhxx.jsp" id="iframe" height="500px" width="100%" scrolling="yes" frameborder="0">
									</iframe> --%>
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
	</div>
</body>
</html>