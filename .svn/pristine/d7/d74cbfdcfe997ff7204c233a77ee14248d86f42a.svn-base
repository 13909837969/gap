<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<!-- JZ_WJTKXXB -->
<title>问卷题库定义列表</title>
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<script type="text/javascript" src="${localCtx}/json/QuestionService.js"></script>
<script type="text/javascript"
	src="${localCtx}/json/TestPaperService.js"></script>
<style type="text/css">
.right-panel {
	background: #fff;
	border: 1px solid #aaa;
	position: fixed;
	top: 0px;
	right: 0px;
	bottom: 0px;
	/*
	filter: alpha(Opacity = 97);
	-moz-opacity: 0.97;
	opacity: 0.97;
	*/
	display: none;
	box-shadow: 0px 0px 10px #888888;
	z-index: 100;
	overflow-y: auto;
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

.control-group textarea {
	width: 100%;
	height: 50px;
}

#sqjz_listquestion .nav-tab-content {
	position: absolute;
	width: 100%;
	padding: 5px;
}
</style>
<script type="text/javascript">
	$(function() {
		var form = new Eht.Form({
			selector : "#sqjz_listquestion_tk_right-panel #form-panel"
		});
		var tableview = new Eht.TableView({
			multable : false,
			selector : "#sqjz_listquestion_tk #tableview"
		});
		//试卷表
		var tablesj = new Eht.TableView({
			selector : "#sqjz_listquestion_sj #tableview"
		});
		var qs = new QuestionService();
		var tps = new TestPaperService();
		var query = new Eht.Form({
			selector : "#sqjz_listquestion_tk #queryform"
		});
		tableview.loadData(function(page, res) {
			qs.find(query.getData(), page, res);
		});
		//点击tableview 行
		tableview.clickRow(function(data) {
			form.fill(data);
			qs.findOne(data.f_tkid, new Eht.Responder({
				success : function(ds) {
					console.log(ds);
					if (ds.daxxs && ds.daxxs.length > 0) {
						$("#sqjz_listquestion_tk_listdaxx").find("tbody")
								.empty();
						for (var i = 0; i < ds.daxxs.length; i++) {
							addDaxxlist(ds.daxxs[i]);
						}
					}
				}
			}));
			$('#sqjz_listquestion_tk_right-panel').show().animate({
				width : 560
			});
			return false;
		});
		var query2 = new Eht.Form({
			selector : "#sqjz_listquestion_sj #queryform"
		});
		//试卷表
		tablesj.loadData(function(page, res) {
			tps.find(query2.getData(), page, res);
		});
		tablesj.clickRow(function(data) {
			$("#sqjz_listquestion_sj_right-panel").show().animate({
				width : 560
			});
			$("#sqjz_listquestion_sj_right-panel").load(
					"${localCtx}/module/sqjz/viewTestPaper.jsp?load=load&stid="
							+ data.f_stid);
			return false;
		});
		//标签导航事件
		$("#sqjz_listquestion .nav-tabs>li").click(function() {
			$("#sqjz_listquestion .nav-tab-content").hide();
			$("#sqjz_listquestion .nav-tabs>li").removeClass("active");
			var hrefid = $(this).attr("href");
			$(hrefid).show();
			$(this).addClass("active");
			if ($(this).attr("index") == 1) {
				tableview.refresh();
			} else {
				tablesj.refresh();
			}
			$('#sqjz_listquestion_tk_right-panel').animate({
				width : 0
			}, function() {
				$(this).hide()
			});
			$('#sqjz_listquestion_sj_right-panel').animate({
				width : 0
			}, function() {
				$(this).hide()
			});
		});
		tableview.transColumn("seq", function(data, index) {
			return index + 1 + (this.opt.paginate.indexPage - 1)
					* this.opt.paginate.pageCount;
		});
		tablesj.transColumn("seq", function(data, index) {
			return index + 1 + (this.opt.paginate.indexPage - 1)
					* this.opt.paginate.pageCount;
		});
		//添加按钮事件
		$("#sqjz_listquestion #addbtn").click(function() {
			form.clear(true);
			$("#sqjz_listquestion_tk_listdaxx").find("tbody").empty();
			addDaxxlist();
			$('#sqjz_listquestion_tk_right-panel').show().animate({
				width : 560
			});
			return false;
		});
		//查询按钮事件
		$("#sqjz_listquestion_tk #querybtn").click(function() {
			tableview.refresh();
		});
		//查询按钮事件
		$("#sqjz_listquestion_sj #querybtn").click(function() {
			tablesj.refresh();
		});
		//添加选项 按钮事件
		$("#sqjz_listquestion_tk_right-panel #addxx").click(function() {
			addDaxxlist();
		});
		//生成试卷按钮事件
		$("#sqjz_listquestion #createbtn").parent().find(".dropdown-menu li")
				.click(function() {
					$("#pager_modal_wjlx").val($(this).val());
					$("#createPager").modal("show").animateCss("bounceInUp");
				});
		//关闭右侧面板
		$("#sqjz_listquestion_tk_right-panel #siderightbar").click(function() {
			$('#sqjz_listquestion_tk_right-panel').animate({
				width : 0
			}, function() {
				$(this).hide()
			});
		});
		//保存按钮事件
		$("#sqjz_listquestion_tk_right-panel #savebtn").click(function() {
			var daxxs = getDaxxData();
			var data = form.getData();
			//答案选项
			data.daxxs = daxxs;
			qs.save(data, new Eht.Responder({
				success : function() {
					tableview.refresh();
					new Eht.Tips().show("保存成功");
					$('#sqjz_listquestion_tk_right-panel').animate({
						width : 0
					}, function() {
						$(this).hide()
					});
				},
				error : function(error) {
					alert(error);
				}
			}));
		});

		var wjxxform = new Eht.Form({
			selector : "#form-create-wjxx"
		});
		//生成试卷确认
		$("#sqjz_listquestion #savecreatebtn").click(function() {
			tps.create(wjxxform.getData(), new Eht.Responder({
				success : function() {
					$("#createPager").modal("hide");
					$("#sqjz_listquestion_tab_sj").click();
					tablesj.refresh();
				}
			}));
		});
		touppcase();
		function addDaxxlist(data) {
			if (data == null) {
				data = {
					f_daxx : "",
					f_daxxms : ""
				};
			}
			var tr = '<tr>'
					+ '<td><input type="text" style="width:40px;" value="'+data.f_daxx+'" name="f_daxx"></td>'
					+ '<td><input type="text" style="width:100%;" value="'
					+ data.f_daxxms + '" name="f_daxxms"></td>' + '</tr>';
			$("#sqjz_listquestion_tk_listdaxx").append(tr);
			touppcase();
		}

		$(window).unbind("click").bind("click", function() {
			$('#sqjz_listquestion_tk_right-panel').animate({
				width : 0
			}, function() {
				$(this).hide()
			});
			$('#sqjz_listquestion_sj_right-panel').animate({
				width : 0
			}, function() {
				$(this).hide()
			});
		});
		$("#sqjz_listquestion .right-panel").click(function() {
			return false
		});
		//获取答案选项信息数据
		function getDaxxData() {
			var rtn = new Array();
			$("#sqjz_listquestion_tk_listdaxx").find("tbody tr").each(
					function() {
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
			$("#sqjz_listquestion_tk_listdaxx input[name]").unbind("change")
					.bind("change", function() {
						$(this).val($(this).val().toUpperCase());
					});
		}
	});
</script>
</head>
<body>
	<div id="sqjz_listquestion">
		<ul class="nav nav-tabs">
			<li class="active" href="#sqjz_listquestion_tk" index="0"><a>题库</a></li>
			<li id="sqjz_listquestion_tab_sj" href="#sqjz_listquestion_sj"
				index="1"><a>试卷</a></li>
		</ul>
		<div class="nav-tab-content" id="sqjz_listquestion_tk">
			<div class="panel panel-default">
				<div class="panel-heading ltrhao-toolbar">
					<div class="control-group">
						<div class="row">
							<div class="col-md-3">
								<input class="btn btn-default btn-sm" type="button" id="addbtn"
									value="新增">
								<div class="btn-group">
									<button class="btn btn-default btn-sm" type="button"
										id="createbtn" data-toggle="dropdown" aria-haspopup="true"
										aria-expanded="false">
										生成试卷 <span class="caret"></span>
									</button>
									<ul class="dropdown-menu">
										<li value="1"><a href="#">生成法律问卷</a></li>
										<li value="2"><a href="#">生成心理测评</a></li>
									</ul>
								</div>

							</div>
							<div class="col-md-9">
								<div id="queryform">
									<span class="control-label">问卷类型</span> <select
										name="f_wjlx[eq]">
										<option></option>
										<option value="1">法律问卷</option>
										<option value="2">心里评测</option>
									</select> <span class="control-label">问题描述</span> <input type="text"
										name="f_wtms[like]" style="width: 100px;"
										id="sqjz_listquestion_f_wtms" /> <input
										class="btn btn-default btn-sm" type="button" id="querybtn"
										value="查询">
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="panel-body">
					<div class="row clearfix">
						<div class="col-md-12">
							<div id="tableview" class="table-responsive">
								<!-- 
							<div field='op' label="<input type='checkbox'>" checkbox="true"></div>
							-->
								<div field="seq" label="序号" width="60" align="center"></div>
								<div field="f_wjlx" label="问卷类型"></div>
								<div field="f_wtms" label="问题描述"></div>
								<div field="f_xtlx" label="选题类型"></div>
								<div field="daxx" label="答案选项"></div>
								<div field="f_wtda" label="问题答案"></div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- 试卷 -->
		<div class="nav-tab-content" style="display: none;"
			id="sqjz_listquestion_sj">
			<div class="panel panel-default">
				<div class="panel-heading ltrhao-toolbar">
					<div class="control-group">
						<div class="row">
							<div class="col-md-12">
								<div id="queryform">
									<span class="control-label">试卷类型</span> <select
										name="f_wjlx[eq]">
										<option></option>
										<option value="1">法律问卷</option>
										<option value="2">心里评测</option>
									</select> <span class="control-label">试卷标题</span> <input type="text"
										name="f_sjbt[like]" style="width: 100px;"
										id="sqjz_listquestion_f_wtms" /> <input
										class="btn btn-default btn-sm" type="button" id="querybtn"
										value="查询">
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="panel-body">
					<div class="row clearfix">
						<div class="col-md-12">
							<div id="tableview" class="table-responsive">
								<!-- 
							<div field='op' label="<input type='checkbox'>" checkbox="true"></div>
							-->
								<div field="seq" label="序号"></div>
								<div field="f_sjbt" label="试卷标题"></div>
								<div field="f_wjlx" label="试卷类型"></div>
								<!-- 1 法律问卷  2 心理评测 -->
								<div field="f_sjzfz" label="试卷总分数"></div>
								<div field="cts" label="创建时间"></div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- 生成试卷 -->
		<div class="modal" id="createPager">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="true">&times;</button>
						<h4 class="modal-title" id="myModalLabel">生成试卷</h4>
					</div>
					<div class="modal-body">
						<div class="form-horizontal" id="form-create-wjxx">
							<div class="form-group">
								<label class="control-label col-sm-3">问卷类型</label> <select
									id="pager_modal_wjlx" name="f_wjlx" class="col-sm-8">
									<option value="1">法律问卷</option>
									<option value="2">心里评测</option>
								</select>
							</div>
							<div class="form-group">
								<label class="control-label col-sm-3">试题名称</label> <input
									type="text" name="f_sjbt" class="col-sm-8" />
							</div>
							<div class="form-group">
								<label class="control-label col-sm-3">试题数量</label> <input
									type="text" name="f_stsl" class="col-sm-8" />
							</div>
							<div class="form-group">
								<label class="control-label col-sm-3">试卷总分值</label> <input
									type="text" name="f_sjzfz" class="col-sm-8" value="100" />
							</div>
							<!-- 日历
							<div class="form-group form-group-sm">
								<label class="control-label col-sm-3"></label>
								<div class="input-group col-sm-8">
									<input type="text" class="form-control form_date" data-date-format="yyyy-MM-dd">
									<span class="input-group-addon calendar"><span class="glyphicon glyphicon-calendar"></span></span>
								</div>
							</div>
							-->
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
						<button type="button" class="btn btn-primary" id="savecreatebtn">确认</button>
					</div>
				</div>
				<!-- /.modal-content -->
			</div>
			<!-- /.modal -->
		</div>


		<!-- 右侧弹出表单 ( 题库表单 ) -->
		<div class="right-panel" id="sqjz_listquestion_tk_right-panel">
			<div class="panel panel-default">
				<div class="panel-heading">
					<span id="siderightbar" class="glyphicon glyphicon-indent-left"></span>&nbsp;&nbsp;问卷题库
				</div>
				<div class="panel-body" id="form-panel">
					<!-- 问卷表单 -->
					<div class="control-group">
						<label class="control-label">问卷类型</label> <select name="f_wjlx">
							<option value="1">法律问卷</option>
							<option value="2">心里评测</option>
						</select>
					</div>
					<div class="control-group">
						<label class="control-label">问题描述</label>
						<textarea name="f_wtms"></textarea>
					</div>
					<div class="control-group">
						<label class="control-label">选题类型</label> <select name="f_xtlx">
							<option value="1">单选</option>
							<option value="2">多选</option>
							<!-- 
							<option value="3">判断</option>
							<option value="4">填空</option>
							<option value="5">解答</option>
							-->
						</select>
					</div>
					<div class="control-group">
						<label class="control-label" for="input01">问题答案</label> <input
							name="f_wtda" type="text" placeholder="" class="input-xlarge">
					</div>
					<div class="control-group">
						<label class="control-label">答案解释</label>
						<textarea name="f_dajx"></textarea>
					</div>
				</div>
			</div>

			<div class="panel panel-default">
				<div class="panel-heading  text-right">
					<span class="pull-left" style="margin-top: 5px;">答案选项</span> <span
						class="btn-group btn-group-sm"><button id="addxx"
							class="btn btn-success">添加选项</button></span>
				</div>
				<div class="panel-body">
					<!-- 答题选项 -->
					<table class="table table-hover" id="sqjz_listquestion_tk_listdaxx">
						<thead>
							<tr>
								<th>选项</th>
								<th>答案选项信息</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td><input type="text" style="width: 40px;" name="f_daxx"></td>
								<td><input type="text" style="width: 100%;" name="f_daxxms"></td>
							</tr>
						</tbody>
					</table>
				</div>
				<div class="panel-footer text-center">
					<button id="savebtn" class="btn btn-success">保存</button>
				</div>
			</div>
		</div>

		<div class="right-panel" id="sqjz_listquestion_sj_right-panel">
			<span id="siderightbar" class="glyphicon glyphicon-indent-left"></span>
		</div>
	</div>
</body>
</html>