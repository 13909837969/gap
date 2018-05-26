<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<style type="text/css">
.table>caption+thead>tr:first-child>td, .table>caption+thead>tr:first-child>th,
	.table>colgroup+thead>tr:first-child>td, .table>colgroup+thead>tr:first-child>th,
	.table>thead:first-child>tr:first-child>td, .table>thead:first-child>tr:first-child>th
	{
	text-align: center;
}

#con {
	margin-top: 0px;
}

tbody {
	text-align: center;
}

table {
	font-weight: normal;
	font-size: 13px;
}
</style>
<title>必接必送</title>
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="${localCtx}/json/AzbjRyxjService.js"></script>
<script type="text/javascript">
	$(function() {
		var service = new AzbjRyxjService();
		var table = new Eht.TableView({
			selector : "#tableaaa"
		});
		var json = {};
		var form = new Eht.Form({
			selector : "#sqjzdagl-field"
		});
		$("#sqjz_listDagl_all #tsk").hide();

		/* 初始化加载数据 */
		table.loadData(function(page, res) {
			service.findAllRy(form.getData(), page, res);
		});
		/* ******************当单击某条数据时，将数据放入json内，以备点击【修改】按钮时调取数据*************************** */
		table.clickRow(function(data) {
			json = data;
		});
		//隐藏的警告框触发事件
		$("#sqjz_listDagl_all #quxiaobtn").click(function() {//单击取消按钮
			$("#sqjz_listDagl_all #hideDiv").hide();
		});
		/* 单击查询按钮触发事件 */
		$("#sqjz_listDagl_all #btn").click(function() {
			table.refresh();//再执行上次方法
		});
		/* **双击某条数据，弹出人员详情页********* */
		table.dblclickRow(function(data) {
			$("#sqjz_listDagl_all #myModal").modal({
				backdrop : 'static',
				keyboard : false
			});//弹出模态框
			$("#sqjz_listDagl_all #iframe").attr("src",
					"${localCtx}/module/sqjz/viewGrdagl.jsp?id=" + data.id);//向子页传输id
		});
		/* 单击新增按钮触发事件 */
		$("#sqjz_listDagl_all #btnAdd")
				.click(
						function(data) {
							$("#sqjz_listDagl_all #myModalAdd").modal({
								backdrop : 'static',
								keyboard : false
							});//弹出模态框
							$("#sqjz_listDagl_all #modal-bodyAdd")
									.load(
											"${localCtx}/module/sqjz/tabViewDagl.jsp?load=load",
											function() {

											});
						});

		/* 单击修改按钮，修改选中信息 */
		$("#sqjz_listDagl_all #btnUp").click(
				function() {
					var array = table.getSelectedData();
					if (array.length == 0) {
						$("#sqjz_listDagl_all #hideDiv").show();
					} else {
						$("#sqjz_listDagl_all #modal-bodyAdd").load(
								"${localCtx}/module/sqjz/tabViewDagl.jsp?load=load&id="
										+ json.id);
						$("#sqjz_listDagl_all #myModalAdd").modal({
							backdrop : 'static',
							keyboard : false
						});
					}
				});

		var form1 = new Eht.Form({
			selector : '#jzjzlxx-form',
			autolayout : true
		});
		$('#listTjdaxx_send').click(function() {
			form1.clear("jzllx");
			$('#myModal1').modal({
				backdrop : 'static'
			});
		});
	});
