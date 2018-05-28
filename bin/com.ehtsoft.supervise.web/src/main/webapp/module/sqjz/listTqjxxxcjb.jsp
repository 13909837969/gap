<%@ page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
<title>提请减刑信息采集表</title>
<jsp:include page="../ltrhao-common.jsp"></jsp:include>

<script type="text/javascript" src="${localCtx}/json/JzTqjxxxService.js"></script>
<script type="text/javascript" src="${localCtx}/json/AuditService.js"></script>



<style>

#siderightbar {
	cursor: pointer;
}
#siderightbar:hover {
	color: #00f;
}
.Shenheliucheng{
	background-color: #C8E6C9;
    font-size: 20px;
    border-radius: 3px;
    padding: 3px;
}
#sqjz_Tqjxxx #tableaaa {
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
</style>
<script type="text/javascript">
$(function(){
	
	var tableview = new Eht.TableView({
		selector:"#sqjz_Tqsjzx #tableview"
	});
	//审核记录
	var tableViews = new Eht.TableView({
		selector:"#tableview_shjl",
		paginate:null
	});
	
	$('#sjzx_sh_modal').modal("hide");
	 
	var qform = new Eht.Form({
		selector:"#zaxx_querypanel"
	});
	var form = new Eht.Form({
		selector:"#zaxx_modal_form",
		autolayout:true
	});
	
	var form1 = new Eht.Form({
		selector:"#modal_form_tqly",
		autolayout:true,
	});
	//审核提交
	var form2 = new Eht.Form({
		selector:"#modal_sh_form_tqly",
		autolayout:true,
	});
	
	
	var formJgxx = new Eht.Form({selector:"#jgxx_view_ry",
		autolayout:true,
		colLabel:"col-sm-3 col-xs-3",
		colCombo:"col-sm-9 col-xs-9"	
	});
	
	
	var nowTime=new Date().format("yyyy-MM-dd");
	
	//审批流程接口
	var service_Sqr = new AuditService();
	
	var service = new JzTqjxxxService();
	
	var query = {};
	//加载当前机构下的所有收监执行采集信息
	tableview.loadData(function(page,res){
		service.find(query,page,res);
	}); 
	
	 var abtn = "${CURRENT_USER_SESSION.orgType}";
	 if(abtn==2){
		 $("#addbtn").hide();
	 }
 
	//查询按钮
	$("#sqjz_Tqsjzx #querybtn").click(function(){
		query.audit = $("#listJgxxcjbSelt").val();
		query["xm[like]"] = $("#searchXm").val(); 
		tableview.refresh();
	});
	//点击添加上报弹出模态框
	$('#sqjz_Tqsjzx #addbtn').click(function(){
		//动态添加矫正人员
	    service.findJzry({},new Eht.Responder({
			success:function(data){
				$("#tqzaform_xmAndLxdh").empty();
				//循环打印矫正人员
				$("#tqzaform_xmAndLxdh").append('<option selected="selected"></option>');
				for(var i=0;i<data.length;i++){
					$("#tqzaform_xmAndLxdh").append("<option value="+data[i].id+">"+data[i].xm + "     " + data[i].grlxdh +"</option>");
				}
				$("#tqzaform_xmAndLxdh").comboSelect();
			}
		})); 
		$("#sfssqsj").val(nowTime);		
		
		$("#sfssqr").val("${CURRENT_USER_SESSION.name}");
	
		$('#sjzxxx_myModal').modal({backdrop:'static'});
	});
	//提交收监执行信息
	$("#sqjz_Tqsjzx #btn_submit").click(function(){
		if(form.validate()){
			service.save(form.getData(),new Eht.Responder({	
				success:function(){
					tableview.refresh();
					$('#sjzxxx_myModal').modal("hide");
				}
			}));
			form.clear();
		}
	});
	var resul = new Eht.Responder({
	     success:function(data){
	    	
	           for(var i =0;i<data.length;i++){
	        
	                var tr = $('<span value="sfssqr" class="shenheliucheng">'+data[i].name+'</span><span class="glyphicon glyphicon-arrow-right"></span>')	
	                $("#shenqingrenHm").append(tr);
	              }
	          
	           }
	});
	//查看提请理由，提请依据详细情况
	  tableview.transColumn("xiangxi",function(data){
		   var orgStyle="${CURRENT_USER_SESSION.orgType}";
		   var dv = $("<div></div>");
		  var btn1 = $('<button  class="btn btn-default btn-sm "><span class="glyphicon glyphicon-edit"></span>&nbsp;可查看</button>');
		  var btn2 = $('<button  class="btn btn-default btn-sm" style="margin-left:10px;"><span class="glyphicon glyphicon-print"></span>&nbsp;审核</button>');
		  var btn3 = $('<button  class="btn btn-default btn-sm" style="margin-left:10px;"><span class="glyphicon glyphicon-print"></span>&nbsp;提请</button>');
			   btn1.data(data);
			   btn2.data(data);
				//查看按钮
				btn1.click(function(){
					var ds = $(this).data();
					$('#sjzx_modal').modal({backdrop:'static'});
					
				  	form1.fill(ds);
				  	 $("#shenqingren").html(ds.sfssqr); 
					 $("#shenqingrenHm").empty();
					 var jsonSqr = {}; 
					// service.findApprover(ds.id,resul);
					/*
					<div id="modal_form_tqly">     
								<textarea name="xsfjshyj" rows="8" type="text" valid="{required:true}" disabled label="审核意见";></textarea>
								<div class="text-right"><span style="color: #3F51B5"></span></div>
								
						</div>*/
					// tableViews.clear();
		        	//将数据填充到审核记录
		   			tableViews.loadData(function(page,res){
		   				service.getHistory(ds.id,res);//参数
		   			});
				  	
				});
				//审核按钮
				btn2.click(function(){
					$('#sjzx_sh_modal').modal({backdrop:'static'});
				  	form2.fill(data);
					$("#xsfjspsj").val(nowTime);
					$("#xsfjspr").val("${CURRENT_USER_SESSION.name}");
				});
				var orgidPd="${CURRENT_USER_SESSION.orgid}";
				if(orgStyle == 2 && data.audit == 2){
				dv.append(btn3);
				}else if(orgStyle == 2 && data.audit == 1){
				   dv.append(btn2);
		  		}else if(orgStyle == 3 && data.xsfjspsj == null && data.orgid != orgidPd){
				   dv.append(btn2);
		  		}else if(orgStyle == 3 && data.audit == 2 || data.audit == 3  || data.audit == 4){
				   dv.append(btn1);
		  		}else if(orgStyle == 4 && data.xsfjspsj != null){
				   dv.append(btn1);
				}else if(orgStyle == 2 && data.xsfjspsj != null && data.audit != 4){
				   dv.append(btn2);
				}
			return dv;
		});
		
		//修改审核状态
	    tableview.transColumn("audit",function(data){
	    	var rtn = "";
			if(data.audit==0){
				rtn="待审核";
			}
			if(data.audit==1){
				rtn="旗县司法局通过";
			}
			if(data.audit==2){
				rtn="盟市司法局通过";
			}
			if(data.audit==3){
				rtn="旗县司法局退回";
			}
			if(data.audit==4){
				rtn="盟市司法局退回";
			}
	    	return rtn;
	    });
	


	//提交审批信息
	$("#btn_sh_submit").click(function(){
		if(form2.validate()){
			service.auditSh(form2.getData(),new Eht.Responder({	
				success:function(){
					tableview.refresh();
					$("#sjzx_sh_modal").modal("hide");
				}
			}));
			form2.clear();
		}
	});
	

	
	
	//关闭按钮事件  清除未选择的数据
	$("#sqjz_Tqsjzx #close #zaxx_modal_form").click(function(){
	       form.clear();
	       tableViews.refresh();
	       tableview.refresh();	       
	});
	
	//提请理由
	var textareaName = "#sqjz_Tqsjzx #floor";//备注输入框id
	var spanName = "#sqjz_Tqsjzx #count";//计数span的id
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
			$(spanName).text("" + $(textareaName).val().length + "/500");
			if ($(textareaName).val().length > 0) {
				$(spanName).css("color", "#3F51B5");
			};
			if ($(textareaName).val().length > 240) {
				$(spanName).css("color", "#FF0000");
			};
		} else {
			$(spanName).text("0/500");
		}
	};
	
	//提请依据
	var textareaName2 = "#sqjz_Tqsjzx #floor2";//备注输入框id
	var spanName2 = "#sqjz_Tqsjzx #count2";//计数span的id
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
	
	
	//审核意见
	var textareaName3 = "#sqjz_Tqsjzx #floor3";//备注输入框id
	var spanName3 = "#sqjz_Tqsjzx #count3";//计数span的id
	$(textareaName3).click(function() {
		countChar(textareaName3, spanName3);
	});
	$(textareaName3).keyup(function() {
		countChar(textareaName3, spanName3);
	});
	$(textareaName3).keydown(function() {
		countChar(textareaName3, spanName3);
	});
	function countChar(textareaName3, spanName3) {
		if ($(textareaName3).val() != "") {
			$(spanName3).text(
					"" + $(textareaName3).val().length + "/500");
			if ($(textareaName3).val().length > 0) {
				$(spanName3).css("color", "#3F51B5");
			}
			;
			if ($(textareaName3).val().length > 240) {
				$(spanName3).css("color", "#FF0000");
			}
			;
		} else {
			$(spanName3).text("0/500");
		}
	};
	
})

