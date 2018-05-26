<%@ page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
<title>提请治安处罚信息采集表</title>
<jsp:include page="../ltrhao-common.jsp"></jsp:include>

<script type="text/javascript" src="${localCtx}/json/TqzacfxxcjbService.js"></script>
<script type="text/javascript" src="${localCtx}/json/AuditService.js"></script>

<script type="text/javascript" src="${localCtx}/json/MzdbService.js"></script>
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
.Shenheliucheng{
	background-color: #C8E6C9;
    font-size: 20px;
    border-radius: 3px;
    padding: 3px;
}
#sqjz_listTqzacfxxcjb #tableaaa {
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
	var tableview = new Eht.TableView({selector:"#sqjz_listTqzacfxxcjb #tableview"});
	var qform = new Eht.Form({selector:"#zaxx_querypanel"});
	var form = new Eht.Form({
		selector:"#zaxx_modal_form",autolayout:true
	});

	var form1 = new Eht.Form({
		selector:"#tqly_modal_form",autolayout:true,
	});
	
	
	var formJgxx = new Eht.Form({selector:"#jgxx_view_ry",
		autolayout:true,
		colLabel:"col-sm-3 col-xs-3",
		colCombo:"col-sm-9 col-xs-9"	
	});
	  
	
	var service = new TqzacfxxcjbService();
	
	var serviceTest = new MzdbService();
	
	serviceTest.getMzdbMap("152103194110083378");
	
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
	//将初始警告信息加载到页面
	tableview.loadData(function(page,res){
		service.find(query,page,res);
	}); 
	
	//审核记录
	var tableViewshjl = new Eht.TableView({selector:"#tableview-shjl",paginate:null});
	//查询按钮
	$("#sqjz_listTqzacfxxcjb #querybtn").click(function(){
		query.audit = $("#listJgxxcjbSelt").val();
		query["xm[like]"] = $("#searchXm").val(); 
		tableview.refresh();
	});

	//点击添加上报弹出模态框
	$('#sqjz_listTqzacfxxcjb #addbtn').click(function(){
		//动态添加审批历史记录信息
		var json = {};
	    service.findJzry(json,new Eht.Responder({
			success:function(data){
				$("#tqzaform_xmAndLxdh").empty();
				$("#tqzaform_xmAndLxdh").append('<option selected="selected"></option>');
				for(var i=0;i<data.length;i++){
					$("#tqzaform_xmAndLxdh").append("<option value="+data[i].id+">"+data[i].xm + "     " + data[i].grlxdh +"</option>");
				}
				$("#tqzaform_xmAndLxdh").comboSelect();
			}
		})); 
		$("#sfssqsj").val(nowTime);		
		$("#sfssqr").val("${CURRENT_USER_SESSION.name}");
		$('#zacfxxcjb_myModal').modal({backdrop:'static'});
	});
	//提交警告上报数据
	$("#sqjz_listTqzacfxxcjb #tqza_btn_submit").click(function(){
		if(form.validate()){			 
			service.save(form.getData(),new Eht.Responder({	
				success:function(){
					tableview.refresh();
					$('#zacfxxcjb_myModal').modal("hide");
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
    };    
    if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));    
    for (var k in o)    
    if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));    
    return fmt;    
    }    
	var nowTime=new Date().Format("yyyy-MM-dd");
	
	 //双击一行获取该行信息
	 var json={};
	 $("#sfssqsj").val(nowTime);
	 tableview.dblclickRow(function(data){
		 changeInput(true);
		 json=data;
		 formJgxx.fill(json);
		 $("#shenqingren").html(json.sfssqr); 
		 $("#sqjz_listTqzacfxxcjb #right-panel").show().animate({width:460});
		 $("#shenqingrenHm").empty();
		 var jsonSqr = {}; 
		 service.findApprover(new Eht.Responder({
			     success:function(data){
			            jsonSqr = data;
			           for(var i =0;i<jsonSqr.length;i++){
			                var tr = $('<span value="sfssqr" class="shenheliucheng">'+jsonSqr[i].name+'</span><span class="glyphicon glyphicon-arrow-right"></span>')	
			                $("#shenqingrenHm").append(tr);
			              }
			           }
		 }));
	 }); 
	 
    //将数据填充到审核记录
		tableViewshjl.loadData(function(page,res){
		service.findApprover(res);//参数
	});
	 tableViewshjl.transColumn("auditStatus",function(data){
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
    
	//关闭面板
	 $("#close").click(function() {
		$('#right-panel').animate({	
			width : 0
		}, function() {
			$(this).hide()
		});	
		form.clear();
		tableview.refresh();
	}); 
	//关闭按钮事件  清除未选择的数据
	$("#sqjz_listTqzacfxxcjb #close #zaxx_modal_form").click(function(){
	       form.clear();
		    json={}; 
	       tableview.refresh();	       
	})
	//关闭右侧内容栏
	$("#siderightbar").click(function(){
		$("#sqjz_listTqzacfxxcjb #right-panel").animate({width:0},function(){
			$("#sqjz_listTqzacfxxcjb #right-panel").hide();
		});
	});
	
	//将数据填充到审核记录
	tableViewshjl.loadData(function(page,res){
		service_Sqr.getAuditHistory(json.id,res);
	})
	
	//提请理由
	var textareaName = "#sqjz_listTqzacfxxcjb #floor";//备注输入框id
	var spanName = "#sqjz_listTqzacfxxcjb #count";//计数span的id
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
	//提请依据
	var textareaName2 = "#sqjz_listTqzacfxxcjb #floor2";//备注输入框id
	var spanName2 = "#sqjz_listTqzacfxxcjb #count2";//计数span的id
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
	//查看提请理由，提请依据详细情况
	   tableview.transColumn("xiangxi",function(data){
	   var button = $('<input type="button" value="提请情况" style="color:blue;">');
	    button.click(function(){
	  	$('#zacfxxcjbtqxx_myModal').modal({backdrop:'static'});
	  	form1.fill(data);
	  	console.log(data);
		});
		return button;
	});  
	  

});

</script>
</head>
<body>
<div id="sqjz_listTqzacfxxcjb">
	<div class="panel panel-default">
		<div class="panel-heading ltrhao-toolbar" style="padding-left: 20px;">
			<div id="zaxx_querypanel">
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
		<div class="panel-body">
			<div id="tableview" class="table-responsive" style="text-align:center;">						
				<div field='xm' label="姓名"></div>
				<div field="xb" label="性别" code="SYS000"></div>
				<div field="grlxdh" label="联系方式"></div>
				<div field="sfzh" label="身份证号码"></div>
				<div field="sfssqr" label="司法所申请人"></div>
				<div field="audit" label="是否审批"></div>
				<div field="xiangxi" label="详细"></div>	
			</div>
		</div>	
	</div>
	<!-- 模态框（Modal） -->
	<div class="modal fade" id="zacfxxcjb_myModal">
			<div class="modal-dialog ">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="false" id="xxx"></button>
						<h4 class="modal-title" id="myModalLabel">添加治安处罚信息</h4>
					</div>
					<div class="modal-body" id="modal-body" style="height: 400px; overflow: auto">
						<div id="zaxx_modal_form">
								<select id="tqzaform_xmAndLxdh" name="aid" label="服刑人员">
								</select>
								<textarea rows="8" name="tqly" id="floor" type="text" maxlength="500" valid="{required:true}" label="提请理由"></textarea>
								<div class="text-right"><span id="count" style="color: #3F51B5;margin-right: 40px;"></span></div>
								<textarea rows="8" name="tqyj" id="floor2" type="text" maxlength="500" valid="{required:true}" label="提请依据"></textarea>
								<div class="text-right"><span id="count2"  style="color: #3F51B5;margin-right: 40px;"></span></div>
								<input name="sfssqsj" label="申请时间" class="form_date" id="sfssqsj" fixedValue="true">
								<input name="sfssqr" type="text" label="申请人" id="sfssqr" value="${CURRENT_USER_SESSION.name}" readonly="true" fixedValue="true">
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal" id="close">关闭</button>
						<button type="button" class="btn btn-primary" id="tqza_btn_submit">提交</button>
					</div>
				</div>
			</div>
		</div>
		
	<!-- 点击详细弹出提请理由，提请依据详细信息 -->
	<div class="modal fade" id="zacfxxcjbtqxx_myModal">
			<div class="modal-dialog ">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="false" id="xxx"></button>
						<h4 class="modal-title" id="myModalLabel">提请理由依据详细信息</h4>
					</div>
					<div class="modal-body" id="modal-body" style="height: 400px; overflow: auto">
						<div id="tqly_modal_form">     
								<textarea name="tqly" rows="8" type="text" valid="{required:true}" disabled label="提请理由";></textarea>
								<div class="text-right"><span style="color: #3F51B5"></span></div>
								<textarea rows="8" name="tqyj" type="text"  valid="{required:true}" disabled label="提请依据";></textarea>
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
		  	<span id="siderightbar" class="glyphicon glyphicon-remove-sign"></span>&nbsp;治安处罚信息
		  </div>
		</div>
		<div class="panel panel-default">
			<div class="panel-heading">
			   <div class="jgxx_view_ry" id="jgxx_view_ry">
				<input type="text" label="姓名" name="xm" getdis="true"/>
				<input type="text" label="联系电话" name="grlxdh" getdis="true"/>
				<input type="text" label="提请理由" name="tqly" getdis="true"/>
				<input type="text" label="提请依据" name="tqyj" getdis="true"/>
				<input type="text" label="申请人" name="sfssqr" getdis="true"/>
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
				<div field="remark" label="审核意见"></div>
				<div field="auditStatus" label="审核状态"></div>
				<div field="cts" label="审核时间"></div>
			</div>
           </div>	
		</div>
	</div>
</div>
</div>
</body>
</html>