</script>
</head>
<body>
	<div id="sqjz_listDagl_all" class="panel panel-default">
		<div id="head" class="panel-heading" style="margin-left: 0px">
			<fieldset id="sqjzdagl-field" style="margin-left: 0px">
				<!-- <legend>档案管理</legend> -->
				姓名:<input class="btn btn-default" type="text" name="xm[like]"
					placeholder="请输入姓名" />
				<!--  style="width:170px;height:28px;text-align:center;" -->
				矫正人员编号:<input type="text" class="btn btn-default"
					name="sqjzrybh[like]" placeholder="请输入矫正人员编号" />
				<!-- style="width:170px;height:28px;text-align:center;" -->
				<input id="btn" type="button" class="btn btn-default btn-sm"
					value="查询"> <input class="btn btn-default" type="button"
					id="listTjdaxx_send" value="添加必接必送数据"> <input
					class="btn btn-default" type="button" id="listPlFsXx_send"
					value="批量发送信息">
				<%-- <a href="${localCtx}/module/sqjz/formSimple.jsp" target="_blank">基本信息录入</a> --%>
			</fieldset>
		</div>
		<div class="container-fluid" id="con">
			<div id="tableaaa" class="panel-body">
				<div field="order" checkbox=true label="选择"></div>
				<div field="xm" label="姓名" id="xm"></div>
				<div field="sfzh" label="身份证号"></div>
				<div field="xsrq" label="刑释日期"></div>
				<div field="hjszd" label="户籍所在地"></div>
				<div field="bjbs" label="必接必送" code="SYS017"></div>
				<div field="zt" label="状态"></div>
				<div field="cz" label="操作" id="cz"></div>
			</div>
		</div>
		<!-- 弹出警告框 -->
		<!-- <div class="alert alert-warning alert-dismissible" role="alert" id="hideDiv" style="text-align:center;font-size:17px;display:none;">
				    <strong>警告!</strong> 请先选择一条信息！
				    <input id="quxiaobtn" class="btn btn-default" type="button" value="取消" >
			</div> -->
	</div>


	<!-- 查看模态框（Modal） -->
	<div class="modal fade" id="myModal1">
		<div class="modal-dialog" style="height: 100%">
			<div class="modal-content" style="height: 100%">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="false">×</button>
					<h4 class="modal-title" id="myModalLabel">添加必接必送信息</h4>
				</div>
				<div class="modal-body" id="modal-body">
					<div class="tab-content col-sm-12">
					
					
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- 000000000000000000000000000000000000000000000000000000 -->
	<!-- 新增/修改模态框（Modal） -->
	<div class="modal fade" id="myModalAdd">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="false">×</button>
					<h4 class="modal-title" id="myModalLabel">个人档案管理</h4>
				</div>
				<div class="modal-body" id="modal-bodyAdd"
					style="height: 510px; overflow-y: auto;">
					<!-- 
							<div id="form-modal-body">
								<iframe id="iframeXz" width="100%" height="500px" scrolling="no" frameborder="0" style="overflow:hidden">
								
								</iframe>
							</div>
							-->
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button id="btn_primary" type="button" class="btn btn-primary">提交</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>



	<!-- 模态框 -->
	<div class="modal fade" id="myModal1" tabindex="-1" role="dialog">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<Button class="close" type="button" data-dismiss="modal"
						aria-hidden="true">&times;</Button>
					<h4 class="modal-title" id="myModalLabel">新增社区矫正人员</h4>
				</div>
				<div class="modal-body">
					<div id="jzjzlxx-form">
						<%-- <div>
								<input type="hidden" value="${param.f_aid}" fixedValue="true" name="f_aid"/>
								<input type="hidden" name="jzlid"/>
							</div> --%>
						<input type="text" name="xm" labelCol="4" label="姓名"
							placeholder="请输入矫正人员姓名" /> <input type="text" name="hjdz"
							labelCol="4" label="户籍详细地址" placeholder="请输入矫正人员户籍地址" /> <input
							type="text" name="grlxdh" labelCol="4" label="联系电话"
							placeholder="请输入矫正人员联系电话" /> <input type="text" name="gjlx"
							labelCol="4" label="管教类型" placeholder="请输入管教类型" /> <input
							type="text" name="pjrq" labelCol="4" label="判决日期"
							placeholder="请选择判决日期" valid="{required:true}" class="form_date"
							data-date-format="yyyy-MM-dd" />
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="submit">提交</button>
				</div>
			</div>
		</div>
	</div>
	</div>



	<script type="text/javascript" src="../azbj/js/listBjBs.js"></script>
</body>
</html>