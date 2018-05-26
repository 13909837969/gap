<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<title>社区矫正人员违规信息采集</title>
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<script type="text/javascript" src="${localCtx}/json/JzrywgxxService.js"></script>
<style type="text/css">
.modal-lg{
	width:600px;
}
</style>
<script type="text/javascript">
		$(function(){
			var nowTime=new Date().format("yyyy-MM-dd");
			var wgxxService = new JzrywgxxService();
			var table = new Eht.TableView({
				selector:"#wgxx_list_all #tableview "
			});
			
			var formcx = new Eht.Form({
				selector:"#wgxx_field"
			});
			var formxx = new Eht.Form({
				selector:"#wgxx_model_field",
				autolayout:true	
			});
			var formtj = new Eht.Form({
				selector:"#wgxxtj_model_field",
				autolayout:true	
			});
			var formxg = new Eht.Form({
				selector:"#wgxxxg_model_field",
				autolayout:true	
			});
			changeInput(true);
			//使初始状态为不可编辑
			function changeInput(ifBoolean){
				if(ifBoolean){
					formxx.disable();
				}else{
					formxx.enable();
				}
			}
			
			//页面加载时
			var query = {};
			table.loadData(function(page,res){
				wgxxService.find(query,page,res);
			})
			
			//单击某条数据时，将该行数据放入json中
			var json = {};
			table.clickRow(function(data){
				json = data;
				changeInput(true);
			})
			
			//点击查询按钮
			$("#querybtn").click(function(){
				query["xm[like]"] = $("#searchXm").val();
				table.refresh();
			});
			//点击添加按钮
			$("#wgxx_list_all #addbtn").click(function(){
				wgxxService.findJzry({},new Eht.Responder({
					success:function(data){
						$("#wgxxfrom_jzrybhAndxm").empty();
						$("#wgxxfrom_jzrybhAndxm").append('<option selected="selected"></option>');
						for(var i=0;i<data.length;i++){
							$("#wgxxfrom_jzrybhAndxm").append("<option value="+data[i].id+">"+data[i].sqjzrybh+"     "+data[i].xm+"</option>");
							
						}
						$("#wgxxfrom_jzrybhAndxm").comboSelect();
					}
				})); 
				$("#wgsj1").val(nowTime);
				$("#wgxx_list_all #wgxxtj_Modal").modal({backdrop:'static'});
			});
			//点击修改按钮
			var query_jbxx={}
			$("#updatebtn").click(function(){
				formxg.fill(json);
				if(json.id==null){
					$("#wgxx_list_all #hideDiv").show();
				}else{
					$("#wgxxxg_Modal").modal({backdrop:'static'});
				}
			});
			//隐藏的警告框触发事件
			$("#wgxx_list_all #quxiaobtn").click(function(){//单击取消按钮
				$("#wgxx_list_all #hideDiv").hide();
			});
			
			
			//添加操作按钮
			table.transColumn("caozuo",function(json){
				var button =Array($('<button id="xqan" class="btn btn-default btn-sm"  style="color:blue"><span class="glyphicon glyphicon-eye-open" ></span>&nbsp;查看</button>'),
						$('<button id="xqan" class="btn btn-default btn-sm"  style="color:blue"><span class="glyphicon glyphicon glyphicon-remove" ></span>&nbsp;删除</button>'));
				button[0].click(function(){
				 changeInput(true);
				 formxx.fill(json);
				 $("#wgxx_list_all #wgxxxx_Modal").modal({backdrop:'static'});
				});
				button[1].click(function(){
					wgxxService.deletewg(json.id);
					table.refresh();
				});
				return button;
				 
			});
			//保存违规信息
			
			$("#wgxx_list_all #bcwg_btn").click(function(){
				if(formtj.validate()){
					 var temp=formtj.getData();
					debugger;
					
					wgxxService.save(temp,new Eht.Responder({
						success:function(){
							table.refresh();
							$("#wgxxtj_Modal").modal("hide");
						}
					}));
					formtj.clear();
				}
			});
			
			//保存修改的违规信息
			$("#bcxg_btn").click(function(){
				if(formxg.validate()){
					wgxxService.save(formxg.getData(),new Eht.Responder({
						success:function(){
							table.refresh();
							$("#wgxxxg_Modal").modal("hide");
						}
					}));
					formxg.clear();
				}
			});
			
			//扣分详情字数判断
			var textareaName = "#wgxx_list_all #wgxq";//备注输入框id
			var spanName = "#wgxx_list_all #count";//计数span的id
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
					};
					if ($(textareaName).val().length > 240) {
						$(spanName).css("color", "#FF0000");
					};
					
				} else {
					$(spanName).text("0/500");
				}
			};
			
		});
		
	</script>
