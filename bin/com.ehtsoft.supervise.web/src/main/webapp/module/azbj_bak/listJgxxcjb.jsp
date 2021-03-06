<%@ page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
<title>警告信息采集表</title>
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<script type="text/javascript" src="${localCtx}/json/JgxxcjbService.js"></script>
<script type="text/javascript" src="${localCtx}/json/AuditService.js"></script>
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
	box-shadow: 0px 0px 10px #888888;
	width: 0;
	display:none;
	overflow: auto;
}
#siderightbar {
	cursor: pointer;
}
#siderightbar:hover {
	color: #00f;
}
#jgxxshyj{
  background-color:	#AAAAAA;
  font-size:14px;
}
#joxzq{
   background-color:#AAAAAA;
}
.Shenheliucheng{
	background-color: #C8E6C9;
    font-size: 20px;
    border-radius: 3px;
    padding: 3px;
}
/* #shenqingrenHm{
  color:#fff;
} */
</style>
<script type="text/javascript">
$(function(){
	var tableview = new Eht.TableView({selector:"#sqjz_listJgxxcjb #tableview"});
	var qform = new Eht.Form({selector:"#jgxx_querypanel"});
	var form = new Eht.Form({
		selector:"#jgxx_modal-form",autolayout:true
	});
	var form1 = new Eht.Form({
		selector:"#tqly_modal_form",autolayout:true
	});
	var formJgxx = new Eht.Form({selector:"#jgxx_view_ry",
		autolayout:true,
		colLabel:"col-sm-3 col-xs-3",
		colCombo:"col-sm-9 col-xs-9"	
	})
	//
	var service = new JgxxcjbService();
	//审批流程接口
	var service_Sqr = new AuditService();
	//使初始状态为不可编辑
	function changeInput(ifBoolean){
		if(ifBoolean){
			formJgxx.disable();
		}else{
			formJgxx.enable();
		}
	}
	//获取下拉选的指
	var query = {};
	 query.xm = $("#searchXm").val();
	//将初始警告信息加载到页面
	tableview.loadData(function(page,res){
		service.find(query,page,res);
	}); 
	//动态添加审批历史记录信息
	service.findJzry(new Eht.Responder({
		success:function(data){
			$("#jgxxform_xmAndLxdh").empty();
			$("#jgxxform_xmAndLxdh").append('<option selected="selected"></option>');
			for(var i=0;i<data.length;i++){
				$("#jgxxform_xmAndLxdh").append("<option value="+data[i].id+">"+data[i].xm + "     " + data[i].grlxdh +"</option>");
			}
			$("#jgxxform_xmAndLxdh").comboSelect();
		}
	}));
	//审核记录
	var tableViewshjl = new Eht.TableView({selector:"#tableview-shjl",paginate:null});
	 tableViewshjl.transColumn("audit",function(data){
     	var rtn = "";
 		if(data.auditStatus==1){
 			rtn="通过";
 		}
 		if(data.auditStatus==2){
 			rtn="未通过";
 		}
 		if(data.auditStatus==0){
 			rtn="待审核";
 		}
     	return rtn;
     })
	//查询按钮
	$("#sqjz_listJgxxcjb #querybtn").click(function(){
		query.audit = $("#listJgxxcjbSelt").val();
		query["xm[like]"] = $("#searchXm").val();
		tableview.refresh();
	});
	//点击添加上报弹出模态框
	$('#sqjz_listJgxxcjb #addbtn').click(function(){
		$("#sfssqsj").val(nowTime);		
		$("#sfssqr").val("${CURRENT_USER_SESSION.name}");
		$('#jgxxcjb_myModal').modal({backdrop:'static'});
	});
	//提交警告上报数据
	$("#sqjz_listJgxxcjb #jgxx_btn_submit").click(function(){
		if(form.validate()){
			service.save(form.getData(),new Eht.Responder({
				success:function(){
					$('#jgxxcjb_myModal').modal("hide");
					tableview.refresh();
				}
			}));
			form.clear();
		}
	});
	
	//获取当前日期
    Date.prototype.Format = function (fmt) {    
    var o = {    
        "M+": this.getMonth() + 1, //月份     
        "d+": this.getDate(), //日     
        "H+": this.getHours(), //小时     
        "m+": this.getMinutes(), //分     
        "s+": this.getSeconds(), //秒     
    };
    if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));    
    for (var k in o)    
    if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));    
    return fmt;    
    }    
	var nowTime=new Date().Format("yyyy-MM-dd HH:mm:ss");
	
	 //双击一行获取该行信息
	 var json={};	 
	 tableview.dblclickRow(function(data){
		 changeInput(true);
		 json=data;
		 formJgxx.fill(json);
		 $("#shenqingren").html(json.sfssqr);  
		 $("#sqjz_listJgxxcjb #right-panel").show().animate({width:460});
		 $("#shenqingrenHm").empty();
		 var jsonSqr = {}; 
		 service.findApprover(new Eht.Responder({
			     success:function(data){
			            jsonSqr = data;
			           for(var i =0;i<jsonSqr.length;i++){
			                var tr = $('<span id="shenqingren" class="shenheliucheng">'+jsonSqr[i].name+'</span><span class="glyphicon glyphicon-arrow-right"></span>')	
			                $("#shenqingrenHm").append(tr);
			              }
			           }
		 }));
			tableViewshjl.refresh(); 
			
	 });
    //将数据填充到审核记录
		tableViewshjl.loadData(function(page,res){
		service.findApprover(res);//参数
	})
	//将申请人添加到页面申请人信息栏
    tableview.transColumn("audit",function(data){
    	var rtn = "";
		if(data.audit==1){
			rtn="通过";
		}
		if(data.audit==2){
			rtn="未通过";
		}
		if(data.audit==0){
			rtn="待审核";
		}
		return rtn;
    })
     
	//关闭按钮事件  清除未选择的数据
	$("#sqjz_listJgxxcjb #close").click(function(){
		   json={};
		    form.clear(); 
	        tableview.refresh(); 
	})
	//关闭右侧内容栏
	$("#siderightbar").click(function(){
		$("#sqjz_listJgxxcjb #right-panel").animate({width:0},function(){
			$("#sqjz_listJgxxcjb #right-panel").hide();
		});
	});
	//将数据填充到审核记录
	tableViewshjl.loadData(function(page,res){
		service_Sqr.getAuditHistory(json.id,res);
	})
	//警告理由
	var textareaName = "#sqjz_listJgxxcjb #floor";//备注输入框id
	var spanName = "#sqjz_listJgxxcjb #count";//计数span的id
	$(textareaName).click(function() {
		countChar(textareaName, spanName);
	});
	$(textareaName).keyup(function(){
		countChar(textareaName, spanName);
	});
	$(textareaName).keydown(function() {
		countChar(textareaName, spanName);
	});
	function countChar(textareaName, spanName) {
		if ($(textareaName).val() != "") {
			$(spanName)
					.text("" + $(textareaName).val().length + "/500");
			if ($(textareaName).val().length > 0) {
				$(spanName).css("color", "#3F51B5");
			}
			;
			if ($(textareaName).val().length > 240) {
				$(spanName).css("color", "#FF0000");
			}
			;
		} else {
			$(spanName).text("0/500");
		}
	}
	;
	//警告依据
	var textareaName2 = "#sqjz_listJgxxcjb #floor2";//备注输入框id
	var spanName2 = "#sqjz_listJgxxcjb #count2";//计数span的id
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
					"" + $(textareaName2).val().length + "/500");
			if ($(textareaName2).val().length > 0) {
				$(spanName2).css("color", "#3F51B5");
			}
			;
			if ($(textareaName2).val().length > 240) {
				$(spanName2).css("color", "#FF0000");
			}
			;
		} else {
			$(spanName2).text("0/500");
		}
	};
	
	//查看警告信息
	   tableview.transColumn("xiangxi",function(data){
	   var button = $('<input type="button" value="提请情况" style="color:blue;">');
	    button.click(function(){
	  	$('#jgxxcjbtq_myModal').modal({backdrop:'static'});
	  	form1.fill(data);
		});
		return button;
	});	
});	
</script>
</head>
<body>
<div id="sqjz_listJgxxcjb">
	<div class="panel panel-default">
		<div class="panel-heading ltrhao-toolbar" style="padding-left: 20px;">
			<div id="jgxx_querypanel">
			  姓名：<input class="input-group-addon" style="width: 150px; border:1px solid #ccc;background-color: #fff;" type="text" name="xm" placeholder="请输入姓名" id="searchXm"/>	
				<label>审核状态</label>
				<select class="btn btn-default" type="text" label="审批状态" id="listJgxxcjbSelt">
					<option value=" ">全部</option>
					<option value="1">通过</option>
					<option value="2">未通过</option>
					<option value="0">待审核</option>
				</select>
				<span>
				<input class="btn btn-default btn-sm" type="button" id="querybtn"
						value="查询"> 
				<input id="addbtn" class="btn btn-default btn-sm"
						type="button" value="添加上报">
				</span>
			</div>
		</div>
		<div class="alert alert-warning alert-dismissible" role="alert" id="hideScDiv" hidden style="text-align:center;font-size:17px">
		    <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
		    <strong>警告!</strong> 确定删除？
		    <input id="shanchubtn" class="btn btn-default" type="button" value="确定" >
		    <input id="quxiaobtn1" class="btn btn-default" type="button" value="取消" >
		</div>	
		<div class="panel-body">
		   <div class="col-md-12">
			<div id="tableview" class="table-responsive">				
				<div field='xm' label="姓名"></div>
				<div field="xb" label="性别" code="SYS000"></div>
				<div field="grlxdh" label="联系方式"></div>
				<div field="sfzh" label="身份证号码"></div>
				<div field="sfssqr" label="司法所申请人"></div>
				<div field="audit" label="是否审批"></div>
				<div field="xiangxi" label="警告信息"></div>
			</div>
			</div>
		</div>	
	</div>
	<!-- 模态框（Modal） -->
	<div class="modal fade" id="jgxxcjb_myModal">
			<div class="modal-dialog ">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="false" id="xxx"></button>
						<h4 class="modal-title" id="myModalLabel">添加警告信息</h4>
					</div>
					<div class="modal-body" id="modal-body" style="height: 400px; overflow: auto">
						<div id="jgxx_modal-form">
						    <select id="jgxxform_xmAndLxdh" name="f_aid" label="服刑人员"></select> 
							<textarea rows="8" name="jgly" id="floor" type="text" maxlength="500" valid="{required:true}" label="警告理由"></textarea>
							<div class="text-right"><span id="count"  style="color: #3F51B5;margin-right: 40px;"></span></div>
							<textarea rows="8" name="jgyj" id="floor2" type="text" maxlength="500" valid="{required:true}" label="警告依据"></textarea>
							<div class="text-right"><span id="count2"  style="color: #3F51B5;margin-right: 40px;"></span></div>
							<input name="sfssqsj" label="警告时间" id="sfssqsj" class="form_date">
							<input name="sfssqr" id="sfssqr" type="text" label="申请人" value="${CURRENT_USER_SESSION.name}" readonly="true">
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal" id="close">关闭</button>
						<button type="button" class="btn btn-primary" id="jgxx_btn_submit">提交</button>
					</div>
				</div>
			</div>
		</div>
		
		<!-- 点击详细弹出提请理由，提请依据详细信息 -->
	<div class="modal fade" id="jgxxcjbtq_myModal">
			<div class="modal-dialog ">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="false" id="xxx"></button>
						<h4 class="modal-title" id="myModalLabel">提请理由依据详细信息</h4>
					</div>
					<div class="modal-body" id="modal-body" style="height: 400px; overflow: auto">
						<div id="tqly_modal_form">     
								<textarea name="jgly" rows="8" type="text" valid="{required:true}" disabled label="提请理由";></textarea>
								<div class="text-right"><span style="color: #3F51B5"></span></div>
								<textarea rows="8" name="jgyj" type="text"  valid="{required:true}" disabled label="提请依据";></textarea>
								<div class="text-right"><span style="color: #3F51B5"></span></div>						
						</div>	
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal" id="close">关闭</button>
					</div>
				</div>
			</div>
		</div>
		
	<!-- 右侧菜单栏 -->
	<div class="right-panel" id="right-panel">
		<div class="panel panel-default">
		  <div class="panel-heading" style="font-size:18px;">
		  	<span id="siderightbar" class="glyphicon glyphicon-remove-sign"></span>&nbsp;警告信息
		  </div>
		</div>
		<div class="panel panel-default">
			<div class="panel-heading">
				<div class="jgxx_view_ry" id="jgxx_view_ry">
				<input type="text" label="姓名" name="xm" getdis="true"/>
				<input type="text" label="联系电话" name="grlxdh" getdis="true"/>
				<input type="text" label="警告理由" name="jgly" getdis="true"/>
				<input type="text" label="警告依据" name="jgyj" getdis="true"/>
				<input type="text" label="审批人" name="sfssqr" getdis="true"/>
				<input type="text" label="申请时间" name="sfssqsj" getdis="true"/>
			</div>
	       <h3>审核流程</h3>
			<div id="shenpiLc">
				<span id="shenqingren" class="Shenheliucheng">申请人</span><span class="glyphicon glyphicon-arrow-right" id="shenqingrenHm"></span>
				<span  class="Shenheliucheng">流程结束</span>
			</div>
			<h3>审核记录</h3>
			<div data-spy="scroll" data-target="#navbar-example" data-offset="0" 
	              style="height:200px;overflow:auto; position: relative;">
			<div id="tableview-shjl" class="table-responsive">
				<div field="name" label="审批人"></div>
				<div field="sfsspyj" label="审核意见"></div>
				<div field="audit" label="审核状态"></div>
				<div field="sfsspsj" label="审核时间"></div>
			</div>
			</div>
		</div>
	</div>
</div>
</div>
</body>
</html>