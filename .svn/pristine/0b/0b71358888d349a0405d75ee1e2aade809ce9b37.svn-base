<%@ page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>

<html>
<head>
<title>司法所交通工具登记表</title>
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
	<h3 align="center">司法所交通工具登记表</h3><br/>
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
				<label for="lastname" class="col-sm-2 control-label">汽车数量 ：</label>
				<div class="col-sm-10 " >
					<input name="qcsl" type="text" class="form-control" id="lastname"
						placeholder="汽车数量" >
				</div>
			</div>
			<div class="row form-group">
				<label for="lastname" class="col-sm-2 control-label">摩托车数量：</label>
				<div class="col-sm-10 " >
					<input name="mtcsl" type="text" class="form-control" id="lastname" 
					placeholder="摩托车数量"  >
				</div>
			</div>
			<div class="row form-group">
				<label for="lastname" class="col-sm-2 control-label">电动车数量：</label>
				<div class="col-sm-10 " >
					<input name="ddcsl" type="text" class="form-control" id="lastname" 
					placeholder="电动车数量"  >
				</div>
			</div>
			<div class="row form-group">
				<label for="lastname" class="col-sm-2 control-label">其他交通工具数量：</label>
				<div class="col-sm-10 " >
					<input name="qtjtgjsl" type="text" class="form-control" id="lastname" 
					placeholder="其他交通工具数量"  >
				</div>
			</div>
			<div class="row form-group">
				<label for="lastname" class="col-sm-2 control-label">交通工具投资金额：</label>
				<div class="col-sm-10 div" >
					<input name="jtgjtzje" type="text" class="form-control" id="lastname"
					placeholder="交通工具投资金额"  ><span>￥</span>
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