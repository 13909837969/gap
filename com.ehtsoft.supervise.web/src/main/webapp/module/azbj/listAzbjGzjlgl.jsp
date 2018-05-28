<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%-- 董育健 --%>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
<title>工作信息管理</title>
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<script type="text/javascript" src="${localCtx}/json/AzbjGzjlglService.js"></script>
<script type="text/javascript" src="${localCtx}/json/AzbjCommonService.js"></script>
<script type="text/javascript">
$(function(){
 	var dataService = new AzbjGzjlglService();
 	var commonService = new AzbjCommonService();
 	var findFlag = false;
 	var form_search = new Eht.Form({selector:"#form_search",codeEmpty:true,codeEmptyLabel:"全部"});
 	var list_table = new Eht.TableView({selector:"#list_table",multable:false}); 
 	var form_add = new Eht.Form({selector:"#form_add",autolayout:true});
 	//展示所有工作信息
 	list_table.loadData(function(page,res){dataService.findAll(form_search.getData(),page,res);});
 	//查询按钮事件
 	$("#btn_search").click(function(){list_table.refresh();});
 	//新增按钮触发事件
 	$('#btn_add').click(function(){
 		form_add.clear();
 		form_add.enable();
 		findYxjry('-1');
 		$("#btn_save").show();
 		$('#modal_gzjl').modal({backdrop:'static'});
 	});
 	//判断是否选中的公用方法
	function checkSelected(){
		if($("#list_table :checkbox:checked").length==1){
			return true;
		}else{
			new Eht.Alert().showNotSelected();
			return false;
		}
	}
 	//查看按钮触发事件
 	$("#btn_view").click(function(){
 		if(checkSelected()){
 			$("#modal_gzjl").modal({backdrop : 'static'});
 			$("#btn_save").hide();
 			form_add.disable();
 			form_add.fill($("#list_table :checkbox:checked").data());
 			findYxjry($("#list_table :checkbox:checked").data().aid);
 		}
 	});
 	//编辑按钮事件
 	$("#btn_edit").click(function() {
		if(checkSelected()){
			form_add.enable();
			$("#btn_save").show();
			$("#modal_gzjl").modal({backdrop : 'static'});
			form_add.fill($("#list_table :checkbox:checked").data());
			findYxjry($("#list_table :checkbox:checked").data().aid);
		}
	});
 	//删除按钮事件
 	$("#btn_delete").click(function() {
		if (checkSelected()) {
			var confirm = new Eht.Confirm();
			confirm.showDelete();
			confirm.onOk(function(){
				dataService.removeOne($("#list_table :checkbox:checked").data(),new Eht.Responder({
					success:function(){
						list_table.refresh();
						confirm.close();
						new Eht.Tips().show();
					}
				}));
			});
		}
	});
 	//模态框保存并且隐藏
 	$('#btn_save').click(function(){
 		if(form_add.validate()){ 
 			dataService.saveOne(form_add.getData(),new Eht.Responder({
 				success:function(data){
 					$('#modal_gzjl').modal('hide');
 					new Eht.Tips().show();
    				list_table.refresh();
 				}
 			}));
 		}
 	});
 	//已衔接人员姓名检索
 	function findYxjry(ryid){
 		if (!findFlag){
 			commonService.findYxjry(new Eht.Responder({
 				success:function(data){
 					$("#sel_azbjryid").empty();
					$("#sel_azbjryid").append('<option selected="selected"></option>');
					for(var i=0;i<data.length;i++){
						$("#sel_azbjryid").append("<option value="+data[i].id+">"+data[i].xm +"   "+ data[i].grlxdh + "</option>");
					}
					$("#sel_azbjryid").comboSelect();
					findFlag = true;
				}
			}));
 	     }
 		if(ryid!='-1'){
				$("#sel_azbjryid option[value="+ryid+"]").attr("selected", "selected"); 
 	    }
	}
});
</script>
</head>
<body>
<!-- 操作按钮部分 -->
<div class="toolbar">
	<button id="btn_add" type="button" class="btn btn-default" style="margin-left:10px;">
		<span class="glyphicon glyphicon-plus" aria-hidden="true"></span>新增</button>
	<button id="btn_view" type="button" class="btn btn-default" style="margin-left:10px;">
		<span class="glyphicon glyphicon-eye-open" aria-hidden="true"></span>查看</button>
	<button id="btn_edit" type="button" class="btn btn-default" style="margin-left:10px;">
		<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>编辑</button>
	<button id="btn_delete" type="submit" class="btn btn-default" style="margin-left:10px;">
		<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>删除</button>			
