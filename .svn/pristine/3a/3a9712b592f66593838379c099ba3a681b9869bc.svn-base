<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>	
<%-- 宋占成 --%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>安置帮教人员衔接</title>
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<script type="text/javascript" src="${localCtx}/json/AzbjRyxjSrevice.js"></script>
<script type="text/javascript">
$(function(){
	var dataService = new AzbjRyxjSrevice();
	//矫正人员
	var form_jzryjbxx = new Eht.Form({formCol:2,selector:"#form_jzryjbxx",autolayout:true});
	//衔接人员
	var form_azbjryxj = new Eht.Form({formCol:2,selector:"#form_azbjryxj",autolayout:true});
	//人员衔接查询
	var form_search = new Eht.Form({selector:"#form_search"});
	//人员衔接列表
	var form_add = new Eht.Form({formCol:2,selector:"#form_add",autolayout:true});
	//人员衔接
	var list_table = new Eht.TableView({selector:"#list_table",multable:false});
	//判断衔接还是为衔接
	function xjztCheck(){
		var xj_zt = $("#select_id").val();
		if(xj_zt == '1'){
			return true;
		}else{
			return false;
		}
	}
	//判断点击的是衔接还是新增
	var xjFlag = null;
	//判断是否选中的公用方法
	function checkSelected(){
		if($("#list_table :checkbox:checked").length == 1){
			return true;
		}else{
			new Eht.Alert().showNotSelected();
			return false;
		}
	}
	//增加
	$("#btn_add").click(function(){
		xjFlag = 2;
		$("#btn_save").show();
		form_add.enable();
		form_add.clear();
		$("#form_jzryjbxx").show();
		$("#modal-footer").show();
		$("#modal_azbj_ryxj").modal({backdrop:'static'});
	});
	//保存
	$("#btn_save").click(function(res){
		var azbj_data = form_add.getData();
		var ryxjw = form_azbjryxj.getData();
		if(xjFlag == 1){
			if(form_azbjryxj.validate()){
				dataService.saveAzbj(ryxjw, new Eht.Responder({
					success : function(){
						$("#modal_azbj_ryxj").modal("hide");
						new Eht.Tips().show("保存成功");
						list_table.refresh();
					}
				}));
			}
		}else if(xjFlag == 2){
			if (form_add.validate()){
				dataService.saveAzbj(azbj_data, new Eht.Responder({
					success : function(){
						$("#modal_azbj_ryxj").modal("hide");
						new Eht.Tips().show("保存成功");
						list_table.refresh();
					}
				}));
			}
		}
	});
	//编辑
	$("#btn_edit").click(function(){
		if (checkSelected()){
			$("#btn_save").show();
			form_add.enable();
			$("#form_jzryjbxx").hide();
			$("#form_add").show();
			$("#modal_azbj_ryxj").modal({backdrop:'static'});
			form_add.fill($("#list_table :checkbox:checked").data());
		}
	});
	//查看一条数据
	$("#btn_view").click(function(){
		if (checkSelected()){
			$("#btn_save").hide();
			$("#form_jzryjbxx").hide();
			$("#form_add").show();
			$("#modal_azbj_ryxj").modal({backdrop:'static'});
			form_add.disable();
			form_add.fill($("#list_table :checkbox:checked").data());
		}
	});
	//衔接
	$("#btn_xj").click(function(){
		xjFlag = 1;
		if (checkSelected()) {
			form_add.enable();
			form_add.clear();
			$("#form_jzryjbxx").hide();
			$("#modal-footer").show();
			$("#modal_azbj_ryxj").modal({backdrop:'static'});
			form_add.fill($("#list_table :checkbox:checked").data());
		}
	});
	//查询
	list_table.loadData(function(page, res){
		if(xjztCheck()){
			$("#btn_xj").attr("disabled",true);
			dataService.findAzbjRyxjAll(form_search.getData(), page, res);
		}else{
			dataService.findAzbjRyxjAll(form_search.getData(), page, res);	
		}
	});
	//条件查询刷新
	$("#btn_search").click(function(){
		$("#btn_xj").attr("disabled",false);
		var checkValue = $("#select_id").val();
		list_table.refresh();
		if (checkValue == '1') {
			$("#query_xjtj").enable();
			$("#query_xjsj").enable();
			$("#btn_add").attr("disabled",false);
			$("#btn_view").attr("disabled",false);
			$("#btn_edit").attr("disabled",false);
			$("#btn_xj").attr("disabled",true);
		} else {
			$("#query_xjtj").disable();
			$("#query_xjsj").disable();
			$("#btn_add").attr("disabled",true);
			$("#btn_view").attr("disabled",true);
			$("#btn_edit").attr("disabled",true);
			$("#btn_xj").attr("disabled",false);
		}
	});
});
</script>
</head>
<body>
<div class="toolbar">
	<button type="button" id="btn_add" class="btn btn-default" style="margin-left: 10px;">
		<span class="glyphicon glyphicon-plus" aria-hidden="true"></span>新增
	</button>
	<button type="button" id="btn_view" class="btn btn-default" style="margin-left: 10px;">
		<span class="glyphicon glyphicon-eye-open" aria-hidden="true"></span>查看
	</button>
	<button type="button" id="btn_edit" class="btn btn-default" style="margin-left: 10px;">
		<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>编辑
	</button>
	<button type="button" id="btn_xj" class="btn btn-default" style="margin-left: 10px;">
		<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>衔接
	</button>
