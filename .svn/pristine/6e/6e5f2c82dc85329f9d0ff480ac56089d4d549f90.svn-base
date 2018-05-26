<%@ page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>
<html>
<head>
<title>审批信息表</title>
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<script type="text/javascript" src="${localCtx}/json/AuditService.js"></script>
<script type="text/javascript">
$(function(){
	//提示框默认为隐藏
	$('#listAuditService #close_alert_div').hide();
	var service = new AuditService();
	var tableView = new Eht.TableView({selector:"#listAuditService #tableview"});
	//审核记录
	var tableViewShjl = new Eht.TableView({selector:"#tableview-shenheJl",paginate:null});
	//审核信息
	var formShxx = new Eht.Form({selector:"#listAuditService #shenpiXx",autolayout:true});
	//添加按钮默认不可编辑
	var formAniu = new Eht.Form({selector:"#listAuditService #select-Morenbkbj"});
	var query = {};
	tableView.loadData(function(page,res){
		$("#audit_shenpi_btn").disable();
		service.findAuditApply(query,page,res);
	});
	var json = {};
	tableView.clickRow(function(data){
		json = data;
		$("#shenqingren").html(json.name);
		$("#shenqingrenHm").empty();
		service.findApprover(json.billid,data.id,new Eht.Responder({
			success:function(data){
				console.log(data);
				$("#audit-process-image").empty();
				//<span class="audit-process">申请人</span>
				//<span class="glyphicon glyphicon-arrow-right"></span>
				//<span class="audit-process">完成</span>
				$("#audit-process-image").append('<span class="audit-process audit-complete">申请人</span>');
				for(var i=0;i<data.length;i++){
					var cls = "";
					if(data[i].curAudit){
						cls = "audit-active";
					}
					$("#audit-process-image").append('<span class="glyphicon glyphicon-arrow-right"></span>');
					$("#audit-process-image").append('<span id="shenheren1" class="audit-process '+cls+'">'+data[i].name+'</span>');
				}
				$("#audit-process-image").append('<span class="glyphicon glyphicon-arrow-right"></span>');
				$("#audit-process-image").append('<span id="shenheren1" class="audit-process">完成</span>');
			}
		}));
		//添加申请人
		if(json.auditing==0){
			$("#audit_shenpi_btn").enable();
		}
		//单击事件右侧信息框弹出
		formShxx.fill(json);
		$('#listAuditService #right-panel').show().animate({
			width : 500
		});
		tableViewShjl.refresh();
	});
	tableViewShjl.transColumn("audit",function(data){
		var rtn = "";
		if(data.auditing==1){
			rtn="通过";
		}
		if(data.auditing==2){
			rtn="不通过";
		}
		return rtn;
	});
	tableView.transColumn("audit",function(data){
		var rtn = "";
		if(data.auditing==1){
			rtn="通过";
		}
		if(data.auditing==2){
			rtn="不通过";
		}
		if(data.auditing==0){
			rtn="待审核";
		}
		return rtn;
	})
	//将数据填充到审核记录
	tableViewShjl.loadData(function(page,res){
		service.getAuditHistory(json.id,res);
	})
	//提示框取消按钮事件
	$('#listAuditService #close_alert').click(function(){
		$('#listAuditService #close_alert_div').hide();
	});
	//点击审批按钮事件
	$("#audit_shenpi_btn").click(function(){
		if(json.id==null){
			$("#listAuditService #close_alert_div").show();
		}else{
			$("#myModalLabel").html(json.title);
			$("#listAuditService #myModal").modal({backdrop: 'static', keyboard: false});//弹出模态框
			//点击通过按钮事件
			$("#listAuditService #tongguo").unbind("click").bind("click",function(){
				service.auditing(json.id,1,$("#remark").val());
				$("#listAuditService #myModal").modal('hide');
				tableView.refresh();
			})
			//点击不通过按钮事件
			$("#listAuditService #butongguo").unbind("click").bind("click",function(){
				service.auditing(json.id,2,$("#remark").val());
				$("#listAuditService #myModal").modal('hide');
				tableView.refresh();
			})
		}
	});
	//审批状态查询按钮触发事件

	$("#listAuditService #select").click(function(){
		if($("#selectZt").val()=="通过"){
			query.audit = "1";
			tableView.refresh();
		}else if($("#selectZt").val()=="不通过"){
			query.audit = "2";
			tableView.refresh();
		}else if($("#selectZt").val()=="待审核"){
			query.audit = "0";
			tableView.refresh();
		}
	})
	//关闭右侧面板
	$("#closebtn").click(function() {
		$('#right-panel').animate({
			width : 0
		}, function() {
			$(this).hide()
		});
	});
	changeInput(true);
	function changeInput(ifBoolean){
		if(ifBoolean){
			formShxx.disable();
		}else{
			formShxx.enable();
		}
	}
	
})

