<%@ page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>

<html>
<head>
<title>调查评估-新增</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<script type="text/javascript" src="${localCtx}/json/JzDcpgxxService.js"></script>
<script type="text/javascript">

	$(function() {
		var form = new Eht.Form({
			selector : '#sqjz_fromDcpg_add_form'
		});
		$("#sqjz_listDcpg_all #btn-primary").click(function() {
			console.log(form.getData());
			var service = new JzDcpgxxService();
			service.save(form.getData(), new Eht.Responder({
				success : function() {
					$("#tableaaa").refreshTable();
					$('#sqjz_listDcpg_all #myModal').modal('hide');
				}
			}));
		});
	});
</script>
</head>
<body>
	<div id="sqjz_fromDcpg_add">
		<div id="sqjz_fromDcpg_add_form">
			<div class="row form-group">
				<label for="firstname" class="col-sm-2 control-label">委托编号</label>
				<div class="col-sm-10">
					<input name="wtbh" type="text" class="form-control"
						id="firstname" placeholder="委托编号">
				</div>
			</div>
			<div class="row form-group">
				<label for="lastname" class="col-sm-2 control-label">拟适用社区服刑人员类型</label>
				<div class="col-sm-10">
					<input name="nsysqjzrylx" type="text" class="form-control" id="lastname"
						placeholder="拟适用社区服刑人员类型">
				</div>
			</div>
			<div class="row form-group">
				<label for="lastname" class="col-sm-2 control-label">被告人（罪犯）姓名</label>
				<div class="col-sm-10">
					<input name="bgrxm" type="text" class="form-control" id="lastname"
						placeholder="被告人（罪犯）姓名">
				</div>
			</div>
			<div class="row form-group">
				<label for="lastname" class="col-sm-2 control-label">被告人（罪犯）身份证号</label>
				<div class="col-sm-10">
					<input name="bgrsfzh" type="text" class="form-control" id="lastname"
						placeholder="被告人（罪犯）身份证号">
				</div>
			</div>
			<div class="row form-group">
				<label for="lastname" class="col-sm-2 control-label">被告人（罪犯）性别</label>
				<div class="col-sm-10">
					<input name="bgrxb" type="text" class="form-control" id="lastname"
						placeholder="被告人（罪犯）性别">
				</div>
			</div>
			<div class="row form-group">
				<label for="lastname" class="col-sm-2 control-label">被告人（罪犯）出生日期</label>
				<div class="col-sm-10">
					<div class="input-group input-group-sm">
					    <input name="bgrcsrq" type="text" class="form-control form_date" data-date-format="yyyy-MM-dd"  id="lastname">
					    <span class="input-group-addon calendar"><span class="glyphicon glyphicon-calendar"></span></span>
				   </div>
				</div>
			</div>
			<div class="row form-group">
				<label for="lastname" class="col-sm-2 control-label">被告人（罪犯）居住地地址</label>
				<div class="col-sm-10">
					<input name="bgrjzddz" type="text" class="form-control" id="lastname"
						placeholder="被告人（罪犯）居住地地址">
				</div>
			</div>
			<div class="row form-group">
				<label for="lastname" class="col-sm-2 control-label">被告人（罪犯）工作单位</label>
				<div class="col-sm-10">
					<input name="bgrgzdw" type="text" class="form-control"
						id="lastname" placeholder="被告人（罪犯）工作单位">
				</div>
			</div>
			<div class="row form-group">
				<label for="lastname" class="col-sm-2 control-label">罪名</label>
				<div class="col-sm-10">
					<input name="zm" type="text" class="form-control"
						id="lastname" placeholder="罪名">
				</div>
			</div>
			<div class="row form-group">
				<label for="lastname" class="col-sm-2 control-label">原判刑期</label>
				<div class="col-sm-10">
					<input name="ypxq" type="text" class="form-control" id="lastname"
						placeholder="原判刑期">
				</div>
			</div>
			<div class="row form-group">
				<label for="lastname" class="col-sm-2 control-label">原判刑期开始日期</label>
				<div class="col-sm-10">
					<div class="input-group input-group-sm">
					    <input name="ypxqksrq" type="text" class="form-control form_date" data-date-format="yyyy-MM-dd" id="lastname">
					    <span class="input-group-addon calendar"><span class="glyphicon glyphicon-calendar"></span></span>
				   </div>
				</div>
			</div>
			<div class="row form-group">
				<label for="lastname" class="col-sm-2 control-label">原判刑期结束日期</label>
				<div class="col-sm-10">
					<div class="input-group input-group-sm">
					    <input name="ypxqjsrq" type="text" class="form-control form_date" data-date-format="yyyy-MM-dd" id="lastname">
					    <span class="input-group-addon calendar"><span class="glyphicon glyphicon-calendar"></span></span>
				   </div>
				</div>
			</div>
			<div class="row form-group">
				<label for="lastname" class="col-sm-2 control-label">原判刑罚</label>
				<div class="col-sm-10">
					<input name="ypxf" type="text" class="form-control" id="lastname"
						placeholder="原判刑罚">
				</div>
			</div>
			<div class="row form-group">
				<label for="lastname" class="col-sm-2 control-label">附加刑</label>
				<div class="col-sm-10">
					<input name="fjx" type="text" class="form-control" id="lastname"
						placeholder="附加刑">
				</div>
			</div>
			<div class="row form-group">
				<label for="lastname" class="col-sm-2 control-label">判决机关</label>
				<div class="col-sm-10">
					<input name="pjjg" type="text" class="form-control" id="lastname"
						placeholder="判决机关">
				</div>
			</div>
			<div class="row form-group">
				<label for="lastname" class="col-sm-2 control-label">判决日期</label>
				<div class="col-sm-10">
					<div class="input-group input-group-sm">
					    <input name="pjrq" type="text" class="form-control form_date" data-date-format="yyyy-MM-dd" id="lastname">
					    <span class="input-group-addon calendar"><span class="glyphicon glyphicon-calendar"></span></span>
				   </div>
				</div>
			</div>
			<div class="row form-group">
				<label for="lastname" class="col-sm-2 control-label">委托单位</label>
				<div class="col-sm-10">
					<input name="wtdw" type="text" class="form-control" id="lastname"
						placeholder="委托单位">
				</div>
			</div>
			<div class="row form-group">
				<label for="lastname" class="col-sm-2 control-label">委托调查书</label>
				<div class="col-sm-10">
					<input name="wtdcs" type="text" class="form-control" id="lastname"
						placeholder="委托调查书">
				</div>
			</div>
			<div class="row form-group">
				<label for="lastname" class="col-sm-2 control-label">被调查人姓名</label>
				<div class="col-sm-10">
					<input name="bdcrxm" type="text" class="form-control" id="lastname"
						placeholder="被调查人姓名">
				</div>
			</div>
			<div class="row form-group">
				<label for="lastname" class="col-sm-2 control-label">与被告人（罪犯）关系</label>
				<div class="col-sm-10">
					<input name="ybgrgx" type="text" class="form-control" id="lastname"
						placeholder="与被告人（罪犯）关系">
				</div>
			</div>
			<div class="row form-group">
				<label for="lastname" class="col-sm-2 control-label">调查事项</label>
				<div class="col-sm-10">
					<input name="dcsx" type="text" class="form-control" id="lastname"
						placeholder="调查事项">
				</div>
			</div>
			<div class="row form-group">
				<label for="lastname" class="col-sm-2 control-label">调查时间</label>
				<div class="col-sm-10">
					<div class="input-group input-group-sm">
					    <input name="dcsj" type="text" class="form-control form_date_time" data-date-format="yyyy-MM-dd" id="lastname">
					    <span class="input-group-addon calendar_time"><span class="glyphicon glyphicon-calendar"></span></span>
				   </div>
				</div>
			</div>
			<div class="row form-group">
				<label for="lastname" class="col-sm-2 control-label">调查地点</label>
				<div class="col-sm-10">
					<input name="dcdd" type="text" class="form-control" id="lastname"
						placeholder="调查地点">
				</div>
			</div>
			<div class="row form-group">
				<label for="lastname" class="col-sm-2 control-label">拟适用矫正类别</label>
				<div class="col-sm-10">
					<input name="nsyjzlb" type="text" class="form-control" id="lastname"
						placeholder="拟适用矫正类别">
				</div>
			</div>
			<div class="row form-group">
				<label for="lastname" class="col-sm-2 control-label">调查单位（司法所）</label>
				<div class="col-sm-10">
					<input name="dcdwsfs" type="text" class="form-control" id="lastname"
						placeholder="调查单位（司法所）">
				</div>
			</div>
			<div class="row form-group">
				<label for="lastname" class="col-sm-2 control-label">调查单位（县区局）</label>
				<div class="col-sm-10">
					<input name="dcdwxqj" type="text" class="form-control" id="lastname"
						placeholder="调查单位（县区局）">
				</div>
			</div>
			<div class="row form-group">
				<label for="lastname" class="col-sm-2 control-label">调查人</label>
				<div class="col-sm-10">
					<input name="dcr" type="text" class="form-control" id="lastname"
						placeholder="调查人">
				</div>
			</div>
			<div class="row form-group">
				<label for="lastname" class="col-sm-2 control-label">调查意见审核人</label>
				<div class="col-sm-10">
					<input name="dcyjshr" type="text" class="form-control" id="lastname"
						placeholder="调查意见审核人">
				</div>
			</div>
			<div class="row form-group">
				<label for="lastname" class="col-sm-2 control-label">调查评估意见书</label>
				<div class="col-sm-10">
					<input name="dcpgyjs" type="text" class="form-control" id="lastname"
						placeholder="调查评估意见书">
				</div>
			</div>
			<div class="row form-group">
				<label for="lastname" class="col-sm-2 control-label">备注</label>
				<div class="col-sm-10">
					<input name="remark" type="text" class="form-control" id="lastname"
						placeholder="备注">
				</div>
			</div>
		</div>
	</div>
</body>
</html>