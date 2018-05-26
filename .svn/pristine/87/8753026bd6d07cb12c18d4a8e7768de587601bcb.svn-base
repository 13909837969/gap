<%@page import="java.util.UUID"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
	<title>调查评估-司法所</title>
	<jsp:include page="../../ltrhao-common.jsp"></jsp:include>
	<style>
	.ui-state-default{
		text-align:center;
	}
	#listDcpg_gzfpLeft{
		width: 300px;
	}
	#listDcpg_gzfpRight{
		width: 570px;
	    position: absolute;
	    right: 5px;
	    top: 5px;
	}
 #title_jbxx table{
	border-collapse:collapse;
	width:100%;
}
 #title_jbxx td{
	text-align:center;
	width:100px;
	font-weight: bold;
}
.input_2{
	border:none;
	width:130px;
	text-align: center;
	cursor: pointer;
}

#title_jbxx tr{
	height:30px;
}
.input_1{
	width:100%;
	height:36px;
	
}
#title_jbxx td>input{
	border:none;
	text-align: center;
}
#showModal table{
	border-collapse:collapse;
	width:100%;
}
 #showModal td{
	text-align:center;
	width:100px;
	font-weight: bold;
}


#showModal tr{
	height:30px;
}

#showModal td>input{
	border:none;
	text-align: center;
}
	</style>
	<script type="text/javascript" src="${localCtx}/json/JzDcpgxxService.js"></script>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<script type="text/javascript">
	$(function(){
		var view_jbxx = new Eht.View({selector:"#show_table",fieldname:"field"});
		var form_dcnr = new Eht.Form({selector:"#table_form"});
		var service = new JzDcpgxxService();
		//初始界面信息展示
		var tableView = new Eht.TableView({selector:"#listDcpgSfs_tableView"});
		
		
		 var showForm = new Eht.View({selector:"#listDcpg_sfs #showModal",fieldname:"field"});
		//定义一个查询条件变量
		var querySearch = {};
		//单击查询按钮触发的事件
		$("#listDcpg_sfs #btnSelect").click(function(){
			querySearch["a.bgrxm[like]"] = $("#listDcpg_sfs #search-xm").val();
			querySearch["a.bgrsfzh[like]"] = $("#listDcpg_sfs #search-sfzh").val();
			tableView.refresh();
		});
		//初始状态页面显示
		tableView.loadData(function(page,res){
			service.findMoreSfs(querySearch,page,res);
			
		});
		//查看附件按钮事件
		tableView.transColumn("ckfj",function(data){
			var button = $('<button  class="btn btn-default btn-sm"><span class="glyphicon glyphicon-eye-open"></span>&nbsp;查看</button>');
			button.unbind("click").bind("click",function(){
				$("#listDcpg_SfsFjxxIMG").attr("src","${localCtx}/image/RMIImageService?_table_name=JZ_WTSJLB_FJ&id="+data.id);		
				//上传文件事件
				if(data.id != null){
					var callbackDcpgSfsImg=function(msg){
						new Eht.Tips().show(msg);
						return false;
					};
				}
				$('#myModal_sfsFjxx').modal({backdrop:'static'});
				return false;
			})
			return button;
		});
		//调查记录按钮事件
		var json = {};
		tableView.clickRow(function(data){
			json=data;
			
		});
		tableView.transColumn("cz",function(data){
				if(data.dcpgzt=="02"){
					var button =$('<button  class="btn btn-default btn-sm "><span class="glyphicon glyphicon-user"></span>&nbsp;管理</button>');
							
					button.click(function(){
						$("#save").hide()
						$("#receive").show();
						$("#back").show();
						$("#table_view").hide();
						tableView.clickRow(function(data){
							json=data;
							view_jbxx.fill(json);
							$("#zp").attr("src","${localCtx}/image/RMIImageService?_table_name=SYS_FACE_IMG&imgid="+data.id+"&icon=per");
						});
						
						$('#myModal_tjwtxx').modal({backdrop:'static'});
					})
				}else{
					var button =new Array($('<button  class="btn btn-default btn-sm "><span class="glyphicon glyphicon-eye-open"></span>&nbsp;查看</button>'),
							$('<button  class="btn btn-default btn-sm" style="margin-left:10px;"><span class="glyphicon glyphicon-edit"></span>&nbsp;调查内容</button>'));
					button[0].click(function(){
						$("#save").hide()
						$("#receive").hide();
						$("#back").hide();
						tableView.clickRow(function(data){
							json=data;
							showForm.fill(json);
							$("#zp").attr("src","${localCtx}/image/RMIImageService?_table_name=SYS_FACE_IMG&imgid="+data.id+"&icon=per");
						});
						
						$('#myModal_SfsTjwtxx').modal({backdrop:'static'});
					})
					button[1].click(function(){
							$("#save").show()
							$("#receive").hide();
							$("#back").hide();
							$("#table_view").show();
							tableView.clickRow(function(data){
								json=data;
								view_jbxx.fill(json);
								$("#listDcpg_sfs #dcdwsfs").attr("readonly",true);
								$("#listDcpg_sfs #dcr").attr("readonly",true);
								$("#listDcpg_sfs #dcdwxqj").attr("readonly",true);
								$("#listDcpg_sfs #dcdwsfs").val(data.jgmc);
								$("#listDcpg_sfs #dcr").val("${CURRENT_USER_SESSION.name}");
								$("#form_id").val(data.id);
								
								
								$("#zp").attr("src","${localCtx}/image/RMIImageService?_table_name=SYS_FACE_IMG&imgid="+data.id+"&icon=per");
							});
							
							$('#myModal_tjwtxx').modal({backdrop:'static'});
				 	})
					
				}
					return button;
			})
					
		//
		$("#listDcpg_sfs #receive").click(function(){
			service.applyOne(json,new Eht.Responder({
				success:function(){
					$('#myModal_tjwtxx').modal('hide');
					tableView.refresh();
					new Eht.Tips().show();
				}
			}))
		})
		$("#listDcpg_sfs #back").click(function(){
			service.deleteOne(json,new Eht.Responder({
				success:function(){
					$('#myModal_tjwtxx').modal('hide');
					tableView.refresh();
					new Eht.Tips().show();
				}
			}))
		})
		//添加调查记录保存信息触发事件
		$("#listDcpg_sfs #save").click(function(){
			if(form_dcnr.validate()){
				service.saveTcpgxx(form_dcnr.getData(),new Eht.Responder({
					success:function(){
						$('#myModal_tjwtxx').modal('hide');
						tableView.refresh();
						new Eht.Tips().show();
					}
				}))
			}
					
		});
		//字数计算
		var textareaName = "#listDcpg_sfs #dcnr";//备注输入框id
		var spanName = "#listDcpg_sfs #text-count";//计数span的id
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
						.text("" + $(textareaName).val().length + "/1000");
				if ($(textareaName).val().length > 0) {
					$(spanName).css("color", "#3F51B5");
				}
				;
				if ($(textareaName).val().length > 240) {
					$(spanName).css("color", "#FF0000");
				}
				;
			} else {
				$(spanName).text("0/1000");
			}
		};
		var textareaName2="#listDcpg_sfs #pgyj_sfs";//备注输入框id
		var spanName2 ="#listDcpg_sfs #text-count2";//计数span的id
		$(textareaName2).click(function() {
			countChar2(textareaName2, spanName2);
		});
		$(textareaName2).keyup(function(){
			countChar2(textareaName2, spanName2);
		});
		$(textareaName2).keydown(function() {
			countChar2(textareaName2, spanName2);
		});
		function countChar2(textareaName2, spanName2) {
			if ($(textareaName2).val() != "") {
				$(spanName2)
						.text("" + $(textareaName2).val().length + "/100");
				if ($(textareaName2).val().length > 0) {
					$(spanName2).css("color", "#3F51B5");
				}
				;
				if ($(textareaName2).val().length >50) {
					$(spanName2).css("color", "#FF0000");
				}
				;
			} else {
				$(spanName2).text("0/100");
			}
		};
		$("#listDcpg_sfs #close").click(function(){
			$("#myModal_tjwtxx").modal('hide');
		})
		$("#gb").click(function(){
			$('#myModal_SfsTjwtxx').modal('hide');
		});
		
	})
	
	</script>
