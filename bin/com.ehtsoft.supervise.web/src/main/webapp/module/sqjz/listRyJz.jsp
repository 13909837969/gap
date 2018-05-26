<%@ page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>
<html>
<head>
<title>社区矫正人员信息采集表</title>
<style type="text/css">
.table>caption+thead>tr:first-child>td, .table>caption+thead>tr:first-child>th,
	.table>colgroup+thead>tr:first-child>td, .table>colgroup+thead>tr:first-child>th,
	.table>thead:first-child>tr:first-child>td, .table>thead:first-child>tr:first-child>th
	{
	text-align: center;
}

tbody {
	text-align: center;
}
</style>
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<script type="text/javascript" src="${localCtx}/json/SqjzRyjzService.js"></script>
<style>
.right-panel {
	background: #fff;
	border: 1px solid #aaa;
	position: absolute;
	top: 0px;
	right: 0px;
	bottom: 0px;
	filter: alpha(Opacity = 97);
	-moz-opacity: 0.97;
	opacity: 0.97;
	display: none;
	box-shadow: 0px 0px 10px #888888;
}

#siderightbar {
	cursor: pointer;
}

#siderightbar:hover {
	color: #00f;
}

.control-group>label {
	margin-right: 10px;
}

.control-group div {
	width: 100%;
	height: 300px;
}

.row-fluid #right-panel_div3 {
	margin: 0 0 0 150px;
}

#right-panel_div2 #f_pf {
	display: block;
	float: right;
	font-size: 30px;
	margin: 0 10px 30px 0;
}

.input {
	outline: none;
	border-bottom: 1px solid #dbdbdb;
	border-top: 0px;
	border-left: 0px;
	border-right: 0px;
	word-break: break-all;
	text-align: center;
}

.div_h {
	text-align: center;
}

.btn-success_tj {
	margin-left: 400px;
}
</style>

<script type="text/javascript">
		$(function(){
			var service = new SqjzRyjzService();
			var form = new Eht.Form({selector:"#listJzsf #querypanel"});
			var tableview = new Eht.TableView({
				selector:"#listJzsf_table",
				multable:false,
				valueCodeField:"f_code",
				labelCodeField:"f_name"
			});
			//多选（选择多行信息）
			tableview.transColumn("xzk",function(data){
				return "<input type='checkbox' field='xzk'/>";
			})
			var json={};
			var jsonArray = [];
			//单击一行获取数据
			tableview.clickRow(function(data){
				json = data;
				jsonArray.push(data);
			})
			tableview.loadData(function(page,res){
				service.findAllRy(form.getData(),page,res);
			});
			//关闭右侧面板
			$("#success").click(function() {
				$('#right-panel').animate({
					width : 0
				}, function() {
					$(this).hide()
				});
			});
			
			//单击下一个按钮   next
			$('#next').click(function(){
				
			});
			
			//获取个人信息数据
			function getDaxxData() {
				var rtn = new Array();
				$("#sqjz_listSxhb").find("tbody tr").each(function() {
					var obj = {};
					$(this).find("input").each(function() {
						var n = $(this).attr("name");
						obj[n] = $(this).val();
					});
					rtn.push(obj);
				});
				return rtn;
			}
			function touppcase() {
				$("#sqjz_listSxhb input[name]").unbind("change").bind(
						"change", function() {
							$(this).val($(this).val().toUpperCase());
						});
			};
			/* 查询信息 */
			$("#listJzsf #listJzsf_find").click(function(){
				tableview.refresh();
			});
			/* 查询详细信息 */
			/* $("#listJzsf #listJzsf_selectbtn").click(function(){
				$("#xm").html(json.xm);
				$("#xb").html(json.xb);
				$("#csrq").html(json.csrq);
				$("#whcd").html(json.whcd);
				$("#grlxdh").html(json.grlxdh);
				$("#hjszdmx").html(json.hjszdmx);
				$('#right-panel').show().animate({
					width : 555
				});
			}); */
			
			//点击tableView 行
			tableview.clickRow(function(data) {
				json = data;
				jsonArray.push(data);
				$("#xm").html('姓名:'+json.xm);
				$("#xb").html('性别:'+json.xb);
				$("#csrq").html(json.csrq);
				$("#whcd").html(json.whcd);
				$("#grlxdh").html('联系方式:'+json.grlxdh);
				$("#hjszdmx").html(json.hjszdmx);
				$('#right-panel').show().animate({
					width : 555
				});
			});
			
			
			var form1 = new Eht.Form({selector:'#jzjzlxx-form',autolayout:true});			
			//单击添加档案数据弹出模态框	
			$('#listTjdaxx_send').click(function(){
				form1.clear("jzllx");
				$('#myModal').modal({backdrop:'static'});
			});
			//提交档案数据弹出模态框
			$('#submit').click(function(){
				console.log(form1.getData());
				if(form.validate()){
					service.saveJzry(form1.getData(),new Eht.Responder({
						success:function(data){
							$('#myModal').modal('hide');
							tableview.refresh();
						}
					}));
				}
			});
		});
	</script>