</div>
<!-- 条件查询部分 -->
<form class="form-inline" style="margin:10px;">
	<div id="form_search">
		<div class="form-group">
			<label for="xm">姓名</label>
			<input type="text" class="form-control" name="xm[like]" placeholder="姓名"/>
		</div>
		<div class="form-group" style="margin-left:10px;">
			<label for="xsbx">现实表现</label>
			<input type="text" class="form-control" name="xsbx[eq]" placeholder="现实表现" code="sys149"/>
		</div>
		<div class="form-group" style="margin-left:10px;">
			<label for="gzqk">工作情况</label>
			<input type="text" class="form-control" name="gzqk[eq]" placeholder="工作情况" code="sys150"/>
		</div>
		<div class="form-group" style="margin-left:10px;">
			<label for="jjzk">经济状况</label>
			<input type="text" class="form-control" name="jjzk[eq]" placeholder="经济状况" code="sys240"/>
		</div>
		<div class="form-group" style="margin-left:10px;">
			<label for="jtqk">家庭情况</label>
			<input type="text" class="form-control" name="jtqk[eq]" placeholder="家庭情况" code="sys151"/>
		</div>
		<div class="form-group" style="margin-left:10px;">
			<label for="hdcs">活动场所</label>
			<input type="text" class="form-control" name="hdcs[eq]" placeholder="活动场所" code="sys152"/>
		</div>
		<div class="form-group" style="margin-left:10px;">
			<label for="shjw">社会交往</label>
			<input type="text" class="form-control" name="shjw[eq]" placeholder="社会交往" code="sys153"/>
		</div>
		<button id="btn_search" type="button" class="btn btn-primary" style="margin-left:10px;"/>
		<span class="glyphicon glyphicon-search" aria-hidden="true"></span>查询</button>
	</div>
</form>
<!-- 页面表格展示 -->
<div id="list_table">
	<div field="xz" label="选择" checkbox="true" width="60"></div>
	<div field="xm" label="姓名" code="SYS149"></div>
	<div field="xsbx" label="现实表现" code="SYS149"></div>
	<div field="gzqk" label="工作情况" code="SYS150"></div>
	<div field="jjzk" label="经济状况" code="SYS240"></div>
	<div field="jtqk" label="家庭情况" code="SYS151"></div>
	<div field="hdcs" label="活动场所" code="SYS152"></div>
	<div field="shjw" label="社会交往" code="SYS153"></div>
</div>
<!-- 模态框 -->
<div class="modal fade" id="modal_gzjl" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	<div class="modal-dialog" role="document" style="width:600px">
		<div class="modal-content">
			<div class="modal-header">
        		<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        		<h4 class="modal-title" id="myModalLabel">矫正人员工作信息</h4>
      		</div>
      		<div class="modal-body" style="overflow:auto;height:400px;"> 
      			<div id="form_add">
     	      		<input type="hidden" name="id">
					<select id="sel_azbjryid" name="azbjryid" label="安置人员" style="max-width:none"></select>
					<input type="text" name="xsbx" label="现实表现" code="sys149" valid="{required:true}"/>
					<input type="text" name="gzqk" label="工作情况" code="sys150" valid="{required:true}"/>
					<input type="text" name="jjzk" label="经济状况" code="sys240" valid="{required:true}"/>
					<input type="text" name="jtqk" label="家庭情况" code="sys151" valid="{required:true}"/>
					<input type="text" name="hdcs" label="活动场所" code="sys152" valid="{required:true}"/>
					<input type="text" name="shjw" label="社会交往" code="sys153" valid="{required:true}"/>
					<input type="text" name="sj" label="时间" valid="{required:true}" class="form_date" data-date-formate="yyyy-MM-dd"/> 
					<input type="text" name="dd" label="地点" valid="{required:true}"/>
					<input type="text" name="zrqmj"	label="责任区民警" valid="{required:true}"/>
					<textarea name="knhwt" type="text" label="困难和问题" maxlength="500" rows="8" valid="{required:true}"></textarea>
					<textarea name="remark" type="text" label="备注" maxlength="500" rows="8"></textarea>
        		</div>
        		<div class="modal-footer">
        			<button type="button" id="btn_save" class="btn btn-primary">保存</button>
        			<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
        		</div>
			</div>
		</div>
	</div>
</div>
</body>
</html>