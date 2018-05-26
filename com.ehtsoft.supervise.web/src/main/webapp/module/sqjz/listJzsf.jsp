<%@ page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>
<html>
<head>
	<title>矫正随访</title>
	<jsp:include page="../ltrhao-common.jsp"></jsp:include>
	<script type="text/javascript"
					src="${localCtx}/json/JzsfService.js"></script>
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
		 .input{  
                outline:none;
                border-bottom: 1px solid #dbdbdb;  
				border-top:0px;  
				border-left:0px;  
				border-right:0px; 
				word-break:break-all;
				text-align:center;
            } 
            .div_h{
              	text-align:center;
              }
              .btn-success_tj{
              	margin-left:400px;
              }
	</style>
	
	<script type="text/javascript">
		$(function(){
			var service = new JzsfService();
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
				service.findAll(form.getData(),page,res);
			});
			//关闭右侧面板
			$("#closebtn").click(function() {
				$('#right-panel').animate({
					width : 0
				}, function() {
					$(this).hide()
				});
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
			/* 新增信息 */
			$("#listJzsf #listJzsf_addbtn").click(function(){
				$('#right-panel').show().animate({
					width : 555
				});
			});
			//添加数据
				$("#savechabtn").click(function(){
					var form = new Eht.Form({selector:"#form-panel"});
					form.fill(json);
					service.save(json,new Eht.Responder({
						success:function(){
							$('#right-panel').animate({
								width : 0
							}, function() {
								$(this).hide();
								}
							);
						}
				}));
				/* $("#modal-body").load(
					"${localCtx}/module/sqjz/formJzsfb.jsp?load=load",function(){
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
					});
					form.fill(json);
				$("#myModal").modal({
						backdrop : 'static',
						keyboard : false,
									}); */
			});
			/* 查询信息 */
			$("#listJzsf #listJzsf_find").click(function(){
				tableview.refresh();
			});
			/* 查询详细信息 */
			$("#listJzsf #listJzsf_selectbtn").click(function(){
				$("#xm").html(json.xm);
				$("#xb").html(json.xb);
				$("#csrq").html(json.csrq);
				$("#whcd").html(json.whcd);
				$("#grlxdh").html(json.grlxdh);
				$("#hjszdmx").html(json.hjszdmx);
				$('#right-panel').show().animate({
					width : 555
				});
			});
		});
	
		
	</script>
</head>
<body>
	<div id="listJzsf">
		<div class="container-fluid">
			<fieldset id="querypanel">
				姓名:<input class="btn btn-default" type="text" name="xm[like]" placeholder="请输入姓名"/> 
				身份证号:<input class="btn btn-default" type="text" name="sfzh[like]" placeholder="请输入身份证号"/> 
				<input class="btn btn-default" type="button" id="listJzsf_find"
						value="查询">
				<input class="btn btn-default" type="button" id="listJzsf_addbtn" value="新增走访笔录">
				<input class="btn btn-default" type="button" id="listJzsf_selectbtn" value="查询详细信息">
			</fieldset>
				 <div id="listJzsf_table">
					<div field="xzk" label="<input type='checkbox'>" checkbox="true"></div>
					<div field="xm" label="姓名"></div>
					<div field="xb" label="性别"></div>
					<div field="mz" label="名族"></div>
					<div field="sfzh" label="身份证号"></div>
					<div field="sqjzksrq" label="社区矫正开始日期"></div>
					<div field="sqjzjsrq" label="社区矫正结束日期"></div>
					<div field="fzlx" label="犯罪类型" code="sys014"></div>
					<div field="f_thr" label="谈话人"></div>
					<div field="f_jlr" label="记录人"></div>
				</div>
				</div>
			</div>
		<!-- 右侧弹出表单 -->
		<div class="right-panel" id="right-panel">
			<div class="panel panel-default">
				<div class="panel-heading">
					<span id="siderightbar" class="glyphicon glyphicon-indent-center"></span>&nbsp;&nbsp;矫正走访笔录
				</div>
				<div class="panel-body" id="form-panel">
					<!-- 矯正人員基本信息 -->
					<div class="container-fluid">
						<div class="row-fluid">
							时间:<input name="f_cts" class="input" type="text"  style="width:190;font-weight:100px"/>
							地点:<input name="f_dz" class="input" type="text" style="width:180;"/><br>
							谈话人:<input name="f_thr" class="input" type="text" style="width:170;"/>
							记录人:<input name="f_jlr" class="input" type="text" style="width:170;"/>
							<!-- <table width="80px;">
								<tr height="40px;">
									<td id="f_cts" name="f_cts">时间:</td>
									<td id="f_dz" name="f_dz">地点:</td>
								</tr>
								<tr height="40px;">
									<td name="f_thr" id="f_thr">谈话人:</td>
									<td name="f_jlr" id="f_jlr">记录人:</td>
								</tr>
							</table> -->
						</div>
						<div class="div_h">
							<span style="font-size:25px">被谈话人信息</span><br>
						</div>
						<div class="row-fluid">
							<table width="80px;">
								<tr height="80px;">
									<td rowspan="2"><img src="../rp/img/user2.jpg"
										style="width: 60px; height: 80px; margin-bottom: 10px;"
										class="img-rounded"></td>
									<td valign="top">
										<table
											style="width: 400px; margin-left: 20px; font-size: 16px;">
											<tr height="50px;">
												<td id="xm" name="xm">张一山</td>
												<td id="csrq" name="mz">出生日期</td>
											</tr>
											<tr>
												<td name="whcd" id="whcd">文化程度</td>
												<td name="grlxdh" id="grlxdh">123456789909</td>
											</tr>
											<tr>
												<td name="hjszdmx" id="hjszdmx">家庭住址</td>
											</tr>
										</table>
									</td>
								</tr>
							</table>
						</div>
					</div>
					<div class="control-group">
						&nbsp;&nbsp;&nbsp;&nbsp;		
						我们是***司法所的司法助理员，今天，我们来家访，主要是为了解决你进来的思
						想状况、行为表现、是否存在生活工作等方面的困难，问你的有关问题请如实回答。
						<textarea name="f_blnr" rows="12" cols="88" 
						onpropertychange="if(this.scrollHeight>80) this.style.posHeight=this.scrollHeight+5">
						</textarea><br>
					</div>
				</div>
			</div>
			<div class="panel-footer ">
				<button id="savechabtn" class="btn btn-success_tj">提交</button>
				<button id="closebtn" class="btn btn-success">关闭</button>
			</div>
		</div>

</body>
</html>