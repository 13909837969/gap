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
			/* 单击数据弹出模态框 */
			table.clickRow(function(data){
				$("#sqjz_listJzdbg_sp #iframe").load("${localCtx}/module/sqjz/formJzdbg.jsp?id=" + data.f_aid + "&load=load");
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
				<div field="xm" label="姓名"></div>
				<div field="grlxdh" label="个人联系电话"></div>
				<div field="sqsj" label="申请时间"></div>
				<div field="qrdmx" label="迁入地明细"></div>
				<div field="jzdbgsy" label="变更理由"></div>
				<div field="sfsshsj" label="司法所审核时间"></div>
				<div field="xsfjspsj" label="县（市、区）<br>司法局审批时间"></div>
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
								<div class="modal-body" id="modal-body">
									<div id="iframe"></div>
								</div>

								<!-- <div class="modal-footer">

									<button type="button" class="btn btn-default" 

											data-dismiss="modal">关闭

									</button>

									<button type="button" class="btn btn-primary">

										提交更改

									</button>

								</div> -->

							</div><!-- /.modal-content -->

						</div><!-- /.modal-dialog -->

					</div>
			
			
						
		</div>
	</div>
</body>
</html>