<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
	<title>调查评估</title>
	<jsp:include page="../ltrhao-common.jsp"></jsp:include>
	<script type="text/javascript" src="${localCtx}/json/JzDcpgxxService.js"></script>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Insert title here</title>
	<script type="text/javascript">	
	$(function(){
		var service = new JzDcpgxxService();
		var table = new Eht.TableView({selector:"#tableaaa",valueCodeField:"f_code",labelCodeField:"f_name"});
		var name = $("#bgrxm").val();
		var wtbh = $("#wtbh").val();
		var query = {"bgrxm[like]":name,"wtbh[eq]":wtbh};
		
		table.loadData(function(page,res){
			service.findAll(query,page,res);
		});
		/* 单击查询按钮触发事件 */
		$("#sqjz_listDcpg_all #cx").click(function(){
			query["bgrxm[like]"] =  $("#name").val();
			query["wtbh[eq]"] = $("#wtbh").val();
			table.refresh();//再执行上次方法
		});	
		/*增加一条信息  */
		$("#sqjz_listDcpg_all #xz").click(function() {
			$("#modal-body").load("${localCtx}/module/sqjz/formDcpg_add.jsp?load=load",function(){
				/* ******************以下为月视图********************** */
					$(".form_date").datetimepicker({
						format: 'yyyy-mm-dd', 
						language:  'zh-CN',
						autoclose: true,
				        weekStart: 1,
				        todayBtn:  1,
						autoclose: 1,
						//todayHighlight: 1,
						//startView: 2,
						minView: 2,
						forceParse: 0	
					});
					$(".calendar").click(function(){
						$(this).parent().find(".form_date").datetimepicker("show");
					});
				/* ******************以下为包含【日、时间】视图的********************** */
					$(".form_date_time").datetimepicker({
						format: 'yyyy-mm-dd hh:ii', 
						language:  'zh-CN',
						autoclose: true,
				        weekStart: 1,
				        todayBtn:  1,
						autoclose: 1,
						//todayHighlight: 1,
						//startView: 2,
						minView: 0,
						forceParse: 0	
					});
					$(".calendar_time").click(function(){
						$(this).parent().find(".form_date_time").datetimepicker("show");
					});
			});
			/* 模态框弹出后,模态框之外的区域不可点 */
			$("#myModal").modal({backdrop : 'static',keyboard : false}); 
		});
	});
	</script>
	<style type="text/css">
		#sqjz_listDcpg_all #tableaaa{
			text-align:center;
		}
	</style>
</head>
<body>
	<div id="sqjz_listDcpg_all">
			<div>
				<fieldset>
					<legend>调查评估</legend>
					 被告人（罪犯）姓名：<input id="bgrxm" type="text" />
					委托编号：<input id="wtbh" type="text" />
					 <input  id="cx" type="button" class="btn btn-default btn-sm" value="查询">
					 <input  id="xz" type="button" class="btn btn-default btn-sm" value="新增">
				</fieldset>	
			</div>		
			<div id="tableaaa">
				<div field="bgrxm" label="被告人（罪犯）姓名"></div>
				<div field="bgrsfzh" label="被告人（罪犯）身份证号"></div>
				<div field="bgrxb" label="被告人（罪犯）性别" code="sys000"></div>
				<div field="bgrgzdw" label="被告人（罪犯）工作单位"></div>
				<div field="zm" label="罪名"></div>
				<div field="ypxq" label="原判刑期"></div>
				<div field="ypxf" label="原判刑罚"></div>
				<div field="fjx" label="附加刑"></div>
				<div field="pjjg" label="判决机关"></div>
				<div field="pjrq" label="判决日期"></div>
				<div field="dcr" label="调查人"></div>
				<div field="dcsj" label="调查时间"></div>
			</div>
			<!-- 模态框（Modal） -->
			<div class="modal fade" id="myModal">
				<div class="modal-dialog ">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal" aria-hidden="false">×</button>
							<h4 class="modal-title" id="myModalLabel">调查评估-新增</h4>
						</div>
						<div class="modal-body" id="modal-body" style="height: 400px; overflow: auto">
						</div>
						<div class="modal-footer">
					        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
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