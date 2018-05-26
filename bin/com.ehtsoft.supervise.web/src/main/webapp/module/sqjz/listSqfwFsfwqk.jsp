<%@ page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>
<html>
<head>
<title>分散服务情况</title>
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<script type="text/javascript" src="${localCtx}/json/SqfwService.js"></script>
<style>
.right-panel {
	background: #fff;
	border: 1px solid #aaa;
	position: absolute;
	top: 0px;
	right: 0px;
	bottom: 0px;
	/* filter: alpha(Opacity = 97);
	-moz-opacity: 0.97;
	opacity: 0.97; */
	display: none;
	box-shadow: 0px 0px 10px #888888;
}
.control-group div {
	width: 100%;
	height: 380px;
}
 #panel-body-left{
 	position: absolute;
 	top:43px;
 	left:0px;
 	bottom:0px;
 	width:200px;
 	border:1px solid #b5b5b5;
 	height:520px;
 }
 #panel-body-right{
 	position: absolute;
 	top:43px;
 	left:200px;
 	bottom:0px;
 	right:0px;
 	border:0px solid black;
 	height:520px;
 }
 .info{
 	text-align:center;
 }
 </style>
<script type="text/javascript">
	$(function(){
		var form = new Eht.Form({
			selector : "#sqjz_listSqfwFsfwqk #querypanel"
		});
		var tableView = new Eht.TableView({
			selector : "#sqjz_listSqfwFsfwqk #tableview"
		});
		var querySearch = {};
		var service = new SqfwService();
		//查询按钮事件
		$("#sqjz_listSqfwFsfwqk #querybtn").click(function() {
			querySearch["b.xm[like]"] = $("#sqjz_listSqfwFsfwqk #search-xm").val();
			tableView.refresh();
		});
		tableView.loadData(function(page, res) {
			service.findDisperseService(querySearch, page, res);
		});
		//点击tableview 行 findOne
		tableView.clickRow(function(data) {
			service.findDisperseJlService(data.sqfsfwid,new Eht.Responder({
				success:function(data){
					$('#sqjz_listSqfwFsfwqk #table-left').empty();
					$("#sqfwhdzj").html('');
					for(var i=0;i<data.length;i++){
						var tr = $('<tr>'
							    +	'<td class="info">'+data[i].fwsj+":"+data[i].fwdz+'</td>'
								+'</tr>');
						$('#sqjz_listSqfwFsfwqk #table-left').append(tr);
						//查出相对应的照片
						tr.data(data[i]);
						tr.click(function(){
							$('#sqjz_listSqfwFsfwqk #table-right').empty();
							var d = $(this).data();
						//	$("#fwdz-td").html(d.fwdz);
							$("#sqfwhdzj").html(d.fwms);
							service.findImageService(d.sqfsfwid,new Eht.Responder({
								success:function(data){
									for(var i=0; i<data.length;i++){
										 var tr = '<tr>'
												 +	 '<td><img id="imgid" style="width: 40px; height: 40px;"></td>'
												 + '</tr>';
										$("#sqjz_listSqfwFsfwqk #table-right").append(tr);
										$('#imgid').attr("src","${localCtx}/image/RMIImageService?_table_name=jz_sqfsfwjlb_img&IMGID="+data[i].imgid);
									}
								}
							}))
							
						})
					}
				}
			}))
				$('#sqjz_listSqfwFsfwqk #right-panel').show().animate({
				width : 555
			});
		});
		
		//关闭右侧面板
		$("#closebtn").click(function() {
			$('#right-panel').animate({
				width : 0
			}, function() {
				$(this).hide()
			});
			tableView.refresh();
		});
		 $("#siderightbar").click(function() {
				$('#right-panel').animate({
					width : 0
				}, function() {
					$(this).hide()
				});
			});
		
	});
	
</script>
</head>
<body>
	<div id="sqjz_listSqfwFsfwqk">
		<div class="panel panel-default">
			<div class="panel-heading ltrhao-toolbar" style="padding-left: 20px;">
				<fieldset id="querypanel">
				<input  class="btn btn-default" type="hidden" name="type" value="0" />
					<input id="search-xm" class="btn btn-default" type="text" name="xm" placeholder="请输入姓名" /> 
					<input class="btn btn-default" type="button" id="querybtn" value="查询">
				</fieldset>
			</div>
			<div class="panel-body">
				<div id="tableview" class="table-responsive">
					<div field='op' label="选择" checkbox="true"></div>
					<div field="xm" label="姓名"></div>
					<div field="fwdfzr" label="服务点负责人"></div>
					<div field="fwdlxrdh" label="服务点联系电话"></div>
					<div field="fwkssj" label="服务开始日期"></div>
					<div field="fwjssj" label="服务结束日期"></div>
					<div field="fwcs" label="服务次数"></div>
					<div field="fwdz" label="服务地址"></div>
				</div>
			</div>
		</div>
		<!-- 右侧弹出表单 -->
		<div class="right-panel" id="right-panel">
			<div class="panel panel-default">
				<div class="panel-heading">
					<span id="siderightbar" class="glyphicon glyphicon-remove" ></span>&nbsp;&nbsp;服务记录
				</div>
				<div class="row" style="height:520px;">
					<div id="panel-body-left">
						<table class="table table-condensed" id="table-left">
						
						
						</table>
					
					</div>
					<div id="panel-body-right">
						<div class="info" id="fwdz-td"></div>
						<table class="table table-condensed" id="table-right">
							
						</table>
							<label for="firstname" class="col-sm-8 control-label" style="text-align:center" >服务内容</label>
						<div class="row form-group">
							<div class="col-sm-10 col-padding15">
								<textarea class="form-control" style="width:350px;height:200px;" id="sqfwhdzj"></textarea>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="panel-footer ">
				<button id="closebtn" class="btn btn-success">关闭</button>
			</div>
		</div>
	</div>
</body>
</html>