</head>
<body>

	<div class="panel panel-default" id="listDcpg_sfs">
		<div class="panel-heading">
			<fieldset id="listDcpg_fieldset" style="margin-top:10px;">
				<label> 被调查人姓名：<input type="text" id="search-xm" style="width:170px;height:28px;text-align:center;" placeholder="请输入姓名"autocomplete="off"/></label>
				<label> 身份证号：<input type="text" id="search-sfzh" style="width:170px;height:28px;text-align:center;" placeholder="请输入被调查人身份证号"autocomplete="off"/></label>
				<input  id="btnSelect" type="button" class="btn btn-default btn-sm" value="查询">
			</fieldset>
		</div>
		<div class="panel-body" id="listDcpgSfs_tableView" style="text-align:center;">
			<div field="op" checkbox=true label="选择"></div>
			<div field="wtrq" label="委托日期"></div>
			<div field="bgrxm" label="被调查人"></div>
			<div field="bgrsfzh" label="身份证号"></div>
			<div field="bgrjzddz" label="住址"></div>
			<div field="dcpgzt" label="状态" code="sys205"></div>
			<!-- <div field="ckfj" label="查看附件"></div> -->
			<div field="cz" label="操作"></div>
		</div>
		<div class="modal fade" id="myModal_tjwtxx" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog modal-lg" >
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true" >
							&times;
						</button>
						<h4 class="modal-title" id=modal_title>委托信息</h4>
					</div>
					<div class="modal-body" style="overflow: auto;">
						<div id="title_jbxx">
							<table border="1" cellspacing="0"  align="center" id="show_table">
								<tr>
									<td class="td1">被告人</td>
									<td field="bgrxm" colspan="2"></td>
									<td class="td1">性别</td>
									<td><div field="bgrxb" code="SYS000"></div></td>
									
									<td rowspan="4" style="width:90px"><div>
									<img id="zp" style="width:90px;height:120px"   alt="一寸免冠照片">
									</div>
									</td>
								</tr>
								<tr>
									<td class="td1">身份证号码</td>
									<td colspan="2"><div field="bgrsfzh"></div></td>
									<td class="td1">出生日期</td>
									<td colspan="1"><div field="bgrcsrq"></div></td>
								</tr>
								<tr>
									<td class="td2">居住地</td>
									<td colspan="4"><div field="bgrjzddz"></div></td>
								</tr>
								
								<tr>
									<td class="td2">罪名</td>
									<td colspan="1"><div field="zm"></div></td>
									<td >工作单位</td>
									<td colspan="2"><div field="bgrgzdw"></div></td>
								</tr>
								<tr>
									<td>原判刑罚</td>
									<td >
										<div  field="ypxf"  code="sys012"></div>
									</td>
									<td>附加刑</td>
									<td colspan="3">
										<div  field="fjx" style="margin-left: 2px;" code="sys013"></div>
									</td>
								</tr>
								<tr>
									<td >判决机关</td>
									<td><div field="pjjg" class="input_1" style="height: 45px;line-height: 45px;"></div></td>
									<td >原判刑期起止日</td>
									<td >
										<div>自&nbsp;&nbsp;<span  field="ypxqksrq" id="ypxqksrq" ></span>&nbsp;&nbsp;起<br>到&nbsp;&nbsp;<span field="ypxqjsrq"></span>&nbsp;&nbsp;止</div
									</td>
									<td>原判刑期</td>
									<td><div  field="ypxq"  class="input_1"style="height: 45px;line-height: 45px;" ></div></td>
								</tr>
								<tr>
									<td >判决日期</td>
									<td colspan="2"><div field="pjrq"></div></td>
									<td>委托日期</td>
									<td colspan="2"><div  field="wtrq"></div></td>
									
								</tr>
									<tr>
									<td>委托机构类别</td>
									<td colspan="3"><div  field="wtjglb" code="sys206" ></div>
									<td >委托单位</td>
									<td colspan="1"><div field="wtdw" ></div></td>
								</tr>
								<tr>
									<td>指派机构</td>
									<td colspan="5">
										<div field="jgmc" style="margin: 0px;"></div>
									</td>
								</tr>
								<!-- <tr>
									<td>委托调查书</td>
									<td colspan="5">
										<a href="">委托调查书</a>
									</td>
								</tr> -->
							</table>
						<div id="table_form">
							<input id="form_id" type="hidden" name="id">
							<table border="1" cellspacing="0"  align="center" style="border-top: none;">
								<tr>
									<td colspan="6" style="font-size: 18px;">调&nbsp;&nbsp;查&nbsp;&nbsp;内&nbsp;&nbsp;容</td>
								</tr>
								<tr>
									<td>被调查人姓名</td>
									<td colspan="2">
										<input getdis="true" label="被调查人姓名" name="bdcrxm"class="input_1" type="text"valid="{required:true}"/>
									</td>
									<td >调查时间</td>
									<td colspan="2"><input name="dcsj" label="调查时间" type="text" class="form_date input_2" readonly="readonly"valid="{required:true,date:true}"><span class="glyphicon glyphicon-list-alt"></span></td>
								</tr>
								<tr>
									<td>与被告人关系</td>
									<td colspan="5">
										<input getdis="true" radio="true" label="与被告人关系" name="ybgrgx"  type="text" code="sys199" style="margin-left: 5px;"valid="{required:true}"/>
									</td>
								</tr>
								<tr>
									<td>调查事项</td>
									<td colspan="5">
										<textarea rows="3" getdis="true" label="调查事项" name="dcsx"style="border:none; resize: none;overflow: hidden; width: 100%;height: 50px; outline: none;"valid="{required:true}"></textarea>
									</td>
								</tr>
								<tr>
									<td >调查地点 </td>
									<td colspan="5"><input name="dcdd" label="调查地点" type="text"class="input_1"valid="{required:true}"></td>
								</tr>
								<tr>
									<td >调查人</td>
									<td colspan="2"><input id="dcr" label="调查人" name="dcr" type="text"class="input_1" valid="{required:true}"></td>
									<td >调查意见审核人 </td>
									<td colspan="2"><input name="dcyjshr" label="调查意见审核人" type="text"class="input_1"valid="{required:true}"></td>
								</tr> 
								
								 <tr>
									<td >调查单位（司法所） </td>
									<td colspan="2"><input id="dcdwsfs" label="调查单位（司法所）" name="dcdwsfs"class="input_1" style="height: 41px;" type="text"valid="{required:true}"></td>
									<td >调查单位（县区局） </td>
									<td colspan="2"><input id="dcdwxqj" name="dcdwxqj"class="input_1" style="height: 41px;" type="text"></td>
								</tr> 
								<tr>
									<td>评估意见</td>
									<td colspan="5">
										<textarea rows="3" name="pgyj"  label="评估意见"style="border:none; resize: none;overflow: hidden; width: 100%;height: 50px;outline: none;"valid="{required:true}"></textarea>
									</td>
								</tr>
							</table>
						</div>
						</div>	
					</div>
					<div class="modal-footer">
						<button id="save" type="button" class="btn btn-default" style="margin-right:30px;background-color: text-transform: ;">提交</button>
						<button id="receive" type="button" class="btn btn-default" style="margin-right:30px;background-color: text-transform: ;">接收</button>
						<button id="back" type="button" class="btn btn-default" style="margin-right:30px;background-color: text-transform: ;">退回</button>
						<button id="close" type="button" class="btn btn-default" style="margin-right:30px;background-color: text-transform: ;">关闭</button>
					</div>
				</div>
			</div>
		</div>
		
		
		
		
		
			<!-- 工作分配(Modal) -->
	<div class="modal fade" id="myModal_SfsTjwtxx" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true"">
			<div class="modal-dialog modal-lg">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
							&times;
						</button>
						<h4 id="sfs_title" class="modal-title" >查看详情</h4>
					</div>
					<div class="modal-body" style="overflow: auto;height:450px" id="showModal">
						<table border="1" cellspacing="0" id="table_view" align="center">
							<tr>
									<td class="td1">被告人</td>
									<td field="bgrxm" colspan="2"></td>
									<td class="td1">性别</td>
									<td><div field="bgrxb" code="SYS000"></div></td>
									
									<td rowspan="4" style="width:90px"><div>
									<img id="zp" style="width:90px;height:120px"   alt="一寸免冠照片">
									</div>
									</td>
								</tr>
								<tr>
									<td class="td1">身份证号码</td>
									<td colspan="2"><div field="bgrsfzh"></div></td>
									<td class="td1">出生日期</td>
									<td colspan="1"><div field="bgrcsrq"></div></td>
								</tr>
								<tr>
									<td class="td2">居住地</td>
									<td colspan="4"><div field="bgrjzddz"></div></td>
								</tr>
								
								<tr>
									<td class="td2">罪名</td>
									<td colspan="1"><div field="zm"></div></td>
									<td >工作单位</td>
									<td colspan="2"><div field="bgrgzdw"></div></td>
								</tr>
								<tr>
									<td>原判刑罚</td>
									<td >
										<div  field="ypxf"  code="sys012"></div>
									</td>
									<td>附加刑</td>
									<td colspan="3">
										<div  field="fjx" style="margin-left: 2px;" code="sys013"></div>
									</td>
								</tr>
								<tr>
									<td >判决机关</td>
									<td><div field="pjjg" class="input_1" style="height: 45px;line-height: 45px;"></div></td>
									<td >原判刑期起止日</td>
									<td >
										<div>自&nbsp;&nbsp;<span  field="ypxqksrq" id="ypxqksrq" ></span>&nbsp;&nbsp;起<br>到&nbsp;&nbsp;<span field="ypxqjsrq"></span>&nbsp;&nbsp;止</div
									</td>
									<td>原判刑期</td>
									<td><div  field="ypxq"  class="input_1"style="height: 45px;line-height: 45px;" ></div></td>
								</tr>
								<tr>
									<td >判决日期</td>
									<td colspan="2"><div field="pjrq"></div></td>
									<td>委托日期</td>
									<td colspan="2"><div  field="wtrq"></div></td>
									
								</tr>
									<tr>
									<td>委托机构类别</td>
									<td colspan="1"><div  field="wtjglb" code="sys206" ></div>
									<td >委托单位</td>
									<td colspan="3"><div field="wtdw" ></div></td>
								</tr>
								<tr>
									<td>指派机构</td>
									<td colspan="5">
										<div field="jgmc" style="margin: 0px;"></div>
									</td>
								</tr>
								<!-- <tr>
									<td>委托调查书</td>
									<td colspan="5">
										<a href="">委托调查书</a>
									</td>
								</tr> -->
							<tr>
								<td>被调查人姓名</td>
								<td colspan="2">
									<div  field="bdcrxm" ></div>
								</td>
								<td >调查时间</td>
								<td colspan="2"><div field="dcsj"  ></div></td>
							</tr>
							<tr>
								<td>与被告人关系</td>
								<td colspan="5">
									<div field="ybgrgx"  code="sys199" ></div>
								</td>
							</tr>
							<tr>
								<td>调查事项</td>
								<td colspan="5">
									<div  field="dcsx"></div>
								</td>
							</tr>
							<tr>
								
								<td >调查地点 </td>
								<td colspan="5"><div field="dcdd"></div></td>
							</tr>
							
							<tr>
								<td >调查人</td>
								<td colspan="2"><div fidld="dcr" class="input_1" ></div></td>
								<td >调查意见审核人 </td>
								<td colspan="2"><div field="dcyjshr" class="input_1"></div></td>
								
							</tr> 
							<tr>
								<td >调查单位（司法所） </td>
								<td colspan="2"><div field="dcdwsfs"class="input_1" ></div></td>
								<td >调查单位（县区局） </td>
								<td colspan="2"><div field="dcdwxqj"class="input_1" ></div></td>
							</tr> 
							<tr>
								<td>评估意见</td>
								<td colspan="5">
									<div  field="pgyj"  ></div>
								</td>
							</tr>
							
					</table>
					</div>
					<div id="yesbt"class="modal-footer">
						<button id="gb" type="button" class="btn btn-default" style="margin-right:30px;background-color: text-transform: ;">关闭</button>
					</div>
				</div>
			</div>
		</div>
		<!-- 查看附件(Modal) -->
		<div class="modal fade" id="myModal_sfsFjxx" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
							&times;
						</button>
						<h4 class="modal-title">附件信息</h4>
					</div>
					<div class="modal-body" id="listDcpg_fjxx" style="overflow:auto;height:450px">
						<input type="hidden" name="callback" fixedValue="true" value="callbackDcpgSfsImg" >
						<img id="listDcpg_SfsFjxxIMG" style="width:100%;height:100%;"> 
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>