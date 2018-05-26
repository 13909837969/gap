<%@page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>
<html>
<head>
<title>解除矫正证明书(司法局)</title>
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<script type="text/javascript" src="${localCtx}/json/JcsqjzzmsService.js"></script>
<script type="text/javascript">
	$(function() {
	//连接Service
	var Service = new JcsqjzzmsService();
	//调用tableview界面方法展示界面
	var tableView = new Eht.TableView({
		selector:"#listJcsqjzzms #listJcsqjzzms_tableview"
	});
	//后台数据调用到主界面进行填充
	tableView.loadData(function(page, res) {
		$("#grant").disable();
	 	Service.find(query, page, res);
	});
	//模态框里面的姓名身份证号码禁止填写From表单
	var form_cx = new Eht.Form({
		selector:"#listJcsqjzzms_modal_disabled",
		autolayout:true,
		colLabel:"col-sm-3 col-xs-3",
		colCombo:"col-sm-9 col-xs-9",
		formCol:2
		});
	//模态框里面的可修改填写From表单
	var form = new Eht.Form({
		selector:"#listJcsqjzzms_modal",
		autolayout:true
		});
	var query ={};/*设置全局变量*/
	//点击主界面的一行信息下发解除证明书按钮解锁
	tableView.clickRow(function(data){
		if(data.sfff){
			$("#grant").disable();
		}else{
			$("#grant").enable();
		}
	});
	//点击下发解除证明书弹出模态框
	$("#listJcsqjzzms #grant").click(function(){
		var ds = tableView.getSelectedData();
		if(ds.length>0){
			form_cx.fill(ds[0]);
			form.fill(ds[0]);
			$('#myModal_grant').modal({backdrop:'static'});
		}
	});
	
	//查询按钮
	$("#listJcsqjzzms #query_cx").click(function(){
		query["xm[like]"] = $("#cx_xm").val();
		query["a.sfzh[like]"] = $("#cx_sfzh").val();
		tableView.refresh();
	});
	//解除矫正证明书
	tableView.transColumn("jcjzzms",function(data) {
		if(data.sfff){
			var button = $('<button  class="btn btn-default btn-sm" style="border-color:#128ef6;color:#128ef6;"><span class="glyphicon glyphicon-list-alt"></span>&nbsp;已经下发证明书</button>');
			button.unbind("click").bind("click",function() {
				$('myModal_grant').modal();
				form.fill(query);			
			});
			return button;
		}else{
			return "";
		}
	});
	
	//下发提交给司法所
	$("#issue").click(function(){
		if(form.validate()){
			Service.save(form.getData(),new Eht.Responder({
					success:function(data){
					 new Eht.Tips().show();
					$('#myModal_grant').modal('hide');
					form.clear();
					tableView.refresh();
				}
			}));
		}
	});
	//新增模态框计数----备注
	form.charValid(function(name,min,max){
		if(name=="hjd"){
			$("#count").html(min+"/"+max);
			if( min/max > 3/4 ){
				$("#count").css("color","#f00");
			}else{
				$("#count").css("color","#00f");
			}
		}
		if(name=="jzd"){
			$("#count1").html(min+"/"+max);
			if( min/max > 3/4 ){
				$("#count1").css("color","#f00");
			}else{
				$("#count1").css("color","#00f");
			}
		}
		
	});
	
	
	
	
	
});
</script>
</head>
<body>
<div id="listJcsqjzzms">
	 <div class="panel panel-default">
		<div class="panel-heading ltrhao-toolbar" style="padding-left: 20px;">
			<fieldset id="querypanel">
				姓名:<input class="btn btn-default" 	type="text" 	placeholder="请输入姓名"  	 id="cx_xm" style="margin-left: 10px;"/>
			身份证号:<input class="btn btn-default" 	type="text" 	placeholder="请输入身份证号"  id="cx_sfzh"	style="margin-left: 10px;"/>
					<input class="btn btn-default" 	type="button" 	id="query_cx" 	value="查询" 				style="margin-left: 10px;"/>
				 	<input class="btn btn-default" 	type="button" 	id="grant" 		value="下发解除证明书"		style="margin-left: 10px;"  getdi="true" />
			</fieldset>
	  </div>
		<div id="listJcsqjzzms_tableview">
			<div field="op" 	label="选择" checkbox="true"></div>
			<div field="xm" 	label="姓名"></div>
			<div field="xb" 	label="性别" code="sys000"></div>
			<div field="sfzh" 	label="身份证号"></div>
			<div field="zm" 	label="具体罪名"></div>
			<div field="pcxx" 	label="判处信息"></div>
			<div field="PJRQ" 	label="判决日期"></div>
			<div field="SQJZJSRQ" 	label="社区矫正结束日期"></div>
			<div field="jcjzzms" label="解除矫正证明书"></div>
		</div>
	</div>
<!-- 模态框（Modal） -->
	<div class="modal fade" id="myModal_grant" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalLabel">解除矫正证明书</h4>
				</div >
				<div class="modal-body" style="height: 400px; overflow: auto">
					<div class="modal-body" id="listJcsqjzzms_modal_disabled">
						<input 	type="text" 	name="xm" 	 id="xm"	label="社区矫正人员姓名" disabled />
						<input 	type="text" 	name="sfzh"  id="sfzh"	label="身份证号" disabled />
					</div>
					<div class="modal-body" id="listJcsqjzzms_modal">
						<!-- <textarea 	name="HJD" 		label="固定户籍地"  rows="2" style="resize: none;" valid="{required:true}"  maxlength="100"></textarea> -->
						<textarea   name="hjd" label="固定户籍地"  maxlength="100" rows="2"  style="resize: none;" valid="{required:true}"></textarea>
							<div class="text-right"><span id="count"  style="color: #3F51B5"></span></div>
						<textarea   name="jzd" label="固定居住地"  maxlength="100" rows="2"  style="resize: none;" valid="{required:true}"></textarea>
							<div class="text-right"><span id="count1"  style="color: #3F51B5"></span></div>
						<textarea  	name="zm" 	label="具体罪名"   rows="2" style="resize: none;"  valid="{required:true}" maxlength="100"></textarea>
						<input 	type="text" 	name="PJRQ" 	label="判决日期"   class="form_date" data-date-formate="yyyy-MM-dd" valid="{date:true,required:true}"  />
						<textarea 	name="rmfymc" 	label="法院名称" rows="2" style="resize: none;"  valid="{required:true}" maxlength="100"></textarea>
						<textarea 	name="pcxx" 	label="判处信息"  rows="2" style="resize: none;"  valid="{required:true}" maxlength="200" ></textarea>
						<textarea 	name="sfjg" 	label="司法机构"  rows="2" style="resize: none;"  valid="{required:true}" maxlength="100" code="sys055"></textarea>
						<input 	type="text" 	name="zxtzswh" 	label="执行通知书文号"   valid="{required:true}" />
						<input 	type="text" 	name="sqjzjsrq" label="社区矫正结束日期"   class="form_date" data-date-formate="yyyy-MM-dd"  valid="{date:true,required:true}"  />
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="issue">下发解矫证明书</button>
				</div>
			</div><!-- /.modal-content -->
		</div><!-- /.modal -->
	</div>
</div>	
</body>
</html>