<%@ page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>
<html>
<head>
<title>帮教对象管理</title>
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<script type="text/javascript" src="${localCtx}/json/AzbjRyxjService.js"></script>
<style>
#sqjz_listBjdxgl #tableaaa {
	z-index: 999;
	width: 80%;
	height: 300px;
	background-color: #FFFFFF;
	margin: auto;
	position: absolute;
	top: 0;
	left: 140px;
	bottom: 0;
	right: 0;
	overflow-y: auto;
	overflow-x: auto;
}

.table-bordered>thead>tr>th {
	text-align: center;
}

.table-bordered>tbody>tr>td {
	text-align: center;
}
</style>
<script>
	$(function() {
		var form = new Eht.Form({
			selector : "#sqjz_listBjdxgl"
		});
		var tableView = new Eht.TableView({
			selector : "#sqjz_listBjdxgl #tableview"
		});
		var service = new AzbjRyxjService();
		tableView.loadData(function(page, res) {
			service.findAllRy(form.getData(), page, res);
		});
		/*增加一条信息  */
		$("#sqjz_listBjdxgl #updatebtn").click(
				function() {
					$("#modal-body").show();
					$("#myModal").modal({
						backdrop : 'static',
						keyboard : false
					});
				});
			//查询
			$("#sqjz_listBjdxgl #querybtn").click(function() {
				tableView.refresh();
			})
		})
</script>
</head>
<body>
	<div id="sqjz_listBjdxgl">
		<div class="panel-heading ltrhao-toolbar">
			<fieldset id="querypanel">
				姓名：<input type="text" name="xm[like]" class="btn btn-default"
					placeholder="请输入姓名" /> 身份证号：<input type="text" name="sfzh[like]"
					class="btn btn-default" placeholder="请输入身份证号" /> <input
					id="querybtn" class="btn btn-default" type="button" value="查询">
				<input id="updatebtn" class="btn btn-default" type="button"
					value="新增">
			</fieldset>
		</div>
		<div class="panel panel-default">
			<div class="panel-body">
				<div id="tableview" class="table-responsive">
					<div field="op" label="序号" checkbox="true"></div>
					<div field="xm" label="帮教对象"></div>
					<div field="bh" label="编号"></div>
					<div field="xsrq" label="刑释日期"></div>
					<div field="fxlx" label="服刑类型"></div>
					<div field="bjlb" label="帮教类别"></div>
					<div field="bjcs" label="帮教次数"></div>
					<div field="bjxz" label="帮教小组"></div>
					<div field="cjpg" label="出监评估"></div>
					<div field="cz" label="操作"></div>
				</div>
			</div>
		</div>
		<!-- 模态框（Modal） -->
		<div class="modal fade" id="myModal" style="width: 1500px;">
			<div class="modal-dialog " style="width: 1100px;">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="false" id="xxx">×</button>
						<h4 class="modal-title" id="myModalLabel">帮扶信息采集表</h4>
					</div>
					<div class="modal-body" id="modal-body"
						style="height: 400px; overflow: auto">
						<div id="ta">
<table class="table table-bordered" >
<!-- 表格 -->
	<thead>
		<tr>
			<td style="background-color: #eeeeee" class="text-center" >身体健康状态</td>
			<td><select id="jclb" name="jclb" class="center-block">
							<option selected value="00">——请选择——</option>
						</select></td>
			<td style="background-color: #eeeeee" class="text-center">是否接受帮教</td>
			<td><select id="jclb" name="jclb"  class="center-block">
							<option selected value="00">——请选择——</option>
						</select>
			</td>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td style="background-color: #eeeeee">有无吸毒历史</td>
			<td><select id="jclb" name="jclb" >
							<option selected value="00">——请选择——</option>
				</select>
			</td>
			
			<td style="background-color: #eeeeee">当前是否吸毒</td>
			<td><select id="jclb" name="jclb" >
							<option selected value="00">——请选择——</option>
						</select></td>
		</tr>
		<tr>
			<td style="background-color: #eeeeee">是否残疾</td>
			<td><select id="jclb" name="jclb" >
							<option selected value="00">——请选择——</option>
						</select></td>
			<td style="background-color: #eeeeee">伤残等级</td>
			<td><select id="jclb" name="jclb" >
							<option selected value="00">——请选择——</option>
						</select></td>
		</tr>
		<tr>
			<td style="background-color: #eeeeee">有无艾滋病</td>
			<td><select id="jclb" name="jclb" >
							<option selected value="00">——请选择——</option>
						</select></td>
			<td style="background-color: #eeeeee">是否艾滋病携带者</td>
			<td><select id="jclb" name="jclb" >
							<option selected value="00">——请选择——</option>
						</select></td>
		</tr>
		<tr>
			<td style="background-color: #eeeeee">有无重大或慢性疾病</td>
			<td><select id="jclb" name="jclb" >
							<option selected value="00">——请选择——</option>
						</select></td>
			<td style="background-color: #eeeeee">何种疾病</td>
			<td><textarea class="form-control col-ma-4" rows="1"  placeholder="请正确输入...."></textarea></td>
		</tr>
		<tr>
			<td style="background-color: #eeeeee">心理健康状况</td>
			<td><select id="jclb" name="jclb" >
							<option selected value="00">——请选择——</option>
						</select></td>
			<td style="background-color: #eeeeee">心理不健康情形</td>
			<td><textarea class="form-control col-ma-4" rows="1" placeholder="请正确输入...."></textarea></td>
		</tr>
		<tr>
			<td style="background-color: #eeeeee">是否进行过心理矫正治疗</td>
			<td><select id="jclb" name="jclb" >
							<option selected value="00">——请选择——</option>
						</select></td>
			<td style="background-color: #eeeeee">心理矫正治疗效果</td>
			<td><select id="jclb" name="jclb" >
							<option selected value="00">——请选择——</option>
						</select></td>
		</tr>
		<tr>
			<td style="background-color: #eeeeee">认罪态度</td>
			<td><select id="jclb" name="jclb" >
							<option selected value="00">——请选择——</option>
						</select></td>
			<td style="background-color: #eeeeee">有无其他导致犯罪的诱因</td>
			<td><select id="jclb" name="jclb" >
							<option selected value="00">——请选择——</option>
			</select></td>
		</tr>
	</tbody>
	<tbody>
		<tr>
			<td style="background-color: #eeeeee">是何种诱因</td>
			<td width="1000px" colspan="3" ><textarea style="height: 100px" class="form-control" rows="2"></textarea></td>
		</tr>
	</tbody>
</table>
<!-- 按钮 -->
	<div>
			<center><button id="asdfghgjg" type="button" class="btn btn-primary" >保存</button></center>
	</div>

</div>


					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal"
							id="close">关闭</button>
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