</div>
<form class="form-inline" style="margin: 10px;">
	<div id="form_search">
		<div class="form-group">
			<label for="xm">姓名</label> 
			<input id="query_xm" type="text" class="form-control" name="xm[like]" placeholder="姓名">
		</div>
		<div class="form-group" style="margin-left: 10px;">
			<label for="xjtj">衔接途径</label> 
			<input id="query_xjtj" type="text" name="xjtj[eq]" class="form-control" code="SYS134" />
		</div>
		<div class="form-group" style="margin-left: 10px;">
			<label for="xjsj">衔接时间</label> 
			<input id="query_xjsj" type="text" name="xjsj[like]" class="form_date form-control" data-date-format="yyyy-MM-dd" />
		</div>
		<div class="form-group" style="margin-left: 10px;">
			<label for="xjsj">衔接</label> 
			<select class="form-control" name="xjzt" id="select_id">
				<option value="1">已衔接</option>
				<option value="2">未衔接</option>
			</select>
		</div>
		<button type="button" id="btn_search" class="btn btn-primary" style="margin-left: 10px;">
			<span class="glyphicon glyphicon-search" aria-hidden="true"></span>查询
		</button>
	</div>
</form>
<div class="tab-pane active" id="list_table">
	<div field="xx1" label="选项" checkbox=true></div>
	<div field="xm" label="姓名"></div>
	<div field="xjtj" label="衔接途径" code="SYS134"></div>
	<div field="bjlx" label="帮教类型" code="SYS043"></div>
	<div field="xjsj" label="衔接时间"></div>
	<div field="xb" label="性别" code="SYS000"></div>
	<div field="jzjg" label="矫正机构"></div>
	<div field="sfswry" label="是否三无人员" code="SYS001"></div>
</div>
<!-- Modal -->
<div class="modal fade" id="modal_azbj_ryxj" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	<div class="modal-dialog" role="document" style="width: 800px; height: 500px;">
		<div class="modal-content" id="modal_content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="myModalLabel">安置帮教人员衔接</h4>
			</div>
			<div class="modal-body">
				<div id="form_add" class="tab-pane active">
					<div id="form_jzryjbxx" class="tab-pane active">
						<input type="text" id="xm" name="xm" label="姓名" valid="{required:true}"/> 
						<input type="text" name="cym" id="cym" label="曾用名"/> 
						<input type="text" name="xb" id="xb" label="性别" valid="{required:true}" code="sys000"/> 
						<input type="text" name="mz" id="mz" label="民族" valid="{required:true}" code="sys003"/> 
						<input type="text" name="sfzh" id="sfzh" label="身份证号" valid="{required:true,cardNo:true}"/> 
						<input type="text" name="csrq" id="csrq" label="出生日期" valid="{required:true}" class="form_date form-control" data-date-format="yyyy-MM-dd"/> 
						<input type="text" name="grlxdh" label="手机号" valid="{required:true,mobile:true}"/> 
						<input type="text" name="sfcn" id="sfcn" label="是否成年" code="sys001" valid="{required:true}"/> 
						<input type="text" name="wcn" id="wcn" label="未成年" code="sys035" valid="{required:true}"/> 
						<input type="text" name="yzzmm" label="原政治面貌" id="yzzmm" code="sys091" valid="{required:true}"/>
						<input type="text" name="xzzmm" label="现政治面貌" id="xzzmm" code="sys091" valid="{required:true}"/> 
						<input type="text" name="jglx" id="jglx" label="矫管类型" valid="{required:true}" code="sys114" /> 
						<input type="text" name="pqzy" label="捕前职业" id="pqzy" code="sys098" valid="{required:true}"/>
						<input type="text" name="whcd" label="文化程度" id="whcd" code="sys028" valid="{required:true}"/> 
						<input type="text" name="xgzdw" label="现工作单位" id="xgzdw" valid="{required:true}"/> 
						<input type="text" name="dwlxdh" label="单位联系电话" id="dwlxdh" valid="{required:true}"/> 
						<input type="text" name="qtlxfs" label="其他联系方式" id="qtlxfs" valid="{required:true}"/> 
						<input type="text" name="sfswry" label="是否三无人员" id="sfswry" code="sys001" valid="{required:true}"/> 
						<input type="text" name="jyjxqk" label="就业就学情况" id="jyjxqk" code="sys031" valid="{required:true}" /> 
						<input type="text" name="sbqsf" label="搜捕前身份" code="SYS137"/>
					</div>
					<div id="form_azbjryxj" class="tab-pane active">
						<input type="text" name="ygzdw" label="原工作单位"/> 
						<input type="text" name="ch" label="绰号"/> 
						<input type="text" name="xjsj" label="衔接时间" valid="{required:true}" class="form_date form-control" data-date-formate="yyyy-MM-dd"/> 
						<input type="text" name="hyzk" label="婚姻状况" valid="{required:true}" code="SYS030" /> 
						<input type="text" name="xjtj" label="衔接途径" valid="{required:true}" code="SYS134" /> 
						<input type="text" name="bjlx" label="帮教类型" valid="{required:true}" code="SYS043" />
						<input type="text" name="gajgsflsgkcs" label="公安机关是否落实管控措施" valid="{required:true}" code="SYS001"/> 
						<input type="text" name="ybbjdxxjfs" label="一般帮教对象衔接方式" valid="{required:true}" code="SYS135" /> 
						<input type="text" name="zdbjdxxjfs" label="重点帮教对象衔接方式" valid="{required:true}" code="SYS136" /> 
						<input type="hidden" name="xjid">
					</div>
				</div>
			</div>
			<div class="modal-footer" id="modal-footer">
				<button type="button" id="btn_save" class="btn btn-primary">保存</button>
				<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
			</div>
		</div>
	</div>
</div>
</body>
</html>