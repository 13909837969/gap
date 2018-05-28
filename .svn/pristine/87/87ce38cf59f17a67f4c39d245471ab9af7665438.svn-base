<%@page import="java.util.UUID"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>评估结果管理</title>
<jsp:include page="../../ltrhao-common.jsp"></jsp:include>
<style>
.ui-state-default {
	text-align: center;
}

#listPgjg_gzfpLeft {
	width: 300px;
}

#listPgjg_gzfpRight {
	width: 570px;
	position: absolute;
	right: 5px;
	top: 5px;
}

.content {
	width: 450px;
	margin: 0 auto;
	text-align: center;
}

.left {
	text-align: left;
}

.right {
	text-align: right;
	text-indent: 2em;
}


.listPgjg_span {
	text-align:left;
	text-decoration: underline
}
.text{
	text-align: left;
	text-indent: 2em;
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
</style>
<script type="text/javascript" src="${localCtx}/json/JzDcpgxxService.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript">
	$(function() {
		$("#listJg").hide();
		var formJs = new Eht.View({selector:"#title_jbxx",fieldname:"field"});
		var form_pgjg = new Eht.Form({selector:"#form_pgjg"});
				var service = new JzDcpgxxService();
				
				var tableView = new Eht.TableView({
					selector : "#listPgjg_tableView"
				});
				

				var form = new Eht.Form({
					selector : "#listPgjg_sfsDcjl",
					autolayout : true
				});
				//定义一个查询条件变量
				var querySearch = {};
				//单击查询按钮触发的事件
				$("#listPgjg #btnSelect").click(
						function() {
							querySearch["bgrxm[like]"] = $(
									"#listPgjg #search-xm").val();
							querySearch["bgrsfzh[like]"] = $(
									"#listPgjg #search-sfzh").val();

							tableView.refresh();
						});
				//初始状态页面显示
				tableView.loadData(function(page, res) {
					service.findPgwc(querySearch, page, res);
				});

				
				//生成评估意见按钮事件
				var query = {};
				var json={};
				tableView.clickRow(function(data){
					json=data;
					debugger;
				});
				
				tableView.transColumn("cz",function(data) {
					
					var	button = new Array($('<button  class="btn btn-default btn-sm "><span class="glyphicon glyphicon-edit"></span>&nbsp;编辑</button>'),
											$('<button  class="btn btn-default btn-sm" style="margin-left:10px;"><span class="glyphicon glyphicon-print"></span>&nbsp;生成</button>'));
					button[0].click(function() {
						tableView.clickRow(function(data){
							json=data;
							formJs.fill(json);
							$("#form_id").val(data.id);
							
							$("#listDcpg_wtsfj_uploadForm").attr("action","${localCtx}/upload/RMIImageService?_table_name=JZ_WTSJLB_FJ&id="+data.id);
							$("#zp").attr("src","${localCtx}/image/RMIImageService?_table_name=SYS_FACE_IMG&imgid="+data.id+"&icon=per"); 
							
						});
						
						$("#myModal_SfsTjwtxx").modal({backdrop : 'static'});
					})
						if (data.dcpgzt == '06') {
							button[1].click(function() {
										tableView.clickRow(function(data){
											
											json=data;
											
										});
										service.findOneDcjl(json.id,new Eht.Responder({
											success : function(data) {
												$("#span2").html(data.dcsj);
												$("#span3").html(new Date().format("yyyy-MM-dd"));
												$("#span9").html(data.dcsx);//调查内容
												$("#span10").html(data.remark);//评估意见
												$("#span1").html(data.wtdw);//委托机构
												$("#span8").html(data.bgrxm);//被调查人
											}
										}));
										var mydate = new Date();//当前时间
										$("#span11").html(mydate.getFullYear());//年
										$("#span12").html(mydate.getMonth() + 1);//月
										$("#span13").html(mydate.getDate());//日
										$("#myModal_Scpgyjs").modal({backdrop : 'static'});
										return false;
									})
						}else {
							button[1].click(function() {
								new Eht.Alert().show('请填写调查评估意见');
							})
						}

						return button;

				})

				$("#sure").click(function() {
					if(form_pgjg.validate()){	
     							
								service.saveDcwc(form_pgjg.getData(), new Eht.Responder({
									success : function() {
										$('#listPgjg #myModal_SfsTjwtxx').modal('hide');
										tableView.refresh();
										new Eht.Tips().show();
									}

								}))
					}		
				})

			
				
				$("#listPgjg #listDcpg_wtsfj").change(function(){
					$("#listDcpg_wtsfj_uploadForm").submit(); 
			
				})
				$("#close").click(function(){
					$('#listPgjg #myModal_SfsTjwtxx').modal('hide');
				})
				
				

			})
</script>

</head>
<body>


	<div class="panel panel-default" id="listPgjg">
		<div class="panel-heading">
			<fieldset id="listPgjg_fieldset" style="margin-top: 10px;">
				<label> 姓名：<input type="text" id="search-xm"
					style="width: 170px; height: 28px; text-align: center;"
					placeholder="请输入姓名" autocomplete="off"/></label> <label> 身份证号：<input type="text"
					id="search-sfzh"
					style="width: 170px; height: 28px; text-align: center;"
					placeholder="请输入被调查人身份证号" autocomplete="off"/></label> <input id="btnSelect" type="button"
					class="btn btn-default btn-sm" value="查询">

			</fieldset>
		</div>
		<div class="panel-body" id="listPgjg_tableView"
			style="text-align: center;">
			<div field="op" checkbox=true label="选择"></div>
			<div field="wtbh" label="委托书编号"></div>
			<div field="wtrq" label="委托日期"></div>
			<div field="bgrxm" label="被调查人"></div>
			<div field="bgrsfzh" label="身份证号"></div>
			<div field="bgrjzddz" label="住址"></div>
			<div field="dcpgzt" label="状态" code="sys205"></div>
			<!-- <div field="ckfj" label="查看附件"></div> -->
			<div field="cz" label="操作"></div>
		</div>


		<!-- 查看附件(Modal) -->
		<div class="modal fade" id="myModal_fjxx" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog ">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="true">&times;</button>
						<h4 class="modal-title">附件信息</h4>
					</div>
					<div class="modal-body" id="listPgjg_fjxx"
						style="overflow: auto; height: 450px">
						<input type="hidden" name="callback" fixedValue="true"
							value="callbackJzryjbxxImg"> <img id="listPgjg_fjxxIMG"
							style="width: 100%; height: 100%;">

					</div>
				</div>
			</div>
		</div>
		<!-- 查看 -->
		<div class="modal fade" id="myModal_SfsTjwtxx" tabindex="-1"
			role="dialog" aria-labelledby="myModalLabel" aria-hidden="true"">
			<div class="modal-dialog modal-lg">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="true">&times;</button>
						<h4 class="modal-title">调查评估</h4>
					</div>
					<div class="modal-body" style="overflow: auto;">
						<div id="title_jbxx">
						<span><input id="id" type="hidden" name="id" /></span>
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
								<td colspan="2"><div field="dcr" class="input_1" style="line-height: 37px;"></div></td>
								<td >调查意见审核人 </td>
								<td colspan="2"><div field="dcyjshr" class="input_1" style="line-height: 37px;"></div></td>
								
							</tr> 
							<tr>
								<td >调查单位（司法所） </td>
								<td colspan="2"><div field="dcdwsfs" ></div></td>
								<td >调查单位（县区局） </td>
								<td colspan="2"><div field="dcdwxqj" id="dcdwxqj"></div></td>
							</tr>
							<tr>
								<td>司法所评估意见</td>
								<td colspan="5">
									<div  field="pgyj"></div>
								</td>
							</tr>
							<tbody id="form_pgjg">
								<tr>
									<td colspan="6" style="font-size: 18px;">司&nbsp;&nbsp;法&nbsp;&nbsp;局&nbsp;&nbsp;审&nbsp;&nbsp;核</td>
								</tr>
								<input id="form_id" name="id" type="hidden">
								
								<tr>
									<td>拟适用矫正类别</td>
									<td colspan="5"><input name="nsysqjzrylx" id="nsyjzlb" radio="true" type="text" code="sys017"valid="{required:true}"></td>
								</tr>
								<tr>
									<td>司法局审核意见</td>
									<td colspan="5">
										<textarea rows="3" name="remark" style="border:none; resize: none;overflow: hidden; width: 100%;height: 50px;outline: none;"valid="{required:true}"></textarea>
									</td>
								</tr>
							<tr>
								<td>调查评估意见书</td>
								<td colspan="5">
									<form id="listDcpg_wtsfj_uploadForm"  method="post" enctype="multipart/form-data" target="importFrame" style="margin:0px;padding:0px;">
										<!-- 文件上传成功或失败的回调方法 -->
										<input type="file"  accept="image/jpg,image/png,application/pdf,application/msword" name="fname" id="listDcpg_wtsfj" style="margin-left:50px;"">
										<iframe id="attachment"  name="importFrame" style="width:0;height:0;display:none;"></iframe>
									</form>
								</td>
							</tr>	
							</tbody>	
						</table>
						</div>
					</div>
					<div class="modal-footer">
						<button id="sure" type="button" class="btn btn-default"style="margin-right: 30px; background: transparent;">提交</button>
						<button id="close" type="button" class="btn btn-default"style="margin-right: 30px; background: transparent;">关闭</button>
					</div>
				</div>
			</div>
		</div>
		<!--生成评估意见书  -->
		<div class="modal fade" id="myModal_Scpgyjs" tabindex="-1"
			role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog modal-lg">
				<div class="modal-content">
					<div class="modal-header">
						<input class="btn no-print" type="button"
							onClick="Print('#myModal_Scpgyjs')" value="打印"
							style="position: absolute; left: 200px; top: 10px;">
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="false">&times;</button>
						<h4 class="modal-title">生成评估意见书</h4>
					</div>
					<div class="modal-body" style="overflow: auto; height: 470px" id="listPgjg_gzfp">
						<div id="myModal_Scpgyjs" >
							<div class="content">
								<h2>调查评估意见书</h2>
								<div class="right">(&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;)字号</div>
								<div class="left"><span id="span1" class="listDcpg_span"></span>人民法院(人民检察院、公安局、监狱)：</div>
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									受你单位委托，我局于<span id="span2"></span>至<span id="span3"></span>对被告人
									<div class="left">(罪犯)<span id="span8" class="listPgjg_span"></span>进行了调查评估。有关情况如下：<span id="span9" class="listPgjg_span"></span></div>
									
								<div class="text">
									综合以上情况，评估意见为<span id="span10" class="listPgjg_span"></span></div>	
												<br>
												<br>
												<br>
								<div class="right"><span id="span11" class="listDcpg_span">______</span>年<span id="span12" class="listDcpg_span">____</span>月<span id="span13" class="listDcpg_span">____</span>日</div>				    
							
						</div>
					</div>
				</div>
			</div>
		</div>
	
	</div>
	

	<script src="Print.js"></script>

</body>
</html>