</script>
</head>
<body>
<div id="sqjz_Tqsjzx">
	<div class="panel panel-default">
		<div class="panel-heading ltrhao-toolbar" style="padding-left: 20px;">
			<div id="zaxx_querypanel">
				<label>
				姓名：
				</label><input class="input-group-addon" style="width: 150px; border:1px solid #ccc;background-color: #fff;" type="text" name="xm" placeholder="请输入姓名" id="searchXm"/>
				<label>审核状态</label>
				<select class="btn btn-default" type="text" label="审批状态" id="listJgxxcjbSelt">
					<option value="">全部</option>
					<option value="0">待审核</option>
					<option value="1">旗县通过</option>
					<option value="2">盟市通过</option>
					<option value="3">旗县退回</option>
					<option value="4">盟市退回</option>
				</select>
				<span>
				<input class="btn btn-default btn-sm" type="button" id="querybtn"
						value="查询"> 
				<input id="addbtn" class="btn btn-default btn-sm"
						type="button" value="添加上报">
				</span>
			</div>
		</div>	
		<div class="panel-body">
			<div id="tableview" class="table-responsive" style="text-align:center;">						
				<div field='xm' label="姓名"></div>
				<div field="xb" label="性别" code="SYS000"></div>
				<div field="grlxdh" label="联系方式"></div>
				<div field="sfzh" label="身份证号码"></div>
				<div field="tqly" label="提请理由"></div>
				<div field="tqyj" label="提请依据"></div>
				<div field="sfssqr" label="司法所申请人"></div>
				<div field="audit" label="是否审批"></div>
				<div field="xiangxi" align = "center" label="详细"></div>	
			</div>
		</div>	
	</div>
	<!-- 模态框（Modal） -->
	<div class="modal fade" id="sjzxxx_myModal">
			<div class="modal-dialog ">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="false" id="xxx"></button>
						<h4 class="modal-title" id="myModalLabel">添加收监执行信息</h4>
					</div>
					<div class="modal-body" id="modal-body" style="height: 400px; overflow: auto">
						<div id="zaxx_modal_form">
								<select id="tqzaform_xmAndLxdh" name="aid" label="服刑人员" valid="{required:true}"></select>
								
								<textarea rows="5" name="tqly" id="floor" type="text" maxlength="500" valid="{required:true}" label="提请理由"></textarea>
								<div class="text-right"><span id="count" style="color: #3F51B5;margin-right: 40px;"></span></div>
								<textarea rows="5" name="tqyj" id="floor2" type="text" maxlength="500" valid="{required:true}" label="提请依据"></textarea>
								<div class="text-right"><span id="count2"  style="color: #3F51B5;margin-right: 40px;"></span></div>
								<input name="sfssqsj" label="申请时间" class="form_date" readonly id="sfssqsj" fixedValue="true">
								<input name="sfssqr" type="text" label="申请人" id="sfssqr" value="${CURRENT_USER_SESSION.name}" readonly="true" fixedValue="true">
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal" id="close">关闭</button>
						<button type="button" class="btn btn-primary" id="btn_submit">提交</button>
					</div>
				</div>
			</div>
		</div>
	<!-- 点击查看弹出提请理由，提请依据详细信息 -->
	<div class="modal fade" id="sjzx_modal">
			<div class="modal-dialog ">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="false" id="xxx"></button>
						<h4 class="modal-title" id="myModalLabel">提请详细信息</h4>
					</div>
					<div class="modal-body" id="modal-body" style="height: 443px; overflow: auto">
						<div id="modal_form_tqly">     
								<textarea name="xsfjshyj" rows="8" type="text" valid="{required:true}" disabled label="旗县审核意见";></textarea>
								<textarea name="dsfjshyj" rows="8" type="text" valid="{required:true}" disabled label="盟市审核意见"></textarea>
						</div>
						<button type="button" style="float:right" class="btn btn-default" data-dismiss="modal" id="close">关闭</button>

		           </div>
					</div>
					<div class="modal-footer">
						
					</div>
				</div>
			</div>
		</div>
		
			<!-- 审核 -->
		<div class="modal fade" id="sjzx_sh_modal">
			<div class="modal-dialog ">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="false" id="xxx"></button>
						<h4 class="modal-title" id="myModalLabel">审核</h4>
					</div>
					<div class="modal-body" id="modal-sh-body" style="height: 345px;">
						<div id="modal_sh_form_tqly">     
								<input type="text" label="司法局审核人" name="xsfjspr" id="xsfjspr" value="${CURRENT_USER_SESSION.name}" disabled getdis="true"/>
								<textarea rows="5" name="shyj" id="floor3" type="text"  valid="{required:true}"  label="审核意见";></textarea>
								<div class="text-right"><span id="count3"  style="color: #3F51B5;margin-right: 40px;"></span></div>
								<input type="text" label="司法局审核时间" name="xsfjspsj" id="xsfjspsj" disabled getdis="true"/>
								<select label ="审核结果 " id="audit" name="audit" valid="{required:true}">
									<option value="1">通过</option>
									<option value="2">未通过</option>
								</select>
								<input type="hidden" id="aid" name="aid" value=""/>
						</div>	
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal" id="close">关闭</button>
						<button type="button" class="btn btn-primary" id="btn_sh_submit">提交</button>
					</div>
				</div>
			</div>
		</div>
</div>
</body>
</html>