</script>
<style>
#right-panel{
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
	width:0px;
}
.audit-process{
	background-color: #C8E6C9;
    font-size: 20px;
    border-radius: 3px;
    padding: 3px 5px;
}
.audit-active{
	background-color: #88fb31;
}
.audit-complete{
	background-color:#57f4f5;
}
</style>
</head>
<body>
	<div id="listAuditService">
	<div class="panel panel-default">
			<div class="panel-heading ltrhao-toolbar" style="padding-left: 50px;">
				<fieldset id="querypanel">
					<label>审核状态</label>
					<select id="selectZt" class="btn btn-default" type="text"  label="审批状态" style="width:200px;">
						<option>待审核</option>
						<option>不通过</option>
						<option>通过</option>
					</select>
					<input class="btn btn-default" type="button" id="select" value="查询" >
					<div id="select-Morenbkbj" style="position: absolute; left: 400px;top: 3px;font-size: 25px;"> 
						<input class="btn btn-default" type="button" id="audit_shenpi_btn" value="审批" disabled>
					</div>
				</fieldset>
			</div>
		<div class="alert alert-warning alert_dismissible" id="close_alert_div" role="alert" style="text-align:center;font-size:17px">
			<strong>提示</strong> 请选择一条信息!
			<input type="button" class="btn btn-default" id="close_alert" value="取消"/>
		</div>
			<div class="panel-body">
				<div id="tableview">
					<div field="billname" label="单据类型"></div>
					<div field="title" label="单据名称"></div>
					<div field="content" label="单据内容"></div>
					<div field="name" label="申请人姓名"></div>
					<div field="cts" label="申请时间"></div>
					<div field="audit" label="审批状态"></div>
				</div>
			</div>
		</div>
		<!-- 审批(Modal) -->
		<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
							&times;
						</button>
						<h4 class="modal-title" id="myModalLabel">警告上报</h4>
					</div>
					<div class="modal-body" style="overflow: auto">
						<div class="modal-body-div">
							<div id="sp-Form">
								<span style="font-size: 23px;padding-left: 200px;">描述内容</span><br>
								<textarea  rows="12"  name="f_hbnr" id="remark" style="width: 565px;"></textarea>
							</div>
						</div>
					</div>
					<div class="modal-footer">
						<button id="tongguo" type="button" class="btn btn-default" >通过</button>
						<button id="butongguo"  type="button" class="btn btn-default">不通过</button>
					</div>
				</div>
			</div>
		</div>
		<!-- 右侧弹出框 -->
		<div id="right-panel" class="panel-heading">
			<div class="panel-heading" style="font-size: 20px;">
				<span class="glyphicon glyphicon-remove" id="closebtn"></span>
				<span>审批信息</span>
			</div>
			<div id="shenpiXx">
				<input type="text" label="单据类型" name="billname" getdis="true"/>
				<input type="text" label="单据名称" name="title" getdis="true"/>
				<input type="text" label="申请人" name="name" getdis="true"/>
				<input type="text" label="申请日期" name="cts" getdis="true"/>
			</div>
			<h3>审核流程</h3>
			<div id="audit-process-image">
				
			</div>
			<h3>审核记录</h3>
			<div id="tableview-shenheJl" class="table-responsive">
				<div field="name" label="审批人"></div>
				<div field="audit" label="审核状态"></div>
				<div field="remark" label="审核意见"></div>
				<div field="cts" label="审核时间"></div>
			</div>
		</div>
	</div>
</body>
</html>