</head>
<body>
<div id="wgxx_list_all" class="panel panel-default">
		<div id="head" class="panel-heading" style="padding-left:20px;">
			<div id="wgxx_field">
				姓名：<input class="input-group-addon" style="width: 150px; border:1px solid #ccc;background-color: #fff;" type="text" name="xm" placeholder="请输入姓名" id="searchXm"/>
				<span>
				<input id="querybtn" class="btn btn-default btn-sm"  type="button"  value="查询"> 
				<input id="addbtn"   class="btn btn-default btn-sm"  type="button"  value="添加">
				<input id="updatebtn"   class="btn btn-default btn-sm"  type="button"  value="修改">
				</span>
			</div>
	</div>	
	<!-- 弹出警告框 -->
	<div class="alert alert-warning alert-dismissible" role="alert" id="hideDiv" style="text-align:center;font-size:17px;display:none;">
		    <strong>警告!</strong> 请先选择一条信息！
		    <input id="quxiaobtn" class="btn btn-default" type="button" value="取消" >
	</div>
	
	<div id="tableview" class="panel-body">
		<div field="op"   label="选择" checkbox=true></div>
		<div field="sqjzrybh" label="社区矫正人员编号" ></div>
		<div field="xm"       label="姓名"></div>
		<div field="xb"       label="性别"     code="SYS000"></div>
		<div field="mz"       label="民族"     code="SYS003"></div>
		<div field="grlxdh"   label="个人联系电话"></div>
		<div field="wglx"     label="违规类型" code="SYS025" ></div>
		<div field="wgsj"     label="违规时间"></div>
		<div field="kfz"      label="扣分值"></div>
		<div field="caozuo"   label="操作"></div>	
	</div>	
	
	<!-- 添加违规模态框 -->
	<div class="modal fade" id="wgxxtj_Modal">
		<div class="modal-dialog modal-lg" >
			<div class="modal-content" >
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" 
							aria-hidden="false">×
					</button>
					<h4 class="modal-title" id="myModalLabel">人员违规信息添加</h4>
				</div>
				<div class="modal-body" id="modal-bodyAdd" style="height:510px;overflow-y:auto;overflow-x:hidden;">
					<div id="wgxxtj_model_field">
						<select id="wgxxfrom_jzrybhAndxm" name="aid" label="服刑人员"></select>
						<input id="wglx1" name="wglx"   label="违规类型" code="SYS025"  >
						<input id="wgsj1" name="wgsj"   label="违规时间" class="form_date" >
						<textarea id="wgxq"   name="wgxq"  type="text"    label="违规详情"></textarea>
						<div class="text-right"><span id="count" style="color: #3F51B5;margin-right: 40px;"></span></div>
						<input id="kfz"   name="kfz"   label="扣分值" valid="{number:true}">
		    		</div>
		    		<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
						<button id="bcwg_btn" type="button" class="btn btn-primary">提交</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 人员违规信息修改 -->
	<div class="modal fade" id="wgxxxg_Modal">
		<div class="modal-dialog modal-lg" >
			<div class="modal-content" >
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" 
							aria-hidden="false">×
					</button>
					<h4 class="modal-title" id="myModalLabel">人员违规信息修改</h4>
				</div>
				<div class="modal-body" id="modal-bodyAdd" style="height:510px;overflow-y:auto;overflow-x:hidden;">
					<div id="wgxxxg_model_field">
						<input id="sqjzrybh2" name="sqjzrybh"   label="社区矫正人员编号" disabled >
						<input id="xm2" name="xm"   label="姓名" disabled  >
						<input id="sfzh2" name="sfzh"   label="身份证号"  disabled>
						<input id="wglx2" name="wglx"   label="违规类型" code="SYS025"  >
						<input id="wgsj2" name="wgsj"   label="违规时间" class="form_date" >
						<textarea id="wgxq2"   name="wgxq"  type="text"    label="违规详情"></textarea>
						<input id="kfz2"   name="kfz"    label="扣分值" valid="{number:true}">
		    		</div>
		    		<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
						<button id="bcxg_btn" type="button" class="btn btn-primary">保存</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- 人员违规详细信息 -->
	<div class="modal fade" id="wgxxxx_Modal">
		<div class="modal-dialog modal-lg" >
			<div class="modal-content" >
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" 
							aria-hidden="false">×
					</button>
					<h4 class="modal-title" id="myModalLabel">人员违规信息表</h4>
				</div>
				<div class="modal-body" id="modal-bodyAdd" style="height:510px;overflow-y:auto;overflow-x:hidden;">
					<div id="wgxx_model_field">
						<input id="sqjzrybh3" name="sqjzrybh"   label="社区矫正人员编号" disabled >
						<input id="xm3" name="xm"   label="姓名" disabled  >
						<input id="xb3" name="xb"   label="性别" code="SYS000"  >
						<input id="mz3" name="mz"   label="民族" code="SYS003" >
						<input id="grlxdh3" name="grlxdh"   label="个人联系电话"  >
						<input id="sfzh3" name="sfzh"   label="身份证号"  >
						<input id="wgl3" name="wglx"   label="违规类型" code="SYS025"  >
						<input id="wgsj3" name="wgsj"   label="违规时间"  >
						<textarea id="wgxq3"   name="wgxq"  type="text"    label="违规详情"></textarea>
						<input id="kfz3" name="kfz" label="扣分值">
		    		</div>
				</div>
			</div>
		</div>
	</div>
	
	
	
</div>
</body>
</html>