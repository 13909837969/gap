<%@ page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>
<html>
<head>
<title>思想汇报</title>
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<script type="text/javascript" src="${localCtx}/json/SxhbService.js"></script>
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
</style>
<script type="text/javascript">
	$(function() {
		var form = new Eht.Form({
			selector : "#sqjz_listSxhb #querypanel"
		});
		var tableView = new Eht.TableView({
			multable : false,
			selector : "#sqjz_listSxhb #tableView",
			valueCodeField : "f_code",
			labelCodeField : "f_name"
		});
		var service = new SxhbService();
		tableView.loadData(function(page, res) {
			service.findAll(form.getData(), page, res);
		});
		//点击tableView 行
		tableView.clickRow(function(data) {
			$('#sxhbnr').empty();
			$("#xm").html(data.xm);
			$("#xb").html(data.xb);
			$("#mz").html(mz);
			$("#sfzh").html(data.sfzh);
			$("#sxhbnr").html(data.f_hbnr);
			$("#f_pf").html(data.f_pf);
			$(".mz_div").innerHTML;
			$("#fzlx").html((".fzlx_div").innerHTML);
			$('#sqjz_listSxhb #right-panel').show().animate({
				width : 555
			});
			//评分良好按钮事件
			$('#sqjz_listSxhb #btn-lh').unbind('click').bind('click',function(){
				service.update(1,data.id, new Eht.Responder({
					success:function(data){
						tableView.refresh();
					}
				}));
			})
			//评分进步按钮事件
			$('#sqjz_listSxhb #btn-jb').unbind('click').bind('click',function(){
				service.update(2,data.id, new Eht.Responder({
					success:function(data){
						tableView.refresh();
					}
				}));
			})
			//评分继续教育按钮事件
			$('#sqjz_listSxhb #btn-jxjy').unbind('click').bind('click',function(){
				service.update(3,data.id, new Eht.Responder({
					success:function(data){
						tableView.refresh();
					}
				}));
			})
		});

		//查询按钮事件
		$("#sqjz_listSxhb #querybtn").click(function() {
			tableView.refresh();
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
	});
</script>
</head>
<body>
	<div id="sqjz_listSxhb">
		<div class="panel panel-default">
			<div class="panel-heading ltrhao-toolbar">
				<fieldset id="querypanel"  style="padding-left: 20px;">
					姓名:<input type="text" name="xm[like]" class="btn btn-default" placeholder="请输入姓名"/> 
					身份证号:<input type="text"name="sfzh[like]" class="btn btn-default" placeholder="请输入身份证号"/> 
					<input class="btn btn-default" type="button" id="querybtn" value="查询">
				</fieldset>
			</div>
			<div class="panel-body" style="padding:3px 0 0 0;">
				<div id="tableView" class="table-responsive" >
					<div field='op' label="选择" checkbox="true"></div>
					<div field="xm" label="姓名"></div>
					<div field="xb" label="性别"></div>
					<div field="mz" label="民族" code="sys003" class="mz_div"></div> 
					<div field="sfzh" label="身份证号"></div>
					<div field="fzlx" label="犯罪类型" code="sys014" class="fzlx_div"></div>
					<div field="f_pf" label="评分"></div>
				</div>
			</div>
		</div>

		<!-- 右侧弹出表单 -->
		<div class="right-panel" id="right-panel">
			<div class="panel panel-default">
				<div class="panel-heading">
					<span id="siderightbar" class="glyphicon glyphicon-indent-center"></span>&nbsp;&nbsp;服刑人员档案
				</div>
				<div class="panel-body" id="form-panel"">
					<!-- 矯正人員基本信息 -->
					<div class="container-fluid">
						<div class="row-fluid">
							<table width="80px;">
								<tr height="80px;">
									<td rowspan="2"><img src="../rp/img/user2.jpg"
										style="width: 60px; height: 80px; margin-bottom: 10px;"
										class="img-rounded"></td>
									<td valign="top">
										<table
											style="width: 300px; margin-left: 20px; font-size: 16px;">
											<tr height="50px;">
												<td id="xm" name="xm">张一山</td>
												<td id="xb" name="xb">男</td>
												<td id="mz" name="mz">汉族</td>
											</tr>
											<tr>
												<td name="sfzh" id="sfzh">15903822378</td>
												<td name="f_pf" id="f_pf">继续教育</td>
											</tr>
										</table>
									</td>
									<td width="100px;">
										<button name="f_pf" id="f_pf" class="btn btn-default">矫正档案</button>
									</td>
								</tr>
							</table>
						</div>
					</div>
					<div class="control-group">
						<label class="control-label">思想汇报内容</label>
						<textarea class="form-control" rows="18" field="sxhbnr" id="sxhbnr"></textarea>
					</div>
				</div>
			</div>
			<div class="panel-footer ">
				<button id="btn-lh" class="btn btn-success">良好</button>
				<button id="btn-jb" class="btn btn-success">进步</button>
				<button id="btn-jxjy" class="btn btn-success">继续教育</button>
				<button id="closebtn" class="btn btn-success">关闭</button>
			</div>
		</div>
	</div>
</body>
</html>