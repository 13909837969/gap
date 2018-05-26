<%@ page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
<title>提请收监执行信息采集表</title>
<jsp:include page="../ltrhao-common.jsp"></jsp:include>

<script type="text/javascript" src="${localCtx}/json/JzTqsjzxService.js"></script>


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
#sqjz_Tqsjzx #tableaaa {
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
	
	var qform = new Eht.Form({selector:"#zaxx_querypanel"});
	var form = new Eht.Form({
		selector:"#zaxx_modal_form",autolayout:true
	});
	
	var form1 = new Eht.Form({
		selector:"#modal_form_tqly",autolayout:true,
	});
	
	var formJgxx = new Eht.Form({selector:"#jgxx_view_ry",
		autolayout:true,
		colLabel:"col-sm-3 col-xs-3",
		colCombo:"col-sm-9 col-xs-9"	
	});
	
	var service = new JzTqsjzxService();

	
	var query = {};
	//加载当前机构下的所有收监执行采集信息
	tableview.loadData(function(page,res){
		service.find(query,page,res);
	}); 
	//审核记录
	var tableViewshjl = new Eht.TableView({selector:"#tableview_shjl",paginate:null});
	//查询按钮
	$("#sqjz_Tqsjzx #querybtn").click(function(){
		query.audit = $("#listJgxxcjbSelt").val();
		query["xm[like]"] = $("#searchXm").val(); 
		tableview.refresh();
	});

	//点击添加上报弹出模态框
	$('#sqjz_Tqsjzx #addbtn').click(function(){
		//动态添加矫正人员
		var json = {};
	    service.findJzry(json,new Eht.Responder({
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
		$('#zacfxxcjb_myModal').modal({backdrop:'static'});
	});
	//提交收监执行信息
	$("#sqjz_Tqsjzx #btn_submit").click(function(){
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
	
	//查看提请理由，提请依据详细情况
	   tableview.transColumn("xiangxi",function(data){
	   var button = $('<button  class="btn btn-default btn-sm "><span class="glyphicon glyphicon-edit"></span>&nbsp;查看</button>');
	    button.click(function(){
	  	$('#sjzx_modal').modal({backdrop:'static'});
	  	form1.fill(data);
	  	console.log(data);
		});
		return button;
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
	//修改审核状态
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
	$("#sqjz_Tqsjzx #close #zaxx_modal_form").click(function(){
	       form.clear();
		    json={}; 
	       tableview.refresh();	       
	})
	
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
	 
	  

});

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
						<button type="button" class="close" data-dismiss="modal" aria-hidden="false" id="xxx"></button>
						<h4 class="modal-title" id="myModalLabel">添加收监执行信息</h4>
					</div>
					<div class="modal-body" id="modal-body" style="height: 400px; overflow: auto">
						<div id="zaxx_modal_form">
								<select id="tqzaform_xmAndLxdh" name="aid" label="服刑人员"></select>
								
								<textarea rows="5" name="tqly" id="floor" type="text" maxlength="500" valid="{required:true}" label="提请理由"></textarea>
								<div class="text-right"><span id="count" style="color: #3F51B5;margin-right: 40px;"></span></div>
								<textarea rows="5" name="tqyj" id="floor2" type="text" maxlength="500" valid="{required:true}" label="提请依据"></textarea>
								<div class="text-right"><span id="count2"  style="color: #3F51B5;margin-right: 40px;"></span></div>
								<input name="sfssqsj" label="申请时间" class="form_date" id="sfssqsj" fixedValue="true">
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
	<!-- 点击详细弹出提请理由，提请依据详细信息 -->
	<div class="modal fade" id="sjzx_modal">
			<div class="modal-dialog ">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="false" id="xxx"></button>
						<h4 class="modal-title" id="myModalLabel">提请详细信息</h4>
					</div>
					<div class="modal-body" id="modal-body" style="height: 400px; overflow: auto">
						<div id="modal_form_tqly">     
								<textarea name="tqly" rows="8" type="text" valid="{required:true}" disabled label="提请理由";></textarea>
								<div class="text-right"><span style="color: #3F51B5"></span></div>
								<textarea rows="8" name="tqyj" type="text"  valid="{required:true}" disabled label="提请依据";></textarea>
								<div class="text-right"><span style="color: #3F51B5"></span></div>						
								<input type="text" label="申请人" name="sfssqr" disabled getdis="true"/>
								<input type="text" label="申请时间" name="sfssqsj" disabled getdis="true"/>
						</div>	
						<h3>审核信息</h3>
					 <div data-spy="scroll" data-target="#navbar-example" data-offset="0" style="height:200px;overflow:auto; position: relative;">
		       			 <div id="tableview_shjl" class="table-responsive">
							<div field="name" label="审批人"></div>
							<div field="remark" label="审核意见"></div>
							<div field="auditStatus" label="审核状态"></div>
							<div field="cts" label="审核时间"></div>
						</div>
		           </div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal" id="close">关闭</button>
					</div>
				</div>
			</div>
		</div>
		
		

</div>
</body>
</html>