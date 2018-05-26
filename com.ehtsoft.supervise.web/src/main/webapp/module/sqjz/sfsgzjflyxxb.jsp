<%@ page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>

<html>
<head>
<title>司法所工作经费来源信息表</title>
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
	.div span{
		position:absolute;
		right:3%;
		display:inline;
		font-size: 15px;
		margin-top: 5px;
	}
	.div input{
		display:inline;
	}
	.ds{
		width: 800px;
		margin-left: 260px;
	}
	
</style>
</head>
<body>
<div class="ds" >
	<h3 align="center">司法所工作经费来源信息表</h3><br/>
	<div id="sqjz_fromDcpg_add " >
		<div id="sqjz_fromDcpg_add_form">
			<div class="row form-group">
				<label for="firstname" class="col-sm-2 control-label">司法所编码：</label>
				<div class="col-sm-10">
					<input name="sfsbm" type="text" class="form-control"
						id="firstname" placeholder="司法所编码">
				</div>
			</div>
			<div class="row form-group">
				<label for="lastname" class="col-sm-2 control-label">列入预算情况:</label>
				<div class="col-sm-10">
					<input name="lrywyf" type="radio" id="lastname" placeholder="列入预算情况">是
					<input name="lrywyf" type="radio" id="lastname" placeholder="列入预算情况">否
				</div>
			</div>
			<div class="row form-group">
				<label for="lastname" class="col-sm-2 control-label">列入预算级别：</label>
				<div class="col-sm-10">
						<select name="lrysjb" class="form-control" id="lastname"> 
						<option value=""></option> 
						<option value="01">县（市、区）财政预算</option>
						<option value="02">乡镇（街道）财政预算</option>
						<option value="99">其他</option>
					</select>
				</div>
			</div>
			<div class="row form-group">
				<label for="lastname" class="col-sm-2 control-label">中央政法专项转移支付资金:</label>
				<div class="col-sm-10">
					<input name="zyzfzxzyzfzj" type="radio" id="lastname">是
					<input name="zyzfzxzyzfzj" type="radio" id="lastname" >否
				</div>
			</div>
			<div class="row form-group">
				<label for="lastname" class="col-sm-2 control-label">其他资金来源：</label>
				<div class="col-sm-10" >
					<input name="qtzjly" type="text" class="form-control" id="lastname"
						placeholder="其他资金来源" >
				</div>
			</div>
		
			
			
			<div class="row form-group">
				<label for="lastname" class="col-sm-2 control-label">年份：</label>
				<div class="col-sm-10">
					<div class="input-group input-group-sm">
					    <input name="nf" type="text" class="form-control form_date" data-date-format="yyyy-MM-dd" id="lastname">
					    <span class="input-group-addon calendar"><span class="glyphicon glyphicon-calendar"></span></span>
				   </div>
				</div>
			</div>
			
			<div class="row form-group">
				<label for="lastname" class="col-sm-2 control-label">经费金额：</label>
				<div class="col-sm-10 div" >
					<input name="jfje" type="text" class="form-control" id="lastname"
					placeholder="业务用房投资金额"  ><span>￥</span>
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