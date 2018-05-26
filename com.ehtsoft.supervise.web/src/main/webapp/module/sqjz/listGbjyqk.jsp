<%@ page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>
<html>
<head>
<title>个别教育培训情况</title>
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<script type="text/javascript" src="${localCtx}/json/JypxService.js"></script>
<script type="text/javascript" src="${localCtx}/json/JzJzryjbxxService.js"></script>

<script type="text/javascript">
	$(function() {
		var form = new Eht.Form({
			selector : "#sqjz_listGbjyqk #modal-body-div",
			autolayout:true
		});
		var tableView = new Eht.TableView({
			selector : "#sqjz_listGbjyqk #tableview",
			multable : true
		});
		var formSearch=new Eht.Form({
			selector : "#querypanel"
		});
		var service = new JypxService();
		//绘制表格
		tableView.loadData(function(page, res) {
			service.findPersonalEducation(formSearch.getData(), page, res);
		});
		//单击一行获取该行信息
		var json = {};
		tableView.clickRow(function(data) {
			json = data;
		});
		//提示框div初始状态为隐藏
		$('#sqjz_listGbjyqk #hideDiv').hide();
		$('#sqjz_listGbjyqk #hideScDiv').hide();
		//关闭按钮
		$('#sqjz_listGbjyqk #guanbibtn').click(function() {
			$('#sqjz_listGbjyqk #hideDiv').hide();
		});

		//取消按钮
		$('#sqjz_listGbjyqk #quxiaobtn').click(function() {
			$('#sqjz_listGbjyqk #hideDiv').hide();
			tableView.refresh();
		})
		$('#sqjz_listGbjyqk #quxiaobtn1').click(function() {
			$("#sqjz_listGbjyqk #hideScDiv").hide();
			tableView.refresh();
		})
		//关闭按钮事件 清除未选择的数据
		$('#sqjz_listGbjyqk #close').click(function() {
			json = {};
			tableView.refresh();
		});
		//关闭按钮事件 清除未选择的数据
		$('#sqjz_listGbjyqk #xxx').click(function() {
			json = {};
			tableView.refresh();
		});
		//查询按钮事件
		$("#sqjz_listGbjyqk #querybtn").click(function() {
			tableView.refresh();
		});
		/*新增加一条信息  */
		$("#sqjz_listGbjyqk #addbtn").click(function() {
			form.clear();
			
			$("#modal-body").show(function() {
				$(".form_date_time").datetimepicker({
						format : 'yyyy-mm-dd hh:ii',
						language : 'zh-CN',
						autoclose : true,
						weekStart : 1,
						todayBtn : 1,
						autoclose : 1,
						//todayHighlight: 1,
						//startView: 2,
						minView : 0,
						forceParse : 0
					});
			})
		$(".calendar_time").unbind('click').bind('click',function(){
				$(this).parent().find(".form_date_time").datetimepicker("show");
		})
				
			$("#myModal").modal({backdrop : 'static',keyboard : false});
		});
		$('#sqjz_listGbjyqk #btn-primary').unbind('click').bind('click',function() {
			if(form.validate()){
			service.saveOne(form.getData(),new Eht.Responder({
				success : function(data) {
					if(data.value =="01"){
						new Eht.Alert().show("该人员不是该机构的矫正人员，请确认后在进行个别教育添加");
					}else{
						tableView.refresh();
						$('#sqjz_listGbjyqk #myModal').modal('hide');
						
					}
				}
			}))
			}
		})

		/*****给矫正人员信息div内插入数据*****/
		/****** 矫正人员信息div初始化隐藏 ******/
		$("#sqjz_listGbjyqk #tableaaa").hide();
		var query = {};
		var serviceJZ = new JzJzryjbxxService();
		var tableViewDiv = new Eht.TableView({
			selector : "#sqjz_listGbjyqk #tableaaa",
			valueCodeField : "f_code",
			labelCodeField : "f_name",
			paginate : null
		});
		tableViewDiv.loadData(function(page, res) {
			serviceJZ.find(query, page, res);
		});

		/* 单击矫正人员输入框，弹出div框及所有矫正人员信息，选择人员进行新增 */
		$("#sqjz_listGbjyqk #xuanze").bind("onchange", function() {
			if ($("#sqjz_listGbjyqk #xuanze").val() != "") {
				query["xm[like]"] = $("#sqjz_listGbjyqk #xuanze").val();
				tableViewDiv.refresh();
				$("#sqjz_listGbjyqk #tableaaa").show();//矫正人员基本信息div弹出
			} else {
				$("#sqjz_listGbjyqk #tableaaa").hide();//矫正人员基本信息div隐藏 
			}
		});

		/* 当矫正人员输入框内输入内容时，触发查询 */
		$("#sqjz_listGbjyqk #xuanze").keyup(function() {
			if ($("#sqjz_listGbjyqk #xuanze").val() != "") {
				query["xm[like]"] = $("#sqjz_listGbjyqk #xuanze").val();
				tableViewDiv.refresh();
				$("#sqjz_listGbjyqk #tableaaa").show(); //矫正人员基本信息div弹出
			} else {
				$("#sqjz_listGbjyqk #tableaaa").hide(); //矫正人员基本信息div隐藏 
			}
		});
		/* 单击某条数据隐藏人员信息表 */
		tableViewDiv.clickRow(function(data) {
			/* 数据输入 */
			data.f_aid = data.id;
			form.fill(data);
			/* 人员信息表隐藏 */
			$("#sqjz_listGbjyqk #tableaaa").hide();
		});
		/*修改一条信息  */
		$("#sqjz_listGbjyqk #updatebtn").click(function() {
			if (json.pxqkid == null) {
				$('#sqjz_listGbjyqk #hideDiv').show();
			} else {
				form.fill(json);
				$("#modal-body").show(function() {
						$(".form_date_time").datetimepicker(
							{
							format : 'yyyy-mm-dd hh:ii',
							language : 'zh-CN',
							autoclose : true,
							weekStart : 1,
							todayBtn : 1,
							autoclose : 1,
							//todayHighlight: 1,
							//startView: 2,
							minView : 0,
							forceParse : 0
						});
				$(".calendar_time").unbind('click').bind('click',function() {
					$(this).parent().find(".form_date_time").datetimepicker("show");});
							form.fill(json);
							$('#sqjz_listGbjyqk #btn-primary').unbind('click').bind('click',function(){
								if(form.validate){
									service.insertOrUpdate(form.getData(),new Eht.Responder({
										success : function(data) {
											tableView.refresh();
												$('#sqjz_listGbjyqk #myModal').modal('hide');
									}}));
								}
							})
						})
						$("#myModal").modal({
							backdrop : 'static',
							keyboard : false
						});
					};
				});
		/* 删除信息 */
		$("#sqjz_listGbjyqk #deletebtn").click(
				function() {
					var array = tableView.getSelectedData();
					if (array.length == 0) {
						$('#sqjz_listGbjyqk #hideDiv').show();
					} else {
						$('#sqjz_listGbjyqk #hideScDiv').show();
						//确定按钮
						$('#sqjz_listGbjyqk #shanchubtn').unbind('click').bind(
								'click', function() {
									$('#sqjz_listGbjyqk #hideScDiv').hide();
									var id = json.pxqkid;
									service.deleteOnePersonalEducation(id);
									tableView.refresh();
								});
					}
				});
		//培训内容
		var textareaName = "#sqjz_listGbjyqk #floor";//备注输入框id
		var spanName = "#sqjz_listGbjyqk #count";//计数span的id
		$(textareaName).click(function() {
			countChar(textareaName, spanName);
		});
		$(textareaName).keyup(function() {
			countChar(textareaName, spanName);
		});
		$(textareaName).keydown(function() {
			countChar(textareaName, spanName);
		});
		function countChar(textareaName, spanName) {
			if ($(textareaName).val() != "") {
				$(spanName)
						.text("已输入：" + $(textareaName).val().length + "/250");
				if ($(textareaName).val().length > 0) {
					$(spanName).css("color", "#3F51B5");
				}
				;
				if ($(textareaName).val().length > 240) {
					$(spanName).css("color", "#FF0000");
				}
				;
			} else {
				$(spanName).text("已输入：0/250");
			}
		}
		;
		//考试分析情况
		var textareaName2 = "#sqjz_listGbjyqk #floor2";//备注输入框id
		var spanName2 = "#sqjz_listGbjyqk #count2";//计数span的id
		$(textareaName2).click(function() {
			countChar(textareaName2, spanName2);
		});
		$(textareaName2).keyup(function() {
			countChar(textareaName2, spanName2);
		});
		$(textareaName2).keydown(function() {
			countChar(textareaName2, spanName2);
		});
		function countChar(textareaName2, spanName2) {
			if ($(textareaName2).val() != "") {
				$(spanName2).text(
						"已输入：" + $(textareaName2).val().length + "/250");
				if ($(textareaName2).val().length > 0) {
					$(spanName2).css("color", "#3F51B5");
				}
				;
				if ($(textareaName2).val().length > 240) {
					$(spanName2).css("color", "#FF0000");
				}
				;
			} else {
				$(spanName2).text("已输入：0/250");
			}
		}
		;
		$("#xb_xb").append('$(<option selected></option>)');
	})