</head>
<body>
	<div id="listJzsf">
		<div class="container-fluid">
			<fieldset id="querypanel">
				姓名:<input class="btn btn-default" type="text" name="xm[like]" placeholder="请输入姓名" /> 
				采集状态:<input class="btn btn-default"type="text" name="sfzh[like]" placeholder="请输入采集状态" /> 
				<input、class="btn btn-default" type="button" id="listJzsf_find" value="查询">
				<input class="btn btn-default" type="button" id="listTjdaxx_send"value="添加档案数据"> 
				<input class="btn btn-default" type="button" id="listPlFsXx_send" value="批量发送信息">
				<!-- <input class="btn btn-default" type="button" id="listJzsf_selectbtn" value="查询详细信息"> -->
			</fieldset>
			<div id="listJzsf_table">
				<%-- <div field="xzk" label="<input type='checkbox'>" checkbox="true"></div> --%>
				<div checkbox="true" label="选择"></div>
				<div field="xm" label="姓名"></div>
				<div field="hjxxdz" label="户籍详细地址"></div>
				<div field="grlxdh" label="联系电话"></div>
				<div field="gjlx" label="管教类型"></div>
				<div field="pjrq" label="判决日期"></div>
				<div field="cjzt" label="采集状态"></div>
			</div>
		</div>
		<!-- 添加档案数据模态框 -->
		<!-- 模态框 -->
		<div class="modal fade" id="myModal" tabindex="-1" role="dialog">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<Button class="close" type="button" data-dismiss="modal" aria-hidden="true">
							&times;
						</Button>
						<h4 class="modal-title" id="myModalLabel">新增社区矫正人员</h4>
					</div>
					<div class="modal-body">
						<div id="jzjzlxx-form">
							<%-- <div>
								<input type="hidden" value="${param.f_aid}" fixedValue="true" name="f_aid"/>
								<input type="hidden" name="jzlid"/>
							</div> --%>
							<input type="text" name="xm" labelCol="4" label="姓名" placeholder="请输入矫正人员姓名"/>
							<input type="text" name="hjdz" labelCol="4" label="户籍详细地址" placeholder="请输入矫正人员户籍地址"/>
							<input type="text" name="grlxdh" labelCol="4" label="联系电话" placeholder="请输入矫正人员联系电话"/>
							<input type="text" name="gjlx" labelCol="4" label="管教类型" placeholder="请输入管教类型"/>
							<input type="text" name="pjrq" labelCol="4" label="判决日期" placeholder="请选择判决日期" valid="{required:true}" class="form_date" data-date-format="yyyy-MM-dd"/>
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
	<!-- 右侧弹出表单 -->
	<div class="right-panel" id="right-panel">
		<div class="panel panel-default">
			<div class="panel-heading">
				<span id="siderightbar" class="glyphicon glyphicon-indent-center"></span>&nbsp;&nbsp;人员信息
			</div>
			<div class="panel-body" id="form-panel">
				<!-- 人員信息 -->
				<div class="container-fluid">
					<div class="row-fluid">
						<table width="80px;">
							<tr height="80px;">
								<td valign="top">
									<table
										style="width: 400px; margin-left: 20px; font-size: 16px;">
										<tr height="50px;">
											<td id="xm" name="xm">姓名</td>
											<td id="xb" name="xb">性别</td>
										</tr>
										<tr height="50px;">
											<td id="grlxdh">联系方式</td>
										</tr>
									</table>
									<table
										style="width: 400px; margin-left: 20px; font-size: 16px;">
										<tr height="50px;">
											<td>人脸采集信息</td>
										</tr>
										<tr>
											<td><img src="../rp/img/xxx.jpg"
												style="width: 60px; height: 80px; margin-bottom: 10px;"
												class="img-rounded"></td>
											<td><img src="../rp/img/xxx.jpg"
												style="width: 60px; height: 80px; margin-bottom: 10px;"
												class="img-rounded"></td>
											<td><img src="../rp/img/xxx.jpg"
												style="width: 60px; height: 80px; margin-bottom: 10px;"
												class="img-rounded"></td>
										</tr>


										<tr height="50px;">

										</tr>
										<tr height="50px;">
											<td>声纹采集信息</td>
											<td style="margin-left: 20px"><input id="cjxx"
												type="button" class="btn btn-info" value="未采集"></td>
										</tr>
										<tr height="50px;">
											<td>指纹采集信息</td>
											<td style="margin-left: 20px"><input id="zwxx"
												type="button" class="btn btn-info" value="未采集"></td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
					</div>
				</div>
			</div>
		</div>
		<div class="panel-footer ">
			<button id="next" class="btn btn-success">
				<span>下一个</span>
			</button>
			<button style="margin-left: 350px" id="success"
				class="btn btn-success">
				<span>确定</span>
			</button>
		</div>




	










	</div>

</body>
</html>