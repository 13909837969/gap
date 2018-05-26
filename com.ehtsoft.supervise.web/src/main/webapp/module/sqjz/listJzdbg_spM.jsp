<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
	<title>居住地变更审批</title>
	<jsp:include page="../ltrhao-common.jsp"></jsp:include>
	<script type="text/javascript" src="${localCtx}/json/JzryJzdbgspService.js"></script>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Insert title here</title>
	<script type="text/javascript">
		$(function(){
			var service = new JzryJzdbgspService();
			var table = new Eht.TableView({selector:"#sqjz_listJzdbg_sp #tableaaa",valueCodeField:"f_code",labelCodeField:"f_name"});
			var name = $("#name").val();
			var query = {"xm[like]":name};
			
			table.loadData(function(page,res){
				service.findAll(query,page,res);
			});
			/* 单击刷新按钮 */
			$("#sqjz_listJzdbg_sp #refresh").click(function(){
				table.refresh();
			})
			/* 单击查询按钮触发事件 */
			$("#sqjz_listJzdbg_sp #btn").click(function(){
				name = $(" #sqjz_listJzdbg_sp #name").val();
				table.loadData(function(page,res){
					service.findName(name,page,res);
				})
			})
			/* 双击击数据弹出模态框 */
			 table.dblclickRow(function(data){
				$("#sqjz_listJzdbg_sp #modal-body").load("${localCtx}/module/sqjz/formJzdbg.jsp?id=" + data.f_aid + "&load=load");
				$("#sqjz_listJzdbg_sp #myModal").modal({backdrop: 'static', keyboard: false});//弹出模态框
			}) 
		});
	</script>
	<style type="text/css">
		#sqjz_listJzdbg_sp #iframe{
			height:500px;
			overflow:auto;
		}
		#sqjz_listJzdbg_sp #tableaaa{
			text-align:center;
		}
		tr>th{
			text-align:center;
			vertical-align:middle;
		}
	</style>
</head>
<body>
	<div id="sqjz_listJzdbg_sp"><!--  class="container" -->
		<div>		<!--  class="row" -->
			<div>
				<fieldset style="padding: 10px 10px;">
					<label>姓名：<input id="name" type="text" style="width:170px;height:28px"/></label>
					<input  id="btn" type="button" class="btn btn-default btn-sm" value="查询">
					<input id="refresh" type="button" class="btn btn-default btn-sm" value="刷新">
				</fieldset>	
			</div>		
			<div id="tableaaa">
				<div field="sqjzrybh" label="社区矫正人员编号"></div>
				<div field="jzsssq" label="矫正所属社区"></div>
				<div field="xm" label="姓名"></div>
				<div field="sqsj" label="申请时间"></div
				<div field="gdjzdmx" label="迁出地"></div>
				<div field="qrdmx" label="迁入地"></div>
				<div field="spyj" label="审批意见"></div>
				<!-- <div field="cz" label="操作" ></div> -->
				
			</div>				
			<!-- 模态框（Modal） -->
			<div class="modal fade" id="myModal">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal" 
									aria-hidden="false">×
							</button>
							<h4 class="modal-title" id="myModalLabel">居住地变更审批</h4>
						</div>
						<%-- <iframe src="${localCtx}/module/sqjz/formJzdbg.jsp?id=" + data.f_aid + "&load=load"></iframe> --%>
						<div class="modal-body" id="modal-body">
							<div id="iframe"></div>
						</div>
						<div class="modal-footer">
						</div>
					</div>
				</div>
			</div>	
		</div>
	</div>
</body>
</html>