</script>
</head>
<body>
	<div id="sqjz_listGbjyqk">
		<div class="panel panel-default">
			<div class="panel-heading ltrhao-toolbar" style="padding-left: 20px;">
				<fieldset id="querypanel">
					姓名:		<input class="btn btn-default" id="search_name" 	type="text"  	name="xm[like]"		placeholder="请输入姓名" style="margin-left:10px;" />
					培训主题:	<input class="btn btn-default" id="search_pxztmc"	type="text"		name="pxztmc[like]" placeholder="请输入培训主题"  style="margin-left:10px;" />
							<input class="btn btn-default" id="querybtn" 		type="button" 	value="查询" style="margin-left:10px;"/>
							<input class="btn btn-default" id="addbtn" 			type="button" 	value="新增" style="margin-left:10px;"/>
							<input class="btn btn-default" id="updatebtn"  		type="button" 	value="修改" style="margin-left:10px;"/>
							<input class="btn btn-default" id="deletebtn" 		type="button" 	value="删除" style="margin-left:10px;"/>
				</fieldset>
			</div>
			<div class="alert alert-warning alert-dismissible" role="alert"id="hideDiv" style="text-align: center; font-size: 17px">
				<strong>警告!</strong> 请先选择一条信息！ <input id="quxiaobtn" class="btn btn-default" type="button" value="取消">
			</div>
			<div class="alert alert-warning alert-dismissible" role="alert"id="hideScDiv" style="text-align: center; font-size: 17px">
				<button type="button" class="close" data-dismiss="alert"aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<strong>警告!</strong> 确定删除？ <input id="shanchubtn"class="btn btn-default" type="button" value="确定">
				 <input id="quxiaobtn1" class="btn btn-default" type="button" value="取消">
			</div>
			<div class="panel-body">
				<div id="tableview" class="table-responsive">
					<div field='op' 	label="选择" checkbox="true"></div>
					<div field="xm" 	label="姓名"></div>
					<div field="xb" 	label="性别" code="sys000"></div>
					<div field="pxztmc" label="培训主题名称"></div>
					<div field="pxsj" 	label="培训时间"></div>
					<div field="pxdd" 	label="培训地点"></div>
					<div field="cts" 	label="创建时间"></div>
				</div>
			</div>
		</div>
		<!-- 模态框（Modal） -->
		<div class="modal fade" id="myModal">
			<div class="modal-dialog ">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="false" id="xxx">×</button>
						<h4 class="modal-title" id="myModalLabel">个人教育情况</h4>
					</div>
					<div class="modal-body" id="modal-body"style="height: 400px; overflow: auto">
						<div id="tableaaa">
							<div field="xm" name="xm" label="姓名" id="table" style="color: #fff"></div>
							<div field="xb" name="xb" label="性别" code="SYS000" id="table"></div>
						</div>
						<div id="modal-body-div" >
							<input name="xm" type="text" label="姓名"placeholder="姓名" id="xuanze" valid="{required:true}">
							<input name="xb" type="text" label="性别" placeholder="性别" valid="{required:true}" id="xb_xb" code="sys000" valid="{required:true}"> 
							<input name="pxztmc" type="text" label="培训主题名称" placeholder="培训主题名称" valid="{required:true}"> 
							<input id="time" name="pxsj" type="text" label="培训时间" class="form_date_time" data-date-format="yyyy-MM-dd" placeholder="培训时间"  valid="{required:true,datetime:true}"> 
							<input name="pxdd" type="text" label="培训地点" placeholder="培训地点" valid="{required:true}">
							<textarea rows="8" name="pxnr" id="floor" type="text" maxlength="250" label="培训内容" valid="{required:true}"></textarea>
							<div class="text-right" style="width: 70px;"><span id="count"  style="color: #3F51B5"></span></div>
							<textarea rows="8" name="pxjgpj" id="floor2" maxlength="250" label="培训结果评价" valid="{required:true}"></textarea>
							<div class="text-right"  style="width: 70px;"><span id="count2" class="text-right" style=" color: #3F51B5"></span></div>
						</div>
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