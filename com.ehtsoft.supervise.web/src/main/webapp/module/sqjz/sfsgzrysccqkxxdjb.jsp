<%@ page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>

<html>
<head>
<title>司法所工作人员受惩处情况信息登记表</title>
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
	$("#sqjz_listDagl_all #quxiaobtnCj").click(function(){//单击取消按钮
		$("#sqjz_listDagl_all #hideDivCj").hide();
	});
</script>
<style type="text/css">
	.ds{
		width: 800px;
		margin-left: 260px;
	}
	
</style>
</head>
<body>
<div class="ds" >
	<h3 align="center">司法所工作人员受惩处情况信息登记表</h3><br/>
	<div id="sqjz_fromDcpg_add " >
		<div id="sqjz_fromDcpg_add_form">
			<div class="row form-group">
				<label for="firstname" class="col-sm-2 control-label">人员编码：</label>
				<div class="col-sm-10">
					<input name="rybm" type="text" class="form-control"
						id="firstname" placeholder="人员编码">
				</div>
			</div>
			<div class="row form-group">
				<label for="lastname" class="col-sm-2 control-label">惩处名称：</label>
				<div class="col-sm-10 div" >
					<input name="ccmc" type="text" class="form-control" id="lastname"
						placeholder="惩处名称" >
				</div>
			</div>
			<div class="row form-group">
				<label for="lastname" class="col-sm-2 control-label">惩处类别:</label>
				<div class="col-sm-10">
					<select name="cclb" class="form-control" id="lastname"> 
						<option value=""></option> 
						<option value="01">党内处分</option>
						<option value="02">行政处分</option>
						
					</select>
				</div>
			</div>
			<div class="row form-group">
				<label for="lastname" class="col-sm-2 control-label">党内处分:</label>
				<div class="col-sm-10">
					<select name="dncf" class="form-control" id="lastname"> 
						<option value=""></option> 
						<option value="01">警告</option>
						<option value="02">严重警告</option>
						<option value="03">撤销党内职务</option>
						<option value="04">留党察看</option>
						<option value="05">开除党籍</option>
						
					</select>
				</div>
			</div>
			<div class="row form-group">
				<label for="lastname" class="col-sm-2 control-label">行政处分:</label>
				<div class="col-sm-10">
					<select name="xzcf" class="form-control" id="lastname"> 
						<option value=""></option> 
						<option value="01">警告</option>
						<option value="02">记过</option>
						<option value="03">记大过</option>
						<option value="04">降级</option>
						<option value="05">撤职</option>
						<option value="06">开除</option>
						
					</select>
				</div>
			</div>
			<div class="row form-group">
				<label for="lastname" class="col-sm-2 control-label">惩处时间：</label>
				<div class="col-sm-10">
					<div class="input-group input-group-sm">
					    <input name="ccsj" type="text" class="form-control form_date" data-date-format="yyyy-MM-dd" id="lastname">
					    <span class="input-group-addon calendar"><span class="glyphicon glyphicon-calendar"></span></span>
				   </div>
				</div>
			</div>
			<div class="row form-group">
				<label for="lastname" class="col-sm-2 control-label">惩处期限：</label>
				<div class="col-sm-10 div" >
					<input name="ccqx" type="text" class="form-control" id="lastname"
						placeholder="惩处期限" >
				</div>
			</div>
			<div class="row form-group">
				<label for="lastname" class="col-sm-2 control-label">惩处内容：</label>
				<div class="col-sm-10">
					<div class="input-group input-group-sm">
					   <textarea  name="ccnr" rows="3" cols="92"></textarea>
					</div>
				</div>
			</div>
			<div class="row form-group"  align="right">
				<button type="button" class="btn btn-default quxiaobtnCj sqjz_listDcpg_all" data-dismiss="modal">关闭</button>
							<button id="dagl_list_btn_primary" type="button" class="btn btn-primary sqjz_listDcpg_all">提交</button>
			</div>
			
		</div>
	</div>
</div>
</body>
</html>